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
    <div class="info">
        <p>Nombre de usuario</p>
        <p><%= DateTime.Now.ToString() %></p>
    </div>
    <div class="container-fluid">
        <div id="header" class="row">
            <div class="container">
                <div class="text-center"><h2>Detalles del grupo: <span>Grupo</span></h2></div>
                <br/>
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <table class="table table-striped table-bordered text-center tabla">
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
                                        <td class="sancion"><% Response.Write(pair.Value); %></td>
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

        // Creo un array para guardar los resultados de las filas.
        var filas = [];

        // Recorro la parte de la tabla que tiene los numeros de sanciones.
        $(".sancion").each(function (index) {

            // Guardo los valores en un array.
            filas[index] = $(this).text();
        });

        // Selecciono el maximo.
        var max = Math.max.apply(null, filas);

        // Sumo uno mas al index del maximo del array.
        var maximo = max + 1;

        // Lo marco en rojo porque es el maximo de sanciones en ese grupo.
        $("tr:nth-child(" + maximo + ")").addClass("maximo");

        // Si hay dos con el maximo de sanciones todavia no se.
    });
</script>
