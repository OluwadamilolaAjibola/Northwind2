{{config(materialized = 'table')}}
select
p."productName" as Products,
sum(od."quantity") as Totalquantitysold,
sum(od."total sales") as Revenue,
count(od."orderID") as totalNumberofOrders
from
{{ref("sl_product")}} p 
left join
{{ref("sl_ordersdetails")}} od 
on 
p."productId" = od."productID"
group by p."productName" 
order by sum(od."quantity") desc
limit 10