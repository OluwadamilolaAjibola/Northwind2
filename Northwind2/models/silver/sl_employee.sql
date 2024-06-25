{{config(materialized = 'table')}}

select
 "employeeId",
 "lastName",
 "firstName",
 "title",
 date("birthDate") as Birthdate,
 date("hireDate") as Hiredate,
 "address",
 "country",
 "city",
 "postalCode",
 "reportsTo"

 from {{ref("br_employee")}}