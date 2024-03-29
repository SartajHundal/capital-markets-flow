-- models/nav.sql

WITH assets AS (
    SELECT
        id,
        asset_value,
        liability_value
    FROM
        {{ ref('raw_assets') }}
)

SELECT
    id,
    (SUM(asset_value) - SUM(liability_value)) AS nav
FROM
    assets
GROUP BY
    id
