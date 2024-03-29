-- models/fpv.sql

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
    SUM(cash_flow * POWER(1 + growth_rate, period)) AS fpv
FROM
    cash_flows
GROUP BY
    id
