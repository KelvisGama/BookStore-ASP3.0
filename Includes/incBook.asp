<%   
    '' Data de criação: 13 de Maio de 2016  

    '' Autor: Kelvis da Gama

    '' Funcionalidade: Conteúdo de um livro para listagem

    ''====================================================

    '' Atualizações:   

    ''====================================================    
%>
<a href="BookDetails.asp?id=<%=oBook.IdBook%>" class="book-thumb">
    <div>
        <img class="cover-thumb img-thumbnail" src="<%=URLCovers & oBook.Cover%>" alt="<%=oBook.Title%>" />
        <h4 class="title-thumb text-uppercase text-left"><%=oBook.Title%> <small class="text-capitalize"><%=oBook.SubTitle%></small></h4>
        
        <p class="price-thumb"><span class="symbol">R$</span> <%=oBook.Price%></p>
    </div>
</a>