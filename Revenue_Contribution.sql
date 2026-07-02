--===========================================================--
    -- Category Price Elasticity & Revenue Contribution --
--=========================================================--

--==================--
  -- Create View --
--==================--
CREATE VIEW VW_PRODUCT_REVENUE_CONTRIBUTION AS (
    SELECT
        COUNT(o.ORDER_ID) ORDER_ID,
        p.CATEGORY,
        SUM(p.UNIT_PRICE * o.QUANTITY) TOTAL_REVENUE
    FROM VW_PRODUCTSTAGING p
    LEFT JOIN VW_ORDERSTAGING o
    GROUP BY p.CATEGORY
    ORDER BY SUM(p.UNIT_PRICE * o.QUANTITY) DESC
)














