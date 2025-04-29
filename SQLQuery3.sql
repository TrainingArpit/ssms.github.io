insert into Users(full_name,email,user_role)
values
('Arpit','arpit@gmail.com','Teacher'),
('Ram','ram@gmail.com','Teacher'),
('NEEL','neel@gmail.com','Teacher'),
('Vee','vee@gmail.com','Teacher');

update Users set user_role = 'Student' WHERE full_name ='Arpit';
update Users set user_role = 'Student' WHERE full_name ='Vee';

insert into Users(full_name,email,user_role)
values
('Boy','boy@gmail.com','Student');
insert into Users(full_name,email,user_role)
values
('RED','red@gmail.com','Teacher');

select * from Users;

insert into Courses(title,courc_des,instructor_id)-----here enter more courses
values
('Maths','In Every aspect of life we have Maths',2),
('Science','Science(Chemistry,Physics,Biology) ',3);

insert into Courses(title,courc_des,instructor_id)
values
('Art','painting ',7);

select *  from Courses;
select * from Users;
select *from Enrollments;

insert into Enrollments(user_id,course_id)--enrollments share
values
(1,2),
(4,1),
(1,1);

insert into Enrollments(user_id,course_id)
values
(6,2)

insert into Enrollments(user_id,course_id)
values
(1,3)

insert into Enrollments(user_id,course_id)
values
(4,3)

select u.full_name, u.email, u.user_role, u1.full_name -----#First query list of students who has instructor
from Users u 
inner join Enrollments e on e.user_id = u.user_id
inner join Courses c on c.course_id = e.course_id
inner join Users u1 on u1.user_role = 'Teacher' and c.instructor_id = u1.user_id;

select full_name,user_role,email from Users where user_role='Teacher'; ----#Second query List of all the instructors---

select c.course_id,c.title,c.instructor_id,u.full_name as teacher_name ----#3rd query courses with all the instructors---
from Courses c
inner join Users u on c.instructor_id= u.user_id
where u.user_role='Teacher';

select u.user_id,u.full_name,c.course_id,c.title ------#5th query students with their courses----
from Users u 
inner join Enrollments e on u.user_id = e.user_id
inner join Courses c on e.course_id = c.course_id
where u.user_role ='Student';

select u.user_id,--#6th query students who have enrolled for multiple courses
u.full_name as student_name,
count(c.course_id) as number_of_courses
from Users u
inner join enrollments e on u.user_id=e.user_id
inner join Courses c on e.course_id=c.course_id
WHERE u.user_role='Student'
group by u.user_id,u.full_name
having count(c.course_id) > 1;

select c.course_id,--#7th query students who have enrolled for multiple courses
c.title as course_name,
count(e.user_id) as number_of_students
from courses c
inner join enrollments e on c.course_id=e.course_id
inner join Users u on e.user_id=u.user_id
WHERE u.user_role='Student'
group by c.course_id, c.title;

select *  from Courses;
select * from Users;
select *from Enrollments;


use cms_db;

