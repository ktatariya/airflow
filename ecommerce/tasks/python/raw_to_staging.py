import os
import logging
from datetime import datetime
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from airflow.models import Variable

def raw_to_staging_snowflake(**kwargs):
    try:
        s3_staging_folder = kwargs['S3_staging_folder_name']
        file_key = kwargs['file_key']
        bucket = kwargs['bucket']
        key = kwargs['key']
        logging.info(f"S3 Staging Folder: {s3_staging_folder}, File Key: {file_key}, Bucket: {bucket}, Key : {key}")

        # Snowflake connection
        conn = SnowflakeHook(snowflake_conn_id='snowflake').get_conn()
        cur = conn.cursor()

        # Assume that the table names and columns are passed as kwargs
        raw_table = kwargs['raw_table']
        staging_table = kwargs['staging_table']
        unique_key = kwargs['unique_key']  # Column(s) to identify unique records

        # Load SQL script from file
        raw_script = f"{os.getenv('AIRFLOW_HOME')}/dags/ecommerce/tasks/sql/staging/staging_{file_key}.sql"
        with open(raw_script, 'r') as sql_file:
            query = sql_file.read()
            
            # Replace placeholders in SQL with actual values
            query = query.format(
                raw_table=raw_table,
                staging_table=staging_table,
                unique_key=unique_key
            )

            # Execute the query
            cur.execute(query)
            cur.execute("COMMIT")
            
        logging.info("Data successfully merged into staging schema")

    except Exception as e:
        logging.error(f'Error processing raw to staging Snowflake: {e}')
        raise e
    finally:
        if conn:
            cur.close()
            conn.close()
            logging.info("Snowflake connection closed")
