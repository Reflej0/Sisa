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
                    <input type="text" class="form-control" id="text" placeholder="E-Mail" />
                </div>
                <button type="button" class="btn btn-primary mx-auto d-block" id="resetearButton">Resetear</button>
            </div>
        </div>

        <div class="error" id="errorDiv"></div>
    </div>
</body>
</html>
