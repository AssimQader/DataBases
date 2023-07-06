select * from Employee;

select Fname, Lname, Salary, Dno from Employee;

select Pname, Plocation, Dnum from Project;

select Fname, Salary*12*0.1 as 'ANNUAL COMM' from Employee;

select SSN, Fname + Lname as [Full_Name], Salary from Employee
where Salary > 1000;


select SSN, Fname + Lname as [Full_Name], Salary from Employee
where Salary*12 > 10000;


select Fname + Lname as 'FullName' , Salary , Sex from Employee
where Sex = 'M';


select Dnum, Dname , MGRSSN from Departments
where MGRSSN = '968574'; 

select Pnumber, Pname, Plocation, Dnum from Project
where Dnum = 10;