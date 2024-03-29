-- models/npv.sql

WITH cash_flows AS (
    SELECT
        id,
        cash_flow,
        period
    FROM
        {{ ref('raw_cash_flows') }}
)

SELECT
    id,
    SUM(cash_flow / POWER(1 + discount_rate, period)) AS npv
FROM
    cash_flows
GROUP BY
    id
