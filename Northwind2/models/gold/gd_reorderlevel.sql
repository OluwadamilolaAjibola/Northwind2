{{config ( materialized ='table'  )}}

select 
"productId",
"productName",
c."categoryId",
"categoryName",
"reorderLevel",
"discontinued"

from {{ref ("sl_product")}} as p
left join {{ref ("sl_categories")}} as c on p."categoryId" = c."categoryId"
where "reorderLevel"= 0 and "discontinued" = 'false'