<%@  language="VBScript" %>
<%  Option Explicit
    Dim booAdmin : booAdmin = false
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página que lista todos os livros de uma categoria

    ''====================================================

    '' Atualizações:   

    ''====================================================  
       

    Dim Id     
    if trim(Request.QueryString("id")) = "" or not isNumeric(trim(Request.QueryString("id"))) then 
        Response.Redirect "default.asp"
        Response.End
    end if
    Id =  Clng(trim(Request.QueryString("id")))
   
    Set oCategory = New cCategory
    oCategory.SelById(Id)
    Dim PageTitle : PageTitle = Application("SiteName") & " | " & oCategory.Name 

%>
<!--#INCLUDE VIRTUAL="/Includes/incTop.asp"-->

<div class="container">
    <%
    Set oBookStore = New cBookStore        
    oBookStore.GetBooksByIdCategory(Id)
    Dim count : count = 1
        
    For each oBook in oBookStore.Books.Items
    
        If count = 1 Then ' A cada 3 livros vai para linha de baixo
            %>
            <div class="row">
                <%
        End If
                %>
                <div class="col-lg-4 book-item">
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
    next

    If (Ubound(oBookStore.Books.Items) + 1) mod 3 <> 0 then
        %></div><%
    End if


    %>
</div>
<!-- /container -->

<!--#INCLUDE VIRTUAL="/Includes/incBottom.asp"-->
