{{config (materialized = 'table')}}

with source_supplier as (
    select * 
    from {{source ( 'Northwind2','supplier')}}
)

select * from source_supplier