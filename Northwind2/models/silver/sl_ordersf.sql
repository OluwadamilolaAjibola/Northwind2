{{config(materialized = 'table')}}
select 
o."orderId",
o."customerId",
o."employeeId", 
od."productID",
p."productName",
od."unitPrice",
od."quantity",
od."discount",
(od."total sales" * 0.6) as Costprice,
od."total sales",
(od."total sales" -(od."total sales" * 0.6)) as Profit,
((od."total sales" -(od."total sales" * 0.6))/(od."total sales")) as ProfitMargin,
date(o."orderDate") as Orderdate,
date(o."requiredDate") as requiredDate,
date(o."shippedDate") as shippedDate,
date(o."shippedDate") - date("orderDate") as "days to ship orders",
o."shipVia" as ShipId,
o."shipCountry",
o."shipCity",
o."shipPostalCode",
(CASE 
    WHEN o."shipCountry" IN ('Argentina', 'Venezuela', 'Brazil') THEN 'South America'
    WHEN o."shipCountry" IN ('Spain', 'Switzerland', 'Italy', 'Belgium', 'Norway', 'Sweden', 'France', 'Austria', 'Poland', 'UK', 'Ireland', 'Germany', 'Denmark', 'Portugal', 'Finland') THEN 'Europe'
    WHEN o."shipCountry" IN ('USA', 'Mexico', 'Canada') THEN 'North America'
    ELSE 'Other'
END) as Continent,
p."discontinued",
p."reorderLevel",
s."companyName",
c."categoryName",
sh."companyName" as ShipcompanyName,
ROW_NUMBER() OVER (PARTITION BY o."customerId" ORDER BY o."orderDate") AS Transaction_number,
MIN(date(o."orderDate")) OVER (PARTITION BY o."customerId") as Firsttransactiondate

 from {{ref("br_orders")}} o
 left join  {{ref("br_ordersdetails")}} od
 on o."orderId" = od."orderID"
 left join {{ref("br_product")}} p
 on p."productId" = od."productID"
 left join {{ref("br_supplier")}} s
 on s."supplierId" = p."supplierId"
 left join {{ref("br_categories")}} c
 on c."categoryId" = p."categoryId"
 left join {{ref("br_shipper")}} sh
 on o."shipVia" = sh."shipperId"