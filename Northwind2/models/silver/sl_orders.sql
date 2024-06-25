{{config(materialized = 'table')}}

select 
"orderId",
"customerId",
"employeeId",
date("orderDate") as Orderdate,
date("requiredDate") as requiredDate,
date("shippedDate") as shippedDate,
date("shippedDate") - date("orderDate") as "days to ship orders",
"shipVia" as ShipId,
"shipCountry",
"shipCity",
"shipPostalCode",
(CASE 
    WHEN "shipCountry" IN ('Argentina', 'Venezuela', 'Brazil') THEN 'South America'
    WHEN "shipCountry" IN ('Spain', 'Switzerland', 'Italy', 'Belgium', 'Norway', 'Sweden', 'France', 'Austria', 'Poland', 'UK', 'Ireland', 'Germany', 'Denmark', 'Portugal', 'Finland') THEN 'Europe'
    WHEN "shipCountry" IN ('USA', 'Mexico', 'Canada') THEN 'North America'
    ELSE 'Other'
END) as Continent

 from {{ref("br_orders")}} 
