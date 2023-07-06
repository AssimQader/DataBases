
				/* Execution Order in SQL Mangment Studio */

--1 FROM
--2 JOIN(SELF-INNER-OUTER)
--3 ON 
--4 WHERE
--5 GROUP BY
--6 HAVING
--7 SELECT 
--8 ORDER BY
--9 TOP


--there is not column is Student table called fullname, but when u orderd by it, it runs without errors
--thats because the order of reading this batch is as follow(look numbers): 
select  st_fname + ' ' + st_lname as fullname  --2)
from sc.Student  --1)
order by fullname --3) 

--so, "select" command executed first and the engine sees "fullname", so it could orderd by it at  line 3





--here as u see from numbers, "where" statement is executed first before "select" line, 
--os in couldn't read fullname yet, and the query throws error.
select  st_fname + ' ' + st_lname as fullname   --3)
from sc.Student  --1) 
where fullname = 'ahmed ali'  --2) 





--to solve the previous error:
select *
from (select  st_fname + ' ' + st_lname as fullname
	  from sc.Student) as newtable
where fullname = 'ahmed ali'


-----------------------------------------------------------------------------

			--DB Schema
			--[SchemaName].ObjectName

Create schema HR
alter schema HR transfer Student
alter schema HR Transfer Instructor


Create Schema Sales
alter schema sales transfer Department



select * from Student  --error: Student is in HR Schema now

select * from HR.Student --right



create table Student(
					id int, 
					name varchar(20)
					)

select * from Student  --right, because u create a new Student table in dbo schema.

create table sales.student  --right, because u create a new Student table in sales schema.
(
 sid int,
 sname varchar(20),
 sage int
)

----------------------------------------------------------------------------------

				/* -- Security --- */

--Authentication [UserName + Pass]
-----Windows Authentication
-----windows admin ==> SQL Admin
-----SQL Server Authentication
-----Create Remote Login


--Authorization [Permisssions]
-----User(Asem) can access tables[student and instructor] only,
-----give him a Grant on (Select and insert)
-----Deny him from (Delete and Update)


-----------------------------------------------------------------------------------------

			/* Full Path of quering table: [ServerName].[DBName].[SchemaName].[TableName] */


-- aquery while stands on ITI database:
select *
from [DESKTOP-VF50P25].ITI.dbo.Course

-- aquery while also stands on ITI database, but acces Company_SD database, and it works thanks for the full path:
select * 
from Company_SD.dbo.project


--get data from two difrent servers(may be in diffrent locations/countries) and diffrent databases also,
--then union the results in one sheet:
select dname
from IPServer1.Company_SD.dbo.Departments
union all
select dept_name
from IPServer2.ITI.sales.Department


-----------------------------------------------------------------------

					/*  SELECT INTO  &  INSERT INTO  */

 --- SELECT INTO --- 
 
 --create new table called "Table2" and put all the columns with the data of "Course" table inside it.
Select * into Table2
from Course

-- same but using Shema name.
Select * into Sales.Table2
from Course


--choose a specific columns to put in the new table, and a condition too to limit the rows that will be taken.
select st_id,st_fname into Table3
from HR.Student
where st_address='alex'


select * into Table4
from HR.Student
where 1=2 --this is a condition return false because 1 != 2, and this line means create the new table,
		  --and put the columns in it but without any data(empyt table with the structure only).



--- INSEERT INTO --- 

--insert in a table already exist.. insert values directly
insert into Table3
values(7,'ali')


--insert based on select.. insert data from another table:
insert into Table3
select st_id, st_fname from Student where st_address='mansoura'


-------------------------------------------------------------------------

				/* --- TOP statment --- */

--show the whole data of the first three rows.
select top(3)* 
from student


--show the first name of the first five rows.
select top(5) st_fname 
from student


select top(3) *
from student
where st_address='alex'


select top(2) salary
from instructor
order by salary desc



select top(5) with ties *
from student
order by st_age desc



--GUID (Global Uniqe Identifire)
--this function returns a different complicated and uniqe ID على مستوى الداتا بيز كلها each time u excute it.
select newid() 



--run it many times and notice the outputs
select top(3)*, newid() as RandomID
from SC.student
order by newid() 

-------------------------------------------------------------------------

			/* --- Time and Date Formats  --- */

select convert(varchar(20),getdate())

select cast(getdate() as varchar(20))

select convert(varchar(20),getdate(),101)
select convert(varchar(20),getdate(),103)
select convert(varchar(20),getdate(),111)
select convert(varchar(20),getdate(),110)
select convert(varchar(20),getdate(),107)


select format(getdate(),'dd-MM-yyyy')
select format(getdate(),'dddd MMMM yyyy')
select format(getdate(),'ddd MMM yy')
select format(getdate(),'dddd')
select format(getdate(),'MMMM')
select format(getdate(),'hh:mm:ss')
select format(getdate(),'hh tt')
select format(getdate(),'HH')
select format(getdate(),'dd-MM-yyyy hh:mm:ss')
select format(getdate(),'dd-MM-yyyy hh:mm:ss tt')


select format(getdate(),'dd') --returns the number of the current day
select day(getdate())  --also returns the number of the current day


select eomonth(getdate()) --returns the last whole date of the current month(30-6-2022)

select format(eomonth(getdate()),'dd') --returns only the last day of the current month(30)


select format(eomonth(getdate()),'dddd') --returns the name of last day in the current month(Friday)
-- note: four d (dddd) returns the name of the day(saturday, friday, ....)
	-- : four m (mmmm) returns the name of the month(febraury, december, ...)


---------------------------------------------------------------------------------------


					/* --- String Functions  --- */

select upper(st_fname), lower(st_lname)
from SC.student


select len(st_fname),st_fname
from student

select substring(st_fname, 1, 3)  --works as left() function
from sc.student

---------------------------------------------------------------------------------------


select db_name()

select suser_name()


select power(salary,2)
from instructor

--select max(len(st_fname))
--from student

select top(1)st_fname
from sc.student
order by len(St_fname) desc


---------------------------------------------------------------------------------------


					/* --- Ranking Functions  --- */


Select *
From (select *, Row_number() over(order by st_age desc) as RN
	  from sc.student) as Newtable
where RN=1


Select *
From (select *, Dense_Rank() over(order by st_age desc) as DR
	  from sc.student) as NewTable
where DR=4


Select *
From (select *,Row_number() over(partition by dept_id order by st_age desc) as RN
	  from sc.student) as Newtable
where RN=1


Select *
From (select *, Dense_Rank() over(partition by dept_id order by st_age desc) as DR
	  from sc.student) as NewTable
where DR=1

---------------------------------------------------------------------------------------



