--=================================--
         -- Facts Staging --
--=================================--

--========================--
    -- Create View --
--========================--

CREATE VIEW VW_ORDERSTAGING AS (
    SELECT 
        ORDER_ID,
        CUSTOMER_ID,
        SELLER_ID,
        PRODUCT_ID,
        COALESCE(QUANTITY, 1) QUANTITY,
        CAST(ORDER_DATE AS DATE) ORDER_DATE
    FROM ORDERS_DATASET
)
