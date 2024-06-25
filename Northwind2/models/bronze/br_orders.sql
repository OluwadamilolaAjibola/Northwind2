  {{config (materialized='table') }}


  with source_orders as (
    select *
    from {{source('Northwind2','Orders')}}
  )

  select * from source_orders