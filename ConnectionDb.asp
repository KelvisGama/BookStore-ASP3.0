<%    
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Possui a função de abrir e fechar as conexões com o BD

    ''====================================================

    '' Atualizações:   13/05 - Criação - Kelvis da Gama

    ''====================================================
    Dim oConn
    DIm booConnOpened
        
    Sub OpenConnection()
        Set oConn               = CreateObject("ADODB.Connection")
        oConn.commandTimeout    = 20
        oConn.ConnectionString  = Application("strConn")
        oConn.Open
        booConnOpened           = true
    End Sub

    Sub CloseConnection()
        oConn.Close : Set oConn = Nothing
        booConnOpened           = false
    End Sub

    
%>




	  