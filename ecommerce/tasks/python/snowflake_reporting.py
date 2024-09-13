import os
import logging
from datetime import datetime
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook

def snowflake_reporting_views(**kwargs):
    conn = None  # Initialize conn to None
    try:
        s3_staging_folder = kwargs['S3_staging_folder_name']
        file_key = kwargs['file_key']
        bucket = kwargs['bucket']
        key = kwargs['key']
        load_id = kwargs['load_id']
        timestamp_utc = datetime.utcnow().strftime('%Y%m%d%H%M%S')

        logging.info(f"S3 Staging Folder: {s3_staging_folder}, File Key: {file_key}, Bucket: {bucket}, Key: {key}")



        # Snowflake connection
        conn = SnowflakeHook(snowflake_conn_id='snowflake').get_conn()
        cur = conn.cursor()

        # Load SQL script from file
        raw_script = f"{os.getenv('AIRFLOW_HOME')}/dags/ecommerce/tasks/sql/reporting/v_reporting.sql"
        with open(raw_script, 'r') as sql_file:
            query = sql_file.read()
            
            # Execute the query with parameters
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
