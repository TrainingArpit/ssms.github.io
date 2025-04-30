create database payrollap;
use payrollap;
--------------------------------------------------------------------------------------------
create table Employees(
Emp_id int identity(1,1) primary key,
Emp_fname varchar(200),
Emp_lname varchar(100),
Emp_dob date not null,
Dept_id int not null
foreign key (Dept_id) references Department(Dept_id) 
);
------------------------------------------------------
create table Department(
Dept_id int identity(1,1) primary key,
Dept_name nvarchar(200) not null
);

select * from Employees;
select * from Department;

insert into Department(Dept_name)
values
('IT Department'),
('HR Department'),
('Training Department');

insert into Employees(Emp_fname,Emp_lname,Emp_dob,Dept_id)
values
('Arpit','Thakur','2000-12-08',2),
('Vee','Thakur','1999-05-09',1),
('Akash','Kumar','1999-01-02',2),
('Pinky','Dinky','2002-06-29',3);

insert into Employees(Emp_fname,Emp_lname,Emp_dob,Dept_id)
values
('Radhe','Mohan','2000-06-23',1);
--------------------------------------------------------------------------------------------------
CREATE FUNCTION GetFullName(@Fname nvarchar(50),@Lname nvarchar(50))

Returns nvarchar(100)

As
begin 
RETURN (@Fname + ' ' +@Lname)
End

select dbo.GetFullName('Arpit','Thakur')

----------------------------------------------------------------------------------------------------
create Function GetEmployeeList()
Returns Table
as 
Return
(
select emp_id ,emp_fname,emp_lname
from employees where dept_id=1
)

select * from dbo.GetEmployeeList();
----------------------------------------------------------------------------------------------------
Create Function GetEmployeeListByDept(@dept_id int)
Returns @Result Table (emp_id int,emp_fname nvarchar(100))
as
Begin
 Insert into @Result
 Select emp_id,emp_fname from employees
 where dept_id = @dept_id
 return
end
select * from dbo.GetEmployeeListbyDept(1); 
-----------------------------------------------------------------------------------------------------
CREATE Function GetEmployeeListCount()
Returns int
As
Begin 
return(
select count(*) from Employees)
end
select dbo.GetEmployeeListCount();
------------------------------------------------------------------------------------------------------
