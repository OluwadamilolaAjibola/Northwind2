{{config (materialized ='table')}}

with source_employee as (
    select *
    from {{source ('Northwind2', 'Employees')}}
)

select * 
from source_employee