<%@  language="VBScript" %>
<%  Option Explicit
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Página de logout

    ''====================================================

    '' Atualizações:   

    ''====================================================  

    Session.Abandon
    Response.Redirect "login.asp"
    Response.End
%>


