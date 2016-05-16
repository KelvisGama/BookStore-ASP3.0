<%@  language="VBScript" %>
<%  Option Explicit
    Dim booAdmin : booAdmin = true
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página de login da area administrativa

    ''====================================================

    '' Atualizações:   

    ''====================================================  
    
    Dim PageTitle : PageTitle = Application("SiteName") & " | Login"
    If Session("Login") = true then Response.Redirect "Admin.asp"
%>


<!--#INCLUDE VIRTUAL="/Includes/incTop.asp"-->
<div class="container">

    <form class="form-signin" action="validateLogin.asp" method="post">
        <h2 class="form-signin-heading">Login</h2>
        <label for="User" class="sr-only">usuário</label>
        <input type="text" name="User" id="User" class="form-control" placeholder="Usuário" required autofocus>
        <p></p>
        <label for="Password" class="sr-only">senha</label>
        <input type="password" name="Password" id="Password" class="form-control" placeholder="Senha" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Entrar</button>
        <p></p>
        <%if Request.QueryString("err") <> "" then %>
        <div class="alert alert-danger" role="alert">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            <span class="sr-only">Error:</span>
            Usuário ou senha inválidos.
        </div>
        <%end if %>
    </form>

</div>

<!-- /container -->

<!--#INCLUDE VIRTUAL="/Includes/incBottom.asp"-->
