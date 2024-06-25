{{config(materialized = 'table')}}
select
"territoryId",
"territoryDescription",
"regionDescription"
 from {{ref("br_territory")}} as t
 left join {{ref("br_region")}} as r on t."regionId" = r."regionId"