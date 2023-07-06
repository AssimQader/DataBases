
--create new table "Grades" and put some info about the student and his courses in it.
select s.St_Id, s.St_Fname, s.St_Age, sc.Grade, c.Crs_Name into Grades 
from SC.Student s, Stud_Course sc , SC.Course c
where s.St_Id = sc.St_Id and c.Crs_Id = sc.Crs_Id

select * from Grades



SELECT 
	   St_Fname, 
	   Grade,
	   stud_prev = lAG(Grade) OVER(ORDER BY Grade),
	   stud_Next = LEAD(Grade) OVER(ORDER BY Grade)
FROM Grades

SELECT 
	   St_Fname, 
	   Grade,
	   stud_prev = lAG (St_Fname) OVER(ORDER BY Grade),
	   stud_Next = LEAD (St_Fname) OVER(ORDER BY Grade)
FROM Grades


SELECT 
	  st_fname,
	  Grade,
	  Crs_name,
	  lowest  =  FIRST_VALUE(Grade) OVER(PARTITION BY Crs_name ORDER BY Grade ),
	  Highest = LAST_VALUE(Grade) OVER(PARTITION BY Crs_name ORDER BY Grade)
FROM Grades










SELECT st_fname,dept_id,st_age,
	   lowest=FIRST_VALUE(st_age) OVER(PARTITION BY dept_id ORDER BY st_age ),
	   Highest=LAST_VALUE(st_age) OVER(PARTITION BY dept_id ORDER BY st_age ROWS BETWEEN unbounded preceding AND unbounded following),
	   stud_prev=lAG(st_age) OVER(PARTITION BY dept_id ORDER BY st_age),
	   stud_Next=LEAD(st_age) OVER(PARTITION BY dept_id ORDER BY st_age )
FROM SC.Student


--lag and lead parameters
SELECT st_fname,dept_id,st_age,
	   stud_prev=lAG(st_age) OVER(PARTITION BY dept_id ORDER BY st_age),
	   stud_prev_diff=st_age-isnull(lAG(st_age) OVER(PARTITION BY dept_id ORDER BY st_age),0)
FROM SC.Student




SELECT st_fname,dept_id,st_age,
	   stud_prev=lAG(st_age) OVER(PARTITION BY dept_id ORDER BY st_age),
	   stud_prev_diff=isnull(st_age,0)-isnull(lAG(st_age) OVER(PARTITION BY dept_id ORDER BY st_age),0),
	   stud_Next=LEAD(st_age) OVER(PARTITION BY dept_id ORDER BY st_age ),
	   stud_Next_diff=isnull(st_age,0)-isnull(LEAD(st_age) OVER(PARTITION BY dept_id ORDER BY st_age),0)
FROM SC.Student



SELECT st_fname,dept_id,st_age,
	   lowest=FIRST_VALUE(st_age) OVER(ORDER BY st_age),
	   Highest=LAST_VALUE(st_age) OVER(ORDER BY st_age ROWS BETWEEN unbounded preceding AND unbounded following),
	   stud_prev=lAG(st_age) OVER(ORDER BY st_age),
	   stud_Next=LEAD(st_age) OVER(ORDER BY st_age )
FROM SC.Student
