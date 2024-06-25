{{config(materialized = 'table')}}

select
"supplierId",
"companyName",
"contactName",
"contactTitle",
"address",
"country",
"city",
"postalCode"

from {{ref("br_supplier")}}