
/* --- 1 --- */

use SD;

create table Department
(
	DeptNo int primary key,
	DeptName varchar(15),
	Location varchar(10),
)

insert into Department
values( 1,'Research','NY'), 
	  (2,'Accounting','DS'),
	  (3,'Markting', 'KW')


sp_addtype loc,'nchar(2)'		--create the datatype
create default def1 as 'NY'		-- create the default
create rule rule1 as @x in('NY','DS','KW')		--create the rule
sp_bindrule rule1, loc		--associate the rule to the new datatype
sp_bindefault def1, loc		--associate the default to the new datatype

ALTER TABLE Department
ALTER COLUMN Location loc;

-----------------------------

create table Emplopyee
(
	EmpNo int, 
	EmpFName varchar(15) not null,
	EmpLName varchar(10) not null,
	DeptNo int, 
	Salary int ,

	constraint c1 primary key(EmpNo),
	constraint c2 Foreign key(DeptNo) references Company.Department(DeptNo),
	constraint c3 unique(Salary),
)
	create rule rule2 as @value < 6000
	sp_bindrule rule2, 'Emplopyee.Salary'



insert into Emplopyee
values( 25348,'Mathew','Smith', 3, 2500), 
	  (10102,'Ann','Jones', 3, 3000),
	  (18316,'John', 'Barrimore' , 1, 2400)


-----------------------------

insert into Project
values( 1,'Apollo', 120000), 
	  (2,'Gemini',95000),
	  (3,'Mercury', 185600)

-----------------------------

insert into Works_On
values(25348,2, 'Clerk', '2007.2.15'),
	  (10102,3,'Manager' , '2012.1.1'),
	  (10102,1,'Analyst', '2006.10.1')

-----------------------------

alter table Emplopyee
add TelephoneNumber varchar(20)

alter table Emplopyee
drop column TelephoneNumber

----------------------------------------------------------------------------

/* --- 2 --- */

create schema Company
alter schema Company transfer Department

create schema Human_Resource 
alter schema Human_Resource  transfer Emplopyee

----------------------------------------------------------------------------

/* --- 3 --- */

--this query shows all the constrains on the table
SELECT * 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Emplopyee'


----------------------------------------------------------------------------

/* --- 4 --- */
create synonym Emp 
for Human_Resource.Emplopyee

Select * from Emplopyee		--Error: the table is not exist
Select * from [Human_Resource].Emplopyee
Select * from Emp
Select * from [Human_Resource].Emp		--Invalid object name 'Human_Resource.Emp' , Emp contains the schema and the table together.

----------------------------------------------------------------------------

/* --- 5 --- */


update Company.Project
set Budget = Budget + 1000
where ProjectName = (select ProjectName
					from Company.Project P inner join dbo.Works_On W  
					on P.ProjectNum = W.ProjectNum and job = 'Manager')


--------------------------------------------------------------------------
/* --- 6 --- */

update Company.Department
set DeptName = 'Sales'
where DeptNo = (select D.DeptNo
				from Human_Resource.Emplopyee E inner join Company.Department D
				on E.DeptNo = D.DeptNo and E.EmpFName = 'John')


--------------------------------------------------------------------------

/* --- 7 --- */

update Works_On
set Enter_Date = '12.12.2007' 
where Enter_Date = (select Enter_Date
					from Human_Resource.Emplopyee E ,  Works_On W , Company.Project P , Company.Department D
					where E.EmpNo = W.EmpNum and W.ProjectNum = P.ProjectNum and P.ProjectNum = 1 and E.DeptNo = D.DeptNo)

--------------------------------------------------------------------------

/* --- 8 --- */

delete from Works_On
where EmpNum in (select E.EmpNo
					from Human_Resource.Emplopyee E inner join Company.Department D
					on E.DeptNo = D.DeptNo and Location = 'KW')


---------------------------------------------------------------------------

/* --- 9 --- */

use ITI
create schema SC
alter schema SC transfer Student

---------------------------------------------------------------------------


