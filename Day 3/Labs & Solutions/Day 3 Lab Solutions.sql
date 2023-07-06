select Dnum , Dname , MGRSSN , Fname + '' + Lname as 'FullName'
from Departments D inner join Employee E
on E.SSN = D.MGRSSN


select Dname , Pname
from Departments D inner join Project p
on D.Dnum = P.Dnum


/*   D.*  means all the data of Dependent(D is the alias of Dependent)  */
select D.* , E.Fname + ' ' + E.Lname as 'FullName' 
from Dependent D inner join Employee E
on SSN = ESSN


select  Pnumber , Pname , Plocation 
from Project 
where City in('Cairo', 'Alex') 


select P.*
from Project P 
where Pname like'a%'  /*start with a and what comes after a is not important */


select Fname + ' ' + Lname as 'Full Name'  , Salary , Dno
from Employee E 
where Dno = 30 and E.Salary >= 1000 and E.Salary <=2000



select Fname + ' ' + Lname as 'Full Name', Hours, Pname
from Employee inner join Works_for
on Dno = 10 and SSN = ESSn and (Hours*7) >= 10    /*the table that results from this inner join statment join with the table Project*/
inner join Project   /* two inner join statments*/
on Pno = Pnumber and Pname = 'AL Rabwah'



/* self join could be done with comma between tables, where, and equal*/
select E.Fname + ' ' + E.Lname as 'Employee Full Name', Supervisor.Fname
from Employee E , Employee Supervisor  /*when u make join between the table and it self, put the same table name after the comma, and give this table الوهمي a diffrent alias name(supervisor) of what preceded the comma(E).. snd make this new table the parent one(the origin one) Supervisor not the Employee.*/
where Supervisor.SSN = E.Superssn and Supervisor.Fname + ' ' + Supervisor.Lname = 'Kamel Mohamed'



select  Fname + ' ' + Lname as 'Full Name' , P.Pname
from Employee E inner join Works_for W
on E.SSN = W.ESSn 
inner join Project P 
on  P.Pnumber = W.Pno
order by P.Pname



select Pnumber , Dname , Lname, Bdate , Address , City
from Project P inner join  Departments D
on City = 'Cairo' and  D.Dnum = P.Dnum
inner join  Employee
on SSN = MGRSSN
/* the previous inner join and any inner join could be done easy without using inner join statment, as follow: 

select Pnumber , Dname , Lname, Bdate , Address , City
from Project P , Departments D , Employee
where City = 'Cairo' and  D.Dnum = P.Dnum and SSN = MGRSSN

but inner join is a pet more faster.
*/



select Fname + ' ' + Lname as 'Full Name'
from Employee inner join Departments
on SSN = MGRSSN


select E.* , D.*
from Employee E left outer join Dependent D
on E.SSN = D.ESSN



insert into Employee
values ('Asem', 'Adel' , 102672 , 1999-02-03 , 'Nasr City', 'M', 3000, 102672, 30)



/*when u make an insert statement u have to insert the values بترتيب the table, as previous..
but if u want to miss some columns(like salary and MangerSSN in this sample, then put 
the columns names u want to affect on between parentheses after the insert into keyword, as follow: */
insert into Employee(Fname, Lname, SSN, Bdate, Address, Sex, Dno) 
values ('Ali', 'Shosha' , 102660 , 2000-04-21 , 'Nasr City', 'M', 30)




update Employee
set Salary = Salary + (Salary* 0.2)
where SSN = 102672