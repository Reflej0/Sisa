<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RestablecerContrasena.aspx.cs" Inherits="Sisa.RestablecerContrasena" %>

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
        <img id="loginLogo" class="d-block mx-auto" src="img/logo2.jpg"/>
            <div class="form-group">
                <br />
                <input type="text" class="form-control no-border-radius" id="user" placeholder="Usuario" />
            </div>
            <div class="form-group">
                <input type="text" class="form-control no-border-radius" id="email" placeholder="E-Mail" />
            </div>
        <button type="button" class="btn no-border-radius" id="restablecerButton">Restablecer</button>
        <div class="error text-center" id="errorDiv"></div>
    </div>
</body>
</html>

<script type="text/javascript">

    $('#restablecerButton').click(function () {
        var user = $('#user').val();
        var email = $('#email').val();

        //Voy a validar que exista el usuario para el que quiere restablecer la contraseña.
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Usuario',
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            data: JSON.stringify(data),
            success: function (response) {
                alert(response.d);
            }
        });
    });

</script>