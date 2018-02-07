<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RestablecerContrasena.aspx.cs" Inherits="Sisa.RestablecerContrasena" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SiSa</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <script src="JS/jquery-3.2.1.min.js"></script>
    <script src="JS/bootstrap.min.js"></script>
    <link href="CSS/estilos.css" rel="stylesheet" />
</head>
<body class="container-fluid fondo-coloreado">
    <!-- Contenido -->
    <div class="col-md-4 offset-md-4 col-xs-10 offset-xs-1 contenido-login">
        <img id="loginLogo" class="d-block mx-auto" src="img/logoCompletoNaranja.png" />
        <div class="form-group">
            <br />
            <input type="text" class="form-control no-border-radius" id="user" placeholder="Usuario" />
        </div>
        <div class="form-group">
            <input type="text" class="form-control no-border-radius" id="email" placeholder="E-Mail" />
        </div>
        <div class="row">
            <div class="col-9">
                <button type="button" class="btn no-border-radius btn-general" id="restablecerButton">Restablecer</button>
            </div>
            <div class="col">
                <button type="button" class="btn no-border-radius btn-general" id="volverButton">Volver</button>
            </div>
        </div>
        <div class="error text-center" id="errorDiv"></div>
    </div>
</body>
</html>

<script type="text/javascript">

    $('#restablecerButton').click(function () {

        var data = {};
        data.user = $('#user').val();
        data.email = $('#email').val();
        //Voy a validar que exista el usuario para el que quiere restablecer la contraseña.
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Recuperar_Contrasena',
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            data: JSON.stringify(data),
            success: function (response) {
                alert(response.d);
            }
        });
    });


    $('#volverButton').click(function () {
        window.location.href = "Login.aspx";
    });

</script>
