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