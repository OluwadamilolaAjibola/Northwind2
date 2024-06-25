{{config (materialized = 'table')}}
WITH first_purchase AS (
    SELECT
        "customerId",
        MIN("orderdate") AS first_order_date
    FROM
        {{ ref ("sl_orders") }}
    GROUP BY
        "customerId"
),
repeat_purchases AS (
    SELECT
        o."customerId",
        o."orderdate",
        fp."first_order_date",
        CASE
            WHEN o."orderdate" > fp."first_order_date" THEN 1
            ELSE 0
        END AS is_repeat
    FROM
        {{ ref ("sl_orders")}} AS o
    JOIN
        first_purchase fp
    ON
        o."customerId" = fp."customerId"
),
customer_retention AS (
    SELECT
        "customerId",
        MAX(is_repeat) AS is_retained
    FROM
        repeat_purchases
    GROUP BY
        "customerId"
)
SELECT
    COUNT(*) FILTER (WHERE is_retained = 1) * 1.0 / COUNT(*) AS retention_rate
FROM
    customer_retention
