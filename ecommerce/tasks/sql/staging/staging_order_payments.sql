--staging_order_payments.sql
MERGE INTO ecommerce.staging.olist_order_payments_dataset AS target
USING (
    SELECT DISTINCT
        order_id ,
        payment_sequential ,
        payment_type ,
        payment_installments ,
        payment_value ,
        r.load_id ,
        r.file_id , 
        %(unique_key)s AS unique_key  -- Use the unique_key value directly
    FROM raw.olist_order_payments_dataset r
    JOIN meta.olist_order_payments_dataset m
    ON r.load_id = m.load_id
        AND r.file_id = m.file_id
) AS source
    ON target.order_id = source.order_id
        AND target.unique_key = source.unique_key  -- Match on unique_key
        AND target.payment_sequential = source.payment_sequential
        AND target.payment_type = source.payment_type
        AND target.payment_installments = source.payment_installments

WHEN MATCHED THEN
    UPDATE SET 
        target.order_id = source.order_id ,
        target.payment_sequential = source.payment_sequential ,
        target.payment_type = source.payment_type ,
        target.payment_installments = source.payment_installments ,
        target.payment_value = source.payment_value ,
        target.load_id = source.load_id ,
        target.file_id = source.file_id 
WHEN NOT MATCHED THEN
    INSERT (
        order_id ,
        payment_sequential ,
        payment_type ,
        payment_installments ,
        payment_value ,
        load_id ,
        file_id , 
        unique_key
    ) VALUES (
        source.order_id ,
        source.payment_sequential ,
        source.payment_type ,
        source.payment_installments ,
        source.payment_value ,
        source.load_id ,
        source.file_id ,
        source.unique_key 
    );
