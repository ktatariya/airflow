from datetime import datetime
from airflow.models import DAG, Variable
from airflow.operators.dummy import DummyOperator
from airflow.operators.python import PythonOperator

import ecommerce.tasks.python.copy_files as py0
import ecommerce.tasks.python.s3_to_snowflake as py1
import ecommerce.tasks.python.meta_s3_to_snowflake as py2
import ecommerce.tasks.python.snowflake_raw_to_staging as py3

# Retrieve configuration
config = Variable.get("CONFIG", deserialize_json=True)
sources = config['SOURCES']

# Retrieve bucket names from Airflow variables
source_bucket = Variable.get("SOURCE_BUCKET")
dest_bucket = Variable.get("DEST_BUCKET")
S3_staging_folder_name = Variable.get("STAGE_AWS_S3_BUCKET_NAME")

# Define default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 9, 10),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
}

# Instantiate the DAG
dag = DAG('e_commerce', 
          default_args=default_args,
          description='A simple DAG for batch processing',
          schedule_interval='0 2 * * *',
          )

# Task: Start task (DummyOperator)
start_task = DummyOperator(
    task_id='start_task',
    dag=dag
)

# Task: End task (DummyOperator)
end_task = DummyOperator(
    task_id='end_task',
    dag=dag
)

# Generate load_id for the current run
def generate_load_id():
    return f"LOAD_{datetime.now().strftime('%Y%m%d%H%M%S')}"

load_id = generate_load_id()

for client, properties in sources.items():
    vendor_name = DummyOperator(task_id=f'{client}', retries=3, dag=dag)
    start_task >> vendor_name
    for file_object, file_properties in properties['files'].items():
        filename_phrase = file_properties['filename_phrase']
        source_prefix = f"ecommerce/{filename_phrase}/"
        dest_prefix = f"ecommerce/{filename_phrase}/"
        
        task_a = PythonOperator(
            task_id=f'{filename_phrase}_s3_raw_to_staging',
            python_callable=py0.copy_s3_files,
            op_kwargs={
                'source_bucket': source_bucket,
                'dest_bucket': dest_bucket,
                'source_prefix': source_prefix,
                'dest_prefix': dest_prefix,
                'load_id': load_id,
            },
            dag=dag,
        )
        vendor_name >> task_a 
        if file_properties.get('snowflake_raw', 0):
            task_b = PythonOperator(
                task_id=f'{file_object}_s3_to_snowflake',
                python_callable=py1.copy_to_snowflake,
                op_kwargs={
                    'vendor': client,
                    'S3_staging_folder_name': client,
                    'file_properties': file_properties,
                    'file_key': filename_phrase,
                    'bucket': dest_bucket,
                    'key': file_object,
                    'load_id': load_id,  # Pass load_id
                },
                dag=dag,
            ) 
            task_a >> task_b
        else:
            vendor_name >> end_task

        if file_properties.get('snowflake_meta', 0):
            task_c = PythonOperator(
                task_id=f'{file_object}_meta_s3_to_snowflake',
                python_callable=py2.meta_to_snowflake,
                op_kwargs={
                    'vendor': client,
                    'S3_staging_folder_name': client,
                    'file_properties': file_properties,
                    'file_key': filename_phrase,
                    'bucket': dest_bucket,
                    'key': file_object,
                    'load_id': load_id,  # Pass load_id
                    'file_id': file_object,  # Pass file_id
                },
                dag=dag,
            )
            task_b >> task_c 
        else:
            vendor_name >> end_task
        if file_properties.get('snowflake_staging', 0):
            task_d = PythonOperator(
                task_id=f'{file_object}_snowflake_raw_to_staging',
                python_callable=py3.snowflake_raw_to_staging,
                op_kwargs={
                    'vendor': client,
                    'S3_staging_folder_name': client,
                    'file_properties': file_properties,
                    'file_key': filename_phrase,
                    'bucket': dest_bucket,
                    'key': file_object,
                    'load_id': load_id,
                    'file_id': file_object,  # Pass load_id
                },
                dag=dag,
            )
            task_c >> task_d >> end_task
        else:
            vendor_name >> end_task
