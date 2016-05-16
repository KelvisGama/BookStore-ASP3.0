<%@  language="VBScript" %>
<%  Option Explicit
    Dim booAdmin : booAdmin = true
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página Adm - Lista os livros cadastrados

    ''====================================================

    '' Atualizações:   

    ''====================================================  
    
    if Session("Login") <> true then Response.Redirect "login.asp"
    Dim PageTitle : PageTitle = Application("SiteName") & " | Livros" 
    
%>
<!--#INCLUDE VIRTUAL="/Includes/incTop.asp"-->
<%
    Set oBookStore = New cBookStore
    oBookStore.GetAllBooks
%>
<div class="container">
    <div class="page-header">
        <h1>Livros</h1>
    </div>

    <a href="addBook.asp" class="btn btn-success btn-lg">
        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;Novo Livro
    </a>

    <a href="logout.asp" class="btn btn-danger btn-lg sair">
        <i class="fa fa-sign-out " aria-hidden="true"></i>&nbsp;Sair
    </a>
    <h1></h1>


    <!-- Table -->
    <table class="table table-striped table-bordered text-center">
        <tr class="info">
            <td>#ID</td>
            <td>Título</td>
            <td>Subtítulo</td>
            <td>Editora</td>
            <td>Ano</td>
            <td>Estoque</td>
            <td>Preço</td>
            <td>Ações</td>
        </tr>
        <%    
        For each oBook in oBookStore.Books.Items
        %>
        <tr>
            <td><%=oBook.IdBook %></td>
            <td><%=oBook.Title %></td>
            <td><%=oBook.SubTitle %></td>
            <td><%=oBook.Publisher %></td>
            <td><%=oBook.Year %></td>
            <td><%=oBook.Stock %></td>
            <td>R$&nbsp;<%=oBook.Price %></td>
            <td>
                <a href="editBook.asp?id=<%=oBook.IdBook %>" class="btn btn-sm btn-warning"><i class="fa fa-pencil" aria-hidden="true"></i>&nbsp;Alterar</a>
                <a href="delBook.asp?id=<%=oBook.IdBook %>&act=del" class="btn btn-sm btn-danger"><i class="fa fa-trash" aria-hidden="true"></i>&nbsp;Excluir</a>
            </td>
        </tr>
        <%
        Next
        %>
    </table>
</div>
<!-- /container -->

<!--#INCLUDE VIRTUAL="/Includes/incBottom.asp"-->
