--staging_sellers.sql
MERGE INTO ecommerce.staging.olist_sellers_dataset AS target
USING (
    SELECT DISTINCT
        seller_id,
        seller_zip_code_prefix,
        seller_city,
        seller_state,
        r.load_id,
        r.file_id,
        %(unique_key)s AS unique_key  -- Use the unique_key value directly
    FROM raw.olist_sellers_dataset r
    JOIN meta.olist_sellers_dataset m
    ON r.load_id = m.load_id
        AND r.file_id = m.file_id
) AS source
    ON target.seller_id = source.seller_id
        AND target.unique_key = source.unique_key  -- Match on unique_key

WHEN MATCHED THEN
    UPDATE SET 
        target.seller_id = source.seller_id,
        target.seller_zip_code_prefix = source.seller_zip_code_prefix,
        target.seller_city = source.seller_city,
        target.seller_state = source.seller_state,
        target.load_id = source.load_id,
        target.file_id = source.file_id
WHEN NOT MATCHED THEN
    INSERT (
        seller_id,
        seller_zip_code_prefix,
        seller_city,
        seller_state,
        load_id,
        file_id,
        unique_key
    ) VALUES (
        source.seller_id,
        source.seller_zip_code_prefix,
        source.seller_city,
        source.seller_state,
        source.load_id,
        source.file_id,
        source.unique_key
    );
