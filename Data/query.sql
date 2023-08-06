USE [CrudWebApp_Db]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 8/6/2023 6:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[DateOfBirth] [datetime2](7) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Salary] [float] NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Employee]    Script Date: 8/6/2023 6:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_Employee]
(
	@Id INT
)
AS
BEGIN
	DECLARE @RowCount INT = 0
		BEGIN TRY
			SET @RowCount = (SELECT COUNT(1) FROM [dbo].[Employees]  WITH (NOLOCK) WHERE Id = @Id)
		
		IF(@RowCount > 0)
			BEGIN
				BEGIN TRAN
					DELETE FROM [dbo].[Employees]
						WHERE Id = @Id
				COMMIT TRAN
			END
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_EmployeeById]    Script Date: 8/6/2023 6:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--GetById
CREATE PROCEDURE [dbo].[sp_Get_EmployeeById] 
(
	@Id INT
)
AS
BEGIN
	
	SELECT Id, FirstName, LastName, DateOfBirth, Email, Salary FROM [dbo].[Employees] WITH (NOLOCK)
	WHERE Id= @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Employees]    Script Date: 8/6/2023 6:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Read all employees
CREATE PROCEDURE [dbo].[sp_Get_Employees] 
AS
BEGIN
	
	SELECT Id, FirstName, LastName, DateOfBirth, Email, Salary FROM [dbo].[Employees] WITH (NOLOCK)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Employee]    Script Date: 8/6/2023 6:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Insert
CREATE PROCEDURE [dbo].[sp_Insert_Employee]
(
	@FirstName VARCHAR(50), 
	@LastName VARCHAR(50), 
	@DateOfBirth DATE, 
	@Email VARCHAR(50), 
	@Salary FLOAT
)
AS
BEGIN
BEGIN TRY
	BEGIN TRAN
	INSERT INTO [dbo].[Employees] (FirstName, LastName, DateOfBirth, Email, Salary) 
		VALUES
			(
				@FirstName,
				@LastName,
				@DateOfBirth,
				@Email,
				@Salary
			)
COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Employee]    Script Date: 8/6/2023 6:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_Employee]
(
	@Id INT,
	@FirstName VARCHAR(50), 
	@LastName VARCHAR(50), 
	@DateOfBirth DATE, 
	@Email VARCHAR(50), 
	@Salary FLOAT
)
AS
BEGIN
	DECLARE @RowCount INT = 0
		BEGIN TRY
			SET @RowCount = (SELECT COUNT(1) FROM [dbo].[Employees]  WITH (NOLOCK) WHERE Id = @Id)
		
		IF(@RowCount > 0)
			BEGIN
				BEGIN TRAN
					UPDATE [dbo].[Employees]
						SET
							FirstName = @FirstName,
							LastName = @LastName,
							DateOfBirth = @DateOfBirth,
							Email = @Email,
							Salary = @Salary
						WHERE Id = @Id
						COMMIT TRAN
			END
		
		END TRY

		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
END
GO
