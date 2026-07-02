
--==============================================================================--
		-- Rolling 90-Day Churn And Revenue Leaked by Churned Customers --
--==============================================================================--

--=====================--
	-- Create CTE --
--=====================--

CREATE VIEW VW_CustomerMetrix AS (
WITH CTE_CHURN AS (
	    SELECT 
            Customer_ID,
            MAX(CAST(ORDER_DATE AS DATE)) LAST_ORDER_DATE,
            AVG(p.UNIT_PRICE * o.QUANTITY) CUSTOMER_AOV,
	    CASE WHEN DATEDIFF(DAY,MAX(CAST(ORDER_DATE AS DATE)), GETDATE()) > 90 THEN 1 ELSE 0 END CHURN
	    FROM VW_ORDERSTAGING o
        LEFT JOIN VW_PRODUCTSTAGING p
        ON p.PRODUCT_ID = o.PRODUCT_ID
        GROUP BY CUSTOMER_ID
),
    
--=======================================================--
		-- Average Days To First Repeat Purchase --
--=======================================================--

    CTE_TIME_TO_VALUE AS (
        SELECT
            CUSTOMER_ID,
            ORDER_DATE,
            ROW_NUMBER() OVER(PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) ORDER_SEQUENCE
        FROM VW_ORDERSTAGING
),

--================================================================--
		-- Days Between First Purchase And Second Purchase --
--================================================================--

    CTE_DAYS_BETWEEN AS (
        SELECT
            CUSTOMER_ID,
            DATEDIFF(
                DAY,MIN(CASE WHEN ORDER_SEQUENCE = 1 THEN ORDER_DATE END),
                    MIN(CASE WHEN ORDER_SEQUENCE = 2 THEN ORDER_DATE END)
            ) DAYS_TO_SECOND_PURCHASE
        FROM CTE_TIME_TO_VALUE
        GROUP BY CUSTOMER_ID
),

    CTE_DAYS_TO_DELIVER AS (
        SELECT
            o.CUSTOMER_ID,
            AVG(DATEDIFF(DAY, o.ORDER_DATE, l.DELIVERY_DATE)) AS DAYS_TO_DELIVER
        FROM VW_LOGISTICSTAGING l
        LEFT JOIN VW_ORDERSTAGING o
        ON l.ORDER_ID = o.ORDER_ID
        GROUP BY o.CUSTOMER_ID
)


--=====================--
	-- Main Query --
--=====================--

	SELECT
          c.CUSTOMER_ID,
          c.CUSTOMER_NAME,
          c.EMAIL,
          c.COUNTRY,
          c.STATE,
          c.CITY,
          c.AGE,
          c.GENDER,
          c.MARITAL_STATUS,
          c.ANNUAL_INCOME,
          c.SIGNUP_DATE,
          cc.LAST_ORDER_DATE,
          cc.CHURN,
          cc.CUSTOMER_AOV,
        CASE WHEN cc.CHURN = 1 THEN cc.CUSTOMER_AOV ELSE 0 END LEAKED_REVENUE,  
        CASE WHEN cc.CHURN = 0 THEN cc.CUSTOMER_AOV ELSE 0 END RETAINED_REVENUE,
          cdb.DAYS_TO_SECOND_PURCHASE,
          dtd.DAYS_TO_DELIVER
  FROM VW_CUSTOMERSTAGING c
  LEFT JOIN CTE_CHURN cc
  ON cc.CUSTOMER_ID = c.CUSTOMER_ID 
  LEFT JOIN CTE_DAYS_BETWEEN cdb
  ON cdb.CUSTOMER_ID = c.CUSTOMER_ID
  LEFT JOIN CTE_DAYS_TO_DELIVER dtd
  ON dtd.CUSTOMER_ID = c.CUSTOMER_ID
)