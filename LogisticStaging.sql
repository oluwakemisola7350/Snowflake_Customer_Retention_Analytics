--=================================--
    -- Dimensions Staging --
--=================================--

--========================--
    -- Create View --
--========================--

CREATE VIEW VW_LOGISTICSTAGING AS (
    SELECT
        ORDER_ID,
        COALESCE(TRACKING_NUMBER, '-') TRACKING_NUMBER,
        CARRIER, 
        COALESCE(TRY_TO_DATE(SHIP_DATE), TRY_TO_DATE(REPLACE(SHIP_DATE , '/', '-'), 'YYYY-MM-DD')) SHIP_DATE,
        CAST(DELIVERY_DATE AS DATE) DELIVERY_DATE,
        DELIVERY_STATUS
    FROM LOGISTICS_DATASET
)