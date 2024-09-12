CREATE OR REPLACE TABLE ecommerce.meta.olist_sellers_dataset (
    s3_path STRING NOT NULL,               -- Full S3 path of the file
    stage_path STRING NOT NULL,            -- Snowflake stage path
    fiscal_year INT,                       -- Year of the DAG execution
    fiscal_month INT,                      -- Month of the DAG execution
    fiscal_day INT,                        -- Day of the DAG execution
    row_count INT,                         -- Number of rows in the file
    file_header STRING,                    -- Header of the file (if applicable)
    file_size NUMBER,                      -- File size in bytes
    last_modified TIMESTAMP_NTZ,           -- Last modified timestamp of the file
    file_type STRING,                      -- File type (CSV, JSON, etc.)
    checksum STRING,                       -- MD5 checksum for file integrity
    execution_timestamp TIMESTAMP_NTZ,     -- Timestamp when the DAG ran
    load_id STRING,                        -- Unique identifier for the load
    file_id STRING,                        -- Identifier for the file     
    PRIMARY KEY (s3_path)                  -- Unique constraint on S3 path to avoid duplicates
);


CREATE OR REPLACE TABLE ecommerce.meta.olist_products_dataset (
    s3_path STRING NOT NULL,               -- Full S3 path of the file
    stage_path STRING NOT NULL,            -- Snowflake stage path
    fiscal_year INT,                       -- Year of the DAG execution
    fiscal_month INT,                      -- Month of the DAG execution
    fiscal_day INT,                        -- Day of the DAG execution
    row_count INT,                         -- Number of rows in the file
    file_header STRING,                    -- Header of the file (if applicable)
    file_size NUMBER,                      -- File size in bytes
    last_modified TIMESTAMP_NTZ,           -- Last modified timestamp of the file
    file_type STRING,                      -- File type (CSV, JSON, etc.)
    checksum STRING,                       -- MD5 checksum for file integrity
    execution_timestamp TIMESTAMP_NTZ,     -- Timestamp when the DAG ran
    load_id STRING,                        -- Unique identifier for the load
    file_id STRING,                        -- Identifier for the file    
    PRIMARY KEY (s3_path)                  -- Unique constraint on S3 path to avoid duplicates
);


CREATE OR REPLACE TABLE ecommerce.meta.olist_orders_dataset (
    s3_path STRING NOT NULL,               -- Full S3 path of the file
    stage_path STRING NOT NULL,            -- Snowflake stage path
    fiscal_year INT,                       -- Year of the DAG execution
    fiscal_month INT,                      -- Month of the DAG execution
    fiscal_day INT,                        -- Day of the DAG execution
    row_count INT,                         -- Number of rows in the file
    file_header STRING,                    -- Header of the file (if applicable)
    file_size NUMBER,                      -- File size in bytes
    last_modified TIMESTAMP_NTZ,           -- Last modified timestamp of the file
    file_type STRING,                      -- File type (CSV, JSON, etc.)
    checksum STRING,                       -- MD5 checksum for file integrity
    execution_timestamp TIMESTAMP_NTZ,     -- Timestamp when the DAG ran
    load_id STRING,                        -- Unique identifier for the load
    file_id STRING,                        -- Identifier for the file     
    PRIMARY KEY (s3_path)                  -- Unique constraint on S3 path to avoid duplicates
);


CREATE OR REPLACE TABLE ecommerce.meta.olist_order_reviews_dataset (
    s3_path STRING NOT NULL,               -- Full S3 path of the file
    stage_path STRING NOT NULL,            -- Snowflake stage path
    fiscal_year INT,                       -- Year of the DAG execution
    fiscal_month INT,                      -- Month of the DAG execution
    fiscal_day INT,                        -- Day of the DAG execution
    row_count INT,                         -- Number of rows in the file
    file_header STRING,                    -- Header of the file (if applicable)
    file_size NUMBER,                      -- File size in bytes
    last_modified TIMESTAMP_NTZ,           -- Last modified timestamp of the file
    file_type STRING,                      -- File type (CSV, JSON, etc.)
    checksum STRING,                       -- MD5 checksum for file integrity
    execution_timestamp TIMESTAMP_NTZ,     -- Timestamp when the DAG ran
    load_id STRING,                        -- Unique identifier for the load
    file_id STRING,                        -- Identifier for the file     
    PRIMARY KEY (s3_path)                  -- Unique constraint on S3 path to avoid duplicates
);


CREATE OR REPLACE TABLE ecommerce.meta.olist_order_payments_dataset (
    s3_path STRING NOT NULL,               -- Full S3 path of the file
    stage_path STRING NOT NULL,            -- Snowflake stage path
    fiscal_year INT,                       -- Year of the DAG execution
    fiscal_month INT,                      -- Month of the DAG execution
    fiscal_day INT,                        -- Day of the DAG execution
    row_count INT,                         -- Number of rows in the file
    file_header STRING,                    -- Header of the file (if applicable)
    file_size NUMBER,                      -- File size in bytes
    last_modified TIMESTAMP_NTZ,           -- Last modified timestamp of the file
    file_type STRING,                      -- File type (CSV, JSON, etc.)
    checksum STRING,                       -- MD5 checksum for file integrity
    execution_timestamp TIMESTAMP_NTZ,     -- Timestamp when the DAG ran
    load_id STRING,                        -- Unique identifier for the load
    file_id STRING,                        -- Identifier for the file     
    PRIMARY KEY (s3_path)                  -- Unique constraint on S3 path to avoid duplicates
);


CREATE OR REPLACE TABLE ecommerce.meta.olist_order_items_dataset (
    s3_path STRING NOT NULL,               -- Full S3 path of the file
    stage_path STRING NOT NULL,            -- Snowflake stage path
    fiscal_year INT,                       -- Year of the DAG execution
    fiscal_month INT,                      -- Month of the DAG execution
    fiscal_day INT,                        -- Day of the DAG execution
    row_count INT,                         -- Number of rows in the file
    file_header STRING,                    -- Header of the file (if applicable)
    file_size NUMBER,                      -- File size in bytes
    last_modified TIMESTAMP_NTZ,           -- Last modified timestamp of the file
    file_type STRING,                      -- File type (CSV, JSON, etc.)
    checksum STRING,                       -- MD5 checksum for file integrity
    execution_timestamp TIMESTAMP_NTZ,     -- Timestamp when the DAG ran
    load_id STRING,                        -- Unique identifier for the load
    file_id STRING,                        -- Identifier for the file     
    PRIMARY KEY (s3_path)                  -- Unique constraint on S3 path to avoid duplicates
);


CREATE OR REPLACE TABLE ecommerce.meta.olist_geolocation_dataset (
    s3_path STRING NOT NULL,               -- Full S3 path of the file
    stage_path STRING NOT NULL,            -- Snowflake stage path
    fiscal_year INT,                       -- Year of the DAG execution
    fiscal_month INT,                      -- Month of the DAG execution
    fiscal_day INT,                        -- Day of the DAG execution
    row_count INT,                         -- Number of rows in the file
    file_header STRING,                    -- Header of the file (if applicable)
    file_size NUMBER,                      -- File size in bytes
    last_modified TIMESTAMP_NTZ,           -- Last modified timestamp of the file
    file_type STRING,                      -- File type (CSV, JSON, etc.)
    checksum STRING,                       -- MD5 checksum for file integrity
    execution_timestamp TIMESTAMP_NTZ,     -- Timestamp when the DAG ran
    load_id STRING,                        -- Unique identifier for the load
    file_id STRING,                        -- Identifier for the file     
    PRIMARY KEY (s3_path)                  -- Unique constraint on S3 path to avoid duplicates
);

CREATE OR REPLACE TABLE ecommerce.meta.olist_customers_dataset (
    s3_path STRING NOT NULL,               -- Full S3 path of the file
    stage_path STRING NOT NULL,            -- Snowflake stage path
    fiscal_year INT,                       -- Year of the DAG execution
    fiscal_month INT,                      -- Month of the DAG execution
    fiscal_day INT,                        -- Day of the DAG execution
    row_count INT,                         -- Number of rows in the file
    file_header STRING,                    -- Header of the file (if applicable)
    file_size NUMBER,                      -- File size in bytes
    last_modified TIMESTAMP_NTZ,           -- Last modified timestamp of the file
    file_type STRING,                      -- File type (CSV, JSON, etc.)
    checksum STRING,                       -- MD5 checksum for file integrity
    execution_timestamp TIMESTAMP_NTZ,     -- Timestamp when the DAG ran
    load_id STRING,                        -- Unique identifier for the load
    file_id STRING,                        -- Identifier for the file     
    PRIMARY KEY (s3_path)                  -- Unique constraint on S3 path to avoid duplicates
);

CREATE OR REPLACE TABLE ecommerce.meta.product_category_name_translation (
    s3_path STRING NOT NULL,               -- Full S3 path of the file
    stage_path STRING NOT NULL,            -- Snowflake stage path
    fiscal_year INT,                       -- Year of the DAG execution
    fiscal_month INT,                      -- Month of the DAG execution
    fiscal_day INT,                        -- Day of the DAG execution
    row_count INT,                         -- Number of rows in the file
    file_header STRING,                    -- Header of the file (if applicable)
    file_size NUMBER,                      -- File size in bytes
    last_modified TIMESTAMP_NTZ,           -- Last modified timestamp of the file
    file_type STRING,                      -- File type (CSV, JSON, etc.)
    checksum STRING,                       -- MD5 checksum for file integrity
    execution_timestamp TIMESTAMP_NTZ,     -- Timestamp when the DAG ran
    load_id STRING,                        -- Unique identifier for the load
    file_id STRING,                        -- Identifier for the file    
    PRIMARY KEY (s3_path)                  -- Unique constraint on S3 path to avoid duplicates
);
