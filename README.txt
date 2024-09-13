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



Usage
Run DAG: Trigger the ecommerce DAG from the Airflow UI.
Monitor Pipeline: Use Airflow’s monitoring tools to track task progress and troubleshoot issues.
Extend Features: Add logging, monitoring, and email notifications for enhanced functionality.



Future Improvements
Enhanced Logging and Monitoring: Implement detailed logging and failure notifications.
Optimized Folder Structure: Improve S3 folder organization for batch processing (e.g., weekly, daily).
Data Cleaning and Standardization: Add more features for data standardization and encoding.
Advanced Security: Further refine IAM policies and Snowflake access controls.


Disclaimer
This pipeline was developed rapidly over a two-day period with a primary focus on functionality. Code quality and standards, including comments, may not be up to the highest standards. However, security considerations have been prioritized, with appropriate IAM roles and Snowflake user access controls.
