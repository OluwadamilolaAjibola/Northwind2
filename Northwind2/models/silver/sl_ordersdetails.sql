{{config(materialized = 'table')}}
 select 
 "orderID",
 "productID",
 "unitPrice",
 "quantity",
 "discount",
 "total sales"

 from {{ref("br_ordersdetails")}}