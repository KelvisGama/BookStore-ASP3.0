<%@  language="VBScript" %>
<%  Option Explicit
    Dim booAdmin : booAdmin = false
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página de detalhes do livro

    ''====================================================

    '' Atualizações:   

    ''====================================================  
    
    

    Dim Id     
    if trim(Request.QueryString("id")) = "" or not isNumeric(trim(Request.QueryString("id"))) then 
        Response.Redirect "default.asp"
        Response.End
    end if
    Id =  Clng(trim(Request.QueryString("id")))
    Set oBook = New cBook
    Dim strResposta : strResposta = oBook.SelById(Id)
    Dim PageTitle : PageTitle = Application("SiteName") & " | " & oBook.Title 
   
%>
<!--#INCLUDE VIRTUAL="/Includes/incTop.asp"-->
<div class="container">

    <%
    
    if oBook.IdBook = strResposta then
    %>
    <div class="row">
        <div class="col-lg-4 text-center">
            <img class="cover img-thumbnail" src="<%=URLCovers & oBook.Cover%>" alt="<%=oBook.Title%>" />
        </div>
        <div class="col-lg-6 ">
            <h1 class="title"><%=oBook.Title%>
                <br>
                <small><%=oBook.SubTitle%></small></h1>
            <blockquote>
                <p class="text-justify"><%=oBook.Summary%></p>
            </blockquote>
            <p class="price text-right"><span class="symbol">R$</span> <%=oBook.Price%></p>

        </div>
    </div>
    <div class="row">
        <button type="button" class="btn btn-success btn-lg btn-block">COMPRAR</button>
    </div>
    <%
    else
    %>
    <h1><%=strResposta %></h1>
    <%
    End if   
    Set oBook = nothing
    %>
</div>
<!-- /container -->

<!--#INCLUDE VIRTUAL="/Includes/incBottom.asp"-->
