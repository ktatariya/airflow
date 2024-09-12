import os
import logging
import pandas as pd
from datetime import datetime
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from airflow.hooks.S3_hook import S3Hook
from airflow.models import Variable

def meta_to_snowflake(**kwargs):
    try:
        s3_staging_folder = kwargs['S3_staging_folder_name']
        file_key = kwargs['file_key']
        bucket = kwargs['bucket']
        key = kwargs['key']
        file_id = kwargs['file_id']
        load_id = kwargs['load_id']
        
        logging.info(f"S3 Staging Folder: {s3_staging_folder}, File Key: {file_key}, Bucket: {bucket}, Key: {key}")
        logging.info(f"Load ID: {load_id}, File ID: {file_id}")

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
                
                if filename.endswith('.csv'):
                    filename_base = filename
                else:
                    filename_base = filename
                
                for file_config in source_config.values():
                    if file_config['filename_phrase'] in filename_base:
                        file_type = file_config['type']
                        if not filename_base.endswith(file_type):
                            filename_base += file_type
                        break
                else:
                    logging.warning(f"Filename '{filename}' does not match any known patterns.")
                    continue
                
                meta_s3_filepath = f's3://{bucket}/{source_key}'
                stage_path = f'@my_s3_stage/{file_key}/{filename_base}'

                logging.info(f'Filename: {filename_base}, S3 path: {meta_s3_filepath}, Snowflake stage: {stage_path}')

                # Download the file to local for processing (temporary path)
                local_file_path = f'/tmp/{filename}'
                s3_client.download_file(bucket, source_key, local_file_path)

                # Get file size and row count
                file_size = os.path.getsize(local_file_path)
                df = pd.read_csv(local_file_path)
                row_count = df.shape[0]

                logging.info(f'File Size: {file_size} bytes, Row Count: {row_count}')

                # Clean up local file
                os.remove(local_file_path)

                cur.execute("BEGIN")
                try:
                    sql_script_path = f"{os.getenv('AIRFLOW_HOME')}/dags/ecommerce/tasks/sql/meta/meta_{file_key}.sql"
                    logging.info(f"Executing SQL script: {sql_script_path}")

                    with open(sql_script_path, 'r') as sql_file:
                        query = sql_file.read()
                        cur.execute(query, {
                            'meta_s3_filepath': meta_s3_filepath,
                            'stage_path': stage_path,
                            'current_year': datetime.now().year,
                            'current_month': datetime.now().month,
                            'current_day': datetime.now().day,
                            'row_count': row_count,
                            'file_header': 'header',  # Replace with actual file header if available
                            'file_size': file_size,
                            'last_modified': datetime.now(),  # Replace with actual last modified timestamp if available
                            'file_type': 'csv',
                            'checksum': 'checksum',  # Replace with actual checksum if available
                            'execution_timestamp': datetime.now(),
                            'load_id': load_id,
                            'file_id': file_id
                        })
                    cur.execute("COMMIT")
                except Exception as e:
                    logging.error(f"SQL Error: {e}")
                    cur.execute("ROLLBACK")
                    raise e
        else:
            logging.info(f"No objects found with prefix {prefix}")

    except Exception as e:
        logging.error(f'Error processing S3 metadata to Snowflake: {e}')
        raise e
    finally:
        if conn:
            cur.close()
            conn.close()
            logging.info("Snowflake connection closed")

if __name__ == "__main__":
    meta_to_snowflake(
        S3_staging_folder_name='test_s3_stage',
        file_key='test_file_key',
        bucket='test_bucket',
        key='test_key',
        load_id='example_load_id',
        file_id='test_file_id'
    )
