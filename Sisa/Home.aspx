<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Sisa.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>SiSa</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    <script src="JS/jquery-3.2.1.min.js"></script>
    <script src="JS/bootstrap.min.js"></script>
    <link href="CSS/estilos.css" rel="stylesheet" />
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-naranja">
          <a class="navbar-brand" href="Home.aspx"> <img class="logo-navbar" src="img/logoNavBar.png" alt="Logo"/></a>
          <a class="navbar-brand"  id="Grupos" href="#">Grupos</a>
          <a class="navbar-brand"  id="Sanciones" href="#">Sanciones</a>
          <a class="navbar-brand"  id="Salir" href="#">Salir</a>
        </nav>
    <!-- Contenido -->
    <div class="info">
        <p><%= Session["Nombre"] %></p>
        <p><%= DateTime.Now.ToString() %></p>
    </div>
    <div class="container-fluid">
        <div id="header" class="row">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6 col-md-6">
                        <img id="homeSoloLogo" class="d-block mx-auto" src="img/SoloLogoNaranja.png" alt="Logo"/>
                    </div>
                    <div class="titulo-home col-md-4">
                        <img id="homeSoloTexto" src="img/SoloLetrasNaranja.png" alt="Logo"/>
                        <h3>Sistema de Sanciones</h3>
                        <p>SiSa es el sistema que permite mantener la paz en el ambiente laboral.</p>
                        <br />
                        <div class="card border-danger mb-3">
                          <div class="card-header text-center">Notificaciones</div>
                            
                            <div id="carouselExampleIndicators" class="carousel slide card-body text-danger asd" data-ride="carousel">
                                <ol class="carousel-indicators">
                                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active indicador"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="1" class="indicador"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="2" class="indicador"></li>
                              </ol>
                              <div class="carousel-inner">
                                <div class="carousel-item active">
                                  <p class="card-title"> Tenes 3 votaciones pendientes.</p>
                                  <br />
                                </div>
                                <div class="carousel-item">
                                  <p class="card-title"> 4 sanciones realizadas </p>
                                  <br />
                                </div>
                                <div class="carousel-item">
                                  <p class="card-title"> 10 sanciones recibidas </p>
                                  <br />
                                </div>
                              </div>

                            </div>
                
                          </div>

                        <ul>
                            <li>
                                Mis grupos
                            </li>
                        </ul>

                    </div>
                </div>

            </div>
        </div>
    </div>

    <footer class="footer align-middle">
        <a class="link-info" href="https://github.com/Reflej0/Sisa"><i class="fab fa-github"></i> Proyecto</a>
        <a class="link-info" href="https://drive.google.com/drive/folders/1pQlQ849c1K7kmFXsuy--92jWJM8wDnie"><i class="fab fa-google-drive"></i> Drive</a>
        
    </footer>

</body>
</html>

<script type="text/javascript">
    var grupo_predeterminado_id; // Variable global de JS que contiene la id del grupo predeterminado del usuario.

    //Cuando cargo el home, también cargo el Grupo Predeterminado del usuario.
    $(document).ready(function () {
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Grupo_Determinado_Usuario',
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                //Se chequea así ya que si response.d es NULL.
                if (response.d) {
                    grupo_predeterminado_id = response.d;
                }
                else {
                    //Manejar acá lo de errores.
                }
            }
        });
    });


   // setInterval(Get_Sanciones_Activas_Grupos, 1000); //Establezco que cada 1000 segundos voy a hacer una llamada de Ajax que obtenga el listado de las sanciones activas.

    //Método de JS.
    function Get_Sanciones_Activas_Grupos() 
    {
        var data = {}; // En esta variable voy a tener el grupo_id.
        data.grupo_id = grupo_predeterminado_id;
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Sanciones_Activas_Grupos',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                //Estructura del response.
                //Donde dice 0 es si devolvió al menos 1, obviamente hay que iterar.
                //o[0].Id - o[0].grupo_id - o[0].usuario_creador_id - o[0].usuario_sancionado_id - o[0].motivo - o[0].estado - o[0].fecha_creacion;
                var o = JSON.parse(response.d); // En esta variable guardo el response.
                //Se chequea así ya que si response.d es NULL.
                if (response.d) 
                {
                    alert(o[0].Motivo);
                    //Manejar acá lo visual.
                }
                else 
                {
                    //Manejar acá lo de errores.
                }
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

