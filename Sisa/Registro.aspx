<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="Sisa.Registro" %>

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
        <div class="justify-content-center align-content-center">
            <img id="loginLogo" class="d-block mx-auto" src="img/logo2.jpg" alt="logo"/>
            <div class="form-group">
                <br />
                <input type="text" class="form-control no-border-radius" id="email" placeholder="Email" />
            </div>
            <div class="form-group">
                <input type="text" class="form-control no-border-radius" id="user" placeholder="Usuario" />
            </div>
            <div class="form-group">
                <input type="password" class="form-control no-border-radius" id="password" placeholder="Contraseña" />
            </div>
            <button type="button" class="btn no-border-radius btn-general" id="addButton">Crear usuario</button>
        </div>
        
        <div class="error text-center" id="errorDiv"></div>
    </div>
</body>
</html>

<script type="text/javascript">

    $('#addButton').click(function () {
        var data = {};
        data.email = $('#email').val();
        data.usuario = $('#user').val();
        data.password = $('#password').val();

        if (validarCampos()) {
            $.ajax({
                type: 'POST',
                url: 'Services/Service.asmx/Set_Usuario',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function (response) {
                    window.location = 'Login.aspx'
                }
            });
        }
    });

    function validarCampos(user, email, pass) {
        var user = $('#user').val();
        var email = $('#email').val();
        var pass = $('#password').val();
        var regexEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

        if (user.length == 0 || email.length == 0 || pass.length == 0) {
            $('#errorDiv').text("Los campos no pueden estar vacíos.");
            $('#errorDiv').show();
            return false;
        }

        if (!regexEmail.test(email)) {
            $('#errorDiv').text("Ingrese un email válido.");
            $('#errorDiv').show();
            return false;
        }

        return true;
    }

</script>