<%@  language="VBScript" %>
<%  Option Explicit
    Dim booAdmin : booAdmin = true
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página Adm - edita uma categoria

    ''====================================================

    '' Atualizações:   

    ''====================================================  
    
    if Session("Login") <> true then Response.Redirect "login.asp"
    Dim PageTitle : PageTitle = Application("SiteName") & " | Editar" 
    Dim booSuccess : booSuccess = false
    Dim act : act = trim(Request.Form("act"))  
    Dim id  : id  = trim(Request.QueryString("id"))    
      
%>
<!--#INCLUDE VIRTUAL="/Includes/incTop.asp"-->
<%
    if act = "edit" then
        Set oCategory = New cCategory
        oCategory.IdCategory= trim(Request.Form("Id"))
        oCategory.Name      = trim(Request.Form("Nome")) 
        oCategory.MenuOrder = trim(Request.Form("Ordem"))
        oCategory.Save
        booSuccess = true
    end if  
    
    Set oCategory = New cCategory
    oCategory.SelById(id)  
%>

<div class="container">
    <div class="page-header">
        <h1>Editar Categoria</h1>
    </div>
    <ol class="breadcrumb">
        <li><a href="admin.asp">Início</a></li>
        <li><a href="listCategories.asp">Categorias</a></li>
        <li class="active">Editar Categoria</li>
    </ol>
    <%if booSuccess = false then%>
    <a href="logout.asp" class="btn btn-danger btn-lg sair">
        <i class="fa fa-sign-out " aria-hidden="true"></i>&nbsp;Sair
    </a>
    <h1></h1>
    <form class="form-inline" action="editCategory.asp?id=<%=oCategory.IdCategory %>" method="post">
        <div class="form-group">
            <label class="sr-only" for="Nome">Nome Categoria</label>
            <div class="input-group">
                <div class="input-group-addon">Nome</div>
                <input type="text" class="form-control" id="Nome" name="nome" placeholder="Nome da Categoria" required value="<%=oCategory.Name %>">
            </div>

            <label class="sr-only" for="Ordem">Ordem</label>
            <div class="input-group">
                <div class="input-group-addon"><i class="fa fa-sort" aria-hidden="true"></i>&nbsp;Ordem</div>
                <input type="number" class="form-control" id="Ordem" name="Ordem" min="1" max="10" value="<%=oCategory.MenuOrder %>">
            </div>

            <input type="hidden" name="act" value="edit" />
            <input type="hidden" name="id" value="<%=oCategory.IdCategory %>" />
            <div class="input-group">
                <button type="submit" class="btn btn-primary"><i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;Salvar</button>
            </div>
        </div>

    </form>
    <%Else %>
    <div class="alert alert-success" role="alert">
        <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
        <span class="sr-only">Sucesso:</span>
        Categoria alterada com sucesso!
    </div>
    <meta http-equiv="refresh" content="3;URL=listCategories.asp" />
    <%End if %>
</div>
<!-- /container -->

<!--#INCLUDE VIRTUAL="/Includes/incBottom.asp"-->
