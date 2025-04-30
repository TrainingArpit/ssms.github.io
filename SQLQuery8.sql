CREATE  DATABASE SCMDB;
USE SCMDB;

Create table Products
(
p_id int identity(1,1) Primary key,
p_name nvarchar(100) not null,
p_price decimal(10,2)not null
);

select * from Products;