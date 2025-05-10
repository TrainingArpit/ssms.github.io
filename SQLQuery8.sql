CREATE  DATABASE SCMDB;
USE SCMDB;

Create table Products
(
p_id int identity(1,1) Primary key,
p_name nvarchar(100) not null,
p_price decimal(10,2)not null
);



Create table ProductsAudit
(
a_id int identity(1,1) Primary key,
p_id int not null,
a_type nvarchar(10) not null,
a_date datetime default getdate()
);

select * from Products;
select * from ProductsAudit;

------------------------------------------------------------------------------Trigger------------------------------------------------------------------

Create trigger trig_after_insert_product       
On Products
After INSERT
As
Begin 
  Insert INTO ProductsAudit(p_id,a_type)
  Select p_id,'INSERTED' From inserted ---------------inserted here is a system table-------------------
End
-------------------------------------------------------------------------------------------------------------------------------------------------------
insert into Products(p_name,p_price)
values
('Arpit',64000);

insert into Products(p_name,p_price)
values
('Vee',84000),
('Sky',74747),
('Dude',87466);

insert into Products(p_name,p_price)
values
('Hunk',85768);
insert into Products(p_name,p_price)
values
('NAMO NAMAH',8);

----------------------------------------------------------2ND TRIGGER------------------------------------------------------------------------------------
Create Trigger trg_io_insert_product
On Products
INSTEAD OF INSERT
AS BEGIN 
  
  insert into ProductsAudit(p_id,a_type)
  values(999,'Inserting')
 END
----------------------------------------------------FIRING 2 TRIGGERS HERE-------------------------------------------------------------------------------
alter Trigger trg_io_insert_product
On Products
INSTEAD OF INSERT
AS BEGIN 
  
  insert into ProductsAudit(p_id,a_type)
  values(999,'Inserting')

   insert into Products(p_name ,p_price)
   select p_name,p_price from inserted
END

insert into Products(p_name,p_price)
values
('Neymar',76800);