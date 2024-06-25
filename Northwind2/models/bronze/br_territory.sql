{{config (materialized = 'table')}}

with source_territory as (
  select * 
  from {{source ('Northwind2','territory')}}

)

select *
from source_territory