{{config(materialized= 'table')}}
select 
concat(e."firstName",'',e."lastName") as FullName,
count(o."orderId") as TotalOrder,
sum(od."total sales") as Revenue
from 
{{ref("sl_ordersdetails")}}  od
left join 
{{ref("sl_orders")}} o
 on od."orderID" = o."orderId"
 left join
 {{ref("sl_employee")}} e
 on o."employeeId" = e."employeeId"
 group by concat(e."firstName",'',e."lastName")
 order by count(o."orderId")desc