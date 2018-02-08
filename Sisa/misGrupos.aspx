<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="misGrupos.aspx.cs" Inherits="Sisa.misGrupos" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SiSa</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
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
        <p><%= Session["Nombre"] %></p>
        <p><%= DateTime.Now.ToString() %></p>
    </div>
    <div class="container-fluid">
        <div id="header" class="row">
            <div class="container">
                <h2>Mis grupos</h2>
                <br/>
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <table class="table table-bordered text-center">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% 
                                foreach (String grupo in nombresGrupos)
                                {
                            %>
                                    <tr>
                                        <td><% Response.Write(grupo);%></td>
                                        <td><button type="button" class="btn btn-danger" id="deleteButton" data-toggle="tooltip" data-placement="auto" title="Salir del grupo"><i class="fas fa-sign-out-alt"></i></button></td>
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

<script type="text/javascript">

    $('#deleteButton').click(function () {
        var del = confirm("Estás seguro que querés salir del grupo?");

        if (del == true) {
            $.ajax({
                type: 'POST',
                url: 'Services/Service.asmx/Delete_Grupo_Usuario',
                contentType: 'application/json;charset=utf-8',
                success: function (response) {
                    //
                }
            });
        }
    });

</script>
