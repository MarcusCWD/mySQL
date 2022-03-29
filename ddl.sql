-- go into the mysql root first
mysql -u root

-- create the database
create database swimming_pool;

-- select the tageted database for usage
use swimming_pool;

-- create table
-- <name of column> <data type> <options>
create table parents(
    parent_id int unsigned auto_increment primary key,
    first_name varchar(200) not null,
    last_name varchar(200) not null
)engine = innodb;
-- engine = innodb is for FK to work

-- show all tables
show tables

-- insert (data into table)
insert into parents (first_name, last_name) values ('Ah Kao', 'Tan');

-- insert multiple
insert into parents (first_name, last_name) values ('Xiao Ming', 'Neo'), ('Ah Hui', 'Tay'), ('Jonny', 'Sins');

-- show all rows from a table
select*from parents;

-- create the students table
create table students (
    student_id int unsigned auto_increment primary key,
    name varchar(45) not null,
    swimming_levle varchar(45),
    date_of_birth date
)engine = innodb;

-- check data type of the corrosponsing primary key 
describe parents;

-- add in FK (forign key)
-- step 1: create the column for the forign key
alter table students add column parent_id int unsigned;
-- step 2: setup the forign key
-- parent_id in the the students table will be refered to the parent_id in the parent table 
alter table students add constraint fk_students_parents
    foreign key (parent_id) references parents(parent_id);

-- insert in some students
insert into students (name, swimming_levle, date_of_birth, parent_id)
    values ('xiao kow', 'beginner', '1999-09-10', 2);

-- update 
-- we need the 'where' to target the col. !!! if not we will update all students_id...
update students set swimming_levle = 'intermediate' where student_id=1;

-- delete 
delete from students where student_id = 1;

--delete table
drop table students

-- rename the column in a table
alter table students rename column swimming_levle to swimming_level;

-- rename the table 
rename table students to swimming_students;
rename table swimming_students to students;