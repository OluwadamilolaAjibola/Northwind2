{{config(materialized = 'table')}}
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
),
cohort_orders AS (
    SELECT
        c.cohort_month,
        DATE_TRUNC('month', o.orderdate) AS order_month,
        COUNT(DISTINCT o."customerId") AS customers
    FROM
        {{ref("sl_orders")}} o
    JOIN
        cohorts c ON o."customerId" = c."customerId"
    GROUP BY
        c.cohort_month,
        DATE_TRUNC('month', o.orderdate)
)
SELECT
    cohort_month,
    order_month,
    customers,
    ROUND((customers * 100.0) / 
          FIRST_VALUE(customers) OVER (PARTITION BY cohort_month ORDER BY order_month), 2) AS retention_rate
FROM
    cohort_orders
ORDER BY
    cohort_month,
    order_month
