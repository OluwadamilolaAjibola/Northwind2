{{config(materialized = 'table')}}

select
 "productId",
 "productName",
 "supplierId",
 "categoryId",
 "quantityPerUnit",
 "unitPrice",
 "unitsInStock",
 "unitsOnOrder",
 "reorderLevel",
 "discontinued"

 from {{ref("br_product")}}