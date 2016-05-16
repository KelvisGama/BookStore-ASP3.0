<%@  language="VBScript" %>
<%  Option Explicit
    Dim booAdmin : booAdmin = true
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página inicial do painel adm

    ''====================================================

    '' Atualizações:   

    ''====================================================  
    
    if Session("Login") <> true then Response.Redirect "login.asp"
    Dim PageTitle : PageTitle = Application("SiteName") & " | Admin" 
   
%>
<!--#INCLUDE VIRTUAL="/Includes/incTop.asp"-->

<div class="container">
    <div class="jumbotron">
        <h3>Olá <strong class="text-uppercase"><%=Session("User") %></strong>,</h3>
        <h4>Bem vindo ao Painel do Administrador</h4>
    </div>

    <a href="listCategories.asp" class="btn btn-info btn-lg">
        <i class="fa fa-cogs" aria-hidden="true"></i>&nbsp;Categorias
    </a>

    <a href="listBooks.asp"  class="btn btn-success btn-lg">
        <i class="fa fa-book" aria-hidden="true"></i>&nbsp;Livros
    </a>

    <a href="logout.asp"  class="btn btn-danger btn-lg sair">
        <i class="fa fa-sign-out " aria-hidden="true"></i>&nbsp;Sair
    </a>


</div>
<!-- /container -->

<!--#INCLUDE VIRTUAL="/Includes/incBottom.asp"-->
