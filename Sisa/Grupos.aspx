<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Grupos.aspx.cs" Inherits="Sisa.Grupos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SiSa</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <script src="JS/jquery-3.2.1.min.js"></script>
    <script src="JS/bootstrap.min.js"></script>
    <link href="CSS/estilos.css" rel="stylesheet" />
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-naranja">
          <a class="navbar-brand" href="Home.aspx"> <img class="logo-navbar" src="img/logoNavBar.png" alt="Logo"/></a>
          <a class="navbar-brand"  id="Grupos" href="#">Grupos</a>
          <a class="navbar-brand"  id="Sanciones" href="#">Sanciones</a>
          <a class="navbar-brand"  id="Salir" href="#">Salir</a>
        </nav>
    <h1>

        Estamo activo en grupo
    </h1>

    <form id="form1" runat="server">
        <div>
        </div>
    </form>

    <footer class="footer align-middle">
        <a class="link-info" href="https://github.com/Reflej0/Sisa"> Proyecto</a>
        <a class="link-info" href="https://drive.google.com/drive/folders/1pQlQ849c1K7kmFXsuy--92jWJM8wDnie">Drive</a>
        
    </footer>
</body>
</html>
