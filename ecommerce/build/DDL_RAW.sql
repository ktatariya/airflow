CREATE OR REPLACE TABLE ecommerce.raw.olist_sellers_dataset (
    seller_id STRING,
    seller_zip_code_prefix INT,
    seller_city STRING,
    seller_state STRING,
    load_id STRING,    -- Add this column to store load_id
    file_id STRING     -- Add this column to store file_id
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_products_dataset (
    product_id STRING,
    product_category_name STRING,
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT,
    load_id STRING,    -- Add this column to store load_id
    file_id STRING     -- Add this column to store file_id
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_orders_dataset (
    order_id STRING,
    customer_id STRING,
    order_status STRING,
    order_purchase_timestamp TIMESTAMP_NTZ,
    order_approved_at TIMESTAMP_NTZ,
    order_delivered_carrier_date TIMESTAMP_NTZ,
    order_delivered_customer_date TIMESTAMP_NTZ,
    order_estimated_delivery_date DATE,
    load_id STRING,    -- Add this column to store load_id
    file_id STRING     -- Add this column to store file_id
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_order_reviews_dataset (
    review_id STRING,
    order_id STRING,
    review_score INT,
    review_comment_title STRING,
    review_comment_message STRING,
    review_creation_date DATE,
    review_answer_timestamp TIMESTAMP_NTZ,
    load_id STRING,    -- Add this column to store load_id
    file_id STRING     -- Add this column to store file_id
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_order_payments_dataset (
    order_id STRING,
    payment_sequential INT,
    payment_type STRING,
    payment_installments INT,
    payment_value FLOAT,
    load_id STRING,    -- Add this column to store load_id
    file_id STRING     -- Add this column to store file_id
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_order_items_dataset (
    order_id STRING,
    order_item_id INT,
    product_id STRING,
    seller_id STRING,
    shipping_limit_date TIMESTAMP_NTZ,
    price FLOAT,
    freight_value FLOAT,
    load_id STRING,    -- Add this column to store load_id
    file_id STRING     -- Add this column to store file_id
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_geolocation_dataset (
    geolocation_zip_code_prefix INT,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city STRING,
    geolocation_state STRING,
    load_id STRING,    -- Add this column to store load_id
    file_id STRING     -- Add this column to store file_id
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_customers_dataset (
    customer_id STRING,
    customer_unique_id STRING,
    customer_zip_code_prefix INT,
    customer_city STRING,
    customer_state STRING,
    load_id STRING,    -- Add this column to store load_id
    file_id STRING     -- Add this column to store file_id
);

CREATE OR REPLACE TABLE ecommerce.raw.product_category_name_translation (
    product_category_name STRING,
    product_category_name_english STRING,
    load_id STRING,    -- Add this column to store load_id
    file_id STRING     -- Add this column to store file_id
);
