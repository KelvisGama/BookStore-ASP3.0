<%@  language="VBScript" %>
<%  Option Explicit
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página de validação do Login

    ''====================================================

    '' Atualizações:   

    ''====================================================  
%>
<!--#INCLUDE VIRTUAL="/ConnectionDb.asp"-->
<!--#INCLUDE VIRTUAL="/Admin/cCredentials.asp"-->
<%
    'Remove caracteres especiais para evitar erros de SQL 
    Function validCarac(Caracter)
	    Caracter = Replace(Caracter, "'", "''")
	    Caracter = Replace(Caracter, "__utmz=", "")
	    Caracter = Replace(Caracter, "utmccn=(direct)", "")
	    Caracter = Replace(Caracter, "SessionRIVERSIDE", "")
	    Caracter = Replace(Caracter, "insert", "")
	    Caracter = Replace(Caracter, "INSERT", "")
	    Caracter = Replace(Caracter, "select", "")
	    Caracter = Replace(Caracter, "SELECT", "")
	    Caracter = Replace(Caracter, "drop","")
	    Caracter = Replace(Caracter, "DROP","")
	    Caracter = Replace(Caracter, "--","")
	    Caracter = Replace(Caracter, "xp_","")
	    Caracter = Replace(Caracter, "XP_","")
	    Caracter = Replace(Caracter, "<", "&lt;")
	    Caracter = Replace(Caracter, ">", "&gt;")
	
	    validCarac = Caracter
    End Function
    
    
    Dim usr : usr = validCarac(trim(Request.Form("User")))
    Dim psw : psw = validCarac(trim(Request.Form("Password")))

    if usr = "" then 
        Response.Redirect  "login.asp?err=true"
        Response.End
    end if

    if psw = "" then 
        Response.Redirect  "login.asp?err=true"
        Response.End
    end if

    Dim oLogin : Set oLogin = New cCredentials
    oLogin.User = usr
    oLogin.Pass = psw
    
    if oLogin.Login = true then
        Response.Redirect "admin.asp"
        Response.End
    else
        Response.Redirect  "login.asp?err=true"
        Response.End
    end if
%>

