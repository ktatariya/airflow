--staging_orders.sql
MERGE INTO ecommerce.staging.olist_orders_dataset AS target
USING (
    SELECT DISTINCT
        order_id ,
        customer_id ,
        order_status ,
        order_purchase_timestamp ,
        order_approved_at ,
        order_delivered_carrier_date ,
        order_delivered_customer_date ,
        order_estimated_delivery_date ,
        r.load_id ,
        r.file_id , 
        %(unique_key)s AS unique_key  -- Use the unique_key value directly
    FROM raw.olist_orders_dataset r
    JOIN meta.olist_orders_dataset m
    ON r.load_id = m.load_id
        AND r.file_id = m.file_id
) AS source
    ON target.order_id = source.order_id
        AND target.unique_key = source.unique_key  -- Match on unique_key

WHEN MATCHED THEN
    UPDATE SET 
        target.order_id = source.order_id ,
        target.customer_id = source.customer_id ,
        target.order_status = source.order_status ,
        target.order_purchase_timestamp = source.order_purchase_timestamp ,
        target.order_approved_at = source.order_approved_at ,
        target.order_delivered_carrier_date = source.order_delivered_carrier_date ,
        target.order_delivered_customer_date = source.order_delivered_customer_date ,
        target.order_estimated_delivery_date = source.order_estimated_delivery_date ,
        target.load_id = source.load_id ,
        target.file_id = source.file_id 
WHEN NOT MATCHED THEN
    INSERT (
        order_id ,
        customer_id ,
        order_status ,
        order_purchase_timestamp ,
        order_approved_at ,
        order_delivered_carrier_date ,
        order_delivered_customer_date ,
        order_estimated_delivery_date ,
        load_id ,
        file_id , 
        unique_key
    ) VALUES (
        source.order_id ,
        source.customer_id ,
        source.order_status ,
        source.order_purchase_timestamp ,
        source.order_approved_at ,
        source.order_delivered_carrier_date ,
        source.order_delivered_customer_date ,
        source.order_estimated_delivery_date ,
        source.load_id ,
        source.file_id ,
        source.unique_key 
    );
