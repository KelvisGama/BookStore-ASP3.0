<%@  language="VBScript" %>
<%  Option Explicit
    Dim booAdmin :booAdmin = false
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página inicial do site

    ''====================================================

    '' Atualizações:   

    ''====================================================  
    
    Dim PageTitle : PageTitle = Application("SiteName") & " | Início"  
%>


<!--#INCLUDE VIRTUAL="/Includes/incTop.asp"-->
<div class="container">
    <div class="jumbotron">
        <h1>Banner</h1>
    </div>
    <div class="page-header">
        <h1>Ultimos Lançamentos</h1>
    </div>
    <%

Dim count : count = 1
Dim mainBooksLimit : mainBooksLimit = 6 ' Lista apenas 6 livros na página principal
Set oBookStore = New cBookStore
oBookStore.GetAllBooks
For each oBook in oBookStore.Books.Items
    
    If count = 1 Then ' A cada 3 livros vai para linha de baixo
    %>
    <div class="row">
        <%
    End If
        %>
        <div class="col-lg-4 book-item">
            <h4><span class="label label-success"><i class="fa fa-tag" aria-hidden="true"></i>Novo</span></h4>
            <!--#INCLUDE VIRTUAL="/Includes/incBook.asp"-->
        </div>
        <%
    If count = 3 Then 'A cada 3 livros vai para linha de baixo
        %>
    </div>
    <%
        count = 1
    Else
        count = count + 1
    End If
    mainBooksLimit = mainBooksLimit - 1
    If mainBooksLimit = 0 then Exit For
next


    %>
</div>

<!-- /container -->

<!--#INCLUDE VIRTUAL="/Includes/incBottom.asp"-->
