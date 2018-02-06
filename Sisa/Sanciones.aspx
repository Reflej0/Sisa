<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sanciones.aspx.cs" Inherits="Sisa.Sanciones" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>SiSa</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
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
    <div class="info">
        <p>Nombre de usuario</p>
        <p><%= DateTime.Now.ToString() %></p>
    </div>
    <div class="container-fluid">
        <div class="form-group">
            <label for="selectGrupo">Grupo</label>
            <select class="form-control" id="selectGrupo">
                <option value="0" selected>Seleccione un grupo...</option>
                <% try
                    {
                        foreach (List<string> item in StringGrupos)
                        {%>

                <option value="<% Response.Write(item[0]);%>"><% Response.Write(item[1]); %></option>
                <%}

                    }
                    catch (Exception e)
                    {
                        Console.WriteLine(e);
                    }
                %>
            </select>
            <label for="selectGrupo">Integrante</label>
            <select class="form-control" id="selectIntegrante" disabled>
                <option value="0" selected>Seleccione un integrante...</option>
            </select>
            <label for="Motivo">Motivo</label>
            <textarea class="form-control" rows="5" id="Motivo"></textarea>
            <button type="button" class="btn no-border-radius btn-general" id="sendButton">Sanción!!!</button>

        </div>
    </div>

    <div class="footer align-middle">
        <a class="link-info" href="https://github.com/Reflej0/Sisa">Proyecto</a>
        <a class="link-info" href="https://drive.google.com/drive/folders/1pQlQ849c1K7kmFXsuy--92jWJM8wDnie">Drive</a>

    </div>

</body>
</html>

<script type="text/javascript">

    function mostrarNotificaciones() {
        var notificaciones = document.getElementById('texto-notificacion');
        notificaciones.textContent = "notificaciones";
    }

    setInterval(mostrarNotificaciones, 1000);

    $('#Grupos').click(function () {

        window.location.href = "Grupos.aspx";

        /*
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Grupos_Usuarios',
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                var o = JSON.parse(response.d);
                alert(o[0].Nombre);
                //Se chequea así ya que si no logeo correctamente response.d es NULL.
                if (response.d != -1) {
                    //Redireccionar a index o mi perfil.
                    //window.location.href = "RestablecerContrasena.aspx";
                } else {
                    $('#errorDiv').text("Las credenciales son incorrectas.");
                    $('#errorDiv').show();
                }
            }
        });

        */
    });

</script>

<script type="text/javascript">

    $('#Sanciones').click(function () {
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Sancion_Usuario',
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                alert(response.d);
                //Se chequea así ya que si no logeo correctamente response.d es NULL.
                if (response.d != -1) {
                    //Redireccionar a index o mi perfil.
                    //window.location.href = "RestablecerContrasena.aspx";
                } else {
                    $('#errorDiv').text("Las credenciales son incorrectas.");
                    $('#errorDiv').show();
                }
            }
        });
    });

    $('#selectGrupo').on('change', function () {
        if (this.value > 0) {
            var data = {};
            data.grupo_id = this.value;

            $.ajax({
                type: 'POST',
                url: 'Services/Service.asmx/Get_Usuarios_Grupos',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function (response) {
                    if (response.d) {
                        $.each(response.d, function (index, value) {
                            $('<option/>', { value: value["Id"] }).text(value["_Usuario"]).appendTo('#selectIntegrante');
                        });
                        $('#selectIntegrante').prop("disabled", false);
                    }
                }
            });
        } else {
            $('#selectIntegrante').prop("disabled", true).empty();
            $('<option/>', { value: 0 }).text("Seleccione un integrante...").appendTo('#selectIntegrante');
        }
    })

</script>

<script type="text/javascript">

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

