{{config(materialized = 'table')}}
SELECT
    o."orderId",
    O."customerId",
    C."customername",
    O."orderdate" as TransactionDate,
    ROW_NUMBER() OVER (PARTITION BY O."customerId" ORDER BY O."orderdate") AS Transaction_number,
    MIN(O."orderdate") OVER (PARTITION BY O."customerId") as Firsttransactiondate
 FROM {{ref ("sl_ordersf")}} O
    LEFT JOIN {{ref("sl_customer")}} C
    ON O."customerId" = C."customerId"

    
