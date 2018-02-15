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
    <div class="container pagina-contenido">
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
                        <option value="0" selected="selected">Seleccione un integrante...</option>
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
            
      <!-- Modal -->
          <div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" >
                <div class="modal-content contenido-modal">
                    <div class="modal-header titulo-modal ">
                        <h4 class="modal-title" id="myModalLabel"><i class="fas fa-info-circle"></i> Información </h4>
                    </div>
                    <div class="modal-body">
                        <label> Sanción aplicada </label>
                    </div>
                    <div class="modal-footer">
                        <button id="cerrarButton" type="button" class="btn btn-outline-dark" data-dismiss="modal" >Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
            <div class="error text-center" id="errorDiv"></div>
        </div>
    </div>
    <!-- #include file="~/Element/_Footer.aspx" -->

</body>
</html>

<script type="text/javascript">

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
        
        if (data.grupo_id != 0 && data.sancionado_id != 0 && data.motivo.length > 0) {
            $.ajax({
                type: 'POST',
                url: 'Services/Service.asmx/Set_Sancion_Usuario',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function (response) {

                        //alert("sancion aplicada");
                        // Muestro el modal.
                        $('#basicModal').modal();
                }
            });
        } else {
            $('#errorDiv').text("Los campos no pueden estar vacíos.");
            $('#errorDiv').show();
        }   

    });

    // Cuando el modal se cierra, por tocar el boton o fuera de si redirijo al home.
    $('#basicModal').on('hidden.bs.modal', function () {
        window.location.href = "Home.aspx";
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

