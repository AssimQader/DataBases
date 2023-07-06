
/* --- User Defined Variables(Local Variables) --- */

Declare @x int;		--declare variable without assigning(default value NULL)
Declare @y int = (select avg(st_age) from SC.Student)		--declare variable and assign it

--u can assign variables with select or set statments
select @x = 90
set @x=80

-- select + variable_name  to show the variable in console
select @x



declare @a int
select @a = st_age from SC.Student		--assign "age of the student whose id is 1" to @y 
where st_id=1
select @a		



declare @z int		--here in this line of declaration: if u didn't give the variable initial value, it assigned implictly with NULL.
select @z = st_age from SC.Student
where st_id = -1	--there is no student with id=-1, so @z stores the last values inside it which is NULL
					--هو مش مخزن نول عشان مفيش طالب بالأي دي دة ف رجعلك نول، لا هو بيرجعلك اخر قيمة اتخزنت فيه 
select @z




--variables stores one value, this query returns all students whose address is Cairo, which is an array,
--studio mangment مش هيعترض ولا هيطلع ايرور but the variable @q will store only the last value in the returned array,
--if the query returns: 1,2,3,4,5 ... @q will store 5 only.
declare @q int
select @q = st_age from SC.Student
where st_address='cairo'
select @q




--To store Arrays use "table" datatype--

Declare @t table(col1 int)  ----> 1D array of int
insert into @t		--with table datatype, use insert into.
values(1),(5),(8),(9)
select * from @t  --because it returns multi values, u have to use "select * from" to show all the columns(it's a table في الاخر يعني,
					-- but it is created in runtime only.




Declare @tt table(col1 int)  ----> 1D array of int(one column table)
insert into @tt
select st_age from SC.Student where st_address='cairo'  --the column that comes after select is the column that will appears مكان col1, so as col1 is int, the column after select must be in datatype too.
select * from @tt
select count(*) from @tt




Declare @ttt table(col1 int,col2 varchar(20))  ----> 2D array(two column table)
insert into @ttt
select st_age, st_fname from SC.Student where st_address='cairo'  --st_age is int(as col1), st_fname is varchar(as col2)
select * from @ttt




--مهم--
declare @var int
select @var = st_age, st_fname	 --the error is because that "select" here is used to assign value to @var, so u cannot use it 
								 --to retrive data from the table at the same line
from SC.Student
where st_id=3




declare @did int
update SC.Student
	set st_fname ='omar', @did = dept_id
where st_id=4
select @did

-----------------------------------------------------------------------------------------

/* --- Built-In Variables(Global Variables) --- */

Select @@servername 

select @@version


update SC.Student set st_age+=1
select @@rowcount		--stores the number of affected rows


select * from student where st_age>25
select @@rowcount
select @@rowcount --output: 1


select * from SC.Student where st_age>25
go
select @@error	--stores the errors numbers


insert into test values('khalid')
select @@identity


---------------------------------------------------------------------------------------------

/* --- if condition --- */



--- if | begin and end are represents the curly brackets { } ---
declare @x int
update SC.Student 
set st_age +=1
set @x = @@ROWCOUNT  --store global value inside local variable.

if @x < 0
	begin
		select 'no rows affected'	--select + string --> like cout<< ""
		select 'welcome to ITI'
	end
else 
	begin
		select 'multi rows affected'
	end



--- if exits()  |   if not exists() ---

--SYS is a schema that stores all the meta data,  write select * from sys and dot(sys.) it will pop up a list of all things u can get metatdat of it,
--like (views, columns, tables, functions, ...)
select * from sys.tables  --run it

if exists(select name from sys.tables where name='staff')
	select 'table is exited'
else
create table staff
(
 sid int,
 sname varchar(20)
)


if not exists( select top_id from course where top_id=1)
	delete from topic where top_id=1
else
	select 'table has relation'




--- try , catch ---

begin try
	delete from topic where top_id=1
end try
begin catch
	select ERROR_LINE(), ERROR_MESSAGE(), ERROR_NUMBER()  --if  error is catched, show the errorline, error message, and the number of error
end catch


---------------------------------------------------------------------------------------------

/* --- while loop --- */

declare @x int=10
while @x <= 20
	begin 
		set @x+=1
		if @x=14
			continue
		if @x=17
			break

		select @x
	end


---------------------------------------------------------------------------------------------

/* case 
		when ........ then  
   end 
*/

--buesniss rule: show me the instructor name and his salary but not as values, I want to replace the salaries with statments:
--if salary is >= 3000 show me 'high salary' instead of 3000, and if it is <3000 show me 'low salary' 
select ins_name, 
               case
					when salary>=3000 then 'high salary'
					when salary<3000 then 'low salary'
					else 'no data'
			   end 
			   as salaries_Column
from instructor




--- iff function:   iif(condition, if true, if false)
select ins_name, iif(salary >= 3000,'high', 'low') as 'temp_col'
from instructor



update instructor
	set salary =
			case
				when salary>3000 then salary*1.20
				else salary*1.30
			end

--choose
--waitfor
---------------------------------------------------------------------------------------------

/* ---windowing functions: lead  |  lag  |   first_value  |   last_value --- */  --> in [ D:\ITI Courses\Data Base\SQL Queries\Lag_Lead_Grades.SQL ]


---------------------------------------------------------------------------------------------

/* --- User-Defined Functions: are three types ---*/


--- 1) Scalar Function: the function that returns one variable(value) ---
--Declare the function: 
create function getName(@id int) returns varchar(30)
	begin
		declare @name varchar(30)
		select @name = st_fname from SC.Student
		where st_id = @id

		return @name  --any function must have one return statment.
	end

--Call the function:
select dbo.getName(4)  --call it with the schema name(mandatoryلازم).


--Delete the function:
drop function getName






--- 2) Inline Function: the function that returns table(multi values) but there are no conditions in its body ---
create function getInst(@did int) returns table  --returns table, not varchar or int or ....
	as
		return 
			(
			 select ins_name, salary * 12 as 'Annual_Column'  --in inlin functions, u have to give a name for the columns taht will appear, if u don't, an error will occure.
			 from instructor
			 where dept_id = @did
			)

--calling
select * from getInst(10)
select ins_name from getinst(10) --get the first column in the created table returns from getinst(10)
select sum(Annual_Column) from getinst(10)





--- 3) Multi Function: the function that returns table(multi values) and there are a conditions in its body ---
create function getStudents(@format varchar(20))
returns @t table  --u have to declare a variable from datatype table after "returns" statment, and define the shape of the table as follow:
				(
				  id_col int,
				  name_col varchar(30)
				)		--the returned table is 2D(two columns)
as
	begin 

		if @format='first'
			insert into @t select st_id, st_fname from SC.Student
		else if @format='Last'
			insert into @t select st_id, st_Lname from SC.Student
		else if @format='fullname'
			insert into @t select st_id, concat(st_fname,' ',st_lname) from SC.Student

		return    --multi function knows what she return, so don't say: return @t ... it's wrong
			
	end

--calling
select * from getStudents('fullname')  --the multi function have to put after * from when u call it, because it returns table(array of values not one value).
select * from getStudents('first')



---------------------------------------------------------------------------------------------

/* --- Batch --- */
--batch is a set of INDEPENDENTمستقلة queries
--هي مجموعة من الكويريز ملهاش أي علاقة ببعض بس بتتنفذ مع بعض عادي وملهاش تأثير على بعض

--u can highlight all the following three statments together and run them.. they will work, 
--if -for example- "update" causes an error, "insert" and "delete" will excute عادي. 
insert
update
delete





/* --- Script --- */
--مجموعة من الكويريز مينفعش تتنفذ مع بعض ف نفس الوقت، وبالذات الكويريز اللي بتتعامل مع الجدول كبنية 
--DDL [ create , truncate, drop, alter ] and "rules" also cannot be created and bind in the same excuteion.
--so to make it possible, u have to seperate them with "GO" keyword, as follow:

create table
go
drop table
go
create rule
go
sp_bindrule






/* --- Transaction --- */
--set of dependent queries معتمدة على بعض works as single unit of code.
--if the whole transaction succed in excution, a "commite" keyword is written at the end, but 
--if one of its statments causes an error, or there is a problem appears in the server like it is restarted, 
--the whole transaction will not excute and a "rollback" keyword is written at the end,
--however, after the problem is solved, it will be re-exuted from scratch.


--Example:
create table parent (pid int Primary key)
create table child (cid int foreign key references parent(pid)) 

insert into parent values(1)
insert into parent values(2)
insert into parent values(3)
insert into parent values(4)
insert into parent values(5)

insert into child values(1)
insert into child values(6)
insert into child values(2)

--syntax of transaction query: 
begin try
	begin transaction
		insert into child values(1)
		insert into child values(390)
		insert into child values(2)
	commit
end try
begin catch
	rollback
end catch

--transactions Properties: ACID   (search)


/* interview question:  is truncate command saved in log file or not? 
--the normal is no, but this is when u excute it as a batch or individually, however, if u put "truncate" command 
  between transaction query (begin transaction .... commit/rollback) it will be saved in the log file 
  to rollback it if something wrong happend in the query or the server*/
------------------------------------------------------------------------------------------------



--dynamic query
declare @col varchar(20) = '*', @t varchar(40) = 'instructor'
execute('select '+ @col + ' from '+ @t)



select 'select * from SC.Student'   --it will show the string 'select * from student' as a result in row.
print('select * from SC.Student')	--it will show the string 'select * from student' as a message. 
--run both and note the diffrence.


execute('select * from SC.Student')  --excute function have the appilty to transfer the string to a query and excute it)


------------------------------------------------------------------------------------------------








