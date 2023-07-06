use ITI

/*--- 1 ---*/
create function getMontht(@dt date)  returns varchar(20)
	begin
		declare @month varchar(20) = format(@dt, 'MMMM') 
		return @month
	end


select dbo.getMontht('09-04-2015') --septemper

--------------------------------------------------------------------

/*--- 2 ---*/
create function getRange(@x int , @y int)
returns @t table
			(
			Ranges int
			)
as
	begin

		while @x <= @y
			begin
				insert into @t values(@x)
				set @x+=1
			end
		return		--multi function knows what she return, so don't say: return @t ... it's wrong

	end

	select * from dbo.getRange(1,5)	 --the multi function have to put after " * from " when u call it, because it returns table(array of values not one value).
		
--------------------------------------------------------------------

/*--- 3 ---*/
create function get_Stud_Dept(@stid int) returns table
 as
	return 
		(
		 select CONCAT(S.St_Fname, ' ', S.St_Lname) as 'Full Name', Dept_Name as 'Dept Name'  --u have to give a name for the columns in inlin functions using as.
		 from SC.Student S , Department D
		 where S.Dept_Id = D.Dept_Id and S.St_Id = @stid
		)

select * from get_Stud_Dept(1);  --call the function

--------------------------------------------------------------------

/*--- 4 ---*/ 
--any scalar function have to contain only one return statment between begin and end
create function Msg(@stid int) returns varchar(50)
	begin
		declare @MSG varchar(50)		--variable to store the message

		declare @FN varchar(50)			--variable to store the first name of the studnt whose id is @stid
		select @FN = St_Fname from SC.Student where St_Id = @stid

		declare	@LN varchar(50)			--variable to store the last name of the studnt whose id is @stid
		select @LN =  St_Lname from SC.Student  where St_Id = @stid

		if @FN is NULL and @LN is NULL
			set @MSG = 'First name & last name are null'
		else if @FN is NULL 
			set @MSG = 'first name is null'
		else if @LN is NULL 
			set @MSG ='last name is null'
		else
			set @MSG = 'First name & last name are not null'

		return @MSG
	end

select  dbo.Msg(1)

--------------------------------------------------------------------

/*--- 5 ---*/
create function func(@mgrid int) returns table
 as
	return
		(
			select Dept_Name as 'Department' , Manager_hiredate as 'Mngr_Hiredate' , Ins_Name as 'Mngr_Name'
			from Department D , Instructor I
			where  I.Ins_Id = D.Dept_Manager and Ins_Id = @mgrid 
		)


select * from func(6)


--------------------------------------------------------------------

/*--- 6 ---*/
create function gets_StudentName(@str varchar(30))
returns @t table 
				(
				  student_name varchar(30)
				)
 as 

	begin
		if @str = 'first name' 
			 insert into @t select ISNULL(St_Fname, 'No FName') from SC.Student
		else if @str = 'last name' 
			 insert into @t select ISNULL(St_Lname, 'No LName') from SC.Student
		else if @str = 'full name' 
			insert into @t select ISNULL(St_Fname, 'No FName') + ' ' + ISNULL(St_Lname, 'No LName') from SC.Student

		return
	end


select * from dbo.gets_StudentName('full name')

--------------------------------------------------------------------

/*--- 7 ---*/
-- left (the string, the length u want from this string to be)  --> left('AsemAdel' , 6) output 'AsemAd'
select St_Id, left(St_Fname, len(St_Fname)-1)  as 'Name_withoutLastChar'
from SC.Student


--------------------------------------------------------------------

/*--- 8 ---*/

update Stud_Course
set Grade = NULL 
where St_Id in (select St_Id 
				from SC.Student S , Department D
				where S.Dept_Id = D.Dept_Id and D.Dept_Name = 'SD')


--------------------------------------------------------------------

/*--- Bouns ---*/

--2)
begin try
	begin transaction
		declare @counter int = 3000
		while @counter <= 6000
			begin
				INSERT INTO SC.Student(St_Id, St_Fname, St_Lname)
				VALUES (@counter , 'Jane' , 'Smith')

				set @counter +=1
			end
	commit
end try
begin catch
	rollback
end catch



--1)
create table SimpleDemo  
(Node hierarchyid not null,  
[Geographical Name] nvarchar(30) not null,  
[Geographical Type] nvarchar(9) NULL);

insert into SimpleDemo  
values
-- root level data
('/', 'Earth', 'Planet') 

-- first level data
,('/1/','Asia','Continent')
,('/2/','Africa','Continent')
,('/3/','Oceania','Continent'),


-- second level data 
 ('/1/1/','China','Country')
,('/1/2/','Japan','Country')
,('/1/3/','South Korea','Country')
,('/2/1/','South Africa','Country')
,('/2/2/','Egypt','Country')
,('/3/1/','Australia','Country')
 

 
-- third level data
,('/1/1/1/','Beijing','City')
,('/1/2/1/','Tokyo','City')
,('/1/3/1/','Seoul','City')
,('/2/1/1/','Pretoria','City')
,('/2/2/1/','Cairo','City')
,('/3/1/1/','Canberra','City')
 



select 
 Node
,Node.ToString() AS [Node Text]
,Node.GetLevel() [Node Level]
,[Geographical Name]
,[Geographical Type]   
from SimpleDemo		


drop table SimpleDemo 