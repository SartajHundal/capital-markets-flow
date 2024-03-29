-- models/order_flow_transform.sql

WITH raw_order_flow AS (
    SELECT
        *
    FROM
        {{ ref('raw_order_flow_data') }}
),
cleaned_order_flow AS (
    SELECT
        *,
        -- Add any cleaning or transformation logic here
    FROM
        raw_order_flow
)

SELECT
    *
FROM
    cleaned_order_flow
