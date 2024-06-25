{{config (materialized = 'table')}}

with source_shipper as (
    select * 
    from {{source ('Northwind2','shipper')}}

)

select * from source_shipper