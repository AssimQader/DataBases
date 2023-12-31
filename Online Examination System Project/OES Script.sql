USE [master]
GO
/****** Object:  Database [Online Examination System]    Script Date: 07/07/2023 12:46:20 ******/
CREATE DATABASE [Online Examination System]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Online Examination System', FILENAME = N'D:\ITI Courses\Data Base\Online Examination System Project\Online Examination System.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Online Examination System_log', FILENAME = N'D:\ITI Courses\Data Base\Online Examination System Project\Online Examination System_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Online Examination System] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Online Examination System].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Online Examination System] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Online Examination System] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Online Examination System] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Online Examination System] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Online Examination System] SET ARITHABORT OFF 
GO
ALTER DATABASE [Online Examination System] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Online Examination System] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Online Examination System] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Online Examination System] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Online Examination System] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Online Examination System] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Online Examination System] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Online Examination System] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Online Examination System] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Online Examination System] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Online Examination System] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Online Examination System] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Online Examination System] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Online Examination System] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Online Examination System] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Online Examination System] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Online Examination System] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Online Examination System] SET RECOVERY FULL 
GO
ALTER DATABASE [Online Examination System] SET  MULTI_USER 
GO
ALTER DATABASE [Online Examination System] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Online Examination System] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Online Examination System] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Online Examination System] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Online Examination System] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Online Examination System] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Online Examination System', N'ON'
GO
ALTER DATABASE [Online Examination System] SET QUERY_STORE = OFF
GO
USE [Online Examination System]
GO
/****** Object:  User [asem]    Script Date: 07/07/2023 12:46:20 ******/
CREATE USER [asem] FOR LOGIN [asem] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[ID] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Duration] [int] NULL,
	[Topic_ID] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ex_Stud_Qus]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_Stud_Qus](
	[Exam_ID] [int] NOT NULL,
	[Question_ID] [int] NOT NULL,
	[Student_ID] [int] NOT NULL,
	[Stud_Answer] [char](1) NULL,
	[Stud_Grade] [int] NULL,
 CONSTRAINT [PK_Ex_Stud_Qus] PRIMARY KEY CLUSTERED 
(
	[Exam_ID] ASC,
	[Student_ID] ASC,
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[ID] [int] NOT NULL,
	[Course_ID] [int] NULL,
 CONSTRAINT [PK_Exam] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam_Quest]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam_Quest](
	[Exam_ID] [int] NOT NULL,
	[Quest_ID] [int] NOT NULL,
 CONSTRAINT [PK_Exam_Quest] PRIMARY KEY CLUSTERED 
(
	[Exam_ID] ASC,
	[Quest_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inst_Course]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inst_Course](
	[Inst_SSN] [int] NOT NULL,
	[Course_ID] [int] NOT NULL,
	[Inst_Evaluation] [char](10) NULL,
 CONSTRAINT [PK_Inst_Course] PRIMARY KEY CLUSTERED 
(
	[Inst_SSN] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[SSN] [int] NOT NULL,
	[Name] [varchar](20) NULL,
	[Address] [varchar](50) NULL,
	[Phone] [varchar](20) NOT NULL,
	[Email] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionV2]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionV2](
	[ID] [int] NOT NULL,
	[Body] [varchar](max) NOT NULL,
	[Mark] [int] NOT NULL,
	[Model_Answer] [char](1) NOT NULL,
	[Type] [char](2) NOT NULL,
	[Course_ID] [int] NOT NULL,
 CONSTRAINT [PK_QuestionV2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stud_Course]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stud_Course](
	[Stud_ID] [int] NOT NULL,
	[Course_ID] [int] NOT NULL,
 CONSTRAINT [PK_Stud_Course] PRIMARY KEY CLUSTERED 
(
	[Stud_ID] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[ID] [int] NOT NULL,
	[Name] [varchar](20) NULL,
	[Address] [varchar](50) NULL,
	[Phone] [varchar](20) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Track_ID] [int] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Topic]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topic](
	[ID] [int] NOT NULL,
	[Name] [varchar](20) NULL,
 CONSTRAINT [PK_Topic] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Track]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track](
	[ID] [int] NOT NULL,
	[Name] [varchar](30) NULL,
	[Manger_SSN] [int] NULL,
 CONSTRAINT [PK_Track] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Track_Course]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track_Course](
	[Track_ID] [int] NOT NULL,
	[Course_ID] [int] NOT NULL,
 CONSTRAINT [PK_Track_Course] PRIMARY KEY CLUSTERED 
(
	[Track_ID] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Topic] FOREIGN KEY([Topic_ID])
REFERENCES [dbo].[Topic] ([ID])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Topic]
GO
ALTER TABLE [dbo].[Ex_Stud_Qus]  WITH CHECK ADD  CONSTRAINT [FK_Ex_Stud_Qus_Exam] FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([ID])
GO
ALTER TABLE [dbo].[Ex_Stud_Qus] CHECK CONSTRAINT [FK_Ex_Stud_Qus_Exam]
GO
ALTER TABLE [dbo].[Ex_Stud_Qus]  WITH CHECK ADD  CONSTRAINT [FK_Ex_Stud_Qus_QuestionV2] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[QuestionV2] ([ID])
GO
ALTER TABLE [dbo].[Ex_Stud_Qus] CHECK CONSTRAINT [FK_Ex_Stud_Qus_QuestionV2]
GO
ALTER TABLE [dbo].[Ex_Stud_Qus]  WITH CHECK ADD  CONSTRAINT [FK_Ex_Stud_Qus_Student] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[Ex_Stud_Qus] CHECK CONSTRAINT [FK_Ex_Stud_Qus_Student]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Course] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_Course]
GO
ALTER TABLE [dbo].[Exam_Quest]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Quest_Exam] FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([ID])
GO
ALTER TABLE [dbo].[Exam_Quest] CHECK CONSTRAINT [FK_Exam_Quest_Exam]
GO
ALTER TABLE [dbo].[Exam_Quest]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Quest_QuestionV2] FOREIGN KEY([Quest_ID])
REFERENCES [dbo].[QuestionV2] ([ID])
GO
ALTER TABLE [dbo].[Exam_Quest] CHECK CONSTRAINT [FK_Exam_Quest_QuestionV2]
GO
ALTER TABLE [dbo].[Inst_Course]  WITH CHECK ADD  CONSTRAINT [FK_Inst_Course_Course] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[Inst_Course] CHECK CONSTRAINT [FK_Inst_Course_Course]
GO
ALTER TABLE [dbo].[Inst_Course]  WITH CHECK ADD  CONSTRAINT [FK_Inst_Course_Instructor] FOREIGN KEY([Inst_SSN])
REFERENCES [dbo].[Instructor] ([SSN])
GO
ALTER TABLE [dbo].[Inst_Course] CHECK CONSTRAINT [FK_Inst_Course_Instructor]
GO
ALTER TABLE [dbo].[QuestionV2]  WITH CHECK ADD  CONSTRAINT [FK_QuestionV2_Course] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[QuestionV2] CHECK CONSTRAINT [FK_QuestionV2_Course]
GO
ALTER TABLE [dbo].[Stud_Course]  WITH CHECK ADD  CONSTRAINT [FK_Stud_Course_Course] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[Stud_Course] CHECK CONSTRAINT [FK_Stud_Course_Course]
GO
ALTER TABLE [dbo].[Stud_Course]  WITH CHECK ADD  CONSTRAINT [FK_Stud_Course_Student] FOREIGN KEY([Stud_ID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[Stud_Course] CHECK CONSTRAINT [FK_Stud_Course_Student]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Track] FOREIGN KEY([Track_ID])
REFERENCES [dbo].[Track] ([ID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Track]
GO
ALTER TABLE [dbo].[Track]  WITH CHECK ADD  CONSTRAINT [FK_Track_Instructor] FOREIGN KEY([Manger_SSN])
REFERENCES [dbo].[Instructor] ([SSN])
GO
ALTER TABLE [dbo].[Track] CHECK CONSTRAINT [FK_Track_Instructor]
GO
ALTER TABLE [dbo].[Track_Course]  WITH CHECK ADD  CONSTRAINT [FK_Track_Course_Course] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[Track_Course] CHECK CONSTRAINT [FK_Track_Course_Course]
GO
ALTER TABLE [dbo].[Track_Course]  WITH CHECK ADD  CONSTRAINT [FK_Track_Course_Track] FOREIGN KEY([Track_ID])
REFERENCES [dbo].[Track] ([ID])
GO
ALTER TABLE [dbo].[Track_Course] CHECK CONSTRAINT [FK_Track_Course_Track]
GO
ALTER TABLE [dbo].[QuestionV2]  WITH CHECK ADD  CONSTRAINT [CHK_Type2] CHECK  (([Type]='tf' OR [Type]='ch'))
GO
ALTER TABLE [dbo].[QuestionV2] CHECK CONSTRAINT [CHK_Type2]
GO
/****** Object:  StoredProcedure [dbo].[CRUD_OPERATION]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[CRUD_OPERATION] @operation varchar(10), @table_name varchar(200), @data varchar(max) , @condition varchar(200) = ''
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
GO
/****** Object:  StoredProcedure [dbo].[EXAM_CORRECTION]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EXAM_CORRECTION] @studName varchar(30), @examID int
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
GO
/****** Object:  StoredProcedure [dbo].[EXAM_QUESTIONS]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EXAM_QUESTIONS] @examID int
as
	select EQ.Exam_ID, Q.Body as 'Question'
	from Exam_Quest EQ inner join QuestionV2 Q
	on EQ.Quest_ID = Q.ID and EQ.Exam_ID = @examID 
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_EXAM]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GENERATE_EXAM] @exam_ID int, @course_name varchar(50), @TFnum int , @CHnum int
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
GO
/****** Object:  StoredProcedure [dbo].[INSTRUCTOR_DATA]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[INSTRUCTOR_DATA]  @InstructorID int
as
		select C.Name as 'Course Name' , COUNT(SC.Stud_ID) as 'Number of Students'
		from Inst_Course IC inner join Course C
		on C.ID = IC.Course_ID and IC.Inst_SSN = @InstructorID
		inner join Stud_Course SC
		on C.ID = SC.Course_ID
		group by C.Name
GO
/****** Object:  StoredProcedure [dbo].[SHOW_EXAM]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SHOW_EXAM] @exam_id int 
as
	select EQ.* , Q.Body , Q.Type , Q.Mark
	from Exam_Quest EQ inner join QuestionV2 Q
	on EQ.Quest_ID = Q.ID and Exam_ID = @exam_id
GO
/****** Object:  StoredProcedure [dbo].[STUD_ANSWER]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[STUD_ANSWER] @StudName varchar(20), @ExamID int , @QuestionID int, @Answer char(1)
as 
	begin try

		declare @StudentID int		--store the id of the student that will answer the exam.
		select @StudentID = ID from Student where Name = @StudName

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
GO
/****** Object:  StoredProcedure [dbo].[STUDENT_ANSWERS]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[STUDENT_ANSWERS] @examID int , @studentID int
as
	select Q.Body as 'Question', ES.Stud_Answer as 'Student Answer'
	from Ex_Stud_Qus ES inner join QuestionV2 Q
	on ES.Question_ID = Q.ID and ES.Exam_ID = @examID and ES.Student_ID = @studentID
GO
/****** Object:  StoredProcedure [dbo].[STUDENT_GRADES]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[STUDENT_GRADES] @studentID int
as
	select S.Name as 'Student Name', C.Name as 'Course Name', concat( SUM(Stud_Grade), ' out of ' , count(ES.Question_ID) )  as 'Sum of the Grades'
	from Ex_Stud_Qus ES inner join Exam E
	on ES.Exam_ID = E.ID and ES.Student_ID = 1 
	inner join Student S 
	on S.ID = ES.Student_ID
	inner join Course C
	on C.ID = E.Course_ID
	group by C.Name, S.Name
GO
/****** Object:  StoredProcedure [dbo].[STUDENTS_PER_TRACK]    Script Date: 07/07/2023 12:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[STUDENTS_PER_TRACK] @trackID int 
as 
	select * 
	from Student
	where Track_ID = @trackID
GO
USE [master]
GO
ALTER DATABASE [Online Examination System] SET  READ_WRITE 
GO
