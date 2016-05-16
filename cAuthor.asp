<%    
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Classe que representa um Author

    ''====================================================

    '' Atualizações:   13/05 - Criação - Kelvis da Gama

    ''====================================================
    Class cAuthor
        Private myIdAuthor
        Private myFirstName
        Private myLastName
        Private myBooks
        
        Private Sub Class_Initialize
            
        End Sub    

        Public Property GET IdAuthor()
            IdAuthor = myIdAuthor
        End Property
        
        Public Property LET IdAuthor(pIdAuthor)
            myIdAuthor = pIdAuthor
        End Property

        Public Property GET FirstName()
            FirstName = myFirstName
        End Property
        
        Public Property LET FirstName(pFirstName)
            myFirstName = pFirstName
        End Property

        Public Property GET LastName()
            LastName = myLastName
        End Property
        
        Public Property LET LastName(pLastName)
            myLastName = pLastName
        End Property

        Public Property Get Books()
            if not isObject(myBooks) then
                set oBookStore = New cBookStore
                Call oBookStore.GetBooksByIdAuthor(Me.IdAuthor)
                set myBooks = oBookStore.Books
                Set oBookStore = nothing
            end if
            Set Books = myBooks
        End Property


        ' ######################################## FUNÇÕES ########################################


        '== Seleciona um Autor no banco a partir de seu IdAuthor
        Public Function SelById(pIdAuthor)
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmdSelId : Set cmdSelId = Server.CreateObject("ADODB.Command")
            Set cmdSelId.ActiveConnection = oConn
            cmdSelId.CommandText = "sp_Author_Sel_id"
            cmdSelId.CommandType = 4'adCmdStoredProc
            cmdSelId.NamedParameters = true
            cmdSelId.Parameters("@int_idAuthor") = pIdAuthor
            Dim rsSelId : Set rsSelId = cmdSelId.Execute()

            If not rsSelId.EOF then
                Me.IdAuthor   = rsSelId("IdAuthor")
                Me.FirstName   = rsSelId("FirstName")
                Me.LastName   = rsSelId("LastName")
                SelById       = Me.IdAuthor
            Else
                SelById       = "Nenhum autor encontrado!"
            end if
            rsSelId. close
            set rsSelId  = nothing
            set cmdSelId = nothing

            Call CloseConnection()
        End Function
        
        '== Adiciona um novo autor no banco
        Public Function AddNew()
            If booConnOpened = false then Call OpenConnection()

            Dim cmdAddNew : Set cmdAddNew = Server.CreateObject("ADODB.Command")
            Set cmdAddNew.ActiveConnection = oConn
            cmdAddNew.CommandText = "sp_Author_Ins"
            cmdAddNew.CommandType = 4'adCmdStoredProc
            cmdAddNew.NamedParameters               = true
            cmdAddNew.Parameters("@str_FirtName")   = Me.FirstName
            cmdAddNew.Parameters("@str_LastName")   = Me.LastName
            
            Dim rsAddNew : Set rsAddNew = cmdAddNew.Execute()
            Me.IdBook   = rsAddNew("IdAuthor")
            AddNew      = rsAddNew("IdAuthor")

            rsAddNew. close
            set rsAddNew  = nothing
            set cmdAddNew = nothing
            Call CloseConnection()
        End Function
        
        '== Remove um autor do banco
        Public Function Delete()
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmdDelete : Set cmdDelete = Server.CreateObject("ADODB.Command")
            Set cmdDelete.ActiveConnection = oConn
            cmdDelete.CommandText = "sp_Author_Del_id"
            cmdDelete.CommandType = 4'adCmdStoredProc
            cmdDelete.NamedParameters               = true
            cmdDelete.Parameters("@int_IdAuthor")   = Me.IdBook
            cmdDelete.Execute() 
            set cmdDelete = nothing

            Call CloseConnection()
        End Function
        
        '== Edita um autor
        Public Function Save()
            If booConnOpened = false then Call OpenConnection()
            
            Dim cmdSave : Set cmdSave = Server.CreateObject("ADODB.Command")
            Set cmdSave.ActiveConnection = oConn
            cmdSave.CommandText = "sp_Author_Upd"
            cmdSave.CommandType = 4'adCmdStoredProc
            cmdSave.NamedParameters             = true
            cmdSave.Parameters("@int_IdAuthor") = Me.IdAuthor
            cmdSave.Parameters("@str_FirstName")= Me.FirstName
            cmdSave.Parameters("@str_LastName") = Me.LastName
            
            cmdSave.Execute()
            Set cmdSave = nothing
            Call CloseConnection()
        End Function
    End Class

%>
