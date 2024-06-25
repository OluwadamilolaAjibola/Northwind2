{{config(materialized='table')}}
WITH first_purchase AS (
    SELECT
        "customerId",
        MIN("orderdate") AS first_order_date
    FROM
        {{ref ("sl_orders")}}
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
        {{ref ("sl_orders")}} o
    JOIN
        first_purchase fp
    ON
        o."customerId" = fp."customerId"
)
SELECT
    "customerId",
    "first_order_date",
    MAX("orderdate") AS last_order_date,
    COUNT(*) FILTER (WHERE is_repeat = 1) AS repeat_orders,
    CASE
        WHEN COUNT(*) FILTER (WHERE is_repeat = 1) > 0 THEN 1
        ELSE 0
    END AS is_retained
FROM
    repeat_purchases
GROUP BY
    "customerId", "first_order_date"
