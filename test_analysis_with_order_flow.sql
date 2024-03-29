-- tests/test_analysis_with_order_flow.sql

SELECT
    *
FROM
    {{ ref('financial_analysis_with_order_flow') }}
WHERE
    -- Add any conditions to test the accuracy or logic of your models
