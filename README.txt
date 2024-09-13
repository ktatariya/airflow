Overview
This repository showcases a robust data engineering pipeline that leverages AWS S3, Snowflake, and Apache Airflow (hosted locally through Astronomer) to create a scalable and maintainable data pipeline. The pipeline is designed for batch processing and includes features for data ingestion, transformation, and reporting.

Features
Data Lake and Data Warehouse Integration: Utilizes AWS S3 for raw and staging data storage and Snowflake for data warehousing.
Open Source Orchestration: Apache Airflow manages the pipeline tasks and schedules, deployed locally via Astronomer.
Parameterized and Dynamic: Uses variables and parameters to avoid hardcoding, ensuring maintainability and standardization.
Security and Access Control: Implements IAM for user management and role-based access control in Snowflake.
Flexible and Scalable: Designed to handle large datasets and easily scalable for different data volumes.
Time Travel and Historical Data Management: Supports historical data management and time-travel capabilities in Snowflake.
Reporting Layer: Builds a reporting layer view from raw and staging datasets.
Architecture

AWS S3: Raw and staging data storage.
Snowflake: Data warehouse with schemas for raw, meta, staging, and reporting.
Apache Airflow: DAG for orchestrating the pipeline tasks, including data ingestion, transformation, and reporting.
Pipeline Structure
Raw Data Storage: Data ingested into S3 from various sources.
Staging Layer: Data is staged and transformed into a standardized format in S3.
Data Warehouse: Data is loaded into Snowflake, processed into raw, meta, staging, and reporting schemas.
Reporting Layer: A reporting view is created in Snowflake from the staging data.
Dataset
The pipeline uses the Brazilian E-Commerce Public Dataset by Olist, available on Kaggle.

Credits
Dataset: Brazilian E-Commerce Public Dataset by Olist, provided through Kaggle.
Tools and Technologies: AWS S3, Snowflake, Apache Airflow (Astronomer), Python, SQL.
