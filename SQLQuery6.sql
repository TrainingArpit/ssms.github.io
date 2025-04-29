select * from tbl_customer where cust_name like'A%';

select * from tbl_customer order by cust_name;

select count(*) from tbl_customer;

select sum(cust_salary) from tbl_customer;

select avg(cust_salary) from tbl_customer;

select max(cust_salary) from tbl_customer;

 
select cust_loc,sum(cust_salary) from tbl_customer group by cust_loc;

select cust_id from tbl_customer group by cust_id;

select cust_name,sum(cust_salary) from tbl_customer group by cust_name;

select cust_name,sum(cust_salary) from tbl_customer group by cust_name having sum(cust_salary) >2000 ;

select distinct  cust_name,cust_loc from tbl_customer; 

select top 5 * from tbl_customer; 