from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator
from datetime import datetime
from airflow.models import Variable
import os
import ecommerce.tasks.python.copy_files as py0


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

# Define the task to copy files
copy_files_task = PythonOperator(
    task_id='copy_files',
    python_callable=py0.copy_files,  # Function from copy_files.py
    dag=dag,
)


# Set task dependencies
start_task >> copy_files_task >> end_task
