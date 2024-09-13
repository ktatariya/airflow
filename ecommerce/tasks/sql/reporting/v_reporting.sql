CREATE OR REPLACE VIEW ecommerce.reporting.v_reporting
AS (
SELECT 
    orders_dat.order_id,
    orders_dat.customer_id,
    orders_dat.order_status,
    orders_dat.order_purchase_timestamp,
    orders_dat.order_approved_at,
    orders_dat.order_delivered_carrier_date,
    orders_dat.order_delivered_customer_date,
    orders_dat.order_estimated_delivery_date,
    
    -- Delivery difference
    DATEDIFF(day, CAST(orders_dat.order_delivered_customer_date AS DATE), orders_dat.order_estimated_delivery_date) AS delivery_diff,

    -- Delivered on time flag
    CASE 
        WHEN DATEDIFF(day, CAST(orders_dat.order_delivered_customer_date AS DATE), orders_dat.order_estimated_delivery_date) >= 0 THEN 'Yes'
        ELSE 'No'
    END AS delivered_on_time_flag,

    -- Total order item value (aggregation at order_id level)
    SUM(items_dat.price * items_dat.order_item_id) AS total_order_item_value,

    -- Total freight value (aggregation at order_id level)
    SUM(items_dat.freight_value * items_dat.order_item_id) AS total_freight_value,

    -- Total order value (aggregation of items + freight)
    SUM(items_dat.price * items_dat.order_item_id) + SUM(items_dat.freight_value * items_dat.order_item_id) AS total_order_value,

    -- Review details
    MAX(reviews_dat.review_score) AS review_score,  -- Assuming one review per order
    MAX(reviews_dat.review_comment_title) AS review_comment_title,
    MAX(reviews_dat.review_comment_message) AS review_comment_message,
    MAX(DATEDIFF(day, CAST(reviews_dat.review_answer_timestamp AS DATE), reviews_dat.review_creation_date)) AS avg_time_taken_to_review,

    -- Seller details
    COUNT(DISTINCT sellers_dat.seller_id) AS distinct_seller_count,  -- Count of distinct sellers per order
    COUNT(DISTINCT sellers_dat.seller_zip_code_prefix) AS distinct_seller_zip_count,
    COUNT(DISTINCT sellers_dat.seller_city) AS distinct_seller_city_count,
    COUNT(DISTINCT sellers_dat.seller_state) AS distinct_seller_state_count,

    -- Customer details
    COUNT(DISTINCT customers_dat.customer_unique_id) AS distinct_customer_count,  -- Count of distinct customers per order
    COUNT(DISTINCT customers_dat.customer_zip_code_prefix) AS distinct_customer_zip_count,
    COUNT(DISTINCT customers_dat.customer_city) AS distinct_customer_city_count,
    COUNT(DISTINCT customers_dat.customer_state) AS distinct_customer_state_count,

    -- Payment details
    COUNT(DISTINCT payments_dat.payment_type) AS distinct_payment_type_count,  -- Count of distinct payment types
    COUNT(DISTINCT payments_dat.payment_installments) AS distinct_payment_installments_count,
    SUM(payments_dat.payment_value) AS total_payment_value  -- Sum of payments for the order

FROM ecommerce.staging.olist_orders_dataset AS orders_dat
    LEFT JOIN ecommerce.staging.olist_order_items_dataset AS items_dat  
        ON orders_dat.order_id = items_dat.order_id
    LEFT JOIN ecommerce.staging.olist_order_reviews_dataset AS reviews_dat
        ON reviews_dat.order_id = orders_dat.order_id
    LEFT JOIN ecommerce.staging.olist_sellers_dataset AS sellers_dat
        ON sellers_dat.seller_id = items_dat.seller_id
    LEFT JOIN ecommerce.staging.olist_customers_dataset AS customers_dat
        ON customers_dat.customer_id = orders_dat.customer_id
    LEFT JOIN ecommerce.staging.olist_order_payments_dataset AS payments_dat
        ON payments_dat.order_id = orders_dat.order_id
    LEFT JOIN ecommerce.staging.olist_products_dataset AS products_dat
        ON products_dat.product_id = items_dat.product_id
    LEFT JOIN ecommerce.staging.olist_geolocation_dataset AS geolocation_dat
        ON geolocation_dat.geolocation_zip_code_prefix = sellers_dat.seller_zip_code_prefix
        AND geolocation_dat.geolocation_zip_code_prefix = customers_dat.customer_zip_code_prefix

GROUP BY 
    orders_dat.order_id,
    orders_dat.customer_id,
    orders_dat.order_status,
    orders_dat.order_purchase_timestamp,
    orders_dat.order_approved_at,
    orders_dat.order_delivered_carrier_date,
    orders_dat.order_delivered_customer_date,
    orders_dat.order_estimated_delivery_date

);
