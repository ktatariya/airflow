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




Future Enhancements
While this pipeline is already powerful and functional, there is potential to extend its capabilities even further:

Additional AWS Tools: Integrating services like AWS Lambda, SNS, WorkMail, SES, SQS, and FTP would allow for features such as automated DAG failure notifications, alerts on file arrival in S3, and much more. The current pipeline is kept simple due to the scope of the dataset and time constraints, but these features can be implemented quickly if needed.

Enhanced Data Cleaning and Standardization: For larger datasets or more complex use cases, features like enforcing UTF-8 encoding, cleaning, and standardizing to CSV formats could easily be added. For this specific project, since the dataset from Kaggle is relatively clean and only used once, I prioritized the core functionality over additional data transformations. However, adding these features would take minimal effort when required.

Folder Structure Improvements: While the current S3 structure is optimized for this use case, improvements for more complex batch processing schedules (e.g., daily, weekly, monthly) could be added for larger datasets.

Scalable Reporting Dashboards: Although not included in this setup, dashboards could be created with tools like Power BI, Looker, or Tableau, with real-time or periodic refresh depending on reporting needs. These can be tailored to fit various business requirements as they arise.



Disclaimer
This pipeline was developed in just two days with a focus on creating a fully functional, scalable data engineering pipeline using cutting-edge cloud tools. Given the simplicity of this use case (a one-time use Kaggle dataset and limited access to paid cloud technologies), I’ve chosen to keep the architecture lean and practical. However, it's important to note that adding more advanced features would be a matter of minutes.

The security setup is already strong with proper IAM roles and Snowflake access control, so no concerns there. All in all, this pipeline is designed to handle much larger and more complex datasets with minimal changes—perfect for batch processing, historical data management, and advanced reporting solutions.
