<%@  language="VBScript" %>
<%  Option Explicit
    Dim booAdmin : booAdmin = true
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página Adm - Add um Livro

    ''====================================================

    '' Atualizações:   

    ''====================================================  
    
    if Session("Login") <> true then Response.Redirect "login.asp"
    Dim PageTitle : PageTitle = Application("SiteName") & " | Novo Livro" 
    Dim booSuccess : booSuccess = false
    Dim act : act = trim(Request.QueryString("act"))    
%>
<!--#INCLUDE VIRTUAL="/Includes/incTop.asp"-->
<!--#INCLUDE VIRTUAL="/Admin/clsUpload.asp"-->
<%
    if act = "add" then
        Dim Upload, File, Path, FileName
        Set Upload = New clsUpload
        
       	    
		Set oBook = New cBook
        oBook.Title      = ""&Upload.Fields("Titulo").Value
        oBook.SubTitle   = ""&Upload.Fields("Subtitulo").Value
        oBook.Summary    = ""&Upload.Fields("Resumo").Value
        oBook.Publisher  = ""&Upload.Fields("Editora").Value
        oBook.Year       = ""&Upload.Fields("Ano").Value
        oBook.Stock      = "0"&Upload.Fields("Estoque").Value
        oBook.Price      = "0"&Upload.Fields("Preco").Value
        oBook.Cover      = ""&Upload.Fields("Capa").FileName
        oBook.AddNew
        
        Path = Server.MapPath(URLCovers)
        Upload("Capa").SaveAs Path &"/"& oBook.Cover
        
        
        booSuccess = true
        
    end if
    
      
%>

<div class="container">
    <div class="page-header">
        <h1>Novo Livro</h1>
    </div>
    <%if booSuccess = false then%>
    <a href="logout.asp" class="btn btn-danger btn-lg sair">
        <i class="fa fa-sign-out " aria-hidden="true"></i>&nbsp;Sair
    </a>
    <h1></h1>
    <div class="row">
        <div class="col-lg-4">
            <form class="form" action="addBook.asp?act=add" method="post" enctype="multipart/form-data" >
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">Título</div>
                        <input type="text" class="form-control" id="Titulo" name="Titulo" placeholder="Título do Livro" required>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Subtítulo</div>
                        <input type="text" class="form-control" id="Subtitulo" name="Subtitulo" placeholder="Subtítulo do Livro" required>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Editora</div>
                        <input type="text" class="form-control" id="Editora" name="Editora" placeholder="Editora" required>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Ano</div>
                        <input type="date" class="form-control" id="Ano" name="Ano" required>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Resumo</div>
                        <textarea class="form-control" id="Resumo" name="Resumo"></textarea>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">Estoque</div>
                        <input type="number" class="form-control" id="Estoque" name="Estoque" min="0" max="1000" required>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon">R$</div>
                        <input type="number" class="form-control" id="Preco" name="Preco" min="0" max="100" required>
                    </div>

                    <div class="input-group">
                        <div class="input-group-addon"><i class="fa fa-image" aria-hidden="true"></i>&nbsp;Capa</div>
                        <input type="file" class="form-control" id="Capa" name="Capa" required>
                    </div>

                    
                    <button type="submit" class="btn btn-primary"><i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;Salvar</button>
                </div>

            </form>
        </div>
    </div>
</div>
<%Else %>
<div class="alert alert-success" role="alert">
    <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
    <span class="sr-only">Sucesso:</span>
    Livro cadastrado com sucesso!
</div>
<meta http-equiv="refresh" content="3;URL=listBooks.asp" />
<%End if %>
</div>
<!-- /container -->

<!--#INCLUDE VIRTUAL="/Includes/incBottom.asp"-->
