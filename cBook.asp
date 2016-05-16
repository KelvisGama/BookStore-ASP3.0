<%    
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Classe que representa um Book 

    ''========================================================

    '' Atualizações:   13/05/2016 - Criação - Kelvis da Gama

    ''========================================================
    Class cBook
        Private myIdBook
        Private myTitle
        Private mySubTitle
        Private myPublisher
        Private myYear
        Private mySummary
        Private myCover
        private myStock
        private myPrice
        Private myAuthors
        Private myCategories

        Private Sub Class_Initialize
            
        End Sub    

        Public Property GET IdBook()
            IdBook = myIdBook
        End Property
        
        Public Property LET IdBook(pIdBook)
            myIdBook = pIdBook
        End Property

        Public Property GET Title()
            Title = myTitle
        End Property
        
        Public Property LET Title(pTitle)
            myTitle = pTitle
        End Property

        Public Property GET SubTitle()
            SubTitle = mySubTitle
        End Property
        
        Public Property LET SubTitle(pSubTitle)
            mySubTitle = pSubTitle
        End Property

        Public Property GET Publisher()
            Publisher = myPublisher
        End Property
        
        Public Property LET Publisher(pPublisher)
            myPublisher = pPublisher
        End Property

        Public Property GET Year()
            Year = myYear
        End Property
        
        Public Property LET Year(pYear)
            myYear = pYear
        End Property

        Public Property GET Summary()
            Summary = mySummary
        End Property
        
        Public Property LET Summary(pSummary)
            mySummary = pSummary
        End Property

        Public Property GET Cover()
            Cover = myCover
        End Property
        
        Public Property LET Cover(pCover)
            myCover = pCover
        End Property

        Public Property GET Stock()
            Stock = myStock
        End Property
        
        Public Property LET Stock(pStock)
            myStock = pStock
        End Property

        Public Property GET Price()
            Price = myPrice
        End Property
        
        Public Property LET Price(pPrice)   
    'response
            'if uBound(split(pPrice,","))  = 0 then pPrice = pPrice & ",00"
            'if Len(split(pPrice,",")(1)) = 1 then pPrice = pPrice & "0"
            myPrice = pPrice
        End Property

        Public Property Get Authors()
            if not isObject(myAuthors) then
                set oBookStore = New cBookStore
                Call oBookStore.GetAuthorsByIdBook(Me.IdBook)
                set myAuthors = oBookStore.Authors
                Set oBookStore = nothing
            end if
            Set Authors = myAuthors
        End Property
        
        Public Property Get Categories()
            if not isObject(myCategories) then
                set oBookStore = New cBookStore
                Call oBookStore.GetCategoriesByIdBook(Me.IdBook)
                set myCategories = oBookStore.Categories
                Set oBookStore = nothing
            end if
            Set Categories = myCategories
        End Property

        ' ######################################## FUNÇÕES ########################################


        '== Seleciona um livro no banco a partir de seu IdBook
        Public Function SelById(pIdBook)
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmdSelId : Set cmdSelId = Server.CreateObject("ADODB.Command")
            Set cmdSelId.ActiveConnection = oConn
            cmdSelId.CommandText = "sp_Book_Sel_id"
            cmdSelId.CommandType = 4' adCmdStoredProc
            cmdSelId.NamedParameters = true
            cmdSelId.Parameters("@int_idBook") = pIdBook
            Dim rsSelId : Set rsSelId = cmdSelId.Execute()

            If not rsSelId.EOF then
                Me.IdBook     = rsSelId("idBook")
                Me.Title      = rsSelId("Title")
                Me.SubTitle   = rsSelId("SubTitle")
                Me.Publisher  = rsSelId("Publisher")
                Me.Year       = rsSelId("Year")
                Me.Summary    = rsSelId("Summary")
                Me.Cover      = rsSelId("imgCover")
                Me.Stock      = rsSelId("Stock")
                Me.Price      = rsSelId("Price")
                SelById       = Me.IdBook
            Else
                SelById       = "O livro não foi encontrado!"
            end if
            rsSelId.close
            set rsSelId  = nothing
            set cmdSelId = nothing

            Call CloseConnection()
        End Function
        
        '== Adiciona um novo livro no banco
        Public Function AddNew()
            If booConnOpened = false then Call OpenConnection()
   
            Dim cmdAddNew : Set cmdAddNew = Server.CreateObject("ADODB.Command")
            Set cmdAddNew.ActiveConnection = oConn
            cmdAddNew.CommandText = "sp_Book_Ins"
            cmdAddNew.CommandType = 4'adCmdStoredProc
            cmdAddNew.NamedParameters               = true
            cmdAddNew.Parameters("@str_Title")      = Me.Title
            cmdAddNew.Parameters("@str_SubTitle")   = Me.SubTitle
            cmdAddNew.Parameters("@str_Publisher")  = Me.Publisher
            cmdAddNew.Parameters("@str_Year")       = Me.Year
            cmdAddNew.Parameters("@str_Summary")    = Me.Summary
            cmdAddNew.Parameters("@str_imgCover")   = Me.Cover
            cmdAddNew.Parameters("@int_Stock")      = Me.Stock
            cmdAddNew.Parameters("@dec_Price")      = Me.Price

            Dim rsAddNew : Set rsAddNew = cmdAddNew.Execute()
            Me.IdBook   = rsAddNew("idBook")
            AddNew      = rsAddNew("idBook")

            rsAddNew. close
            set rsAddNew  = nothing
            set cmdAddNew = nothing
            Call CloseConnection()
        End Function
        
        '== Remove um livro do banco
        Public Function Delete()
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmdDelete : Set cmdDelete = Server.CreateObject("ADODB.Command")
            Set cmdDelete.ActiveConnection = oConn
            cmdDelete.CommandText = "sp_Book_Del_id"
            cmdDelete.CommandType = 4' adCmdStoredProc
            cmdDelete.NamedParameters            = true
            cmdDelete.Parameters("@int_IdBook")  = Me.IdBook
            cmdDelete.Execute() 
            set cmdDelete = nothing

            Call CloseConnection()
        End Function

        Public Function Save()
            If booConnOpened = false then Call OpenConnection()
            
            Dim cmdSave : Set cmdSave = Server.CreateObject("ADODB.Command")
            Set cmdSave.ActiveConnection = oConn
            cmdSave.CommandText = "sp_Book_Upd"
            cmdSave.CommandType = 4' adCmdStoredProc
            cmdSave.NamedParameters               = true
            cmdSave.Parameters("@int_IdBook")     = Me.IdBook
            cmdSave.Parameters("@str_Title")      = Me.Title
            cmdSave.Parameters("@str_SubTitle")   = Me.SubTitle
            cmdSave.Parameters("@str_Publisher")  = Me.Publisher
            cmdSave.Parameters("@str_Year")       = Me.Year
            cmdSave.Parameters("@str_Summary")    = Me.Summary
            cmdSave.Parameters("@str_imgCover")   = Me.Cover
            cmdSave.Parameters("@int_stock")      = Me.Stock
            cmdSave.Parameters("@dec_price")      = Me.Price

            cmdSave.Execute()
            Set cmdSave = nothing
            Call CloseConnection()
        End Function
    End Class

%>
