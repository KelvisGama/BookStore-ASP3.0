# BookStore

>Site básico simulando uma livraria, com área pública e painel Adm para cadastro e alteração de livros.

## Recursos utilizados

Todo o site foi desenvolvido em ASP 3.0 utlizando o conceito de Orientação a Objetos.
Foram utlizados os frameworks Bootstrap, JQuery e Font-Awesome.
Utlizado banco de dados SQL Server.

## Área Pública

Contém uma página `default` como página principal, exibe os últimos livros cadastrados e no topo as `categorias` cadastradas.
Clicando sobre um livro, o usuário é redirecionado para página de detalhes do livro.
Na página de `categorias` são exibidos todos os livros vinculados àquela categoria.

## Area Restrita

A área restrita consite em painel de administração dos dados da área pública.
É possível `cadastrar, alterar e excluir uma categoria`, `cadastrar, alterar e excluir um livro` e também é possível vincular um livro à uma determinada categoria.

Para acessar a área pública é necessário efetuar Login.

## Banco de Dados
Toda interação entre aplicação e banco de dados foi feita utilizando `storage procedores`.

### Tabelas
- **Book** - Tabela que armazena os livros cadastrados.
- **Category** - Tabela que armazena as categorias cadastradas.
- **Author** - Tabela que armazena os autores cadastrados.
- **BookCategory** - Tabela que amarzena os vinculos entre a tabela **Book** e a tabela **Category**.
- **BookAuthor** - Tabela que armazena os vinculos entre a tabela **Book** e tabela **Author**.
- **Login** - Armazena os dados de login dos usuários do Painel.
- 
# Como Usar
 - Criar um novo site no IIS
 - Copiar todos os arquivos do projeto dentro da pasta raiz do site
 - executar o arquivo `script.sql` em um servidor SQL Server (O arquivo irá criar o BD com as tabelas e as procedures necessárias)
 - **O arquivo Global.asa contén os dados de conexão com o BD** altere-os conforme a necessidade.

# Melhorias
 - Layout
 - Mais funcionalidades (como o cadastro de autores)
 - Terminar o desenvolvimento pendendte.
