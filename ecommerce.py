from datetime import datetime
from airflow.models import DAG, Variable
from airflow.operators.dummy import DummyOperator
from airflow.operators.python import PythonOperator

import ecommerce.tasks.python.copy_files as py0

# Retrieve configuration
config = Variable.get("CONFIG", deserialize_json=True)
sources = config['SOURCES']

# Retrieve bucket names from Airflow variables
source_bucket = Variable.get("SOURCE_BUCKET")
dest_bucket = Variable.get("DEST_BUCKET")

# Define default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 9, 6),
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
            },
            dag=dag,
        )
        
        vendor_name >> task_a >> end_task
