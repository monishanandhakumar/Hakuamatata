--Create database
--Create database databasename
create database Hakunamata

--delete database
drop database Hakunamata

create database dbHakunamata
--use database
use dbHakunamata
--DDL Data Definition Language -create,alter,drop,truncate
--Deals with stucture of the table
--create tabel tablename (colnum1 datatype.....colnumN datatype)
create table tbldepartment(departmentid int,departmentname varchar(10))
--to see the structure of the table
sp_help tbldepartment

--To add new column to the table
alter table tbldepartment add yearofestablishment date 

--to change the size
alter table tbldepartment alter column departmentname varchar(20)

--delete table
drop table tbldepartment 

--DML
insert into tbldepartment values(1,'HR')

select * from tbldepartment

--Primary Key

create table tbldepartment(departmentid int primary key,departmentname varchar(10),yearofestablishment date )

insert into tbldepartment values(1,'HR','2016-4-12')
--error  Violation of PRIMARY KEY constraint 'PK__tbldepar__F9B930454A5D18C7'
insert into tbldepartment values(1,'Finance','2016-3-12')

--to drop primary key
alter table tbldepartment drop constraint PK__tbldepar__F9B930454A5D18C7

sp_help tbldepartment

--Adding primary key to existing table column
alter table tbldepartment add constraint pk_did primary key(departmentid)

---DML -data inside the table -Data Manipulation Language 
--Insert,update,delete
insert into tbldepartment (departmentid,departmentname,yearofestablishment) values
(2,'Admin','2011-10-30'),(3,'UI','2013-12-12')

select * from tbldepartment

--to change the size
alter table tbldepartment alter column departmentname varchar(20)

insert into tbldepartment (departmentid,departmentname,yearofestablishment) values
(4,'Development','2011-10-30')


insert into tbldepartment (departmentid,departmentname) values
(5,'XXX')

---create tblEmployee
--INT20046
create table tblEmployee(employeeid varchar(20) primary key,employeename varchar(30) not null,
phno varchar(30) unique )

insert into tblEmployee(employeeid,employeename,phno) values('INT2000','Sri','789012345')

--error not null violation
insert into tblEmployee(employeeid,phno) values('INT2001','789012345')
--error Violation of UNIQUE KEY constraint 
insert into tblEmployee(employeeid,employeename,phno) values('INT2001','Abi','789012345')
--unique will accept only one null value 
insert into tblEmployee(employeeid,employeename) values('INT2001','Abi')

select * from tblEmployee
--error Violation of UNIQUE KEY constraint 
insert into tblEmployee(employeeid,employeename) values('INT2002','Vinay')

--Drop tblEmployee
drop table tblEmployee

sp_help tblEmployeePersonalinfo
create table tblEmployeePersonalinfo(employeename varchar(30) not null unique,age int check(age >21),phno varchar(20) primary key,
gender nvarchar(10),employeeaddress nvarchar(20),degree varchar(20))

insert into tblEmployeePersonalinfo (employeename,age,phno,gender,employeeaddress,degree) values
('SaiCharan',22,'9012345671','male','madurai','BE'),('Abi',23,'9012345678','female','madurai','BE'),
('Raj',23,'7812345678','male','chennai','MSC'),('Kamal',25,'6785345678','male','Trichy','Mtech')

--violation of check constraint
insert into tblEmployeePersonalinfo (employeename,age,phno,gender,employeeaddress,degree) values
('Sai',20,'9012348991','male','madurai','BE')

select * from tbldepartment
select * from tblEmployeePersonalinfo
select * from tblEmployee
--create tblEmployee

create table tblEmployee(employeeid int primary key identity(1000,1),designation nvarchar(20),
salary int ,did int references tbldepartment(departmentid),
phoneno varchar(20) references tblEmployeePersonalinfo(phno))

insert into tblEmployee(designation,salary,did,phoneno) values
('HRManager',78000,1,'6785345678'),('Senoirdeveloper',88000,4,'7812345678'),
('Senoirdeveloper',88000,4,'9012345671'),('Senoirdeveloper',88000,4,'9012345678')

--Delete
--HardDelete
delete from tbldepartment where departmentid=5
--Softdelete
alter table tbldepartment add isrunning bit

--update 
update tbldepartment set isrunning=1

--softdelete
update tbldepartment set isrunning=0 where departmentid=3

--DQL --Data Query Language
--select

--to see the entire table
select * from tbldepartment

--to see particular column
select employeename,employeeaddress  from tblEmployeePersonalinfo

--Where clause
select * from tblEmployeePersonalinfo where employeeaddress='madurai'
--Relational Operator >,<,>=,<=,=,!=,or,and between

--display the emp details whose age is>23
select * from tblEmployeePersonalinfo where age>23
----display the emp details whose age is>23 and degree=BSC
select * from tblEmployeePersonalinfo where age>23 and degree='BSC'

--display the department name where yoe should be btw 1-1-2010-31-12-2011
select departmentname from tbldepartment where yearofestablishment between '2010-1-1' and '2011-12-31'

--Like operator patten matching .-,%,^,[]
--display all the employee name starts with b
select  employeename from tblEmployeePersonalinfo where  employeename like 'b%'

--display all the employee name ends with i
select  employeename from tblEmployeePersonalinfo where  employeename like '%i'

--display all the employee name contain a inbetween
select  employeename from tblEmployeePersonalinfo where  employeename like '%a%'

--display all the employee name contain second charater a 
select  employeename from tblEmployeePersonalinfo where  employeename like '_a%'

--display all the employee name contain second charater a 
select  employeename from tblEmployeePersonalinfo where  employeename like '_a%'

--display all the employee name where name starts with a to g 
select  employeename as [Employee Name] from tblEmployeePersonalinfo where  employeename like '[a-g]%'

--fetching the data from 2 tables
--Display employee name and salary

select a.employeename,b.salary  from  tblEmployeePersonalinfo a ,tblEmployee b
where a.phno=b.phoneno

--Aggregate function--group ,Min,Max,Avg,Sum,Count

--count--will not include null value
--display no of employee in hakunamata
select count(phno)  [TotalEmployee] from tblEmployeePersonalinfo 

--select min salary of the employee

select min(salary) 'Minium Salary' from tblEmployee

select max(salary) 'Maxium Salary' from tblEmployee

select sum(salary) 'Total Salary' from tblEmployee

--Order by ascending order ,descending order
--select columnlist from tbal

select * from tblEmployeePersonalinfo order by employeename

select * from tblEmployeePersonalinfo order by employeename desc

--arranging based on column list

select employeename,gender,employeeaddress from tblEmployeePersonalinfo 
order by 3 desc

select * from tblEmployeePersonalinfo 
order by employeeaddress,employeename desc

--group by works with aggregate function
--display no of employees from each department
select did,COUNT(*) 'No of Employees' from tblEmployee group by did

--display deptname,no of employees from each department

select b.departmentname,COUNT(a.employeeid) 'No of Employees' from tblEmployee a ,tbldepartment b
where a.did=b.departmentid
 group by b.departmentname

 --Arithimetic  +,-,*,/,%

 --Unique

 select distinct(employeeaddress) from tblEmployeePersonalinfo

 --Is It Possible to use aggegrate function in where clause?
 --Total no of employee salary except maximum salary
 select sum(salary) from tblEmployee where salary != max(salary)

 --Having Clause
--display deptname,no of employees from each department having more than 2 employee

select b.departmentname,COUNT(a.employeeid) 'No of Employees' from tblEmployee a ,tbldepartment b
where a.did=b.departmentid
 group by b.departmentname
 having COUNT(a.employeeid)>2
 order by b.departmentname desc

 --display the no of male and female from chennai or madurai or trichy)

 select gender,count(gender) from tblEmployeePersonalinfo
 where employeeaddress in ('Chennai','madurai','trichy')
  group by gender

  --display the max salary of each department
  select did,max(salary) 'Maximun salary' from tblEmployee
   group by did
   having MAX(salary)>80000

   --display the no of employees under each degree where their name not between l-u having the count>2