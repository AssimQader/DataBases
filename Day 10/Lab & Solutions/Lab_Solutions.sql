
declare c1 cursor 
for
	select distinct St_Fname
	from SC.Student
	where St_Fname is not NULL
for read only 

declare @name varchar(20), @allnames varchar(300)

open c1 --point the cursor(pointer) to the first row in the result set. c1 now points to 'Ahmed'
fetch c1 into @name --bring(fetch) the row that c1 points to and store it in the variable @name
while @@FETCH_STATUS = 0
	begin
		set @allnames = CONCAT(@allnames, ' , ' ,@name)
		fetch c1 into @name --move c1 to fetch the next row an store it in @name. its like (i++) in for loop
	end
select @allnames as 'Names'
close c1
deallocate c1




declare c1 cursor
for 
	select St_Fname 
	from SC.Student
	where St_Fname is not NULL
for read only

declare @name varchar(10) , @targetAhmed varchar(10) , @c int = 0

open c1
fetch c1 into @name
while @@FETCH_STATUS = 0
	begin
		if @name = 'Ahmed'
			set @targetAhmed = @name
		if @name = 'Amr'
			begin
				if @targetAhmed = 'Ahmed'  --check if @targetAhmed stores 'Ahmed' from the previous loop
					begin
						set @c+=1 -- increase counter by one
						set @targetAhmed = '' --reset @targetAhmed to be empty, because variables stores the last values, so in the next loop when it check if it contains 'Ahmed' it may contain it from another previous loops, مش اللي قبلها على طول
					end
			end

		fetch c1 into @name
	end

select @c
close c1
deallocate c1






--- 1 ---
use Company_SD;

declare c1 cursor
for
	select Salary 
	from Employee
	where salary is not NULL
for update 

declare @sal int

open c1
fetch c1 into @sal
while @@FETCH_STATUS = 0
	begin
		if (@sal < 3000)
			begin
				update Employee
				set Salary = @sal*1.10
				where current of c1
			end
		else if (@sal >= 3000)
			begin
				update Employee
				set Salary = @sal*1.20
				where current of c1
			end

		fetch c1 into @sal
	end

close c1
deallocate c1




--- 2 ---
use ITI;
declare c1 cursor
for
	select D.Dept_Name , I.Ins_Name 
	from Department D inner join Instructor I
	on D.Dept_Manager = I.Ins_Id
for read only 

declare @DeptName varchar(10), @MngrName varchar(10)

open c1
fetch c1 into @DeptName, @MngrName
while @@FETCH_STATUS = 0
	begin
		select @DeptName as 'DeptName', @MngrName as 'MngrName'
		fetch c1 into @DeptName, @MngrName
	end

close c1
deallocate c1




--- 3 ---
declare c1 cursor 
for
	select distinct St_Fname
	from SC.Student
	where St_Fname is not NULL
for read only 

declare @name varchar(20), @allstudents varchar(200)

open c1 --point the cursor(pointer) to the first row in the result set. c1 now points to 'Ahmed'
fetch c1 into @name --bring(fetch) the row that c1 points to and store it in the variable @name
while @@FETCH_STATUS = 0
	begin
		set @allstudents = CONCAT(@allstudents, ' , ' ,@name)
		fetch c1 into @name --move c1 to fetch the next row an store it in @name. its like (i++) in for loop
	end
select @allstudents as 'Names'
close c1
deallocate c1





--- 4 ---
--Done ==> in screen shoot.

--- 5 ---
--Done ==> in Excel Sheet.

--- 6 ---
--Scritp Created.




--- 7 ---
use SD;

create sequence seq1
start with 1
increment by 1
minvalue 1 
maxvalue 10

insert into Human_Resource.Emplopyee(EmpNo, EmpFName, EmpLName )
values(next value for seq1, 'Emad', 'Ahmed')