<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="detalleGrupo.aspx.cs" Inherits="Sisa.detalleGrupo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
    <!-- Contenido -->
    <div class="info">
        <p>Nombre de usuario</p>
        <p><%= DateTime.Now.ToString() %></p>
    </div>
    <div class="container-fluid">
        <div id="header" class="row">
            <div class="container">
                <h2>Grupo</h2>
                <br/>

                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <table class="table table-bordered text-center">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Sanciones</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% 
                                foreach (var pair in sanciones)
                                {
                            %>
                                    <tr>
                                        <td><% Response.Write(pair.Key); %></td>
                                        <td><% Response.Write(pair.Value); %></td>
                                    </tr>
                            <%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer align-middle">
        <a class="link-info" href="https://github.com/Reflej0/Sisa"> Proyecto</a>
        <a class="link-info" href="https://drive.google.com/drive/folders/1pQlQ849c1K7kmFXsuy--92jWJM8wDnie">Drive</a>
        
    </div>
</body>
</html>
