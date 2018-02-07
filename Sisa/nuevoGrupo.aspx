<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nuevoGrupo.aspx.cs" Inherits="Sisa.nuevoGrupo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SiSa</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    <script src="JS/jquery-3.2.1.min.js"></script>
    <script src="JS/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <link rel="stylesheet" href="/resources/demos/style.css"/>
    <link href="CSS/estilos.css" rel="stylesheet" />
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-naranja">
        <a class="navbar-brand" href="Home.aspx">
            <img class="logo-navbar" src="img/logoNavBar.png" alt="Logo" /></a>
        <a class="navbar-brand" id="Grupos" href="#">Grupos</a>
        <a class="navbar-brand" id="Sanciones" href="#">Sanciones</a>
        <a class="navbar-brand" id="Salir" href="#">Salir</a>
    </nav>
    <!-- Contenido -->
    <div class="info">
        <p><%= Session["Nombre"] %></p>
        <p><%= DateTime.Now.ToString() %></p>
    </div>
    <div class="container">
        <div class="titulo-formulario">
            <h3>Nuevo grupo</h3>
        </div>
        <br />
        <div class="form-group">
            <div class="row">
                <div class="col col-md-6">
                    <div class="col col-md-6">
                        <label for="Motivo">Nombre del grupo</label>
                        <input class="form-control" id="nombre" />
                    </div>
                    <div class="col col-md-6">
                        <label for="selectGrupo">Integrante</label>
                        <input class="form-control" id="integrantes" />
                    </div>
                </div>
                <div class="col col-md-6">
                    <table>
                        <thead>
                            <tr>
                                <th>Integrantes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr><td>Tocino</td></tr>
                            <tr><td>Tocino</td></tr>
                            <tr><td>Tocino</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <br />
            <div class="text-center">
                <button type="button" class="btn btn-success" id="addButton">Agregar <i class="fas fa-plus"></i></button>
            </div>
            

        </div>
    </div>

    <div class="footer align-middle">
        <a class="link-info" href="https://github.com/Reflej0/Sisa"><i class="fab fa-github"></i> Proyecto</a>
        <a class="link-info" href="https://drive.google.com/drive/folders/1pQlQ849c1K7kmFXsuy--92jWJM8wDnie"><i class="fab fa-google-drive"></i> Drive</a>

    </div>

</body>
</html>

  <script>
      var array_usuarios = [];
      $(document).ready(function () {
          $.ajax({
              type: 'POST',
              url: 'Services/Service.asmx/Get_Usuarios',
              contentType: 'application/json;charset=utf-8',
              success: function (response) {
                  //Se chequea así ya que si response.d es NULL.
                  if (response.d) {
                      var array_full = eval('(' + response.d + ')');
                      for (i in array_full) {
                          array_usuarios.push(array_full[i]["_Usuario"]);
                      }
                  }
                  else {
                      //Manejar acá lo de errores.
                  }
              }
          });
          $("#integrantes").autocomplete({
              source: array_usuarios
          });
      });
  </script>