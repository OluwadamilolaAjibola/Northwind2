{{config(materialized = 'table')}}

with source_product as (
    select * 
    from {{source ('Northwind2', 'product')}}
)

select * 
from source_product