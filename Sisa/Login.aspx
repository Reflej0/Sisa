<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Sisa.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>SiSa</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <script src="JS/jquery-3.2.1.min.js"></script>
    <script src="JS/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="justify-content-center align-content-center">
            <img class="img-circle col-md-2" src="img/logo2.jpg"/>
            <div class="form-group">
                <br />
                <input type="text" class="form-control" placeholder="Usuario" />
            </div>
            <div class="form-group">
                <input type="password" class="form-control" placeholder="Contraseña" />
            </div>
            <button type="button" class="btn btn-primary">Ingresar</button>
        </div>
    </div>
</body>
</html>
