-- models/debt_ratio.sql

{% set debt_ratio_model = 'debt_ratio' %}

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
total_debt AS (
    SELECT
        company_id,
        SUM(value) AS total_debt
    FROM
        {{ ref('financial_statements') }}
    WHERE
        statement_type = 'balance_sheet' AND
        account_type = 'liability' AND
        account_subtype = 'debt'
    GROUP BY
        company_id
)

SELECT
    total_assets.company_id,
    total_debt.total_debt / total_assets.total_assets AS debt_ratio
FROM
    total_assets
JOIN
    total_debt ON total_assets.company_id = total_debt.company_id
