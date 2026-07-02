# Snowflake Customer Intelligence & E-Commerce Revenue Warehouse

An end-to-end Analytics Engineering pipeline built completely within Snowflake. This repository demonstrates data profiling, staging layer transformations, cleaning architectures, and complex analytical models to uncover critical retention, operational, and financial insights.

## Repository Architecture & File Directory

The project is structured following modular modern data warehouse design principles:

### 1. Data Quality & Profiling Layer
These scripts execute complete data profiling checks across raw data assets to isolate anomalies. They leverage performance-optimized aggregation routines (`SUM(CASE WHEN [column] IS NULL THEN 1 ELSE 0 END)`) to audit data health prior to downstream consumption.
* **`CustomersDataQuality.sql`**: Audits client profile records for incomplete structural attributes.
* **`ProductsDataQuality.sql`**: Profiles inventory data to ensure pricing frameworks are complete.
* **`OrdersDataQuality.sql`**: Verifies transactional fields to safeguard revenue calculation metrics.
* **`SellersDataQuality.sql`**: Validates partner distributions and merchant profile attributes.
* **`LogisticsDataQuality.sql`**: Audits shipping timestamps and delivery milestones for missing data gaps.

### 2. Staging & Transformation Layer (Views)
These scripts clean raw data, explicitly cast variable types, map intuitive aliases, and encapsulate operational cleaning rules into clean, accessible Snowflake relational database views (`CREATE VIEW VW_[NAME] AS...`).
* **`CustomerStaging.sql`**: Normalizes demographic segments and maps unique client keys.
* **`ProductStaging.sql`**: Validates product categorical dimensions and retail pricing data.
* **`OrderStaging.sql`**: Formats purchase transaction timelines and isolates unique transaction lifecycles.
* **`SellerStaging.sql`**: Standardizes marketplace merchant dimensions and distributions.
* **`LogisticStaging.sql`**: Standardizes delivery dates and calculates logistics milestones.

### 3. Advanced Analytical Metric Layer
Advanced queries that transform clean staged data into high-value operational dashboards and business performance metrics.
* **`CustomerMetrix.sql`**: Uses multi-layered Common Table Expressions (CTEs) and SQL window functions (`ROW_NUMBER() OVER (...)`) to calculate rolling 90-day customer churn, identify leaked vs. retained revenue, track Time-to-Value (TTV), and calculate delivery lag impacts.
* **`Revenue_Contribution.sql`**: Evaluates category price elasticity and total financial impacts by aggregating total revenue streams across product categories to guide inventory optimization strategies.

## Technical Skillsets Demonstrated
* **Advanced Cloud SQL (Snowflake):** Advanced processing using views, analytical queries, and efficient transformation logic.
* **Data Profiling & Quality Assurance:** Pre-modeling data auditing to identify structure breakdowns and missing value counts.
* **Data Warehousing Design:** Practical application of staging layers (`STAGING`) and presentation layers (`METRICS`) to separate transformations.
* **Advanced Analytical Logic:** CTE implementation, window functions, time-series calculations (`DATEDIFF`), and financial leak segment analysis.

