-- models/financial_analysis_with_order_flow.sql

WITH financial_data AS (
    SELECT
        *
    FROM
        {{ ref('financial_data_model') }}
),
order_flow_data AS (
    SELECT
        *
    FROM
        {{ ref('order_flow_transform') }}
)

SELECT
    financial_data.*,
    order_flow_data.*,
    -- Add any analysis or calculations that combine financial and order flow data
FROM
    financial_data
JOIN
    order_flow_data ON financial_data.company_id = order_flow_data.company_id
