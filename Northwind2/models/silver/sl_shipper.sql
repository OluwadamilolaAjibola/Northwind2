{{config(materialized = 'table')}}
select
 "shipperId",
 "companyName"

 from {{ref("br_shipper")}}