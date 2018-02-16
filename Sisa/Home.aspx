<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Sisa.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">

    <!-- Contenido -->
    <div class="pagina-header">

        <div class="container pagina-contenido">
            <div class="row">
                <div class="col-sm-6 col-md-6">
                    <img id="homeSoloLogo" class="d-block mx-auto logo-inicio" src="img/SoloLogoNaranja.png" alt="Logo" />
                </div>
                <div class="titulo-home col-md-4">
                    <img id="homeSoloTexto" src="img/SoloLetrasNaranja.png" alt="Logo" />
                    <h3>Sistema de Sanciones</h3>
                    <p>SiSa es el sistema que permite mantener la paz en el ambiente laboral.</p>
                </div>
            </div>
        </div>
    </div>
    <div class="container pagina-contenido">
        <div class="loading">
  <span>s</span>
  <span>i</span>
  <span>s</span>
  <span>a</span>
  
</div>
        <div class="row"  id="informacionHome">
            <div class="col-md-4">
                <div class="card">
                    <h5 class="card-header">Votaciones</h5>
                    <div class="card-body">
                        <p>Cuando se inicia una sanción, primero pasa a votación para que todos los miembros del grupo decidan si les parece justa su aplicación</p>
                        <h5 class="card-title">Votaciones pendientes: <span id="votaciones_pendientes" class="badge badge-info">0</span></h5>
                        <div class="card-footer bg-transparent border-info text-votaciones">No te olvides de votar!</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <h5 class="card-header">Sanciones</h5>
                    <div class="card-body">
                        <p>Cuando usas vocabulario inapropiado en el horario laboral se te puede aplicar una sanción por violar el código de convivencia según la ley № 10326 </p>
                        <h5 class="card-title">Sanciones recibidas: <span id="sanciones_recibidas" class="badge badge-secondary">0</span></h5>
                        <div class="card-footer bg-transparent border-secondary text-sanciones text-center font-weight-bold" id="consejo">--</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <h5 class="card-header">Sancionado del mes</h5>
                    <div class="card-body">
                        <p>Cada mes se elige al sancionado del mes, esta persona es aquella que haya recibido más sanciones durante el mes pasado.</p>
                        <br />
                        <h5 class="card-title">Sancionado del mes: <span id="sancionado_mes" class="badge badge-secondary">sbhadbda</span></h5>
                        <div class="card-footer bg-transparent border-secondary text-sancionado text-center font-weight-bold" id="sancionado">--</div>
                    </div>
                </div>
            </div>
        </div>

    </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
    <script>
    var grupo_predeterminado_id; // Variable global de JS que contiene la id del grupo predeterminado del usuario.
    var array_sanciones = []; // Variable global de JS que contiene las sanciones del grupo predeterminado del usuario.
    var array_mis_sanciones = []; // Variable global de JS que contiene MIS sanciones, osea las que me hicieron.
    var sanciones = 0; // Variable global de JS que contiene la cantidad de sanciones del grupo.
    var mis_sanciones = 0; // Variable global de JS que contiene la cantidad de MIS sanciones.
    //Cuando cargo el home, también cargo el Grupo Predeterminado del usuario.
    $(document).ready(function () {
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Grupo_Determinado_Usuario',
            contentType: 'application/json;charset=utf-8',
            beforeSend: function () {
                // setting a timeout
                $('#informacionHome').css("display", "none");
            },
            success: function (response) {
                //Se chequea así ya que si response.d es NULL.
                if (response.d) {
                    grupo_predeterminado_id = response.d;
                    Get_Sanciones_Activas_Grupos();
                    Get_Sancion_Usuario();
                }
                else {
                    //Manejar acá lo de errores.
                }
            },
        });

        var usuarioLogueado = $("#nombreUsuario").text();
        var sancionadoDelMes = $("#sancionado_mes").text();
        if (usuarioLogueado === sancionadoDelMes) {
            $('#sancionado_mes').addClass("badge-congrats");
            $('#sancionado').text("Felicitaciones!");
            $('#sancionado').addClass("text-congrats");
            $('#sancionado').addClass("border-congrats");
        } else {
            $('#sancionado').text("Seguí participando");
        }

    });

    //Método de JS.
    function Get_Sanciones_Activas_Grupos() 
    {
        var data = {}; // En esta variable voy a tener el grupo_id.
        data.grupo_id = grupo_predeterminado_id;
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Sanciones_Activas_Grupos_Usuario',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                //Estructura del response.
                //Donde dice 0 es si devolvió al menos 1, obviamente hay que iterar.
                //o[0].Id - o[0].grupo_id - o[0].usuario_creador_id - o[0].usuario_sancionado_id - o[0].motivo - o[0].estado - o[0].fecha_creacion;
                //Se chequea así ya que si response.d es NULL.
                if (response.d) 
                {
                    var array_aux = eval('(' + response.d + ')'); // Así convierto un string -> array JSON.
                    array_sanciones = []; // Limpio el array global.
                    for (i in array_aux) { // Esto es para que los elementos del array_aux pasen a array_sanciones.
                        array_sanciones.push(array_aux[i]);
                    }
                }
                else 
                {
                    //Manejar acá lo de errores.
                }
                sanciones = array_sanciones.length; //Obtengo la cantidad de sanciones.
                $('#votaciones_pendientes').text(sanciones); // Las muestro dinámicamente.
            }
        });
    }
    function Get_Sancion_Usuario() {
        var data = {}; // En esta variable voy a tener el grupo_id.
        data.grupo_id = grupo_predeterminado_id;
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Sancion_Usuario',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                //Estructura del response.
                //Donde dice 0 es si devolvió al menos 1, obviamente hay que iterar.
                //Se chequea así ya que si response.d es NULL.
                if (response.d) {
                    var array_aux = eval('(' + response.d + ')'); // Así convierto un string -> array JSON.
                    array_mis_sanciones = []; // Limpio el array global.
                    for (i in array_aux) { // Esto es para que los elementos del array_aux pasen a array_sanciones.
                        array_mis_sanciones.push(array_aux[i]);
                    }
                }
                else {
                    //Manejar acá lo de errores.
                }
                mis_sanciones = array_mis_sanciones.length; //Obtengo la cantidad de sanciones.
                $('#sanciones_recibidas').text(mis_sanciones); // Las muestro dinámicamente.

                // Si las sanciones superan las 5 muestro mensajes rojos de alerta.
                if (mis_sanciones < 5) {
                    $('#sanciones_recibidas').addClass("badge-success");
                    $('#consejo').text("Muy bien! Estás manteniendo la paz.");
                    $('#consejo').addClass("text-success");
                    $('#consejo').addClass("border-success");
                } else {
                    $('#sanciones_recibidas').addClass("badge-danger");
                    $('#consejo').text("Cuidá tu vocabulario.");
                    $('#consejo').addClass("text-danger");
                    $('#consejo').addClass("border-danger");
                }

                $('#informacionHome').fadeIn(1000);
                $('.loading').css("display", "none");
            }
        });
    }



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
</asp:Content>
