<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sanciones.aspx.cs" Inherits="Sisa.Sanciones" %>

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
    <div class="container">
        <div class="titulo-formulario">
            <h3>Reportar una sanción <i class="far fa-frown"></i></h3>
        </div>
        <br />
        <div class="form-group">
            <div class="row">
                <div class="col col-md-6">
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
                </div>
                <div class="col col-md-6">
                    <label for="Motivo">Motivo</label>
                    <textarea class="form-control" rows="4" id="Motivo"></textarea>

                </div>
            </div>
            <br />
            <div class="text-center">
                <button type="button" class="btn btn-danger" id="sendButton">Sanción <i class="fas fa-gavel"></i></button>
            </div>
            

        </div>
    </div>
    <!-- #include file="~/Element/_Footer.aspx" -->

</body>
</html>

<script type="text/javascript">

    function mostrarNotificaciones() {
        //var notificaciones = document.getElementById('texto-notificacion');
        //notificaciones.textContent = "notificaciones";
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
                url: 'Services/Service.asmx/Get_Usuarios_Grupos_Sanciones',
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

    $('#sendButton').click(function () {
        var data = {};
        data.grupo_id = $('#selectGrupo').val();
        data.sancionado_id = $('#selectIntegrante').val();
        data.motivo = $("#Motivo").val();

            $.ajax({
                type: 'POST',
                url: 'Services/Service.asmx/Set_Sancion_Usuario',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function (response) {
                    if (response.d == 0)
                    {
                        alert("Sancion aplicada");
                    }
                    window.location.href = "Home.aspx";
                }
            });
       
    });
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

