<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="misGrupos.aspx.cs" Inherits="Sisa.misGrupos" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SiSa</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
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
                                        <td>
                                            <!-- #include file="~/Element/_DeleteGrupoUsuario.aspx" -->
                                            <a href="editarGrupo.aspx?id=<%Response.Write(grupo.Key);%>" class="btn btn-info editButton" id="edit-<% Response.Write(grupo.Key);%>" data-toggle="tooltip" data-placement="auto" title="Editar"><span class="glyphicon glyphicon-edit"></span></a>
                                        </td>
                                    </tr>
                            <%
                                }
                            %>
                            </tbody>
                        </table>

                        <br />
                        <div class="text-center">
                            <button type="button" class="btn btn-success" id="newGroup">Nuevo grupo <i class="fas fa-plus"></i></button>
                        </div>
                        
                    </div>
                </div>    
            </div>            
        </div>
    </div>

    <!-- #include file="~/Element/_Footer.aspx" -->

</body>
</html>

<script type="text/javascript">

    $('#newGroup').click(function () {
        window.location = "nuevoGrupo.aspx";
    });

</script>
