-- models/debt_equity_ratio.sql

{% set debt_to_equity_ratio_model = 'debt_to_equity_ratio' %}

WITH total_equity AS (
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
    total_equity.company_id,
    total_debt.total_debt / total_equity.total_equity AS debt_to_equity_ratio
FROM
    total_equity
JOIN
    total_debt ON total_equity.company_id = total_debt.company_id
