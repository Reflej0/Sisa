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
    <!-- #include file="~/Element/_Navbar.aspx" -->

    <!-- Contenido -->
    <div class="container-fluid pagina-contenido">
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
                        <tbody class="integrantes">
                            
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

    <!-- #include file="~/Element/_Footer.aspx" -->
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
              source: array_usuarios,
              select: function (event, ui) {
                  //Creo un tr para agregar a la tabla el integrante que ingresó
                  var trIntegrante = document.createElement('tr');
                  $('.integrantes').append(trIntegrante);

                  //Creo un td y le pongo el nuevo integrante.
                  var tdIntegrante = document.createElement('td');
                  tdIntegrante.append(ui.item.value);
                  trIntegrante.append(tdIntegrante);
              }
          });
      });
  </script>