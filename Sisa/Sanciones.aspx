<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sanciones.aspx.cs" Inherits="Sisa.Sanciones1" %>

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
                    <button type="button" class="btn btn-danger" id="addSancion">Nueva sanción <i class="fas fa-plus"></i></button>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-12">
                        <table class="table table-striped table-bordered text-center tabla">
                            <thead>
                                <tr>
                                    <th>Grupo</th>
                                    <th>Creador</th>
                                    <th>Sancionado</th>
                                    <th>Motivo</th>
                                    <th>Estado</th>
                                    <th>Fecha</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% foreach (List<string> item in StringSanciones)
                                {%>
                                    <tr>
                                        <td><% Response.Write(Grupos[Convert.ToInt32(item[0])]);%></td>
                                        <td><% Response.Write(item[1]);%></td>
                                        <td><% Response.Write(item[2]);%></td>
                                        <td><% Response.Write(item[3]);%></td>
                                        <% String estado = (Int32.Parse(item[4]) == 1) ? "En votación" : "Aceptada" ;%>
                                        <td><% Response.Write(estado);%></td>
                                        <td><% Response.Write(item[5]);%></td>
                                   </tr>             
                                <%
                                }%>
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

    $('#addSancion').click(function () {
        window.location = "nuevaSancion.aspx";
    });

</script>
