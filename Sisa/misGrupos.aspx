﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="misGrupos.aspx.cs" Inherits="Sisa.misGrupos" %>

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
    <!-- #include file="~/Element/_Navbar.aspx" -->

    <!-- Contenido -->
    <div class="container-fluid pagina-contenido">
        <div id="header" class="row">
            <div class="container">
                <div class="text-center"><h2>Mis grupos</h2></div>
                <br/>
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <table class="table table-striped table-bordered text-center tabla">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% 
                                foreach (var grupo in nombresGrupos)
                                {
                            %>
                                    <tr id="grupo-<% Response.Write(grupo.Key);%>">
                                        <td><a href="detalleGrupo.aspx?<% Response.Write(grupo.Key);%>"><% Response.Write(grupo.Value);%></a></td>
                                        <td><button type="button" class="btn btn-danger deleteButton" id="<% Response.Write(grupo.Key);%>" data-toggle="tooltip" data-placement="auto" title="Salir del grupo"><i class="fas fa-sign-out-alt"></i></button></td>
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

    <!-- #include file="~/Element/_Footer.aspx" -->

</body>
</html>

<script type="text/javascript">

    $('.deleteButton').click(function () {
        var del = confirm("Estás seguro que querés salir del grupo?");
        var data = {};
        data.grupo_id = $(this).attr('id');

        if (del == true) {
            $.ajax({
                type: 'POST',
                url: 'Services/Service.asmx/Delete_Grupo_Usuario',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json;charset=utf-8',
                success: function (response) {
                    $('#grupo-' + data.grupo_id).remove();
                }
            });
        }
    });

</script>
