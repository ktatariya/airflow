import os
import logging
import json
from airflow.exceptions import AirflowException
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from airflow.hooks.S3_hook import S3Hook
from airflow.models import Variable

def copy_to_snowflake(**kwargs):
    try:
        s3_staging_folder = kwargs['S3_staging_folder_name']
        file_key = kwargs['file_key']
        bucket = kwargs['bucket']
        key = kwargs['key']
        logging.info(f"S3 Staging Folder: {s3_staging_folder}, File Key: {file_key}, Bucket: {bucket}, Key : {key}")

        config = Variable.get("CONFIG", deserialize_json=True)
        source_config = config['SOURCES']['ecommerce']['files']
        
        s3_hook = S3Hook(aws_conn_id='aws_default')
        s3_client = s3_hook.get_conn()
        
        snowflake_stage = Variable.get("STAGE_AWS_S3_BUCKET_NAME")
        logging.info(f"Snowflake Stage: {snowflake_stage}")
        
        conn = SnowflakeHook(snowflake_conn_id='snowflake').get_conn()
        cur = conn.cursor()
        
        prefix = f'{s3_staging_folder}/{file_key}/{key}.csv'
        logging.info(f"Listing objects with prefix {prefix}")
        
        
        response = s3_client.list_objects_v2(Bucket=bucket, Prefix=prefix)
        logging.info(f"S3 List Objects Response: {response}")

        if 'Contents' in response:
            for obj in response['Contents']:
                source_key = obj['Key']
                filename = os.path.basename(source_key)
                
                for file_config in source_config.values():
                    if file_config['filename_phrase'] in filename:
                        file_type = file_config['type']
                        if not filename.endswith(file_type):
                            filename += file_type
                        break
                else:
                    logging.warning(f"Filename '{filename}' does not match any known patterns.")
                    continue
                
                meta_s3_filepath = f's3://{bucket}/{source_key}'
                stage_path = f'@my_s3_stage/{file_key}/{filename}'

                logging.info(f'Filename: {filename}, S3 path: {meta_s3_filepath}, Snowflake stage: {stage_path}')

                cur.execute("BEGIN")
                try:
                    raw_script = f"{os.getenv('AIRFLOW_HOME')}/dags/ecommerce/tasks/sql/as_is/{file_key}.sql"
                    with open(raw_script, 'r') as sql_file:
                        query = sql_file.read()
                        cur.execute(query, {
                            'meta_s3_filepath': meta_s3_filepath,
                            'stage_path': stage_path
                        })
                    cur.execute("COMMIT")
                except Exception as e:
                    logging.error(f"SQL Error: {e}")
                    cur.execute("ROLLBACK")
                    raise e
        else:
            logging.info(f"No objects found with prefix {prefix}")

    except Exception as e:
        logging.error(f'Error processing S3 to Snowflake: {e}')
        raise e
    finally:
        if conn:
            cur.close()
            conn.close()
            logging.info("Snowflake connection closed")
