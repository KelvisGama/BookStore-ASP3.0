<%   
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Conteúdo do topo do site

    ''====================================================

    '' Atualizações:   

    ''====================================================    
    Const URLImages =  "/images/"
    Const URLCovers =  "/images/covers/"

%>

<!--#INCLUDE VIRTUAL="/ConnectionDb.asp"-->
<!--#INCLUDE VIRTUAL="/cBook.asp"-->
<!--#INCLUDE VIRTUAL="/cAuthor.asp"-->
<!--#INCLUDE VIRTUAL="/cCategory.asp"-->
<!--#INCLUDE VIRTUAL="/cBookStore.asp"-->

<!DOCTYPE html>
<html lang="pt-br" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="" />
    <meta name="author" content="Kelvis da Gama" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/favicon.ico" type="image/x-icon">

    <title><%=PageTitle %></title>

    <!-- CSS -->
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/css/style.css" rel="stylesheet" />
    <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" />

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <%
        Dim oBookStore
        Dim oCategory
        Dim oBook
        Dim oAuthor
        Set oBookStore = New cBookStore
        oBookStore.GetAllCategories

        if booAdmin = false then
    %>
    <!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand logo" href="/default.asp">
                    <img src="<%=URLimages %>logo.png" alt="Início" class="logo-img" /><p class="logo-book">Book<span class="logo-store">Store</span></p>
                </a>
            </div>
            <div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="/default.asp">Início</a></li>
                    <%
                      For each oCategory in oBookStore.Categories.Items
                    %>
                    <li><a href="category.asp?id=<%=oCategory.IdCategory %>"><%=oCategory.Name %></a></li>
                    <%  
                      Next  
                    %>
                </ul>
            </div>
            <div id="navbar-admin" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="Admin/login.asp">Admin</a></li>
                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
    </nav>
       
    <% end if %>