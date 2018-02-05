<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Sisa.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>SiSa</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <script src="JS/jquery-3.2.1.min.js"></script>
    <script src="JS/bootstrap.min.js"></script>
    <link href="CSS/estilos.css" rel="stylesheet" />
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-naranja">
          <a class="navbar-brand"  id="Grupos" href="#">Grupos</a>
          <a class="navbar-brand"  id="Sanciones" href="#">Sanciones</a>
          <a class="navbar-brand"  id="Salir" href="#">Salir</a>
        </nav>
    <!-- Contenido -->
    <div class="info">
        <p>Nombre de usuario</p>
        <p>12/12/2012 00:00</p>
    </div>
    <div class="container-fluid">
        <div id="header" class="row">
            <div class="container">
                <div class="col-sm-3 col-md-3">
                    <img id="homeSoloLogo" class="d-block mx-auto" src="img/solo_logo.jpg" alt="Logo"/>
                </div>
                <div class="col-sm-1">
                    <img id="homeSoloTexto" class="d-block mx-auto" src="img/solo_texto.jpg" alt="Logo"/>
                </div>
            </div>
        </div>
    </div>
    <!-- div id="main">
        <div class="container">
            <div class="row">
                <div class="col-sm-3 col-md-3">
                    <div class="panel-group" id="accordion">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <button>
                                        <span class="glyphicon glyphicon-folder-close"></span>
                                        Grupos
                                    </button>
                                </h4>
                            </div>
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <button >
                                        <span class="glyphicon glyphicon-folder-close"></span>
                                        Sanciones
                                    </button>
                                </h4>
                            </div>
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <button >
                                        <span class="glyphicon glyphicon-folder-close"></span>
                                        Salir
                                    </button>
                                </h4>
                            </div>
                        </div>
                    </div>
        </div>
                <div class="col-sm-9 col-md-9" id="pantalla">
                    <div class="well">
                        <h1>	HOME!				</h1>
                    </div>
                </div>
            </div>
        </div> <!-- Cierro container -->
    </--!> <!-- Cierro main -->

    <div class="footer">
        footer
    </div>

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

