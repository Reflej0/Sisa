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
                    <input type="password" class="form-control" id="password" placeholder="Contraseña" />
                </div>
                <button type="button" class="btn btn-primary mx-auto d-block" id="loginButton">Ingresar</button>
            </div>
        </div>

        <div class="error" id="errorDiv"></div>
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