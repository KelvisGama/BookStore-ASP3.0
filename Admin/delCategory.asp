<%@  language="VBScript" %>
<%  Option Explicit
    Dim booAdmin : booAdmin = true
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página Adm - deleta uma categoria

    ''====================================================

    '' Atualizações:   

    ''====================================================  
    
    if Session("Login") <> true then Response.Redirect "login.asp"
    Dim PageTitle : PageTitle = Application("SiteName") & " | Deleta" 
    Dim booSuccess : booSuccess = false
    Dim act : act = trim(Request.QueryString("act"))  
    Dim id  : id  = trim(Request.QueryString("id"))    
      
%>
<!--#INCLUDE VIRTUAL="/Includes/incTop.asp"-->
<%
    if act = "del" then
        Set oCategory = New cCategory
        oCategory.IdCategory= trim(id)
        oCategory.Delete
        booSuccess = true
    end if  
    
%>

<div class="container">
    <%if booSuccess = false then%>
    <div class="alert alert-danger" role="alert">
        <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
        <span class="sr-only">Sucesso:</span>
        Não foi possível excluir a categoria!
    </div>
    <meta http-equiv="refresh" content="3;URL=listCategories.asp" />
    <%Else %>
    <div class="alert alert-success" role="alert">
        <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
        <span class="sr-only">Sucesso:</span>
        Categoria excluída com sucesso!
    </div>
    <meta http-equiv="refresh" content="3;URL=listCategories.asp" />
    <%End if %>
</div>
<!-- /container -->

<!--#INCLUDE VIRTUAL="/Includes/incBottom.asp"-->
