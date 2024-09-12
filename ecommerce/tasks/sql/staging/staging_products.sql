--staging_products.sql
MERGE INTO ecommerce.staging.olist_products_dataset AS target
USING (
    SELECT DISTINCT
        product_id ,
        product_category_name ,
        product_name_lenght ,
        product_description_lenght ,
        product_photos_qty ,
        product_weight_g ,
        product_length_cm ,
        product_height_cm ,
        product_width_cm ,
        r.load_id ,
        r.file_id , 
        %(unique_key)s AS unique_key  -- Use the unique_key value directly
    FROM raw.olist_products_dataset r
    JOIN meta.olist_products_dataset m
    ON r.load_id = m.load_id
        AND r.file_id = m.file_id
) AS source
    ON target.product_id = source.product_id
        AND target.unique_key = source.unique_key  -- Match on unique_key

WHEN MATCHED THEN
    UPDATE SET 
        target.product_id = source.product_id ,
        target.product_category_name = source.product_category_name ,
        target.product_name_lenght = source.product_name_lenght ,
        target.product_description_lenght = source.product_description_lenght ,
        target.product_photos_qty = source.product_photos_qty ,
        target.product_weight_g  = source.product_weight_g ,
        target.product_length_cm = source.product_length_cm ,
        target.product_height_cm = source.product_height_cm ,
        target.product_width_cm = source.product_width_cm ,
        target.load_id = source.load_id ,
        target.file_id = source.file_id 
WHEN NOT MATCHED THEN
    INSERT (
        product_id ,
        product_category_name ,
        product_name_lenght ,
        product_description_lenght ,
        product_photos_qty ,
        product_weight_g ,
        product_length_cm ,
        product_height_cm ,
        product_width_cm ,
        load_id ,
        file_id , 
        unique_key
    ) VALUES (
        source.product_id ,
        source.product_category_name ,
        source.product_name_lenght ,
        source.product_description_lenght ,
        source.product_photos_qty ,
        source.product_weight_g ,
        source.product_length_cm ,
        source.product_height_cm ,
        source.product_width_cm ,
        source.load_id ,
        source.file_id ,
        source.unique_key 
    );
