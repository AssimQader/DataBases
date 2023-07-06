
---- 1 ----
use ITI;

create proc stdsNum 
as 
	select D.Dept_Name , COUNT(st_id) as 'Students_Number'
	from SC.Student S inner join Department D
	on S.Dept_Id = D.Dept_Id
	group by D.Dept_Name

exec stdsNum




---- 2 ----
use Company_SD;

alter proc P1_Infos
as
	if (select count(W.ESSn) 
		from Works_for W
		where W.Pno = 100) > 3
		select 'The number of employees in the project p1 is 3 or more'
	else 
		begin
			select 'The following employees work for the project p1'

			select E.Fname + ' ' + E.Lname as 'Emp_FullName'
			from Works_for W inner join Employee E 
			on W.Pno = 100 and W.ESSn = E.SSN
		end

exec P1_Infos





---- 3 ----
use Company_SD;

alter proc EmpProj_Update @old_EmpNum int , @new_EmpNumber int, @projNumber int
as 
	begin try
		update Works_for
		set ESSn = @new_EmpNumber
		where ESSn = @old_EmpNum and Pno = @projNumber
	end try
	begin catch
		select 'Error occured while inserting a new Employee'
	end catch


exec EmpProj_Update 77, 669955, 5





---- 4 ----
use Company_SD;

alter table Project
add Budget int 

create table Audits
(
	ProjectNo int, 
	UserName varchar(30),
	ModifiedDate date, 
	Budget_Old int,
	Budget_New int
)

create trigger trig1 
on Project 
after update
as
	if(UPDATE(Budget)) --to fire the trigger if the update is happened on the Budget column only
		begin 
			declare @old int, @new int, @projectNumber int
			select @old = Budget from deleted   --store the old budget in @old
			select @new = Budget from inserted  --store the new budget in @new
			select @projectNumber = Pnumber from inserted   --store the project number 

			insert into Audits values (@projectNumber, suser_name(), getdate(), @old, @new)
		end
	
update Project
set Budget = 5000
where Pnumber = 200





---- 5 ----
create trigger trig2 
on Departments
instead of insert
as 
	select 'can’t insert a new record in this table'
	

insert into Departments(Dname, Dnum)
values('DP5', 70)





---- 6 ----
create trigger trig3
on Employee
instead of insert
as 
	if FORMAT(getdate(), 'MMMM') = 'March'
		select 'can’t hire and Employee in March month'
	else
		begin
			insert into Employee
			select * from inserted
		end




---- 7 ----
use ITI;

create table Student_Audit 
(
	Server_User_Name varchar(50),
	Datee date,
	Note varchar(100)
)

create trigger trig4
on SC.Student
after insert
as 
	declare @user varchar(50) , @key int 
	set @user = SUSER_NAME()
	select @key = St_Id from inserted

	insert into Student_Audit
	values(@user, GETDATE(), CONCAT(@user, ' insert New Row with Key = ' , @key , ' in the table Student'))





---- 8 ----
use ITI;

create trigger trig5
on SC.Student
instead of delete
as
	declare @user varchar(50) , @key int 
	set @user = SUSER_NAME()
	select @key = St_Id from deleted

	insert into Student_Audit
	values(@user, GETDATE(), CONCAT(@user, ' try to delete Row with Key =' , @key , ' in the table Student'))





---- 9 ----
use AdventureWorks2012;

select * from HumanResources.Employee
for xml raw('Employee'), elements, root('Employees')




---- 10 ----
use ITI; 

--using auto
select Department.Dept_Name, Instructor.Ins_Name
from Instructor inner join Department
on Instructor.Dept_Id = Department.Dept_Id
order by Dept_Name
for xml auto, elements, root('Departments')


--using path
select Department.Dept_Name "Department/@Dept_Name", Instructor.Ins_Name "Instructor/@Ins_Name" --make department name and instructor name as attributes for the elements.
from Instructor inner join Department
on Instructor.Dept_Id = Department.Dept_Id
for xml path('Department'), elements, root('Departments')





---- 11 ----
use Company_SD;

declare @docs xml =
		'<customers>
              <customer FirstName="Bob" Zipcode="91126">
                     <order ID="12221">Laptop</order>
              </customer>
              <customer FirstName="Judy" Zipcode="23235">
                     <order ID="12221">Workstation</order>
              </customer>
              <customer FirstName="Howard" Zipcode="20009">
                     <order ID="3331122">Laptop</order>
              </customer>
              <customer FirstName="Mary" Zipcode="12345">
                     <order ID="555555">Server</order>
              </customer>
       </customers>'


declare @pointer int

Exec sp_xml_preparedocument @pointer output, @docs

select * 
into Customers
from OPENXML(@pointer, '//customer')
with (
		FirstName varchar(20) '@FirstName',
		ZipCode int '@Zipcode',
		OrderName varchar(20) 'order',
		OrderID int 'order/@ID'
	 )

Exec sp_xml_removedocument @pointer









					/*Bouns*/



--2)
use Company_SD;

---Trigger on the level of database: prevent any user from altering Company_SD
create trigger PreventAltering
on database 
after ALTER_TABLE  --have to use after/for only and rollback تحت, u cannot use instead of with triggers on database
as
	print ('Table modifications are not allowed.')
	rollback transaction


alter table Departments
drop column Dname
