{{config( materialized = 'table')}}

with source_ordersdetails as (
    select *
    from {{source ('Northwind2','ordersdetails')}}
)

select * 
from source_ordersdetails