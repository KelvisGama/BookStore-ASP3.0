USE [master]
GO
/****** Object:  Database [bookStore]    Script Date: 16/05/2016 17:39:25 ******/
CREATE DATABASE [bookStore]
 --CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'bookStore', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\bookStore.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'bookStore_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\bookStore_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [bookStore] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [bookStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [bookStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [bookStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [bookStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [bookStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [bookStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [bookStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [bookStore] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [bookStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [bookStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [bookStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [bookStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [bookStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [bookStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [bookStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [bookStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [bookStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [bookStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [bookStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [bookStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [bookStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [bookStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [bookStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [bookStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [bookStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [bookStore] SET  MULTI_USER 
GO
ALTER DATABASE [bookStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [bookStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [bookStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [bookStore] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [bookStore]
GO
/****** Object:  User [usrBookStore]    Script Date: 16/05/2016 17:39:25 ******/
CREATE USER [usrBookStore] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [userBookStore]    Script Date: 16/05/2016 17:39:25 ******/
CREATE USER [userBookStore] FOR LOGIN [userBookStore] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [userBookStore]
GO
/****** Object:  StoredProcedure [dbo].[sp_Author_Books_idAuthor]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna todos os livros de um autor
-- =============================================
CREATE PROCEDURE [dbo].[sp_Author_Books_idAuthor] 
	@int_idAuthor int
AS
BEGIN
	SET NOCOUNT ON;

	IF (ISNULL(@int_idAuthor, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_idAuthor não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	SELECT idBook
	,Title
	,Subtitle
	,Publisher
	,[year]
	,Summary
	,imgCover
	,Stock
	,Price
	FROM Book
	WHERE idBook IN 
	(SELECT idBook FROM BookAuthor WHERE idAuthor = @int_idAuthor)
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Author_Del_id]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que remove um author
-- =============================================
CREATE PROCEDURE [dbo].[sp_Author_Del_id]
	@int_IdAuthor int
AS
BEGIN	
	IF (ISNULL(@int_IdAuthor, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_IdAuthor não pode ser NULL', 18, 0)
		RETURN
	END

	DELETE
	FROM Author
	WHERE idAuthor = @int_IdAuthor
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Author_Ins]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que insere um novo autor
-- =============================================
CREATE PROCEDURE [dbo].[sp_Author_Ins]
	@str_FisrtName varchar(100),
	@str_LastName varchar(100)
AS
BEGIN	
	IF (ISNULL(@str_FisrtName, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @str_FisrtName não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	IF (ISNULL(@str_LastName, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @str_LastName não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	INSERT INTO Author
	(FirstName
	,LastName
	)
	OUTPUT Inserted.idAuthor
	VALUES
	(@str_FisrtName,
	@str_LastName)
	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Author_Sel]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna todos os autores da loja
-- =============================================
CREATE PROCEDURE [dbo].[sp_Author_Sel]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT idAuthor
	,FirstName
	,LastName
	FROM Author
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Author_Sel_id]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna os dados de um autor a partir do IdBook
-- =============================================
CREATE PROCEDURE [dbo].[sp_Author_Sel_id] 
	@int_idAuthor int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT idAuthor
	,FirstName
	,LastName
	FROM Author
	WHERE idAuthor = @int_idAuthor
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Author_Upd]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que altera os dados de um Autor
-- =============================================
CREATE PROCEDURE [dbo].[sp_Author_Upd]
	@int_IdAuthor int,
	@str_FistName varchar(100),
	@str_LastName varchar(100)
AS
BEGIN	

	IF (ISNULL(@int_IdAuthor, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_IdAuthor não pode ser NULL.', 18, 0)
		RETURN
	END

	IF (ISNULL(@str_FistName, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @str_FistName não pode ser NULL ou vazio.', 18, 0)
		RETURN
	END

	IF (ISNULL(@str_LastName, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @str_LastName não pode ser NULL ou vazio.', 18, 0)
		RETURN
	END

	UPDATE Author
	SET
	FirstName	= @str_FistName
	,LastName	= @str_LastName	
	WHERE idAuthor = @int_IdAuthor
	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Book_Authors_idBook]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna todos os autores de um livro
-- =============================================
CREATE PROCEDURE [dbo].[sp_Book_Authors_idBook] 
	@int_idBook int
AS
BEGIN
	SET NOCOUNT ON;

	IF (ISNULL(@int_idBook, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_idBook não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	SELECT idAuthor
	,FirstName
	,LastName
	FROM Author
	WHERE idAuthor IN 
	(SELECT idAuthor FROM BookAuthor WHERE idBook = @int_idBook)
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Book_Categories_idBook]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna todos as categorias de um livro
-- =============================================
CREATE PROCEDURE [dbo].[sp_Book_Categories_idBook] 
	@int_idBook int
AS
BEGIN
	SET NOCOUNT ON;

	IF (ISNULL(@int_idBook, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_idBook não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	SELECT idCategory
	,Name
	,MenuOrder
	FROM Category
	WHERE idCategory IN 
	(SELECT idCategory FROM BookCategory WHERE idBook = @int_idBook)
END



GO
/****** Object:  StoredProcedure [dbo].[sp_Book_Del_id]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que remove um livro
-- =============================================
CREATE PROCEDURE [dbo].[sp_Book_Del_id]
	@int_IdBook int
AS
BEGIN	
	IF (ISNULL(@int_IdBook, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_IdBook não pode ser NULL', 18, 0)
		RETURN
	END

	DELETE
	FROM Book
	WHERE idBook = @int_IdBook
	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Book_Ins]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna todos os livros da loja
-- =============================================
CREATE PROCEDURE [dbo].[sp_Book_Ins]
	@str_Title varchar(50),
	@str_SubTitle varchar(100),
	@str_Publisher varchar(50),
	@str_Year date,
	@str_Summary varchar(MAX),
	@str_imgCover varchar(50),
	@int_Stock int,
	@dec_Price decimal(18,2)
AS
BEGIN	
	IF (ISNULL(@str_Title, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @str_Title não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	INSERT INTO Book
	(Title
	,Subtitle
	,Publisher
	,[Year]
	,Summary
	,imgCover
	,Stock
	,Price)
	OUTPUT Inserted.idBook
	VALUES
	(@str_Title,
	@str_SubTitle,
	@str_Publisher,
	@str_Year,
	@str_Summary,
	@str_imgCover,
	@int_Stock,
	@dec_Price)
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Book_Sel]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna todos os livros da loja
-- =============================================
CREATE PROCEDURE [dbo].[sp_Book_Sel]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT idBook
	,Title
	,Subtitle
	,Publisher
	,[Year]
	,Summary
	,imgCover
	,Stock
	,Price
	FROM Book
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Book_Sel_id]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna os dados de um livro a partir do IdBook
-- =============================================
CREATE PROCEDURE [dbo].[sp_Book_Sel_id] 
	@int_idBook int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT idBook
	,Title
	,Subtitle
	,Publisher
	,[Year]
	,Summary
	,imgCover
	,Stock
	,Price
	FROM Book
	WHERE idBook = @int_idBook
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Book_Upd]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que altera os dados de um livro
-- =============================================
CREATE PROCEDURE [dbo].[sp_Book_Upd]
	@int_IdBook int,
	@str_Title varchar(50),
	@str_SubTitle varchar(100),
	@str_Publisher varchar(50),
	@str_Year date,
	@str_Summary varchar(MAX),
	@str_imgCover varchar(50),
	@int_stock int,
	@dec_price decimal(18,2)
AS
BEGIN	

	IF (ISNULL(@int_IdBook, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_IdBook não pode ser NULL', 18, 0)
		RETURN
	END

	IF (ISNULL(@str_Title, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @str_Title não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	UPDATE Book
	SET
	Title = @str_Title
	,Subtitle	= @str_SubTitle
	,Publisher 	= @str_Publisher
	,[Year]		= @str_Year
	,Summary	= @str_Summary
	,imgCover	= @str_imgCover
	,Stock		= @int_stock
	,Price		= @dec_price
	WHERE IdBook = @int_IdBook
	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BookAuthor_Del]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que remove vinculo do Livro com Autor
-- =============================================
CREATE PROCEDURE [dbo].[sp_BookAuthor_Del]
	@int_idBook int,
	@int_idAuthor int
AS
BEGIN	
	IF (ISNULL(@int_idBook, '') = '')
	BEGIN
		RAISERROR('Parâmetro Inválido: @int_idBook não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	IF (ISNULL(@int_idAuthor, '') = '')
	BEGIN
		RAISERROR('Parâmetro Inválido: @int_idAuthor não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	DELETE FROM BookAuthor
	WHERE
	idBook = @int_idBook
	AND 
	idAuthor = @int_idAuthor
	
END




GO
/****** Object:  StoredProcedure [dbo].[sp_BookAuthor_Ins]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que vincula Livro com Autor
-- =============================================
CREATE PROCEDURE [dbo].[sp_BookAuthor_Ins]
	@int_idBook int,
	@int_idAuthor int
AS
BEGIN	
	IF (ISNULL(@int_idBook, '') = '')
	BEGIN
		RAISERROR('Parâmetro Inválido: @int_idBook não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	IF (ISNULL(@int_idAuthor, '') = '')
	BEGIN
		RAISERROR('Parâmetro Inválido: @int_idAuthor não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	INSERT INTO BookAuthor
	(idBook
	,idAuthor)
	VALUES
	(@int_idBook,
	@int_idAuthor)
	
END



GO
/****** Object:  StoredProcedure [dbo].[sp_BookCategory_Del]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que remove vinculo do Livro com Autor
-- =============================================
CREATE PROCEDURE [dbo].[sp_BookCategory_Del]
	@int_idBook int,
	@int_idCategory int
AS
BEGIN	
	IF (ISNULL(@int_idBook, '') = '')
	BEGIN
		RAISERROR('Parâmetro Inválido: @int_idBook não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	IF (ISNULL(@int_idCategory, '') = '')
	BEGIN
		RAISERROR('Parâmetro Inválido: @int_idCategory não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	DELETE FROM BookCategory
	WHERE
	idBook = @int_idBook
	AND 
	IdCategory = @int_idCategory
	
END





GO
/****** Object:  StoredProcedure [dbo].[sp_BookCategory_Ins]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que vincula Livro com Autor
-- =============================================
CREATE PROCEDURE [dbo].[sp_BookCategory_Ins]
	@int_idBook int,
	@int_idCategory int
AS
BEGIN	
	IF (ISNULL(@int_idBook, '') = '')
	BEGIN
		RAISERROR('Parâmetro Inválido: @int_idBook não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	IF (ISNULL(@int_idCategory, '') = '')
	BEGIN
		RAISERROR('Parâmetro Inválido: @int_idCategory não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	INSERT INTO BookCategory
	(idBook
	,IdCategory)
	VALUES
	(@int_idBook,
	@int_idCategory)
	
END




GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Books_idCategory]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna todos os livros de uma Categoria
-- =============================================
CREATE PROCEDURE [dbo].[sp_Category_Books_idCategory] 
	@int_idCategory int
AS
BEGIN
	SET NOCOUNT ON;

	IF (ISNULL(@int_idCategory, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido:@int_idCategory não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	SELECT idBook
	,Title
	,Subtitle
	,Publisher
	,[year]
	,Summary
	,imgCover
	,Stock
	,Price
	FROM Book
	WHERE idBook IN 
	(SELECT idBook FROM BookCategory WHERE IdCategory = @int_idCategory)
END



GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Del_id]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que remove uma Categoria
-- =============================================
CREATE PROCEDURE [dbo].[sp_Category_Del_id]
	@int_IdCategory int
AS
BEGIN	
	IF (ISNULL(@int_IdCategory, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_IdCategory não pode ser NULL', 18, 0)
		RETURN
	END

	DELETE
	FROM Category
	WHERE idCategory = @int_IdCategory
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Ins]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que insere uma nova categoria
-- =============================================
CREATE PROCEDURE [dbo].[sp_Category_Ins]
	@str_Name varchar(50),
	@int_MenuOrder int
AS
BEGIN	
	IF (ISNULL(@str_Name, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @str_Name não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	IF (ISNULL(@int_MenuOrder, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_MenuOrder não pode ser NULL.', 18, 0)
		RETURN
	END

	INSERT INTO Category
	(Name
	,MenuOrder)
	OUTPUT Inserted.idCategory
	VALUES
	(@str_Name,
	@int_MenuOrder)
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Sel]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna todas as Categorias
-- =============================================
CREATE PROCEDURE [dbo].[sp_Category_Sel]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT idCategory
	,Name
	,MenuOrder
	FROM Category
	ORDER BY MenuOrder ASC
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Sel_id]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que retorna os dados de uma Categoria específica
-- =============================================
CREATE PROCEDURE [dbo].[sp_Category_Sel_id] 
	@int_idCategory int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT idCategory
	,Name
	,MenuOrder
	FROM Category
	WHERE idCategory = @int_idCategory
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Upd]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kelvis da Gama
-- Create date: 13/15/2016
-- Description:	Procedure que altera os dados de uma Categoria
-- =============================================
CREATE PROCEDURE [dbo].[sp_Category_Upd]
	@int_IdCategory int,
	@str_Name varchar(50),
	@int_MenuOrder int
AS
BEGIN	

	IF (ISNULL(@int_IdCategory, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_IdCategory não pode ser NULL', 18, 0)
		RETURN
	END

	IF (ISNULL(@str_Name, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @str_Name não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	IF (ISNULL(@int_MenuOrder, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @int_MenuOrder não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	UPDATE Category
	SET
	Name = @str_Name
	,MenuOrder 	= @int_MenuOrder
	WHERE idCategory = @int_IdCategory
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kelvis da Gama
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Login] 
	@str_User varchar(100),
	@str_Pass varchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	IF (ISNULL(@str_User, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @str_User não pode ser NULL ou vazio', 18, 0)
		RETURN
	END

	IF (ISNULL(@str_Pass, '') = '')
	BEGIN
		RAISERROR('Paramentro Inválido: @str_Pass não pode ser NULL ou vazio', 18, 0)
		RETURN
	END
	SELECT [User],Pass FROM [Login] WHERE [User] = @str_User AND Pass = @str_Pass
END

GO
/****** Object:  Table [dbo].[Author]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Author](
	[idAuthor] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[idAuthor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Book]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Book](
	[idBook] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Subtitle] [varchar](100) NULL,
	[Publisher] [varchar](50) NULL,
	[Year] [date] NULL,
	[Summary] [varchar](max) NULL,
	[imgCover] [varchar](50) NULL,
	[Stock] [int] NULL,
	[Price] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[idBook] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BookAuthor]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookAuthor](
	[idBook] [int] NOT NULL,
	[idAuthor] [int] NOT NULL,
 CONSTRAINT [PK_BookAuthor] PRIMARY KEY CLUSTERED 
(
	[idBook] ASC,
	[idAuthor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookCategory]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCategory](
	[idBook] [int] NOT NULL,
	[IdCategory] [int] NOT NULL,
 CONSTRAINT [PK_BookCategory] PRIMARY KEY CLUSTERED 
(
	[idBook] ASC,
	[IdCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[idCategory] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[MenuOrder] [int] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[idCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Login]    Script Date: 16/05/2016 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Login](
	[idLogin] [int] IDENTITY(1,1) NOT NULL,
	[User] [varchar](100) NOT NULL,
	[Pass] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Author] ON 

INSERT [dbo].[Author] ([idAuthor], [FirstName], [LastName]) VALUES (1, N'Kelvis', N'da Gama')
INSERT [dbo].[Author] ([idAuthor], [FirstName], [LastName]) VALUES (2, N'Kelvis', N'da Gama')
INSERT [dbo].[Author] ([idAuthor], [FirstName], [LastName]) VALUES (3, N'Kelvis', N'da Gama')
INSERT [dbo].[Author] ([idAuthor], [FirstName], [LastName]) VALUES (4, N'Kelvis', N'da Gama')
INSERT [dbo].[Author] ([idAuthor], [FirstName], [LastName]) VALUES (5, N'Kelvis', N'da Gama')
INSERT [dbo].[Author] ([idAuthor], [FirstName], [LastName]) VALUES (6, N'Kelvis', N'da Gama')
INSERT [dbo].[Author] ([idAuthor], [FirstName], [LastName]) VALUES (7, N'Kelvis', N'da Gama')
INSERT [dbo].[Author] ([idAuthor], [FirstName], [LastName]) VALUES (8, N'Kelvis', N'da Gama')
SET IDENTITY_INSERT [dbo].[Author] OFF
SET IDENTITY_INSERT [dbo].[Book] ON 

INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (2, N'Livro 1', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (3, N'Livro 2', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'3.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (4, N'Livro 3', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'4.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (5, N'Livro 4', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'5.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (6, N'Livro 5', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'6.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (7, N'Livro 6', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'7.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (8, N'Livro 7', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (9, N'Livro 8', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (10, N'Livro 9', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (11, N'Livro 10', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (12, N'Livro 11', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (13, N'Livro 12', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (14, N'Livro 13', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (15, N'Livro 14', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (16, N'Livro 15', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[Book] ([idBook], [Title], [Subtitle], [Publisher], [Year], [Summary], [imgCover], [Stock], [Price]) VALUES (17, N'Livro 16', N'Principe Caspian', N'Abril', CAST(0x2A2B0B00 AS Date), N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent viverra dolor vitae arcu fringilla, ut vehicula felis sagittis. Morbi viverra sit amet est sed dignissim. In non sem et nisl rutrum interdum. Maecenas blandit ultrices purus pharetra mattis. Pellentesque non lectus est. Vivamus et ligula blandit, maximus nunc at, aliquet odio. Vestibulum eleifend nisl eget mi finibus pharetra. Duis sed est odio. Nunc vitae elit ex. Proin fermentum sollicitudin diam, id congue diam vestibulum non. Donec non molestie mi, in vulputate est. Duis a nisl a lectus rhoncus placerat quis in leo. Mauris ut lectus non augue finibus porttitor. Nullam ut ex tincidunt orci tincidunt congue quis ut nibh. Fusce quis porta nisi.', N'2.jpg', NULL, CAST(100.00 AS Decimal(18, 2)))

SET IDENTITY_INSERT [dbo].[Book] OFF
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (2, 1)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (3, 1)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (4, 1)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (5, 5)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (6, 2)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (7, 2)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (8, 2)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (9, 5)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (10, 3)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (11, 3)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (12, 3)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (13, 5)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (14, 4)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (15, 4)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (16, 4)
INSERT [dbo].[BookCategory] ([idBook], [IdCategory]) VALUES (17, 5)
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([idCategory], [Name], [MenuOrder]) VALUES (1, N'Terror', 4)
INSERT [dbo].[Category] ([idCategory], [Name], [MenuOrder]) VALUES (2, N'Novela', 2)
INSERT [dbo].[Category] ([idCategory], [Name], [MenuOrder]) VALUES (3, N'Ação', 4)
INSERT [dbo].[Category] ([idCategory], [Name], [MenuOrder]) VALUES (4, N'Ficção', 5)
INSERT [dbo].[Category] ([idCategory], [Name], [MenuOrder]) VALUES (5, N'Romance', 3)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Login] ON 

INSERT [dbo].[Login] ([idLogin], [User], [Pass]) VALUES (1, N'admin', N'admin')
SET IDENTITY_INSERT [dbo].[Login] OFF
ALTER TABLE [dbo].[BookAuthor]  WITH CHECK ADD  CONSTRAINT [FK_BookAuthor_Author] FOREIGN KEY([idAuthor])
REFERENCES [dbo].[Author] ([idAuthor])
GO
ALTER TABLE [dbo].[BookAuthor] CHECK CONSTRAINT [FK_BookAuthor_Author]
GO
ALTER TABLE [dbo].[BookAuthor]  WITH CHECK ADD  CONSTRAINT [FK_BookAuthor_Book] FOREIGN KEY([idBook])
REFERENCES [dbo].[Book] ([idBook])
GO
ALTER TABLE [dbo].[BookAuthor] CHECK CONSTRAINT [FK_BookAuthor_Book]
GO
ALTER TABLE [dbo].[BookCategory]  WITH CHECK ADD  CONSTRAINT [FK_BookCategory_Book] FOREIGN KEY([idBook])
REFERENCES [dbo].[Book] ([idBook])
GO
ALTER TABLE [dbo].[BookCategory] CHECK CONSTRAINT [FK_BookCategory_Book]
GO
ALTER TABLE [dbo].[BookCategory]  WITH CHECK ADD  CONSTRAINT [FK_BookCategory_Category] FOREIGN KEY([IdCategory])
REFERENCES [dbo].[Category] ([idCategory])
GO
ALTER TABLE [dbo].[BookCategory] CHECK CONSTRAINT [FK_BookCategory_Category]
GO
USE [master]
GO
ALTER DATABASE [bookStore] SET  READ_WRITE 
GO
