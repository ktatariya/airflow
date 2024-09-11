/*CREATE TABLE product_category_translation (
    product_category_name VARCHAR(255),
    product_category_name_english VARCHAR(255)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(255),
    customer_state VARCHAR(255)
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(255)
);

CREATE TABLE order_items (
    order_id INT,
    order_item_id INT,
    product_id INT,
    seller_id INT,
    shipping_limit_date TIMESTAMP,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE order_payments (
    order_id INT,
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE order_reviews (
    review_id INT PRIMARY KEY,
    order_id INT,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_category_name VARCHAR(255),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g FLOAT,
    product_length_cm FLOAT,
    product_height_cm FLOAT,
    product_width_cm FLOAT
);

CREATE TABLE sellers (
    seller_id INT PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(255),
    seller_state VARCHAR(255)
);
*/

CREATE OR REPLACE TABLE ecommerce.raw.olist_sellers_dataset (
    seller_id STRING,
    seller_zip_code_prefix INT,
    seller_city STRING,
    seller_state STRING
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
    product_width_cm INT
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_orders_dataset (
    order_id STRING,
    customer_id STRING,
    order_status STRING,
    order_purchase_timestamp TIMESTAMP_NTZ,
    order_approved_at TIMESTAMP_NTZ,
    order_delivered_carrier_date TIMESTAMP_NTZ,
    order_delivered_customer_date TIMESTAMP_NTZ,
    order_estimated_delivery_date DATE
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_order_reviews_dataset (
    review_id STRING,
    order_id STRING,
    review_score INT,
    review_comment_title STRING,
    review_comment_message STRING,
    review_creation_date DATE,
    review_answer_timestamp TIMESTAMP_NTZ
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_order_payments_dataset (
    order_id STRING,
    payment_sequential INT,
    payment_type STRING,
    payment_installments INT,
    payment_value FLOAT
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_order_items_dataset (
    order_id STRING,
    order_item_id INT,
    product_id STRING,
    seller_id STRING,
    shipping_limit_date TIMESTAMP_NTZ,
    price FLOAT,
    freight_value FLOAT
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_geolocation_dataset (
    geolocation_zip_code_prefix INT,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city STRING,
    geolocation_state STRING
);

CREATE OR REPLACE TABLE ecommerce.raw.olist_customers_dataset (
    customer_id STRING,
    customer_unique_id STRING,
    customer_zip_code_prefix INT,
    customer_city STRING,
    customer_state STRING
);

CREATE OR REPLACE TABLE ecommerce.raw.product_category_name_translation (
    product_category_name STRING,
    product_category_name_english STRING
);
