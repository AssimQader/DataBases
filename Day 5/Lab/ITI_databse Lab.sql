
/* --- 1 --- */
select count(St_Id) as 'Num of students have ages'
from Student 
where St_Age is not NULL;


/* --- 2 --- */
select distinct Ins_Name
from Instructor 


/* --- 3 --- */
select St_Id , ISNULL(St_Fname ,'TFName' ) + ' ' + ISNULL( St_Lname, 'TLName')  as 'Student Full Name',  ISNULL(Dept_Name , 'TDept') as 'Department Name'
from Student S , Department D
where S.Dept_Id = D.Dept_Id


/* --- 4 --- */
select Ins_Name , Dept_Name
from Instructor left outer join Department 
on Ins_Id = Dept_Manager


/* --- 5 --- */
select St_Fname + ' ' + St_Lname as 'student Full Name', Crs_Name
from Student S join Stud_Course  SC
on S.St_Id = SC.St_Id and Grade is not NULL
join Course C
on C.Crs_Id = SC.Crs_Id


/* --- 6 --- */
select COUNT(Crs_Id) as 'Num of Courses' , Top_Id
from Course
group by Top_Id


/* --- 7 --- */
select max(Salary) as 'Max Salary' , min(Salary) as 'Min Salary'
from Instructor


/* --- 8 --- */
select Ins_Name
from Instructor
where Salary < (select avg(Salary) from Instructor)

/* --- 9 --- */
select Dept_Name
from Instructor I join Department D
on I.Dept_Id = D.Dept_Id and I.Salary in (select min(Salary) from Instructor)


/* --- 10 --- */
select top(2) Salary  
from Instructor
order by Salary desc


/* --- 11 --- */
select Ins_Name , coalesce(CONVERT(char(30) ,Salary) ,'Instructor Bouns' )
from Instructor


/* --- 12 --- */
select avg(Salary)
from Instructor


/* --- 13 --- self join */
select St.St_Fname , Super.*
from Student St join Student Super 
on Super.St_Id =  St.St_super 


/* --- 14 --- */

select * 
from (select * , DENSE_RANK() over(partition by Dept_Id order by Salary desc ) as DN
		from Instructor 
		where Salary is not NULL) as NewTable_Ranked
where DN<=1


/* --- 15 --- */

select Dept_Id
from student
group by Dept_Id
order by newid()
 


