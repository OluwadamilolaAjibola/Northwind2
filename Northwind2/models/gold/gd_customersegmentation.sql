 {{ config ( materialized = 'table')}}
 WITH recency AS (
    SELECT
        "customerId",
        current_date - MAX("orderdate") AS recency
    FROM
        {{ ref ( "sl_orders")}}
    GROUP BY
        "customerId"
),
frequency AS (
    SELECT
        "customerId",
        COUNT("orderId") AS frequency
    FROM
        {{ ref ("sl_orders")}}
    GROUP BY
        "customerId"
),
monetary AS (
    SELECT
        o."customerId",
        SUM(od."total sales") AS monetary
    FROM
        {{ ref ("sl_orders")}} o
        JOIN
        {{ ref ("sl_ordersdetails")}} od
        ON o."orderId" = od."orderID"
    GROUP BY
        "customerId"
),
rfm AS (
    SELECT
        r."customerId",
        r."recency",
        f."frequency",
        m."monetary",
        NTILE(3) OVER (ORDER BY r."recency") AS recency_segment,
        NTILE(3) OVER (ORDER BY f."frequency" DESC) AS frequency_segment,
        NTILE(3) OVER (ORDER BY m."monetary" DESC) AS monetary_segment
    FROM
        recency r
    JOIN
        frequency f ON r."customerId" = f."customerId"
    JOIN
        monetary m ON r."customerId" = m."customerId"
)
SELECT
    "customerId",
    "recency",
    "frequency",
    "monetary",
    "recency_segment",
    "frequency_segment",
    "monetary_segment",
    CONCAT("recency_segment", "frequency_segment", "monetary_segment") AS rfm_score
FROM
    rfm

