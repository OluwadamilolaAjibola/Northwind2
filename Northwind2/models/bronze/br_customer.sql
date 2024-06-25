  {{config (materialized='table') }}


  with source_customer as (
    select *
    from {{source('Northwind2','Customer')}}
  )

  select * from source_customer