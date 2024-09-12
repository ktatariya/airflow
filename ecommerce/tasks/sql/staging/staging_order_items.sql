--staging_order_items.sql
MERGE INTO ecommerce.staging.olist_order_items_dataset AS target
USING (
    SELECT DISTINCT
        order_id ,
        order_item_id ,
        product_id ,
        seller_id ,
        shipping_limit_date ,
        price ,
        freight_value ,
        r.load_id ,
        r.file_id , 
        %(unique_key)s AS unique_key  -- Use the unique_key value directly
    FROM raw.olist_order_items_dataset r
    JOIN meta.olist_order_items_dataset m
    ON r.load_id = m.load_id
        AND r.file_id = m.file_id
) AS source
    ON target.order_id = source.order_id
        AND target.unique_key = source.unique_key  -- Match on unique_key
        AND target.order_item_id = source.order_item_id
        AND target.product_id = source.product_id
        AND target.seller_id = source.seller_id

WHEN MATCHED THEN
    UPDATE SET 
        target.order_id = source.order_id ,
        target.order_item_id = source.order_item_id ,
        target.product_id = source.product_id ,
        target.seller_id = source.seller_id ,
        target.shipping_limit_date = source.shipping_limit_date ,
        target.price = source.price ,
        target.freight_value = source.freight_value ,
        target.load_id = source.load_id ,
        target.file_id = source.file_id 
WHEN NOT MATCHED THEN
    INSERT (
        order_id ,
        order_item_id ,
        product_id ,
        seller_id ,
        shipping_limit_date ,
        price ,
        freight_value ,
        load_id ,
        file_id , 
        unique_key
    ) VALUES (
        source.order_id ,
        source.order_item_id ,
        source.product_id ,
        source.seller_id ,
        source.shipping_limit_date ,
        source.price ,
        source.freight_value ,
        source.load_id ,
        source.file_id ,
        source.unique_key 
    );
