--staging_category_name_translation.sql
MERGE INTO ecommerce.staging.product_category_name_translation AS target
USING (
    SELECT DISTINCT
        product_category_name ,
        product_category_name_english ,
        r.load_id,
        r.file_id,
        %(unique_key)s AS unique_key  -- Use the unique_key value directly
    FROM raw.product_category_name_translation r
    JOIN meta.product_category_name_translation m
    ON r.load_id = m.load_id
        AND r.file_id = m.file_id
) AS source
    ON target.product_category_name = source.product_category_name
        AND target.unique_key = source.unique_key  -- Match on unique_key
        AND target.product_category_name_english = source.product_category_name_english
        
WHEN MATCHED THEN
    UPDATE SET 
        target.product_category_name = source.product_category_name ,
        target.product_category_name_english = source.product_category_name_english ,
        target.load_id = source.load_id,
        target.file_id = source.file_id
WHEN NOT MATCHED THEN
    INSERT (
        product_category_name ,
        product_category_name_english ,
        load_id,
        file_id,
        unique_key
    ) VALUES (
        source.product_category_name ,
        source.product_category_name_english ,
        source.load_id,
        source.file_id,
        source.unique_key
    );
