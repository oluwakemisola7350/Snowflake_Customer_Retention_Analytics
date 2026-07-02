--=================================--
    -- Dimensions Staging --
--=================================--

--========================--
    -- Create View --
--========================--
CREATE VIEW vw_CUSTOMERSTAGING AS (
    SELECT 
        CUSTOMER_ID,
        TRIM(FIRST_NAME || ' ' || COALESCE(MIDDLE_NAME, '')  || ' ' || LAST_NAME) CUSTOMER_NAME, 
        LOWER(EMAIL) EMAIL, 
        COUNTRY, 
        STATE, 
        CITY,
        AGE,
        GENDER, 
        MARITAL_STATUS,
        ANNUAL_INCOME,
        CAST(SIGNUP_DATE AS DATE) SIGNUP_DATE
FROM DATABASE_CUSTOMERS_ANALYTICS.PUBLIC.CUSTOMERS_DATASET 
);
