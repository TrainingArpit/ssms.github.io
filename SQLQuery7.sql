select * from Table_A p
inner join Table_B q on p.id =q.id; 

select * from Table_A p
left outer join Table_B q on p.id =q.id; 

select * from Table_A p
right outer join Table_B q on p.id =q.id;

select * from Table_A,Table_B where Table_A.id =Table_B.id;

alter Table Table_A
ADD m_id int;

select * from Table_A;

select * from Table_A p inner join Table_B q on p.id=q.id;


