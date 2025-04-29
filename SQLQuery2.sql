use cms_db;----database
 
create table Users(----------create user table
user_id int identity(1,1) primary key,
full_name nvarchar(100) not null,
email nvarchar(100) unique not null,
user_role nvarchar(50) not null check(user_role in ('Student','Teacher')),
created_at datetime default getdate() 
);


create table Courses(------create Courses table-----
course_id int identity(1,1) primary key,
title nvarchar(200) not null,
courc_des nvarchar(max),
instructor_id int not null,
created_at datetime default getdate(),
foreign key (instructor_id ) references users (user_id)
);

create table Enrollments(------create Enrollments table
enrollment_id int identity(1,1) primary key,
user_id int not null,
course_id int not null,
enrolled_at datetime default getdate(),
foreign key (user_id ) references Users (user_id),
foreign key (course_id ) references Courses (course_id)
);

select * from Users;--to display the users table
select * from Courses;--to display the cources table
select * from Enrollments;--display the enrollments table


