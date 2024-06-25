  {{config (materialized='table') }}


  with source_categories as (
    select *
    from {{source('Northwind2','Categories')}}
  )

  select * from source_categories