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
    <nav class="navbar navbar-expand-lg navbar-naranja">
        <a class="navbar-brand" href="Home.aspx">
            <img class="logo-navbar" src="img/logoNavBar.png" alt="Logo" /></a>
        <a class="navbar-brand" id="Grupos" href="#">Grupos</a>
        <a class="navbar-brand" id="Sanciones" href="#">Sanciones</a>
        <a class="navbar-brand" id="Salir" href="#">Salir</a>
    </nav>
    <!-- Contenido -->
    <div class="container">
        <div class="titulo-formulario">
            <h3>Sanciones Pendientes <i class="far fa-frown"></i></h3>
        </div>
        <br />
        <div class="form-group">
            <table>
                <thead>
                    <th>Grupo</th>
                    <th>Nombre</th>
                    <th>Motivo</th>
                    <th>Si</th>
                    <th>No</th>
                </thead>
                <tbody>
                    <tr>
                        <% try
                            {
                                foreach (List<string> item in StringSanciones)
                                {%>
                        <input type="hidden" id="grupo_id" value="<% Response.Write(Grupos[Convert.ToInt32(item[0])]);%>"/>
                        <tr>
                            <td><% Response.Write(Grupos[Convert.ToInt32(item[0])]);%></td>
                            <td><% Response.Write(item[1]);%></td>

                            <td><% Response.Write(item[2]);%></td>

                            <td>
                                <input type="radio" name="radio<% Response.Write(item[3]);%>" id="<% Response.Write(item[3]);%>"></td>
                            <td>
                                <input type="radio" name="radio<% Response.Write(item[3]);%>" id="<% Response.Write(item[3]);%>"></td>

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

                            <button type="button" class="btn no-border-radius btn-general" id="enviarButton">Enviar</button>

        </div>
    </div>

    <div class="footer align-middle">
        <a class="link-info" href="https://github.com/Reflej0/Sisa"><i class="fab fa-github"></i>Proyecto</a>
        <a class="link-info" href="https://drive.google.com/drive/folders/1pQlQ849c1K7kmFXsuy--92jWJM8wDnie"><i class="fab fa-google-drive"></i>Drive</a>

    </div>

</body>
</html>

<script type="text/javascript">
    /*$(':radio').each(function () {
        alert($(this).val());
        alert($(this).attr('id'));
    });*/
    $('#enviarButton').click(function () {
        $(':radio:checked').each(function ()
        {
            var data = {};
            data.voto_valor = 1;
            data.sancion_id = $(this).attr('id');
            data.grupo_id = $("grupo_id").val();
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
        });
    });
</script>
