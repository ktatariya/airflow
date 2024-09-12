--meta_sellers.sql
INSERT INTO meta.olist_sellers_dataset (
    s3_path, 
    stage_path, 
    fiscal_year, 
    fiscal_month, 
    fiscal_day, 
    row_count, 
    file_header, 
    file_size, 
    last_modified, 
    file_type, 
    checksum, 
    execution_timestamp,
    load_id,  -- New field
    file_id   -- New field
)
SELECT 
    %(meta_s3_filepath)s AS s3_path, 
    %(stage_path)s AS stage_path, 
    %(current_year)s AS year, 
    %(current_month)s AS month, 
    %(current_day)s AS day,
    %(row_count)s AS row_count, 
    %(file_header)s AS file_header, 
    %(file_size)s AS file_size, 
    %(last_modified)s AS last_modified, 
    %(file_type)s AS file_type, 
    %(checksum)s AS checksum, 
    %(execution_timestamp)s AS execution_timestamp,
    %(load_id)s AS load_id,  -- Insert load_id
    %(file_id)s AS file_id   -- Insert file_id
;


