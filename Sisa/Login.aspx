<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Sisa.Login" %>

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
    <div class="col-md-4 offset-md-4 col-xs-10 offset-xs-1 contenido-login">
        <img id="loginLogo" class="d-block mx-auto" src="img/logo2.jpg" alt="Logo"/>
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
        <hr class="linea-separadora">
        <p class="text-center"><a href="">Registrate</a> para comenzar a sancionar gente</p>
    </div>
</body>
</html>

<script type="text/javascript">

    $('#loginButton').click(function () {
        var data = {};
        data.user = $('#user').val();
        data.pass = $('#password').val();

        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Login',
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            data: JSON.stringify(data),
            success: function (response) {
                //Si pudo loguear
                if (response.d){
                    //Redirecciono
                } else {
                    $('#errorDiv').text("Las credenciales son incorrectas.");
                    $('#errorDiv').show();
                }
            }
        });
    });

</script>