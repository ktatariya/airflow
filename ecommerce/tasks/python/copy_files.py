import os
from datetime import datetime
from airflow.hooks.S3_hook import S3Hook

def copy_s3_files(source_bucket, dest_bucket, source_prefix, dest_prefix, load_id):
    s3_hook = S3Hook(aws_conn_id='aws_default')  # Ensure you have an Airflow connection named 'aws_default'
    s3_client = s3_hook.get_conn()

    try:
        print(f"Copying files from {source_bucket}/{source_prefix} to {dest_bucket}/{dest_prefix}")
        response = s3_client.list_objects_v2(Bucket=source_bucket, Prefix=source_prefix)
        if 'Contents' in response:
            for obj in response['Contents']:
                source_key = obj['Key']
                filename = os.path.basename(source_key)
                dest_key = os.path.join(dest_prefix, filename)  # Remove timestamp from destination key
                copy_source = {'Bucket': source_bucket, 'Key': source_key}

                s3_client.copy_object(CopySource=copy_source, Bucket=dest_bucket, Key=dest_key)
                print(f"Moved {source_key} to {dest_key}")
        else:
            print(f"No objects found with prefix {source_prefix}")

    except Exception as e:
        print(f"Error moving files: {e}")
        raise

# Example usage if running this script directly
if __name__ == "__main__":
    source_bucket_name = 'your-source-bucket'
    dest_bucket_name = 'your-destination-bucket'
    
    # Example prefixes
    source_prefix = 'ecommerce/source_prefix/'
    dest_prefix = 'ecommerce/destination_prefix/'

    copy_s3_files(source_bucket_name, dest_bucket_name, source_prefix, dest_prefix, load_id='example_load_id')
