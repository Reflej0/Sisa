<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="Sisa.Registro" %>

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
    <div class="contenido">
        <div class="container">
            <div class="justify-content-center align-content-center">
                <img class="mx-auto d-block col-md-2" src="img/logo2.jpg"/>
                <div class="form-group">
                    <br />
                    <input type="text" class="form-control" id="user" placeholder="Usuario" />
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" id="email" placeholder="Email" />
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" id="password" placeholder="Contraseña" />
                </div>
                <button type="button" class="btn btn-primary mx-auto d-block" id="loginButton">Crear usuario</button>
            </div>
        </div>

        <div class="error" id="errorDiv"></div>
    </div>
</body>
</html>

<script type="text/javascript">

    $('#addButton').click(function () {
        var data = {};
        data.email = $('#email').val();
        data.user = $('#user').val();
        data.pass = $('#password').val();

        if (validarCampos()) {
            $.ajax({
                type: 'POST',
                url: 'Services/Service.asmx/Registro',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function (response) {
                    //
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