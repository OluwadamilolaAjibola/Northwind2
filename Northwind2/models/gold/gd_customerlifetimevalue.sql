 {{config ( materialized = 'table')}}
 WITH total_revenue AS (
    SELECT
        SUM("total sales") AS total_revenue,
        COUNT("orderID") AS total_orders
    FROM
        {{ref ("sl_ordersdetails")}}
),
average_order_value AS (
    SELECT
        SUM("total sales")/ COUNT ("orderID") AS avg_order_value
    FROM
        {{ ref ("sl_ordersdetails")}}
),
total_orders AS (
    SELECT
        COUNT("orderID") AS total_orders
    FROM
        {{ ref ("sl_ordersdetails")}}
),
unique_customers AS (
    SELECT
        COUNT(DISTINCT "customerId") AS unique_customers
    FROM
        {{ ref ("sl_orders")}}
),
purchase_frequency AS (
    SELECT
      total_orders / unique_customers as pf
      FROM 
      total_orders,unique_customers
),
customer_value AS (
    SELECT
     avg_order_value * pf as cv
     FROM average_order_value,purchase_frequency
      
),
customer_lifespan AS (
    SELECT
        "customerId",
        MAX("orderdate") - MIN("orderdate") AS lifespan
    FROM
        {{ ref ("sl_orders")}}
    GROUP BY
        "customerId"
),
average_customer_lifespan AS (
    SELECT
        AVG("lifespan") AS avg_customer_lifespan
    FROM
        customer_lifespan
)
SELECT
    cv * avg_customer_lifespan AS customer_lifetime_value
FROM
    customer_value, average_customer_lifespan
