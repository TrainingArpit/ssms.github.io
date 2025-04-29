create table Patients(
P_id int identity(1,1) primary key,
name nvarchar(100) not null,
dob date ,
gender nvarchar(100),
phone nchar(15)
);

create table Doctors(
D_id int identity(1,1) primary key,
name nvarchar(100) not null,
speciality nchar(200) ,
phone nchar(15)
);

create table Appointments(
App_id int identity(1,1) primary key,
P_id int not null,
D_id int not null,
a_date date default convert(date, getdate()),
a_time time default convert(time,getdate()),
a_status varchar(20)
check (a_status in('Scheduled','Completed')),
foreign key (P_id) references Patients (P_id),
foreign key (D_id) references Doctors (D_id)
);

alter table Doctors Rename column name to D_name;


SELECT * from Patients; 
select * from Doctors;
select * from Appointments;

insert into Patients(name,dob,gender,phone)
values
('Shruti','2002-06-29','Female',9584584850),
('GUY','2000-06-08','Male',8345824850),
('Angela','1998-12-27','Female',8213338773),
('Steve','1999-03-03','Male',8485023213);

insert into Doctors (name,speciality,phone)
values
('Arpit','Psychiatrists',9898898999),
('Akash','Gynocologyst',8989000098),
('Vee','Dermatologists',7989700600);

insert into Patients(P_name,dob,gender,phone)
values
('Johnny','1982-03-07','Male',6767896884);

insert into Appointments(P_id,D_id,a_status)
values
(1,1,'Scheduled');
insert into Appointments(P_id,D_id,a_status)
values
(1,2,'Completed'),
(2,1,'Completed');
insert into Appointments(P_id,D_id,a_status)
values
(3,1,'Scheduled'),
(3,3,'Scheduled'),
(4,1,'Completed');
insert into Appointments(P_id,D_id,a_status)
values
(4,3,'Completed');

select D_id,
(select count(App_id) from Appointments a where a.D_id=d.D_id)as Total_app,--#Query1 ---Number of appointments per doctor 
D_name from Doctors d
group by D_id,D_name;

select P_id,
(select count(App_id) from Patients p where a.P_id = p.P_id)as appointment,--#Query2 -----Lists of Patients with their latest appointments
a_date ,a_time from Appointments a
group by P_id,a_date,a_time 
order by a_time;

select * from Patients where P_id not in(select P_id from Appointments);---#Query 3 ----Patient who never booked an appointment

select * from Patients where P_id in(select P_id from Appointments);-----#Query 4 -----Patient who has at least one appointment
