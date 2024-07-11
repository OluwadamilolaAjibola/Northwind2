{{ config(materialized ='table')}}
select 
s."companyName" as shipping_method,
count(o."orderId") as totalNumberofOrders,
o."shipid"  
from 
{{ref ("sl_orders")}} as o
left join 
{{ref("sl_shipper")}} as s
on o."shipid"= s."shipperId"
group by s."companyName",o."shipid"  
order by count(o."orderId")  desc