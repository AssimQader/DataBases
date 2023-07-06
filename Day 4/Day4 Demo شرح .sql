
 /*Aggregate functions مبتعتمدش ال null values*/


select Sum(salary)
from Instructor

Select Max(salary) as Max_val,Min(salary) as Min_Val
from Instructor

select count(st_id), count(*), Count(st_age)
from sc.Student


--متوسط اعمار الطلاب
--there is ages with null values, so it will sum the all ages and divide it by number of ages(without nulls)
select avg(st_age)
from sc.Student  --output:23

select avg( isnull(st_age, 0) ) --replace nulls with zero
from sc.Student		--output:22

select sum(st_age)/Count(*)
from sc.Student		--output:22



--show me the deptID, and sum of salaries in each departmenrt
select sum(salary), dept_id
from Instructor
group by dept_id



--show me the deptID, DeptName, and sum of salaries in each departmenrt
select sum(salary), d.dept_id, dept_name
from Instructor i inner join Department d
	 on d.Dept_Id = i.Dept_Id
group by d.dept_id, dept_name




select avg(st_age), st_address, dept_id
from sc.student
group by st_address, dept_Id



select sum(salary),dept_id
from Instructor
group by dept_id


select sum(salary), dept_id
from Instructor
where salary>1000
group by dept_id



select sum(salary), dept_id
from Instructor
where salary>6000
group by dept_id



select sum(salary), dept_id
from Instructor
group by dept_id



select sum(salary), dept_id
from Instructor
group by dept_id 
having sum(salary) > 50000 



select sum(salary), dept_id
from Instructor
group by dept_id
having Count(ins_id) > 5



select sum(salary), dept_id
from Instructor
group by dept_id
having sum(salary) > 50000



select sum(salary), dept_id
from Instructor
where salary>1000
group by dept_id
having sum(salary)>50000

----------------------------------------------------------------------------

						/* --- Sub Queries --- */

select *
from sc.student
where st_age < (select avg(St_Age)    --subquery with where condition
				from sc.student)


select * , (select count(st_id)   --subquery as a column result of select statement
			from sc.student)
from sc.student



select dept_name
from Department
where dept_id in (select distinct dept_id
				   from sc.student
					where dept_id is not null)



select distinct dept_name
from sc.student s inner join Department d
	on d.Dept_Id = s.Dept_Id



----Subqueries + DML: 
delete from Stud_Course
where st_id = 1


delete from Stud_Course
where st_id in (select st_id from sc.student 
				where st_address='cairo')

--------------------------------------------------------------------------------

						  /* --- Union Family --- */
--				 union all  |  union   |   except  |   intersect


select st_fname as names
from sc.student
union all
select ins_name
from Instructor



select st_fname, st_id
from sc.student
union all
select ins_name, ins_id
from Instructor



--the columns that will union togther sholud be the same datatype,
--and as st_id is int, u have to convert to varchar if u want to union it with the isntructor name column
select convert(varchar(2), st_id)
from sc.student
union all
select ins_name
from Instructor



--intersect: المتقاطع\المتشابه
select st_fname 
from sc.student
intersect 
select ins_name
from Instructor


--show all students names, except the names that are similar to instructors name
select st_fname 
from sc.student
except
select ins_name
from Instructor
------------------------------------------------------------------------------------


--------------------Numermic DataTypes
--bit       ==> 0 or 1
--tinyint   ==> 1 Byte     -128:+127  unsigned  0:255
--smallint  ==> 2 Byte     -32768 : +32767   unsigned 0:65500
--int       ==> 4 Byte
--bigint    ==> 8 Byte


--------------------Decimal DataTypes
--smallmoney  ==> 4 Byte   .0000
--money       ==> 8 Byte   .0000
--real        ==> 4 Byte   .0000000
--float            .00000000000000000000000
--dec(decimal)==> dec(5,2)  123.90  


--------------------String DataTypes  & Character DataTypes
--char(10)       ==>[Fixed Length characters]  ahmed 10   ali 10  على ؟؟
--varchar(10)    ==>[variable length characters] ahmed 5   ali 3
--nchar(10)       ==> n means: unicode: arabic letters
--nvarchar(10)
--nvarchar(max)   up to 2GB


-------------------- Date & Time DataTypes
--Date              11/10/2020
--Time              hh:mm:12.897(seconds and milly seconds)
--Time(7)           hh:mm:12.9876543
--smalldatetime     mm/dd/YYYY hh:mm:00
--datetime          mm/dd/YYYY hh:mm:ss.786
--datetime2(7)      mm/dd/YYYY hh:mm:ss.7867654


--------------------Binary DataTypes
--binary    011101  111100
--image


--------------------others
--sql_variant
--uniqueidentifier
--XML
--money
--smallmoney

-----------------------------------------------------------------------------------























------------------------------------------------------------------------------------------------

create table test
(
 eid int identity(1,1),
 SSN int  primary key,
 ename varchar(20)
)


select * from test

delete from test

truncate table test

insert into test
values(3388,'eman')

insert into test
values(5467,'eman')


--Batch  Script   Transaction
insert
go
update


--DDL
create rule
go
sp_bindrule
go
create table
go
drop table

--------------------------
create table parent(pid int primary key)

create table child(cid int foreign key references parent(pid))

insert into parent values(1)
insert into parent values(2)
insert into parent values(3)
insert into parent values(4)

begin transaction
	insert into child values(1)
	insert into child values(10)
	insert into child values(3)
commit


select * from child
truncate table child

begin try
	begin transaction
	insert into child values(1)
	insert into child values(200)
	insert into child values(3)
	commit
end try
begin catch
	ROLLBACK
	select ERROR_LINE() ,ERROR_MESSAGE(), ERROR_NUMBER()
end catch

begin transaction
	insert
	truncate
	update
	delete
--------

--case   IIF
select ins_name,salary,
			case
			when salary>=3000 then 'high sal'
			when salary<3000 then 'low'
			else 'no data'
			end   as newsal
from Instructor

select ins_name,iif(salary>=3000,'high','low')
from Instructor

update Instructor
	set salary=
			case
			when salary >=3000 then salary*1.10
			else salary*1.20
			end

