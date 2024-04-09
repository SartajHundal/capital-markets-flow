-- models/order_flow_transform.sql

WITH raw_order_flow AS (
    SELECT
        *
    FROM
        {{ ref('raw_order_flow_data') }}
),
cleaned_order_flow AS (
    SELECT
        -- Data Type Conversion
        CAST(timestamp_column AS TIMESTAMP) AS timestamp_column,
        CAST(amount_column AS DECIMAL(10, 2)) AS amount_column,
        -- Handling Missing Values
        -- (Assuming missing values are allowed in this case)
        COALESCE(column_name, 'N/A') AS column_name,
        -- Normalization
        CASE 
            WHEN currency_column = 'USD' THEN amount_column
            WHEN currency_column = 'EUR' THEN amount_column * conversion_rate_to_usd
            ELSE NULL
        END AS usd_amount,
        -- Handling Outliers (Assuming filtering outliers is done beforehand)
        -- Standardization
        LOWER(text_column) AS text_column
    FROM
        raw_order_flow
    WHERE
        -- Data Validation (Example: Checking if order timestamps fall within a valid range)
        timestamp_column BETWEEN 'start_date' AND 'end_date'
)

SELECT
    *
FROM
    cleaned_order_flow;
