<%@  language="VBScript" %>
<%  Option Explicit
    Dim booAdmin : booAdmin = true
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página Adm - Lista as Categorias

    ''====================================================

    '' Atualizações:   

    ''====================================================  
    
    if Session("Login") <> true then Response.Redirect "login.asp"
    Dim PageTitle : PageTitle = Application("SiteName") & " | Categorias" 
    Set oBookStore = New cBookStore
    oBookStore.GetAllCategories
%>
<!--#INCLUDE VIRTUAL="/Includes/incTop.asp"-->
<div class="container">
    <div class="page-header">
        <h1>Categorias</h1>
    </div>
    <ol class="breadcrumb">
        <li><a href="admin.asp">Início</a></li>
        <li class="active">Categorias</li>
    </ol>
    <a href="addCategory.asp" class="btn btn-success btn-lg">
        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;Nova Categoria
    </a>

    <a href="logout.asp" class="btn btn-danger btn-lg sair">
        <i class="fa fa-sign-out " aria-hidden="true"></i>&nbsp;Sair
    </a>
    <h1></h1>
    

        <!-- Table -->
        <table class="table table-striped table-bordered text-center">
            <tr class="info">
                <td>#ID</td>
                <td>Nome</td>
                <td>Ordem</td>
                <td>Ações</td>
            </tr>
            <%    
        For each oCategory in oBookStore.Categories.Items
            %>
            <tr>
                <td><%=oCategory.IdCategory %></td>
                <td><%=oCategory.Name %></td>
                <td><%=oCategory.MenuOrder %></td>
                <td>
                    <a href="editCategory.asp?id=<%=oCategory.IdCategory %>" class="btn btn-sm btn-warning"><i class="fa fa-pencil" aria-hidden="true"></i>&nbsp;Alterar</a>
                    <a href="delCategory.asp?id=<%=oCategory.IdCategory %>&act=del" class="btn btn-sm btn-danger"><i class="fa fa-trash" aria-hidden="true"></i>&nbsp;Excluir</a>
                </td>
            </tr>
            <%
        Next
            %>
        </table>
</div>
<!-- /container -->

<!--#INCLUDE VIRTUAL="/Includes/incBottom.asp"-->
