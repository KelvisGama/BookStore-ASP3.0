<%    
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Classe que valida o login

    ''====================================================

    '' Atualizações:   13/05 - Criação - Kelvis da Gama

    ''====================================================
    Class cCredentials
        Private myUser
        Private myPass
        
        Private Sub Class_Initialize
            
        End Sub    

        Public Property GET User()
            User = myUser
        End Property
        
        Public Property LET User(pUser)
            myUser = pUser
        End Property

        Public Property GET Pass()
            Pass = myPass
        End Property
        
        Public Property LET Pass(pPass)
            myPass = pPass
        End Property

        ' ######################################## FUNÇÕES ########################################


        '== Valida o Login
        Public Function Login()
            If booConnOpened = false then Call OpenConnection()
                
            Dim cmd : Set cmd = Server.CreateObject("ADODB.Command")
            Set cmd.ActiveConnection = oConn
            cmd.CommandText = "sp_Login"
            cmd.CommandType = adCmdStoredProc
            cmd.NamedParameters = true
            cmd.Parameters("@str_User") = Me.User
            cmd.Parameters("@str_Pass") = Me.Pass
            Dim rs : Set rs = cmd.Execute()

            If not rs.EOF then
                Session("Login")    = True
                Session("User")     = Me.User
                Login               = True
            Else
                Session("Login")   = false
                Login = Server.HTMLEncode("Usuário ou Senha Incorretos!")
            end if
            rs.close
            set rs  = nothing
            set cmd = nothing

            Call CloseConnection()
        End Function
        


    End Class

%>
