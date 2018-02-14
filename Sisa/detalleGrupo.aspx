<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="detalleGrupo.aspx.cs" Inherits="Sisa.detalleGrupo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SiSa</title>
    <script src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
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
                <div class="text-center">
                    <h2>Detalles del grupo: <span>Grupo</span></h2>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <table class="table table-striped table-bordered text-center tabla">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Numero</th>
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
                                    <td class="sancion">
                                        <% Response.Write(pair.Value); %>
                                            
                                    </td>
                                    <td class="palitos">
                                        <ol id="count">&nbsp;</ol>
                                    </td>

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
    $(document).ready(function () {
        $(function () {
            $('#tally').on('click', function () {
                $('#count').append('<li></li>');
            });
        });

        var cantidad;

        // Recorro la parte de la tabla que tiene los numeros de sanciones.
        $(".sancion").each(function (index) {

            // tomo el numero de sanciones para mostrar en palitos el numero.
            cantidad = $(this).text();
            for (var i = 0; i < cantidad; i++) {
                $(this).closest('td').next("td").find("ol").append('<li></li>');
            }
        });
    });


    $('#Salir').click(function () {
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Logout',
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                window.location.href = "Login.aspx";
            }
        });
    });
</script>
