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
    <!-- #include file="~/Element/_Navbar.aspx" -->

    <!-- Contenido -->
    <div class="container-fluid pagina-contenido">
        <div id="header" class="row">
            <div class="container">
              <div class="titulo-formulario">
                  <h2>Mis grupos</h2>
              </div>
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
                                foreach (var grupo in grupos)
                                {
                            %>
                                    <tr id="grupo-<% Response.Write(grupo.Id);%>">
                                        <td><a href="detalleGrupo.aspx?<% Response.Write(grupo.Id);%>"><% Response.Write(grupo.Nombre);%></a></td>
                                        <td>
                                            <%if (grupo.Administrador_id == idAdminSession)
                                                    { %>
                                            <a style="visibility:visible" href="editarGrupo.aspx?id=<%Response.Write(grupo.Id);%>" class="btn btn-info editButton" id="edit-<% Response.Write(grupo.Id);%>" data-toggle="tooltip" data-placement="auto" title="Editar"><i class="fas fa-edit"></i></a>
                                            <% }
                                                else {%>
                                            <a style="visibility:hidden" href="editarGrupo.aspx?id=<%Response.Write(grupo.Id);%>" class="btn btn-info editButton" id="edit-<% Response.Write(grupo.Id);%>" data-toggle="tooltip" data-placement="auto" title="Editar"><i class="fas fa-edit"></i></a>
                                            <%
                                                } %>
                                            <!-- #include file="~/Element/_DeleteGrupoUsuario.aspx" -->
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
    /*
    $('.editButton').click(function () {
        var value = $(this).attr('id');
        var idAdmin = value.split('-')[2];
        if (idAdmin == ){
            $(this).show();
        }
        else {
            alert("Debes ser admin para editar!");
        }
    });*/

</script>
