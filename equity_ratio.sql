-- models/equity_ratio.sql

{% set equity_ratio_model = 'equity_ratio' %}

WITH total_assets AS (
    SELECT
        company_id,
        SUM(value) AS total_assets
    FROM
        {{ ref('financial_statements') }}
    WHERE
        statement_type = 'balance_sheet' AND
        account_type = 'asset'
    GROUP BY
        company_id
),
total_equity AS (
    SELECT
        company_id,
        SUM(value) AS total_equity
    FROM
        {{ ref('financial_statements') }}
    WHERE
        statement_type = 'balance_sheet' AND
        account_type = 'equity'
    GROUP BY
        company_id
)

SELECT
    total_assets.company_id,
    total_equity.total_equity / total_assets.total_assets AS equity_ratio
FROM
    total_assets
JOIN
    total_equity ON total_assets.company_id = total_equity.company_id
