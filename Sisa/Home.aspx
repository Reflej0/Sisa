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
<body class="container-fluid fondo-coloreado">
    <!-- Contenido -->
    <div id="header" class="row">
        <div class="col-sm-3 col-md-3">
            <img id="homeSoloLogo" class="d-block mx-auto" src="img/solo_logo.jpg" alt="Logo"/>
        </div>
        <div class="col-sm-1">
            <img id="homeSoloTexto" class="d-block mx-auto" src="img/solo_texto.jpg" alt="Logo"/>
        </div>
        <div class="col-sm-2">
            <h1> Header </h1>
        </div>
         

    </div>
    <br />
    
    <hr/>
    <hr/>
    <br />

    <div id="main">
        <div class="container">
    <div class="row">
        <div class="col-sm-3 col-md-3">
            <div class="panel-group" id="accordion">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <button id="Grupos">
                                <span class="glyphicon glyphicon-folder-close"></span>
                                Grupos
                            </button>
                        </h4>
                    </div>
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <button id="Sanciones">
                                <span class="glyphicon glyphicon-folder-close"></span>
                                Sanciones
                            </button>
                        </h4>
                    </div>
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <button id="Salir">
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
</div>

    </div>

    <br />
    <br />
    <br />

    <div id="footer">
        footer
    </div>

    <!-- <img id="homeLogo" class="d-block mx-auto" src="img/logo2.jpg" alt="Logo"/>-->
    <div class="col-md-4 offset-md-4 col-xs-10 offset-xs-1 contenido-login">
        
            <div class="form-group">
                <br />
                <input type="text" class="form-control no-border-radius" id="user" placeholder="Usuario" />
            </div>
            <div class="form-group">
                <input type="password" class="form-control no-border-radius" id="password" placeholder="Contraseña" />
            </div>
        <button type="button" class="btn no-border-radius" id="loginButton">Ingresar</button>
        <div class="error text-center" id="errorDiv"></div>
        <br />
        <hr class="linea-separadora" />
        <p class="text-center"><a href="Registro.aspx">Registrate</a> para comenzar a sancionar gente</p>
    </div>
</body>
</html>

<script type="text/javascript">

    $('#Grupos').click(function () {
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Grupos_Usuarios',
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                var o = JSON.parse(response.d);
                alert(o[0].nombre);
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

