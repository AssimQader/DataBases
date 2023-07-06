use Company_SD

/* --- 1 --- */
select Dependent_name , D.Sex, E.Sex
from Dependent D , Employee E
where D.ESSN = E.SSN  and D.Sex = 'F'and E.Sex = 'F'
union
select Dependent_name , D.Sex, E.Sex
from Dependent D , Employee E
where D.ESSN = E.SSN  and D.Sex = 'M'and E.Sex = 'M'

 
/* --- 2 --- */
select Pname , sum(hours*7)
from Project , Works_for 
where Pnumber = pno
group by Pname


/* --- 3 --- */
 select * 
 from Departments join Employee
 on  Dno = Dnum and SSN =  (select min(SSN) from Employee)



/* --- 4 --- */
select Dname, max(Salary) as 'MaxSalary', min(Salary) as 'MinSalary' , avg(Salary) as 'AvgSalary'
from Departments join Employee
on Dno = Dnum
group by Dname


/*--------------------------------------------------------------------------*/

/* --- 5.retrive all the Employees that have no dependets ---*/

/*retrive employees that have or not dependent*/
select Fname + ' ' + Lname as 'Full Name'
from Employee left outer join Dependent
on ESSN = SSN

except 

/*retrive employees only have dependent*/
select Fname + ' ' + Lname as 'Full Name'
from Employee join Dependent
on ESSN = SSN


/* --- 5.retrive all the Mangers that have no dependets --- */

--way 1
select Fname + ' ' + Lname as 'Full Name'
from Departments join Employee
on SSN = MGRSSN  /*till here, i retrive the mangers*/
left outer join Dependent /* then "left outer join" the previous results table with Dependent table to get the mangers that have dependents and the mangers they have no dependents too*/
On ESSN = MGRSSN and ESSN is NULL

except 

select Fname + ' ' + Lname as 'Full Name'
from Departments join Employee
on SSN = MGRSSN  /*till here, i retrive the mangers*/
join Dependent /* then "inner join" the previous results table with Dependent table to get the mangers that have dependents only*/
On ESSN = MGRSSN



--way 2
SELECT Fname + ' ' + Lname as 'Full Name'
FROM Employee
WHERE SSN not in(SELECT ESSN from Dependent) -- SSN of employee is not in dependent(employee have no dependents)
and SSN in(SELECT MGRSSN FROM Departments) -- SSN of employee is in department as a manger.

/*--------------------------------------------------------------------------*/



/*--- 6 --- */
/*get the number of employees in each department, and the avg of the salries in this department:
avg = (sum all salaries of all employess in this department / number of employees in this department) */
select Dname , Dnum , COUNT(SSN) as 'Num Of Employees' , avg(salary) as 'Avg salaries in the department'
from Departments , Employee
where Dno = Dnum
group by Dname , Dnum 
having avg(Salary) < (select avg(Salary) from Employee) /* < the avg salaries of all employees */




/*--- 7 ---  recap */
select Fname + ' ' + Lname , Pname , Dno
from Employee , Works_for ,Project
where SSN = ESSn and Pno = Pnumber
order by Dno , Fname , Lname




/*--- 8 ---  recap */

select max(salary) as 'max'
from Employee
union 
select max(Salary) from Employee
where Salary not in (select max(Salary) from Employee)




/*--- 9 --- */

select Fname + ' ' + Lname as 'Similars Names'
from Employee
intersect /*get the names that exist in both queries results. هات أسامي الموظفين اللي اسمهم شبه اسم حد في الديبندنتس  */
select  Dependent_name
from Dependent




/*--- 10 --- */ 
select SSN, Fname + ' ' + Lname as 'Full Name'
from Employee 
where exists(select distinct Fname from Employee join Dependent on SSN = ESSN );
/*if waht inside exists parenthese return at least one record(row), then exists return true and excute the query before where statment
translate what inside exists: retrieve all the employees that have dependent, and as there are employees have dependentفعلاً, 
so exists return true, and what before where will excute.*/

select SSN, Fname + ' ' + Lname as 'Full Name'
from Employee 
where not exists(select distinct Fname from Employee join Dependent on SSN = ESSN );
/*if waht inside "not exists" parenthese return any record(row), then "not exists" return false and not excute the query before where statment.
translate what inside exists: retrieve all the employees that have dependent, and as there are employees have dependentفعلاً, 
so not exists return false, and what before where will not excute. 
if there is not any employee have any dependent, then "not exists" will return true, and whate before where will excute. */





/*--- 11 --- */
insert into Departments
values('DEPT IT', 100, 112233, '2006-11-01 00:00:00.000') /*Ahmed(112233) becomes a manger for the department DPT IT*/

select Fname , MGRSSN , Dname
from Employee join  Departments
on SSN = MGRSSN




/*--- 12 --- */

/*a*/
/*update department 100 to make noha his manger*/
update Departments
set MGRSSN = 968574
where Dnum = 100;

/*update noha record(as employee) to make her works in department 100*/
update Employee
set Dno = 100
where SSN = 968574


/*b*/
update Departments
set MGRSSN = 102672
where Dnum = 20;

update Employee
set Dno = 20
where SSN = 102672


/*c*/
update Employee
set Superssn = 102672
where SSN = 102660



/*--- 13 --- */

--prevent him from being manger 
update Departments
set MGRSSN = NULL 
where MGRSSN = 223344

--delete his dependnts
delete from Dependent
where ESSN = 223344

--delete supersssn
update Employee 
set Superssn=NULL 
where Superssn=223344

--finally delete him
delete from Employee
where SSN = 223344 




/*--- 14 --- */

UPDATE Employee 
SET Salary = Salary + (Salary * .3)
WHERE SSN IN ( SELECT ESSn FROM Works_for inner join project on Pno = Pnumber and Pname = 'Al Rabwah')