-- models/interest_coverage_ratio.sql

{% set interest_coverage_ratio_model = 'interest_coverage_ratio' %}

WITH ebit AS (
    SELECT
        company_id,
        SUM(value) AS ebit
    FROM
        {{ ref('financial_statements') }}
    WHERE
        statement_type = 'income_statement' AND
        account_type = 'income' AND
        account_subtype = 'ebit'
    GROUP BY
        company_id
),
interest_expense AS (
    SELECT
        company_id,
        SUM(value) AS interest_expense
    FROM
        {{ ref('financial_statements') }}
    WHERE
        statement_type = 'income_statement' AND
        account_type = 'expense' AND
        account_subtype = 'interest'
    GROUP BY
        company_id
)

SELECT
    ebit.company_id,
    ebit.ebit / interest_expense.interest_expense AS interest_coverage_ratio
FROM
    ebit
JOIN
    interest_expense ON ebit.company_id = interest_expense.company_id
