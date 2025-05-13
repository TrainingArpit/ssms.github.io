create database Arpitprac;------------------------------------------create Database---------------------
go-----------------------------------------------------------Marks the end of the batch---------------
use Arpitprac;------------------------------------------------------Use Database-----------------------
Create table employee1---------------------------------------------creating a Table----------------------------------ddl
(
e_id int identity(1,1) primary key,---------identity (1-its the first record,1-its for the increment)   (primary key unique identification pk-dml)
f_name nvarchar(50),
l_name nvarchar(50),
Birthdate Date,
Salary Decimal(10,2)
);

insert into employee1(f_name,l_name,Birthdate,Salary)---------------------------insert values-------------------
values
('shittyy','mouth','2002-12-21',89485.23),
('Cute','Prey','2001-01-21',78985.23),
('Dark','brook','1998-02-19',65485.23);

select * FROM employee1;-----------------------------------------------display data---------------------dql

alter table employee------------------------------------------------adding column-----------------------------ddl
ADD m_name varchar(50);

ALTER TABLE employee-------------------------------------------------deleting a column-------------------------------------------------------ddl
Drop column m_name;-------------------------------------------------------using drop------------------------ddl

Delete from employee--------------------------------------deleting  a row using where clause---------------------------------------dml
where e_id =1;

update employee     --------------------------------------------updating a column-----------------------------dml
set f_name='RATTY'   
where e_id=2;

TRUNCATE table employee-------------------------------------deletes all data of the table -------------------- ddl

update employee --------------------------------------------one more update example ----------------------using where clause---------------------
set Salary =34634.12
where e_id =1;



Create LOGIN EmployeeUser WITH PASSWORD ='Strong password123!';
Create USER EmployeeUser  FOR LOGIN EmployeeUser;

-------------------------------------------------------------------------------Some DCL commands-------------------------------------------
GRANT SELECT ON Employees TO EmployeeUser;-----------------------------------assigns some permissions
GRANT INSERT ON Employees TO EmployeeUser;

REVOKE	SELECT ON Employees TO EmployeeUser;----------------------------remove the assigned positions
REVOKE INSERT ON Employees TO EmployeeUser;


-----------------------------------------------------------------------------------TRANSACTIONS-----------------------------------------------
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

                                   -------------------------------------------------TRANSACTION HERE-------------------------------------------------
BEGIN TRANSACTION;
UPDATE ACCOUNTS
SET Balance =7584.89
WHERE a_id =2;

UPDATE ACCOUNTS
SET Balance =7584.89
WHERE a_id =2;
 
COMMIT TRANSACTION;
SELECT * FROM ACCOUNTS;

--------------------------------------------------------------------------Elaborated example for transactions------------------------------------------
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


UPDATE SalesTransactions----------------------------------------------------------------------DML--------------------------------------------------------
SET T_Date ='2025-05-01'
WHERE T_id=5;
SELECT  * FROM SalesTransactions;

UPDATE SalesTransactions----------------------------------------------------------------------DML--------------------------------------------------------
SET Cust_Name ='Arpit'
WHERE T_id=5;
SELECT  * FROM SalesTransactions;

EXEC sp_rename 'SalesTransactions.Quality','Quantity','COLUMN'; --------------------SMALL PROCEDURE TO CHANGE THE COLUMN NAME---------------------------------------

---------------------------------------------------------------------------------------------TRANSACTION HERE-------------------------------------------------------
BEGIN TRANSACTION;

UPDATE SalesTransactions
Set Quantity =5
WHERE Cust_Name ='Arpit' AND Product = 'Books';
SELECT Cust_Name,
SUM(Price * Quantity) AS Total_Sales,
COUNT(T_id) AS Number_OF_Transactions
FROM SalesTransactions
WHERE T_Date >='2025-05-01' -------------------------------------------------------------------Filter by date
GROUP BY Cust_Name ------------------------------------------------------------------------------Customer
HAVING SUM(Price * Quantity) > 1500
ORDER BY Cust_Name

COMMIT TRANSACTION;

SELECT * FROM SalesTransactions;
-----------------------------------------------------------------------------------------------Transact SQL-------------------------------------------------------------------
--------------------------------------------------------------------------------------------Each and everything here--------------------------------------------------------------
--------------------------------------------------------------------------------------------Using some Scalar variables-----------------------------------------------------------
DECLARE @A INT = 30;---------------------------------------------------------------------------@A , @B AND @Result---------------------------------------------------
DECLARE @B INT = 10;
DECLARE @Result INT;
SET @Result =@A + @B;
SELECT @A AS FIRST_NUMBER ,@B AS SECOND_NUMBER,@Result AS TOTAL;

-------------------------------------------------------------------------------------------------------one more example------------------------------------------------------

DECLARE @FIRST_NAME NVARCHAR(50),@LAST_NAME NVARCHAR(50),@FULL_NAME VARCHAR(120);
SET @FIRST_NAME ='Arpit';
SET @LAST_NAME ='Thakur';
SET @FULL_NAME =@FIRST_NAME + ' ' + @LAST_NAME ;
SELECT @FULL_NAME;

-------------------------------------------------------------------------------------Using SCALAR VARIABLES IN QUERIES--------------------------------------------------------------------

DECLARE @Name NVARCHAR(50),@Salary DECIMAL(10,2),@Bonus DECIMAL(10,2),@Bonus_rate FLOAT ,@T_Salary DECIMAL(10,2)
SET @Name ='Arpit'
SET @Salary =60000;
SET @Bonus_rate=0.5;
SET @Bonus = @Salary * @Bonus_rate;
SET @T_Salary = @Salary + @Bonus;
SELECT @Name AS EMP_NAME,@Salary AS EMP_SALARY,@Bonus_rate AS BONUS_RATE,@Bonus AS Bonus_Salary,@T_Salary AS Total_Salary;

-------------------------------------------------------------------------------------------WORKING on Procedures----------------------------------------------------------------------------

CREATE TABLE Department(
Dept_id INT IDENTITY(1,1) PRIMARY KEY,
Dept_name NVARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Employees1(
Emp_Id INT IDENTITY(1,1) PRIMARY KEY,
Emp_Name NVARCHAR(50) NOT NULL,
Salary DECIMAL(10,2),
Dept_Id Int,
FOREIGN KEY (Dept_Id) REFERENCES Department(Dept_Id) ON DELETE CASCADE-----------------by using ON DELETE CASCADE-THE CHANGES THAT ARE MADE IN PARENT TABLE IS AUTOMATICALLY APPLIED TO THE CHILD TABLE-----------
);

INSERT INTO Department(Dept_name)
VALUES
('HR'),
('IT'),
('Finance');

INSERT INTO Employees1(Emp_Name,Salary,Dept_Id)
VALUES
('Arpit',58000,1),
('Vee',75664,2),
('BULL',84774,3);

SELECT * FROM Department;
SELECT * FROM Employees1;

ALTER TABLE Employees1
Drop COLUMN JoinDate;

ALTER TABLE Employees1
ADD Join_Date Date DEFAULT GETDATE();

UPDATE Employees1
SET Join_Date='2025-11-22'
WHERE Emp_Id =3;
         -------------------------------------------------------------------------CREATING A PROCEDURE--------------------------------------------------
CREATE PROCEDURE AddEmployee
 @Name NVARCHAR(100),
 @Salary DECIMAL(10,2),
 @Dept_ID INT,
 @New_Emp_Id INT OUTPUT
 AS
 BEGIN 
   DECLARE @ErrorMsg NVARCHAR(4000);
    
	BEGIN TRY
	    BEGIN TRANSACTION;
		--------------------------------------------------------------------------Inserting new employee---------------------------------------------
		INSERT INTO Employees1(Emp_Name,Salary,Dept_Id)
		VALUES(@Name,@Salary,@Dept_Id);

	    ----------------------------------------------------------------------Retrieve the new Employee Value----------------------------------------------------
	SET @New_Emp_Id =SCOPE_IDENTITY();

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;

	SET @ErrorMsg = ERROR_MESSAGE();
	PRINT 'Error Occupied: ' + @ErrorMsg;
END CATCH
END;

DECLARE @NewId INT;

EXEC AddEmployee
    @Name = 'Eve',
	@Salary =75000,
	@Dept_ID =2,
	@New_Emp_Id =@NewId OUTPUT;

SELECT @NewId AS NewEmployeeID;

DELETE FROM Employees1
WHERE Emp_Id =5;

Select * from Employees1;
---------------------------------------------------------One more example for better understanding of the concept Transactions----------------------------------------------------------------------

CREATE TABLE Accounts(
Acc_Id INT IDENTITY(1,1) PRIMARY KEY,
Acc_Name NVARCHAR(50),
Balance DECIMAL(10,2)
);
INSERT INTO Accounts (Acc_Name,Balance)
VALUES
('Arpit',23239.00),
('Vee',434636.00);

-------------------------------------------------------------------use this for checking the insufficient  balance ----------------------------------------

UPDATE Accounts
SET Balance =500.00
WHERE Acc_Id = 2;
SELECT * FROM Accounts;

----------------------------------------------------------here i am using this transaction to send money from one account to another------------------------

DECLARE @Amount DECIMAL(10,2) = 400;
DECLARE @FromAccount INT = 1;
DECLARE @ToAccount INT =2;
 
 BEGIN TRANSACTION;
 -------------------------------------------------------------------------------Deducting from source Account-------------------------
 UPDATE Accounts
 SET BALANCE = BALANCE - @Amount
 WHERE Acc_Id = @FromAccount;
 ----------------------------------------------------------------------------------Add to Destination Account -----------------------
 UPDATE Accounts
 SET BALANCE =BALANCE + @Amount
 WHERE Acc_Id = @ToAccount;

 IF (SELECT BALANCE FROM Accounts WHERE Acc_Id =@FromAccount) < 0
 BEGIN
        PRINT 'INSUFFICIENT FUNDS. TRANSACTION ROLLED BACK.';
		ROLLBACK;
 END
 ELSE 
 BEGIN
      PRINT 'TRANSACTON COMMITED SUCCESSFULLY'
	  COMMIT;
END;
SELECT * FROM Accounts;

-------------------------------------------------------------------------GETTING A BETTER UNDERSTANDING OF PROCEDURES----------------------------------------------

CREATE TABLE EMPLOYEE
(
EMP_ID INT IDENTITY(1,1) PRIMARY KEY,
EMP_NAME NVARCHAR(50),
SALARY DECIMAL(10,2)
);
INSERT INTO EMPLOYEE(EMP_NAME,SALARY)
VALUES
('KING',77474.22),
('ARPIT',84899.00),
('VEE',84589.00);

SELECT * FROM EMPLOYEE;
------------------------------------------------------------------------------NOW CREATING A PROCEDURES--------------------------------------------------

CREATE PROCEDURE UPDATE_EMP_SALARY
@Emp_Id INT,
@New_Salary Decimal(10,2),
@Message NVARCHAR(50) OUTPUT

AS
BEGIN
IF EXISTS (SELECT 1 FROM EMPLOYEE WHERE EMP_ID = @Emp_id)
BEGIN

UPDATE EMPLOYEE
SET SALARY = @New_Salary
WHERE Emp_ID=@Emp_Id;

SET @Message ='SALARY UPDATED SUCCESSFULLY.';
END
ELSE 
BEGIN
SET @Message ='EMPLOYEE NOT FOUND.';
END
END;

-------------------------------------------------------------------------------------------EXCECUTING THE PROCEDURES----------------------------------
DECLARE @ResultMessage NVARCHAR(100) ;
EXEC UPDATE_EMP_SALARY
@Emp_Id = 3,
@New_Salary =89870,
@Message =@ResultMessage OUTPUT;
SELECT @ResultMessage AS ResultMessage;
SELECT * FROM EMPLOYEE;

-----------------------------------------------------------------------------------------------------Triggers------------------------------------------
CREATE TABLE SALARY_LOG(
LOG_ID INT IDENTITY(1,1) PRIMARY KEY,
EMP_ID INT,
OLD_SALARY DECIMAL(10,2),
NEW_SALARY DECIMAL(10,2),
CHANGE_DATE DATE DEFAULT GETDATE()----------------------------------------------------------------BUILT IN TYPE FOR DATE--------------------------------
);

-----------------------------------------------------------------------------------------------------CREATE A TRIGGER-----------------------------------
CREATE TRIGGER TRG_SALARY_UPDATE
ON EMPLOYEE
AFTER UPDATE 
AS
BEGIN 
     DECLARE @EMP_ID INT,@OLD_SALARY DECIMAL(10,2) ,@NEW_SALARY DECIMAL(10,2)
 
 SELECT
	  @EMP_ID=i.EMP_ID,
	  @OLD_SALARY=d.SALARY,
	  @NEW_SALARY=i.SALARY
  FROM
	 INSERTED i
  INNER JOIN DELETED d ON i.EMP_ID = d.EMP_ID;-----------------------------------------------------INNER JOIN USED HERE------------------------------------
 INSERT INTO SALARY_LOG(EMP_ID,OLD_SALARY ,NEW_SALARY)
 VALUES
 (@EMP_ID,@OLD_SALARY,@NEW_SALARY);
END;

-------------------------------------------------------------------------------------------This Update Will Trigger The Trigger-----------------------------
UPDATE EMPLOYEE
SET SALARY =84746.45
WHERE EMP_ID=1;
SELECT * FROM SALARY_LOG;
SELECT * FROM EMPLOYEE;

DELETE FROM SALARY_LOG
WHERE LOG_ID=1;

-----------------------------------------------------------------------------------------------------Working on CLOSURES-------------------------------------
-----------------------------------------------------------------------------we cant create closures but we can create closure-like Behaviour----------------
------example--------
CREATE TABLE #COUNTERR(
	OPERTAION NVARCHAR(50),
	COUNTT INT
);
INSERT INTO #COUNTERR(OPERTAION,COUNTT)
VALUES
('INSERT',0),
('UPDATE',0);

SELECT * FROM #COUNTERR;
----------------------------------------------CREATING  A PROCEDURE TO UPDATE THE STATE-------------------------------------
CREATE PROCEDURE UpdateCounter
  @OPERATION NVARCHAR(50)
AS
BEGIN
    UPDATE #COUNTERR
	SET COUNTT = COUNTT + 1
	WHERE OPERTAION =@OPERATION
END;
------------------------------------ANOTHER PROCEDURE TO GET INTO THAT STATE(LIKE PROCEDURES)--------------------------------
CREATE PROCEDURE GET_COUNTERR
AS
BEGIN
      SELECT * FROM #COUNTERR
END;

EXEC UpdateCounter 'Insert';-----------------EXEC TO EXECUTE THE PROCEDURE--------------------
EXEC UpdateCounter 'Insert';
EXEC UpdateCounter 'Update';

EXEC GET_COUNTERR;
-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------Now we gonna learn ABOUT FUNCTIONS----------------------------------

------------------------SOME FUNCTIONS---------------------

SELECT LEN('HEY KING');---LENGTH
SELECT SUBSTRING('HEY KING',1,5);---PRINTS THE STRING BETWEEN 1-5
SELECT CHARINDEX('KING','HEY KING');----PRINTS THE CHARACTER INDEX THAT I HAVE ASKED FOR LIKE KING STARTS FROM INDEX 5 IN HEY KING-------------------

-------------------------DATE TIME FUNCTIONS---------------------

SELECT GETDATE(); -----CURRENT DATE AND TIME
SELECT DATEADD(DAY,5,GETDATE()); ----ADDS 5 DAYS TO THE CURRENT DATE
SELECT DATEDIFF(YEAR,'2000-12-08','2025-05-13');---------GAP BETWEEN THE DATES IN YEAR

-----------------------MATHEMATICAL FUNCTIONS-------------------

SELECT ABS(-15);------GIVES POSITIVE VALUE
SELECT ROUND(123.458,2);---ROUNDS OFF THE VALUE BY 2
SELECT CEILING(4.7);---OUTPUT 5
SELECT FLOOR(4.7);---------OUTPUT 4

---------------------------------------------------------------------------SCALAR FUNCTIONS----------------------------------------------------------------

-------------------MAKING A SCALER FUNCTION TO CALCULATE AREA OF A CIRCLE------------------
CREATE FUNCTION CAL_AREA_CIRCLE(@Radius DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
      DECLARE @Area DECIMAL(10,2);
	  SET @AREA = 3.14 * @Radius * @Radius;
	  RETURN @Area;
END;

SELECT dbo.CAL_AREA_CIRCLE(5);

----------------------------------------------------------ADVANCED EXAMPLE: COMBINING SCALAR AND TABLE VALUED FUNCTION-----------------------------------------

CREATE TABLE SALE(
SALES_ID INT IDENTITY(1,1) PRIMARY KEY,
PRODUCT NVARCHAR(50),
QUANTITY INT,
UNIT_PRICE DECIMAL(10,2)
);

INSERT INTO SALE(PRODUCT,QUANTITY,UNIT_PRICE)
VALUES
('PRODUCT A',10,15.00),
('PRODUCT B',5,25.00),
('PRODUCT C',20,20.00);


SELECT * FROM SALE;

---------------------------------------------------------------------------SCALAR FUNCTION TO CALCULATE TOTAL SALE: ---------------------------------------

CREATE FUNCTION CAL_TOTAL_SALE(@QUANTITY INT ,@UNIT_PRICE DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
 RETURN @QUANTITY * @UNIT_PRICE;
END;

SELECT dbo.CAL_TOTAL_SALE(4,1500.99);








