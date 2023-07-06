
									/* Part 1 */

---- 1 ----
create view V1 
as
	select CONCAT(St_Fname, ' ' , St_Lname) as 'FullName', Crs_Name 
	from sc.Student S inner join Stud_Course S_C
	on S.St_Id = S_C.St_Id and S_C.Grade > 50  
	inner join SC.Course C
	on S_C.Crs_Id = C.Crs_Id




---- 2 ----
create view V2 with encryption
as
	select Ins_Name , Top_Name
	from Department D 
	inner join Instructor I on Ins_Id = Dept_Manager  --until here it returns the instructors who work as mangers
	inner join Ins_Course IC on IC.Ins_Id = I.Ins_Id  --return the mangers who give a courses
	inner join SC.Course C  on C.Crs_Id = IC.Crs_Id	  --return the courses these mangers give
	inner join Topic T on T.Top_Id = C.Top_Id		  --return the topics these mangers are teach



---- 3 ----
create view V3
as
	select Ins_Name , Dept_Name
	from Department D inner join Instructor I
	on I.Dept_Id = D.Dept_Id and Dept_Name in('SD', 'Java')



---- 4 ----
create view V4
as 
	select *
	from SC.Student
	where St_Address in ('Alex','Cairo')
	with check option  --to prevent user from change address when he update or insert in the view



---- 5 ----
use SD
create view V5
as 
	select EmpFName, COUNT(projectNum) as 'NumOFProjects'
	from Human_Resource.Emplopyee E inner join Works_On W
	on E.EmpNo = W.EmpNum
	group by EmpFName



---- 6 ----
create nonclustered index i1
on Department(Manager_hiredate)




---- 7 ----
create unique index i2
on SC.Student(St_Age) --The CREATE UNIQUE INDEX statement terminated because a duplicate values found in the column St_Age.




---- 8 ----
create table DailyTransactions
(
UserID int identity primary key,
Amount int  
)

create table LastTransactions
(
UserID int,
Amount int  
)



merge into LastTransactions as T
using DailyTransactions as S
on T.UserID = S.USerID

when matched then
	update
	set T.Amount = S.Amount
when not matched by target then
	insert
	values(S.UserID, S.Amount);
								

--After Merging:
select * from LastTransactions


-------------------------------------------------------------------------------------------------


									/* Part 2 */

use SD;

---- 1 ----
create view Clerk_View
as 
	select EmpNo , ProjectNum , Job, Enter_Date
	from Human_Resource.Emplopyee E 
	inner join Works_On W on E.EmpNo = W.EmpNum and Job = 'clerk'
	inner join Company.Project P on P.ProjectNum = W.ProjectNum



---- 2 ----
create view ProjectView_Without_Budget
as 
	select ProjectNum, ProjectName
	from Company.Project



---- 3 ----
create view V_Count
as 
	select P.ProjectName , COUNT(Job) as 'Number Of Jobs'
	from Company.Project P inner join Works_On W
	on P.ProjectNum = W.ProjectNum 
	group by P.ProjectName



---- 4 ----
create view V_Project_P2
as 
	select EmpFName 
	from Human_Resource.Emplopyee E
	inner join Works_On W on E.EmpNo = W.EmpNum
	inner join ProjectView_Without_Budget PWV on PWV.ProjectNum = W.ProjectNum and PWV.ProjectNum = 2



---- 5 ----
select top(2)* 
from ProjectView_Without_Budget




---- 6 ----
drop view Clerk_View, V_Count




---- 7 ----
create view Dept2_Employees
as
	select EmpNo, EmpLName
	from Human_Resource.Emplopyee 
	where DeptNo = 2




---- 8 ----
select EmpLName 
from Dept2_Employees
where EmpLName like '%j%'




---- 9 ----
create view v_dept
as
	select DeptNo, DeptName
	from Company.Department



---- 10 ----
insert into v_dept
values(4, 'Development')

select * from v_dept



---- 11 ----
create view v_2006_check
as 
	select EmpNum, ProjectNum, Enter_Date
	from Works_On
	where Enter_Date between '1-1-2006' and '12-31-2006'


