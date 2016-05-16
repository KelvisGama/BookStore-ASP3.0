<%    
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Classe que representa a BookStore

    ''====================================================

    '' Atualizações:   13/05 - Criação - Kelvis da Gama

    ''====================================================
    Class cBookStore
        
        Private myCategories
        Private myBooks
        Private myAuthors

        Sub Class_Initialize()
            set myBooks      = Server.CreateObject ("Scripting.Dictionary")
            set myAuthors    = Server.CreateObject ("Scripting.Dictionary")
            set myCategories = Server.CreateObject ("Scripting.Dictionary")
        End Sub

        Sub Class_Terminate()
            set myBooks         = Nothing
            set myAuthors       = Nothing
            set myCategories    = Nothing
        End Sub

       
        Public Property Get Books()
            Set Books = myBooks
        End Property
       
        Public Property Get Authors()
            Set Authors = myAuthors
        End Property

        Public Property Get Categories()
            Set Categories = myCategories
        End Property

    '' ######################################## FUNÇÕES ########################################

        'Carrega todos os livros do banco
        Public Function GetAllBooks()
            If booConnOpened = false then Call OpenConnection()                
            Dim cmdSelAll : Set cmdSelAll = Server.CreateObject("ADODB.Command")
            Set cmdSelAll.ActiveConnection = oConn
            cmdSelAll.CommandText = "sp_Book_Sel"
            cmdSelAll.CommandType = 4 'adCmdStoredProc
            Dim rsSelAll : Set rsSelAll = cmdSelAll.Execute()
            Dim oBook
            While Not rsSelAll.EOF 
                Set oBook        = New cBook
                oBook.IdBook     = rsSelAll("idBook")
                oBook.Title      = rsSelAll("Title")
                oBook.SubTitle   = rsSelAll("SubTitle")
                oBook.Publisher  = rsSelAll("Publisher")
                oBook.Year       = rsSelAll("Year")
                oBook.Summary    = rsSelAll("Summary")
                oBook.Cover      = rsSelAll("imgCover")
                oBook.Stock      = rsSelAll("Stock")
                oBook.Price      = rsSelAll("Price")
                myBooks.Add oBook.IdBook,oBook
                rsSelAll.MoveNext
            Wend
            rsSelAll.close
            set rsSelAll  = nothing
            set cmdSelAll = nothing
            Call CloseConnection()  
        End Function

        ' Carrega todos os livros de um determinado Autor
        Public Function GetBooksByIdAuthor(pIdAuthor)
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmdSelIdAuthor : Set cmdSelIdAuthor = Server.CreateObject("ADODB.Command")
            Set cmdSelIdAuthor.ActiveConnection = oConn
            cmdSelIdAuthor.CommandText = "sp_Author_Books_idAuthor"
            cmdSelIdAuthor.CommandType = 4 'adCmdStoredProc
            cmdSelIdAuthor.NamedParameters = true
            cmdSelIdAuthor.Parameters("@int_IdAuthor") = pIdAuthor
            Dim rsSelIdAuthor : Set rsSelIdAuthor = cmdSelIdAuthor.Execute()
            Dim oBook
            While Not rsSelIdAuthor.EOF 
                Set oBook        = New cBook
                oBook.IdBook     = rsSelIdAuthor("idBook")
                oBook.Title      = rsSelIdAuthor("Title")
                oBook.SubTitle   = rsSelIdAuthor("SubTitle")
                oBook.Publisher  = rsSelIdAuthor("Publisher")
                oBook.Year       = rsSelIdAuthor("Year")
                oBook.Summary    = rsSelIdAuthor("Summary")
                oBook.Cover      = rsSelIdAuthor("imgCover")
                oBook.Stock      = rsSelIdAuthor("Stock")
                oBook.Price      = rsSelIdAuthor("Price")
                myBooks.Add oBook.IdBook,oBook
                rsSelIdAuthor.MoveNext
            Wend
            rsSelIdAuthor.close
            set rsSelIdAuthor  = nothing
            set cmdSelIdAuthor = nothing

            Call CloseConnection()
        End Function

        ' Carrega todos os livros de uma determinada Categoria
        Public Function GetBooksByIdCategory(pIdCategory)
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmdSelIdCategory : Set cmdSelIdCategory = Server.CreateObject("ADODB.Command")
            Set cmdSelIdCategory.ActiveConnection = oConn
            cmdSelIdCategory.CommandText = "sp_Category_Books_idCategory"
            cmdSelIdCategory.CommandType = 4 'adCmdStoredProc
            cmdSelIdCategory.NamedParameters = true
            cmdSelIdCategory.Parameters("@int_IdCategory") = pIdCategory
            Dim rsSelIdCategory : Set rsSelIdCategory = cmdSelIdCategory.Execute()
            
            Dim oBook 
            While Not rsSelIdCategory.EOF 
                Set oBook        = New cBook
                oBook.IdBook     = rsSelIdCategory("idBook")
                oBook.Title      = rsSelIdCategory("Title")
                oBook.SubTitle   = rsSelIdCategory("SubTitle")
                oBook.Publisher  = rsSelIdCategory("Publisher")
                oBook.Year       = rsSelIdCategory("Year")
                oBook.Summary    = rsSelIdCategory("Summary")
                oBook.Cover      = rsSelIdCategory("imgCover")
                oBook.Stock      = rsSelIdCategory("Stock")
                oBook.Price      = rsSelIdCategory("Price")                
                myBooks.Add oBook.IdBook,oBook
                rsSelIdCategory.MoveNext
            Wend
            rsSelIdCategory.close
            set rsSelIdCategory  = nothing
            set cmdSelIdCategory = nothing

            Call CloseConnection()
        End Function



        'Carrega todos os Autores
        Public Function GetAllAuthors()
            If booConnOpened = false then Call OpenConnection()                
            Dim cmdSelAll : Set cmdSelAll = Server.CreateObject("ADODB.Command")
            Set cmdSelAll.ActiveConnection = oConn
            cmdSelAll.CommandText = "sp_Author_Sel"
            cmdSelAll.CommandType = 4 'adCmdStoredProc
            Dim rsSelAll : Set rsSelAll = cmdSelAll.Execute()
            Dim oAuthor
            While Not rsSelAll.EOF 
                Set oAuthor        = New cBook
                oAuthor.IdAuthor     = rsSelAll("IdAuthor")
                oAuthor.FirstName    = rsSelAll("FirstName")
                oAuthor.LastName     = rsSelAll("LastName")
                MyAuthors.Add oAuthor.IdAuthor,oAuthor
                rsSelAll.MoveNext
            Wend
            rsSelAll.close
            set rsSelAll  = nothing
            set cmdSelAll = nothing
            Call CloseConnection()
        End Function

        ' Carrega todos os Autores de um determinado Livro
        Public Function GetAuthorsByIdBook(pIdBook)
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmdSelIdBook : Set cmdSelIdBook = Server.CreateObject("ADODB.Command")
            Set cmdSelIdBook.ActiveConnection = oConn
            cmdSelIdBook.CommandText = "sp_Book_Authors_idBook"
            cmdSelIdBook.CommandType = 4 'adCmdStoredProc
            cmdSelIdBook.NamedParameters = true
            cmdSelIdBook.Parameters("@int_IdBook") = pIdBook
            Dim rsSelIdBook : Set rsSelIdBook = cmdSelIdBook.Execute()
            Dim oAuthor
            While Not rsSelIdBook.EOF 
                Set oAuthor        = New cBook
                oAuthor.IdAuthor     = rsSelIdBook("IdAuthor")
                oAuthor.FirstName    = rsSelIdBook("FirstName")
                oAuthor.LastName     = rsSelIdBook("LastName")
                MyAuthors.Add oAuthor.IdAuthor,oAuthor
                rsSelIdBook.MoveNext
            Wend
            rsSelIdBook.close
            set rsSelIdBook  = nothing
            set cmdSelIdBook = nothing
            Call CloseConnection()
        End Function

        'Carrega todas as Categorias
        Public Function GetAllCategories()
            If booConnOpened = false then Call OpenConnection()                
            Dim cmdSelAll : Set cmdSelAll = Server.CreateObject("ADODB.Command")
            Set cmdSelAll.ActiveConnection = oConn
            cmdSelAll.CommandText = "sp_Category_Sel"
            cmdSelAll.CommandType = 4 'adCmdStoredProc
            Dim rsSelAll : Set rsSelAll = cmdSelAll.Execute()
            Dim oCategory
            While Not rsSelAll.EOF 
                Set oCategory        = New cCategory
                oCategory.IdCategory    = rsSelAll("IdCategory")
                oCategory.Name          = rsSelAll("Name")
                oCategory.MenuOrder     = rsSelAll("MenuOrder")
                myCategories.Add oCategory.IdCategory,oCategory
                rsSelAll.MoveNext
            Wend
            rsSelAll.close
            set rsSelAll  = nothing
            set cmdSelAll = nothing
            Call CloseConnection()
        End Function

        ' Carrega todas as Categorias de um determinado Livro
        Public Function GetCategoriesByIdBook(pIdBook)
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmdSelIdBook : Set cmdSelIdBook = Server.CreateObject("ADODB.Command")
            Set cmdSelIdBook.ActiveConnection = oConn
            cmdSelIdBook.CommandText = "sp_Book_Categories_idBook"
            cmdSelIdBook.CommandType = 4 'adCmdStoredProc
            cmdSelIdBook.NamedParameters = true
            cmdSelIdBook.Parameters("@int_IdBook") = pIdBook
            Dim rsSelIdBook : Set rsSelIdBook = cmdSelIdBook.Execute()
            Dim oCategory
            While Not rsSelIdBook.EOF 
                Set oCategory       = New cBook
                oCategory.IdAuthor  = rsSelIdBook("IdAuthor")
                oCategory.FirstName = rsSelIdBook("FirstName")
                oCategory.LastName  = rsSelIdBook("LastName")
                MyCategories.Add oCategory.IdCategory,oCategory
                rsSelIdBook.MoveNext
            Wend
            rsSelIdBook.close
            set rsSelIdBook  = nothing
            set cmdSelIdBook = nothing
            Call CloseConnection()
        End Function

        ' Vincula Livro com Autor
        Public Sub JoinAuthorWithBook(pIdAuthor, pIdBook)
                If booConnOpened = false then Call OpenConnection()
                
                Dim cmdJoin : Set cmdJoin = Server.CreateObject("ADODB.Command")
                Set cmdJoin.ActiveConnection = oConn
                cmdJoin.CommandText = "sp_BookAuthor_Ins"
                cmdJoin.CommandType = 4 'adCmdStoredProc
                cmdJoin.NamedParameters = true
                cmdJoin.Parameters("@int_idAuthor") = pIdAuthor
                cmdJoin.Parameters("@int_idBook")   = pIdBook
                cmdJoin.Execute()

                set cmdJoin = nothing

                Call CloseConnection()
        End Sub

        ' Remove vinculo Livro com Autor
        Public Sub DelAuthorWithBook(pIdAuthor, pIdBook)
                If booConnOpened = false then Call OpenConnection()
                
                Dim cmdJoin : Set cmdJoin = Server.CreateObject("ADODB.Command")
                Set cmdJoin.ActiveConnection = oConn
                cmdJoin.CommandText = "sp_BookAuthor_Del"
                cmdJoin.CommandType = 4 'adCmdStoredProc
                cmdJoin.NamedParameters = true
                cmdJoin.Parameters("@int_idAuthor") = pIdAuthor
                cmdJoin.Parameters("@int_idBook")   = pIdBook
                cmdJoin.Execute()

                set cmdJoin = nothing

                Call CloseConnection()
        End Sub

        ' Vincula Livro com Categoria
        Public Sub JoinCategoryWithBook(pIdCategory, pIdBook)
                If booConnOpened = false then Call OpenConnection()
                
                Dim cmdJoin : Set cmdJoin = Server.CreateObject("ADODB.Command")
                Set cmdJoin.ActiveConnection = oConn
                cmdJoin.CommandText = "sp_BookCategory_Ins"
                cmdJoin.CommandType = 4 'adCmdStoredProc
                cmdJoin.NamedParameters = true
                cmdJoin.Parameters("@int_IdCategory") = pIdCategory
                cmdJoin.Parameters("@int_idBook")   = pIdBook
                cmdJoin.Execute()

                set cmdJoin = nothing

                Call CloseConnection()
        End Sub

        ' Remove vinculo Livro com Autor
        Public Sub DelCategoryWithBook(pIdCategory, pIdBook)
                If booConnOpened = false then Call OpenConnection()
                
                Dim cmdJoin : Set cmdJoin = Server.CreateObject("ADODB.Command")
                Set cmdJoin.ActiveConnection = oConn
                cmdJoin.CommandText = "sp_BookCategory_Del"
                cmdJoin.CommandType = 4 'adCmdStoredProc
                cmdJoin.NamedParameters = true
                cmdJoin.Parameters("@int_IdCategory") = pIdCategory
                cmdJoin.Parameters("@int_idBook")   = pIdBook
                cmdJoin.Execute()

                set cmdJoin = nothing

                Call CloseConnection()
        End Sub
    End Class
%>
