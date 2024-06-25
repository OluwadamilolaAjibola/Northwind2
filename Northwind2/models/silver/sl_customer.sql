{{config(materialized = 'table' )}}
 select 
 "customerId",
 "companyName",
 "contactName" as customername,
 "contactTitle" as "customer job position",
 "address",
 "country",
 "city",
 "postalCode"

 from {{ref("br_customer")}}