--staging_geolocation.sql
MERGE INTO ecommerce.staging.olist_geolocation_dataset AS target
USING (
    SELECT DISTINCT
        geolocation_zip_code_prefix ,
        geolocation_lat ,
        geolocation_lng ,
        geolocation_city ,
        geolocation_state ,
        r.load_id ,
        r.file_id , 
        %(unique_key)s AS unique_key  -- Use the unique_key value directly
    FROM raw.olist_geolocation_dataset r
    JOIN meta.olist_geolocation_dataset m
    ON r.load_id = m.load_id
        AND r.file_id = m.file_id
) AS source
    ON target.geolocation_city = source.geolocation_city
        AND target.unique_key = source.unique_key  -- Match on unique_key
        AND target.geolocation_zip_code_prefix = source.geolocation_zip_code_prefix
        AND target.geolocation_lat = source.geolocation_lat
        AND target.geolocation_lng = source.geolocation_lng
        AND target.geolocation_state = source.geolocation_state

WHEN MATCHED THEN
    UPDATE SET 
        target.geolocation_zip_code_prefix = source.geolocation_zip_code_prefix ,
        target.geolocation_lat = source.geolocation_lat ,
        target.geolocation_lng = source.geolocation_lng ,
        target.geolocation_city = source.geolocation_city ,
        target.geolocation_state = source.geolocation_state ,
        target.load_id = source.load_id ,
        target.file_id = source.file_id 
WHEN NOT MATCHED THEN
    INSERT (
        geolocation_zip_code_prefix ,
        geolocation_lat ,
        geolocation_lng ,
        geolocation_city ,
        geolocation_state ,
        load_id ,
        file_id , 
        unique_key
    ) VALUES (
        source.geolocation_zip_code_prefix ,
        source.geolocation_lat ,
        source.geolocation_lng ,
        source.geolocation_city ,
        source.geolocation_state ,
        source.load_id ,
        source.file_id ,
        source.unique_key 
    );
