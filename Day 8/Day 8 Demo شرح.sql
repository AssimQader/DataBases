use ITI

							/* --- Index --- */

--Clustered Index:
create clustered index i29 
on sc.student(st_fname)  --error: there is already clustered index on the PK column (St_Id)


--Non-Clustered Index: u can create many nonclustered index, but it is not recommended to do that
create nonclustered index i30
on sc.student(st_fname)

create nonclustered index i22
on sc.student(st_address)

create nonclustered index i7  
on sc.student(st_age)


--there are two constrains(PK and unique) when u create them, there is an index created implicitly on the columns that 
--have them:
--1)Primary key constraint   ==> clusterd index
--2)Unique Constraint        ==> unique - nonclustered index

create table mystaff
(
  eid int identity,
  SSN int Primary key,   --clustered index created
  sal int unique,        --unique-nonclustered inedx created
  overtime int unique,   --unique-nonclustered inedx created
  age int,
  constraint c44 check(age>20)
)


--full table scan will happen to get all the instructors whose salaries are equal to 8000
select * from Instructor where Salary = 8000

select * from topic where top_name = 'db'

-------------------------------------------------------------------------------------------------


						/* --- Types Of Tables --- */


----------physical table: the normal one
create table exam
(
 eid int,
 edate date,
 numofQ int
)

insert into exam
values(1,'1/1/2024',30)

select * from exam

drop table exam 




----------table variable: 
--its scope is the batch only, means that u have to hielight the declaration, insert into, and the call select
--all together to get a result, if u run the declare statment first, then run the call(select * from @exam) it will give u 
--an error that u have to declare the variable @exame firstعلى الرغم من انك لسة عامله ديكلير فوق but all the code lines 
--have to be hielighted and run together.
declare @exam table 
(
 eid int,
 edate date,
 numofQ int
)

insert into @exam
values(1,'1/1/2024',30)

select * from @exam






---------local table: ==> "session based" table, created in runtime in memory: 
/* --It is defined with one hash(#) sign before the name of the table.
   --Local tables are created inside "System Databses" file \ "tempdb" \ "Temporary Tables" file.
   --The scope of this local table is the session u are work in only, if u opend a new session(query)
     and try to select from this table, it will give u error "invalid table name #exam" هو مش شايف الجدول دة.
   --Every "New Query" تمثل new session. Once u close the session, local tables are droped automatically. */
create table #exam
(
 eid int,
 edate date,
 numofQ int
)



----------Global Table: ==> "Shared" table:
--It is defined with two hashs(##) signs before the name of the table.
--The scope of this local table is the session u are work in and any opend sessions too(shared).
--If u closed the session, the global tables are still exist in other sessions(seen for other users).
create table ##exam
(
 eid int,
 edate date,
 numofQ int
)


--------------------------------------------------------------------------------------------------------------
 
 							/* --- View --- */

/* --The only query u can write inside the body of view is select statments and joins,
	 no other DML or DDL(update, delete, alter, insert, order by,  ...),
	 but u can write DMLs onعلى the view AFTER u created it, كأنك بتعدل على الفيو, however, when u do so, the actual table is 
	 the table that will get affected, because views are just a virtual tables. */

--types of views:
--1) Standard View
--2) Partitioned View: view have a data from different servers and different databases.
--3) Indexed View: view have actual data(copy of the physical tables), it is not a virtual view... (search more)


--LIMITATIONS:
--CAN'T USE AGGREGATE FUNCTION ON VIEWS
--CAN USE COMPUTE OR COMPUTE BY
--CAN'T USE ORDER BY eXCEPT IF U USE IT WITH tOP



--Example 1
create view vstud
as
  select * from sc.student

select * from vstud




--Example 2
create view vcairo(sid, sname, sadd) ---> alias names for the columns of the original tables
as
	select st_id, st_fname, st_address
	from sc.student
	where St_Address = 'cairo'

select * from vcairo

select sname from vcairo --notic that there is no column in Student table called sname, but it is in the view vcairo.

--put the view in a specifc schema
alter schema hr transfer vcairo
select * from hr.vcairo

--back the view "vcairo" from hr schema to dbo schema
alter schema dbo transfer hr.vcairo

--delete the view
drop view vcairo



create view valex 
as 
	select St_Id, St_Fname, St_Address
	from sc.Student 
	where St_Address = 'Alex'



--Example 3: alter the view(cahnge its body)
alter view vcairo(sid, sname, sadd)
as
	select st_id, st_fname, st_address
	from sc.student
	where St_Address='alex'




--Example 4: create view contains two other views
create view vcairo_alex
as
	select * from valex
	union all
	select * from vcairo

select * from vcairo_alex




--Example 5: create view contains view joined with original table
create view vgrades
as
	select sname, dname, grade
	from vjoin v inner join Stud_Course sc
	on v.sid = sc.St_Id

select * from vgrades





--Example 6: view with encryption: to prevent "sp_helptext" from read the code this view is created with,
--and when u generate a script for ur databas, it will throw an error and the script file هيضرب.
create view vjoin(sid, sname, did, dname) with encryption
as
	select st_id, st_fname, d.dept_id, dept_name
	from sc.student s inner join Department d
	on d.Dept_Id = s.Dept_Id


sp_helptext 'vjoin'






------DML(insert, update, delete) on the views------

--1) view contains select from one single table:
create view vcairo(sid, sname, sadd)
as
	select st_id, st_fname, st_address
	from sc.Student
	where St_Address='cairo'
	with check option

	drop view vcairo

insert into vcairo
values(99,'ahmed','cairo')


insert into vcairo
values(90,'omar','alex') /*the view "vcairo" contains the students live in cairo, and u insert here a student lives in alex,
	the query will run ومش هيعترض because as u know it inserts in the actuall table "Students", but if u want to prevent
	such a behavior and only insert 'cairo', write "with check option" after the "where" condition..*/

select * from vcairo




--2) view contains select from multiple tables(joined):
alter view vjoin(sid, sname, did, dname) with encryption
as
	select st_id, st_fname, d.dept_id, dept_name
	from sc.Student s inner join Department d
	on d.Dept_Id = s.Dept_Id


--delete query is not permited at all xxxxx
--insert  update ar permited بشرط انك تدخل او تحدث داتا بتاعة جدول واحد فيهم بس
insert into vjoin(sid, sname) --Student table
values(55, 'ahmed')

insert into vjoin(did, dname) --Department table
values(1000, 'cloud')

update vjoin
	set sname = 'ali'   --update on a column exist in Student table only
where sid = 1



--XXXXXXXXXXXXXXXXXXXX
insert into vjoin
values(55,'ahmed', 1000, 'cloud') --error because u insert into two tables: [55,ahmed] are for Student, and [1000,cloud] are for Department


--XXXXXXXXXXXXXXXXXXX
update vjoin
	set sname='ali', dname='HR' --update two tables, error
where sid = 1




------------------------------------------------------------------------------------------------------------


 							 /* ---Merge --- */
					--wahtch the record from ==> 02:40:00

create table LastTransaction
(
	id int,
	namee varchar(20),
	val int
)

create table DailyTransaction
(
	id int,
	namee varchar(20),
	val int
)



Merge into LastTransaction as T  --T for Target
using DailyTransaction     as S  --S for Source
on T.id = S.id

when Matched then
	update
		set T.val = S.val
when Matched and T.val - S.val < 1000 then  --more than one Matched is allowed.  Matched with condition(and) is also allowed.
	update 
		set T.val = 1000
when not Matched by Target then
	Insert
	values(S.id, S.namee, S.val)
when not MAtched by Source then
	delete ;



select * from LastTransaction








