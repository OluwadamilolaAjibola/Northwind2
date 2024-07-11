{{config(materialized='table')}}
select
c."customername",
sum(od."total sales") as Revenue
from
{{ref("sl_customer")}} c
left join 
{{ref("sl_orders")}} o
on o."customerId" = c."customerId"
join
{{ref("sl_ordersdetails")}} od
on 
o."orderId" = od."orderID"
group by c."customername"
order by sum(od."total sales") desc
limit 10