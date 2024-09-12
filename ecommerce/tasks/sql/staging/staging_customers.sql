--staging_customers.sql
MERGE INTO ecommerce.staging.olist_customers_dataset AS target
USING (
    SELECT DISTINCT
        customer_id ,
        customer_unique_id ,
        customer_zip_code_prefix ,
        customer_city ,
        customer_state ,
        r.load_id ,
        r.file_id , 
        %(unique_key)s AS unique_key  -- Use the unique_key value directly
    FROM raw.olist_customers_dataset r
    JOIN meta.olist_customers_dataset m
    ON r.load_id = m.load_id
        AND r.file_id = m.file_id
) AS source
    ON target.customer_id = source.customer_id
        AND target.unique_key = source.unique_key  -- Match on unique_key
        AND target.customer_unique_id = source.customer_unique_id

WHEN MATCHED THEN
    UPDATE SET 
        target.customer_id = source.customer_id ,
        target.customer_unique_id = source.customer_unique_id ,
        target.customer_zip_code_prefix = source.customer_zip_code_prefix ,
        target.customer_city = source.customer_city ,
        target.customer_state = source.customer_state ,
        target.load_id = source.load_id ,
        target.file_id = source.file_id 
WHEN NOT MATCHED THEN
    INSERT (
        customer_id ,
        customer_unique_id ,
        customer_zip_code_prefix ,
        customer_city ,
        customer_state ,
        load_id ,
        file_id , 
        unique_key
    ) VALUES (
        source.customer_id ,
        source.customer_unique_id ,
        source.customer_zip_code_prefix ,
        source.customer_city ,
        source.customer_state ,
        source.load_id ,
        source.file_id ,
        source.unique_key 
    );
