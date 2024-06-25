{{config (materialized = 'table')}}

-- Create a temporary table to hold the cohort information
WITH first_order AS (
    SELECT
        "customerId",
        MIN(orderdate) AS first_order_date
    FROM
        {{ref("sl_orders")}}
    GROUP BY
        "customerId"
),
cohorts AS (
    SELECT
        "customerId",
        DATE_TRUNC('month', first_order_date) AS cohort_month
    FROM
        first_order
)

-- Join the cohort information with the orders table
SELECT
    c.cohort_month,
    DATE_TRUNC('month', o.orderdate) AS order_month,
    COUNT(DISTINCT o."customerId") AS customers,
    o."customerId"
FROM
    {{ref("sl_orders")}} o
JOIN
    cohorts c ON o."customerId" = c."customerId"
GROUP BY
    c.cohort_month,
    DATE_TRUNC('month', o.orderdate),
    o."customerId"
ORDER BY
    c.cohort_month,
    DATE_TRUNC('month', o.orderdate),
    o."customerId"

