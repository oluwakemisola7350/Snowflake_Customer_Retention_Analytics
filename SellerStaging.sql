--=================================--
    -- Dimensions Staging --
--=================================--

--========================--
    -- Create View --
--========================--

CREATE VIEW VW_SELLERSTAGING AS (
    SELECT
        SELLER_ID,
        FIRST_NAME || ' ' || COALESCE(MIDDLE_NAME, '') || ' ' || LAST_NAME SELLERS_NAME,
        SELLER_RATING, 
        CAST(ONBOARDING_DATE AS DATE) ONBOARDING_DATE,
        TOTAL_REVENUE
    FROM SELLERS_DATABASE
)