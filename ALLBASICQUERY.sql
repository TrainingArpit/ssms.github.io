create database Arpitprac;--------------create Database---------------------
go---------------------------------Marks the end of the batch---------------
use Arpitprac;---------------------------Use Database-----------------------
Create table employee1-------------------creating a Table--------------------ddl
(
e_id int identity(1,1) primary key,---------identity (1-its the first record,1-its for the increment)   (primary key unique identification pk-dml)
f_name nvarchar(50),
l_name nvarchar(50),
Birthdate Date,
Salary Decimal(10,2)
);

insert into employee1(f_name,l_name,Birthdate,Salary)----------insert values-------------------
values
('shittyy','mouth','2002-12-21',89485.23),
('Cute','Prey','2001-01-21',78985.23),
('Dark','brook','1998-02-19',65485.23);

select * FROM employee1;-----------------display data---------------------dql

alter table employee--------------------adding column-----------------------------ddl
ADD m_name varchar(50);

ALTER TABLE employee------------------deleting a column-------------------------------------------------------ddl
Drop column m_name;---------------------using drop------------------------ddl

Delete from employee-----------------deleting  a row using where clause---------------------------------------dml
where e_id =1;

update employee     ------------------updating a column-----------------------------dml
set f_name='RATTY'   
where e_id=2;

TRUNCATE table employee-----------------deletes all data of the table -------------------- ddl

update employee --------------------------one more update example ----------------------using where clause---------------------
set Salary =34634.12
where e_id =1;



Create LOGIN EmployeeUser WITH PASSWORD ='Strong password123!';
Create USER EmployeeUser  FOR LOGIN EmployeeUser;

----------------------------------------Some DCL commands-------------------------------------------
GRANT SELECT ON Employees TO EmployeeUser;-------assigns some permissions
GRANT INSERT ON Employees TO EmployeeUser;

REVOKE	SELECT ON Employees TO EmployeeUser;---------------remove the assigned positions
REVOKE INSERT ON Employees TO EmployeeUser;


----------------------------------------------TRANSACTIONS-----------------------------------------------
CREATE TABLE ACCOUNTS(
a_id int identity(1,1) Primary key,
a_holder nvarchar(50),
Balance Decimal(10,2)
)
INSERT INTO ACCOUNTS(a_holder,Balance)-------------------------------------------------dml
VALUES 
('Aro',3834.23),
('Crime',84834.12),
('Mkc',767767.23);

select * from ACCOUNTS;

-----------------------TRANSACTION HERE------------------
BEGIN TRANSACTION;
UPDATE ACCOUNTS
SET Balance =7584.89
WHERE a_id =2;

UPDATE ACCOUNTS
SET Balance =7584.89
WHERE a_id =2;
 
COMMIT TRANSACTION;
SELECT * FROM ACCOUNTS;

-------------------------------------Elaborated example for transactions---------------------
CREATE TABLE SalesTransactions(
T_id int identity(1,1),
Cust_Name NVARCHAR(50),
Product NVARCHAR(80),
Quality int,
Price Decimal(10,2),
T_Date DATE
);

INSERT INTO SalesTransactions(Cust_Name,Product,Quantity,Price,T_Date)
VALUES
('Kaali','Keyboard',1,800.99,'2025-07-29');
--('Arpit','Books',3,1499.22,'2025-06-10'),
--('Vee','Makeup kit',1,6000.22,'2025-08-12'),
--('Reddy','Trimmer',1,1600.99,'2025-08-23'),
--('Ram','Crockery',5,999.88,'2025-07-23'),
--('Kaali','laptop',1,61000.99,'2025-05-29');


UPDATE SalesTransactions-------------------------------------DML--------------------------------------------------------
SET T_Date ='2025-05-01'
WHERE T_id=5;
SELECT  * FROM SalesTransactions;

UPDATE SalesTransactions-------------------------------------DML--------------------------------------------------------
SET Cust_Name ='Arpit'
WHERE T_id=5;
SELECT  * FROM SalesTransactions;

EXEC sp_rename 'SalesTransactions.Quality','Quantity','COLUMN'; --------------------SMALL PROCEDURE TO CHANGE THE COLUMN NAME---------------------------------------

----------------------------------------------------------TRANSACTION HERE---------------------------------------------
BEGIN TRANSACTION;

UPDATE SalesTransactions
Set Quantity =5
WHERE Cust_Name ='Arpit' AND Product = 'Books';
SELECT Cust_Name,
SUM(Price * Quantity) AS Total_Sales,
COUNT(T_id) AS Number_OF_Transactions
FROM SalesTransactions
WHERE T_Date >='2025-05-01' --------------Filter by date
GROUP BY Cust_Name ---------------------Customer
HAVING SUM(Price * Quantity) > 1500
ORDER BY Cust_Name

COMMIT TRANSACTION;

SELECT * FROM SalesTransactions;
------------------------------------------------------------Transact SQL-------------------------------------------------------------------
-----------------------------------------------------Each and everything here--------------------------------------------------------------
-----------------------------------------------------Using some Scalar variables-----------------------------------------------------------
DECLARE @A INT = 30;------------------------------------@A , @B AND @Result---------------------------------------------------
DECLARE @B INT = 10;
DECLARE @Result INT;
SET @Result =@A + @B;
SELECT @A AS FIRST_NUMBER ,@B AS SECOND_NUMBER,@Result AS TOTAL;

--------------------------------------------------------one more example------------------------------------------------------
DECLARE @FIRST_NAME NVARCHAR(50),@LAST_NAME NVARCHAR(50),@FULL_NAME VARCHAR(120);
SET @FIRST_NAME ='Arpit';
SET @LAST_NAME ='Thakur';
SET @FULL_NAME =@FIRST_NAME + ' ' + @LAST_NAME ;
SELECT @FULL_NAME;




