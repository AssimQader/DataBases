ALTER TABLE QuestionV2
ADD CONSTRAINT CHK_Type2 CHECK (Type = 'tf' or Type = 'ch');

--------------------------------------------------------------------------------------------

				/* ---- Crud Operations Procedure ---- */

alter proc CRUD_OPERATION @operation varchar(10), @table_name varchar(200), @data varchar(max), @condition varchar(200) = ''
as

  DECLARE @sql_query VARCHAR(500);
  
  IF @operation = 'SELECT' 
    SET @sql_query = CONCAT('SELECT ', @data, ' FROM ', @table_name)
  ELSE IF @operation = 'INSERT'
    SET @sql_query = CONCAT('INSERT INTO ', @table_name, ' VALUES(', @data, ')')
  ELSE IF @operation = 'UPDATE'
    SET @sql_query = CONCAT('UPDATE ', @table_name, ' SET ', @data, ' WHERE ', @condition)
  ELSE IF @operation = 'DELETE'
    SET @sql_query = CONCAT('DELETE FROM ', @table_name, ' WHERE ', @condition)
  ELSE
    RAISERROR('Invalid operation', 16, 1)
  
   EXECUTE (@sql_query)


 --test procedure:
exec CRUD_OPERATION 'INSERT' , 'Student' , ' 9, ''Omar Zakaria'', ''Cairo-Nasrcity'', 01029382392, ''OmarZ'', ''Omar123#'', 3 '
exec CRUD_OPERATION 'DELETE' , 'Topic' , '' ,'ID = 3'
exec CRUD_OPERATION 'UPDATE' , 'Topic' , ' Name = ''databases'' ' ,'ID = 3'

-------------------------------------------------------------------------------------------------------------


				/* ---- Generate Exame Procedure ---- */

alter proc GENERATE_EXAM @exam_ID int, @course_name varchar(50), @TFnum int , @CHnum int
as 
	declare @courseID int --variable stores the courseID.
	select @courseID = ID from Course where Name = @course_name

	--create the exam and define the target course in "Exam" table.
	insert into Exam
	values(@exam_ID , @courseID)

	--generate random questions for each exam, and store them in "Exam_Quest" table.
	begin try
		begin transaction
		/*
			select Top(@TFnum)ID
			into #TFQuestions
			from QuestionV2 
			where Type = 'tf' and Course_ID = @courseID
			order by newid()


			select Top(@CHnum)ID
			into #MCQQuestions
			from QuestionV2 
			where Type = 'ch' and Course_ID = @courseID
			order by newid() 
		*/

			while @TFnum != 0
				begin
					declare @quest_id int  --variable stores eustion id in each loop.
				
				/*this loop is to prevent the repeatation of any question in the exam, 
				  NEWID() may give u the same result twice because it chooses randomly.*/
					declare @flag int = 0
					while @flag = 0 
						begin
							select @quest_id = ID
							from QuestionV2
							where Type = 'tf' and Course_ID = @courseID 
							order by NEWID()

							if not exists(select Quest_ID from Exam_Quest where Quest_ID = @quest_id)
								set @flag += 1
						end 

					--insert the exam ID and each question for this exam in "Exam_Quest" table.
					insert into Exam_Quest
					values(@exam_ID , @quest_id)

					set @TFnum -= 1		---- like counter--;
				end



			while @CHnum != 0
				begin
					declare @quest_id2 int

					declare @flag2 int = 0
					while @flag2 = 0
						begin
							select @quest_id2 = ID
							from QuestionV2
							where Type = 'ch' and Course_ID = @courseID 
							order by NEWID()

							if not exists(select Quest_ID from Exam_Quest where Quest_ID = @quest_id2)
								set @flag2 += 1
						end 

					insert into Exam_Quest
					values(@exam_ID ,  @quest_id2 )

					set @CHnum -= 1
				end 


			--Show the exam after creation.
			select EQ.* , Q.Body , Q.Type , Q.Mark
			from Exam_Quest EQ inner join QuestionV2 Q
			on EQ.Quest_ID = Q.ID and Exam_ID = @exam_id

		commit
	end try
	begin catch
		rollback
	end catch


 --test procedure:	
exec GENERATE_EXAM 2, 'Flutter', 3, 2 

-------------------------------------------------------------------------------------------------------------


				/* ---- Show Exam Procedure ---- */

alter proc SHOW_EXAM @exam_id int 
as
	select EQ.* , Q.Body , Q.Type , Q.Mark
	from Exam_Quest EQ inner join QuestionV2 Q
	on EQ.Quest_ID = Q.ID and Exam_ID = @exam_id


 --test procedure:
exec SHOW_EXAM 2


-------------------------------------------------------------------------------------------------------------

				 /* ---- Student Answering Procedure ---- */

alter proc STUD_ANSWER @StudName varchar(20), @ExamID int , @QuestionID int, @Answer char(1)
as 
	begin try

		declare @StudentID int		--store the id of the student that will answer the exam.
		select @StudentID = ID from Student where Name = @StudName

		--check if the question the user will answer is really exist in the exam or not.
		if not exists(select Quest_ID from Exam_Quest where Quest_ID = @QuestionID)
			RAISERROR (15600, -1, -1, 'This Exam have no such a question!');


		--fill the table "Ex_Stud_Ques" with data
		insert into Ex_Stud_Qus(Exam_ID, Question_ID, Student_ID, Stud_Answer) 
		values(@ExamID, @QuestionID, @StudentID, @Answer)


		declare @modelAns char(1)		--store the model answer(from QuestionV2 table) of the question the user has answerd.
		select @modelAns = Q.Model_Answer
		from QuestionV2 Q
		where Q.ID = @QuestionID


		--compare the student answer and the model answer.
		if (@Answer = @modelAns)
			begin
				update Ex_Stud_Qus
				set Stud_Grade = 1
				where Exam_ID = @ExamID and Question_ID = @QuestionID and Student_ID = @StudentID 
			end
	end try
	begin catch
		throw 53000 , 'Invalid Data intered!!', 1
	end catch


 --test procedure:
exec STUD_ANSWER 'Asem Adel', 2, 19, 'b'

-------------------------------------------------------------------------------------------------------------


				/* ---- Exam Correction Procedure ---- */

alter proc EXAM_CORRECTION @studName varchar(30), @examID int
as 
	declare @studid int
	select @studid = ID from Student where Name = @studName

	--Get number of questions per Exam
	declare @numOfQuestions int 
	select @numOfQuestions = COUNT(Question_ID)
	from Ex_Stud_Qus 
	where Exam_ID = @examID

	select S.Name, concat(SUM(Stud_Grade), ' out of ' , @numOfQuestions)  as 'Sum of the Grades'
	from Ex_Stud_Qus EXQ , Student S
	where S.ID = @studid and Exam_ID = @examID
	group by S.Name


 --test procedure:
exec EXAM_CORRECTION 'Asem Adel' , 2


------------------------------------------------------------------------------------------------------------------

									/* --- SSRS Stored Procedures --- */

	-- 1)
alter proc STUDENTS_PER_TRACK @trackID int 
as 
	select * 
	from Student
	where Track_ID = @trackID



	-- 2)
alter proc STUDENT_GRADES @studentID int
as
	select S.Name as 'Student Name',
		   C.Name as 'Course Name', 
		   concat( SUM(Stud_Grade), ' out of ' , count(ES.Question_ID) )  as 'Sum of the Grades'
	from Ex_Stud_Qus ES inner join Exam E
	on ES.Exam_ID = E.ID and ES.Student_ID = 1 
	inner join Student S 
	on S.ID = ES.Student_ID
	inner join Course C
	on C.ID = E.Course_ID
	group by C.Name, S.Name



		-- 3)
create proc INSTRUCTOR_DATA  @InstructorID int
as
	select C.Name as 'Course Name' , COUNT(SC.Stud_ID) as 'Number of Students'
	from Inst_Course IC inner join Course C
	on C.ID = IC.Course_ID and IC.Inst_SSN = @InstructorID
	inner join Stud_Course SC
	on C.ID = SC.Course_ID
	group by C.Name



		-- 4)
create proc EXAM_QUESTIONS @examID int
as
	select EQ.Exam_ID, Q.Body as 'Question'
	from Exam_Quest EQ inner join QuestionV2 Q
	on EQ.Quest_ID = Q.ID and EQ.Exam_ID = @examID 



		-- 5)
create proc STUDENT_ANSWERS @examID int , @studentID int
as
	select Q.Body as 'Question', ES.Stud_Answer as 'Student Answer'
	from Ex_Stud_Qus ES inner join QuestionV2 Q
	on ES.Question_ID = Q.ID and ES.Exam_ID = @examID and ES.Student_ID = @studentID

-----------------------------------------------------------------------------------------------------------------


			--  The End :)  --