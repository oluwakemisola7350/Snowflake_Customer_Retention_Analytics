# Snowflake_Customer_Retention_Analytics
Advanced SQL analytics pipeline built in Snowflake utilizing complex CTEs and Window Functions to track Rolling 90days Churn, Leaked Revenue, Order Fulfilment Lag, and Customer Time To Value Metrics

# Snowflake Customer Retention & Revenue Analytics

This is An enterprise-level SQL analytics pipeline designed to calculate high-impact customer health and financial metrics directly within Snowflake.

## Key Analytics Engineered
* Rolling 90-Day Churn & Leaked Revenue: Identifies customers inactive for over 90 days and flags the exact revenue leaked vs. retained.
* Time-to-Value (TTV): Calculates the exact number of days it takes for a newly acquired customer to make their second repeat purchase.
* Logistics Performance: Computes the average days to deliver items ("DAYS_TO_DELIVER") to see if shipping speed impacts churn.
* Advanced Architecture: Built completely with performance-optimized Common Table Expressions (CTEs), DATEDIFF, and window ranking functions ("ROW_NUMBER() OVER (...)").
