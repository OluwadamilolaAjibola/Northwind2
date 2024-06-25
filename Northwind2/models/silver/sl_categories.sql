{{config(materialized = 'table')}}

select
"categoryId",
 "categoryName"

 from {{ref("br_categories")}}