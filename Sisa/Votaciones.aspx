<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Votaciones.aspx.cs" Inherits="Sisa.Votaciones" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
    <div class="container">
        <div class="titulo-formulario">
            <h3>Sanciones Pendientes</h3>
        </div>
        <br />
        <div class="form-group">
            <table class="table table-hover text-center">
                <thead>
                    <tr>
                        <th>Grupo</th>
                        <th>Nombre</th>
                        <th>Motivo</th>
                        <th>Si</th>
                        <th>No</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <% try
                            {
                                foreach (List<string> item in StringSanciones)
                                {%>
                        <input type="hidden" id="grupo_id" value="<% Response.Write(item[0]);%>" />
                        <tr>
                            <td><% Response.Write(Grupos[Convert.ToInt32(item[0])]);%></td>
                            <td><% Response.Write(item[1]);%></td>

                            <td><% Response.Write(item[2]);%></td>

                            <td>
                                <button class="btn btn-success" si_no="1" onclick="Votar(this.id)" id="<% Response.Write(item[3]);%>"><i class="fas fa-check"></i></button>
                            </td>
                            <td>
                                <button class="btn btn-danger" si_no="0" onclick="Votar(this.id)" id="<% Response.Write(item[3]);%>"><i class="fas fa-times"></i></button>
                            </td>
                            <%
                                }%>
                        </tr>
                        <%}
                            catch (Exception e)
                            {
                                Console.WriteLine(e);
                            }%>
                    </tr>
                </tbody>
            </table>

        </div>
    </div>

    <!-- #include file="~/Element/_Footer.aspx" -->


</body>
</html>

<script type="text/javascript">
    /*$(':radio').each(function () { DEBUG
        alert($(this).val());
        alert($(this).attr('id'));
    });*/
    function Votar(sancion_id)
    {
            var data = {}; // Variable que encapsula.
            data.voto_valor = $(this).attr('si_no'); // Los checkbox tienen un atributo si_no. si_no = 1 es Voto a Favor.
            data.sancion_id = sancion_id // Obtengo el id de la sanción.
            data.grupo_id = $("#grupo_id").val(); // Obtengo el id del grupo.
            $.ajax({
                type: 'POST',
                url: 'Services/Service.asmx/Set_Voto_Sancion',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function (response) {
                    alert(response.d);
                }
            });
    }
</script>
