--=================================--
    -- Dimensions Staging --
--=================================--

--========================--
    -- Create View --
--========================--

CREATE VIEW VW_PRODUCTSTAGING AS (
    SELECT 
        PRODUCT_ID,
        TRIM(PRODUCT_NAME) PRODUCT_NAME,
        TRIM(CATEGORY) CATEGORY,
        UNIT_PRICE
    FROM PRODUCTS_DATASET
)