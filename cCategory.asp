<%    
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Classe que representa uma Category

    ''====================================================

    '' Atualizações:   13/05 - Criação - Kelvis da Gama

    ''====================================================
    Class cCategory
        Private myIdCategory
        Private myName
        Private myMenuOrder
        Private myBooks
        
        Private Sub Class_Initialize
            
        End Sub    

        Public Property GET IdCategory()
            IdCategory = myIdCategory
        End Property
        
        Public Property LET IdCategory(pIdCategory)
            myIdCategory = pIdCategory
        End Property

        Public Property GET Name()
            Name = myName
        End Property
        
        Public Property LET Name(pName)
            myName = pName
        End Property

        Public Property GET MenuOrder()
            MenuOrder = myMenuOrder
        End Property
        
        Public Property LET MenuOrder(pMenuOrder)
            myMenuOrder = pMenuOrder
        End Property

        Public Property Get Books()
            if not isObject(myBooks) then
                set oBookStore = New cBookStore
                Call oBookStore.GetBooksByIdCategory(Me.IdCategory)
                set myBooks = oBookStore.Books
                Set oBookStore = nothing
            end if
            Set Books = myBooks
        End Property


        ' ######################################## FUNÇÕES ########################################


        '== Seleciona uma Categoria no banco a partir de seu IdCategoria
        Public Function SelById(pIdCategory)
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmdSelId : Set cmdSelId = Server.CreateObject("ADODB.Command")
            Set cmdSelId.ActiveConnection = oConn
            cmdSelId.CommandText = "sp_Category_Sel_id"
            cmdSelId.CommandType = 4 'adCmdStoredProc
            cmdSelId.NamedParameters = true
            cmdSelId.Parameters("@int_idCategory") = pIdCategory
            Dim rsSelId : Set rsSelId = cmdSelId.Execute()

            If not rsSelId.EOF then
                Me.IdCategory = rsSelId("idCategory")
                Me.Name       = rsSelId("Name")
                Me.MenuOrder  = rsSelId("MenuOrder")
                SelById       = Me.IdCategory
            Else
                SelById       = "A Categoria não foi encontrada!"
            end if
            rsSelId.close
            set rsSelId  = nothing
            set cmdSelId = nothing

            Call CloseConnection()
        End Function
        
        '== Adiciona uma nova Categoria no banco
        Public Function AddNew()
            If booConnOpened = false then Call OpenConnection()

            Dim cmdAddNew : Set cmdAddNew = Server.CreateObject("ADODB.Command")
            Set cmdAddNew.ActiveConnection = oConn
            cmdAddNew.CommandText = "sp_Category_Ins"
            cmdAddNew.CommandType = 4 'adCmdStoredProc
            cmdAddNew.NamedParameters               = true
            cmdAddNew.Parameters("@str_Name")       = Me.Name
            cmdAddNew.Parameters("@int_MenuOrder")  = Me.MenuOrder

            Dim rsAddNew : Set rsAddNew = cmdAddNew.Execute()
            Me.IdCategory   = rsAddNew("idCategory")
            AddNew          = rsAddNew("idCategory")

            rsAddNew. close
            set rsAddNew  = nothing
            set cmdAddNew = nothing
            Call CloseConnection()
        End Function
        
        '== Remove uma Categoria do banco
        Public Function Delete()
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmdDelete : Set cmdDelete = Server.CreateObject("ADODB.Command")
            Set cmdDelete.ActiveConnection = oConn
            cmdDelete.CommandText = "sp_Category_Del_id"
            cmdDelete.CommandType = 4 'adCmdStoredProc
            cmdDelete.NamedParameters            = true
            cmdDelete.Parameters("@int_IdCategory")  = Me.IdCategory
            cmdDelete.Execute() 
            set cmdDelete = nothing

            Call CloseConnection()
        End Function

        '== Edita uma categoria
        Public Function Save()
            If booConnOpened = false then Call OpenConnection()
            
            Dim cmdSave : Set cmdSave = Server.CreateObject("ADODB.Command")
            Set cmdSave.ActiveConnection = oConn
            cmdSave.CommandText = "sp_Category_Upd"
            cmdSave.CommandType = 4 'adCmdStoredProc
            cmdSave.NamedParameters               = true
            cmdSave.Parameters("@int_IdCategory") = Me.IdCategory
            cmdSave.Parameters("@str_Name")       = Me.Name
            cmdSave.Parameters("@int_MenuOrder")  = Me.MenuOrder
            
            cmdSave.Execute()
            Set cmdSave = nothing
            Call CloseConnection()
        End Function


    End Class

%>
