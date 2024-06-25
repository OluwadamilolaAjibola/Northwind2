{{config (materialized = 'table')}}

with source_region as (
    select *
    from {{source ('Northwind2', 'region' )}}
    )

    select * 
    from source_region