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
                        <input class="form-control" id="_integrantes" />
                    </div>
                </div>
                <div class="col col-md-6">
                    <table id="table">
                        <thead>
                            <tr>
                                <th>Integrantes</th>
                            </tr>
                        </thead>
                        <tbody id="integrantes" class="integrantes">
                            <!-- Se llena por JS cuando se van agregando integrantes -->
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
      var array_usuarios = []; // ARRAY QUE CONTIENE LOS NOMBRES DE USUARIO.
      var array_usuarios_id = []; // ARRAY QUE CONTIENE LOS IDS DE USUARIO.
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
                          array_usuarios_id.push(array_full[i]["Id"]);
                      }
                  }
                  else {
                      //Manejar acá lo de errores.
                  }
              }
          });


          $("#_integrantes").autocomplete({
              source: array_usuarios,
              select: function (event, ui) {
                  //Creo un tr para agregar a la tabla el integrante que ingresó
                  var trIntegrante = document.createElement('tr');
                  trIntegrante.setAttribute('id', 'tr-' + ui.item.value);
                  $('.integrantes').append(trIntegrante);

                  //Creo un td y le pongo el nuevo integrante.
                  var tdIntegrante = document.createElement('td');
                  tdIntegrante.append(ui.item.value);
                  trIntegrante.append(tdIntegrante);
                  
                  var btnEliminar = document.createElement('button');
                  btnEliminar.setAttribute('class', 'btn btn-sm btn-danger eliminarButton');
                  btnEliminar.setAttribute('id', ui.item.value);
                  tdIntegrante.append(btnEliminar);

                  var iTrash = document.createElement('i');
                  iTrash.setAttribute('class', 'fa fa-trash');
                  iTrash.setAttribute('aria-hidden', 'true');
                  btnEliminar.append(iTrash);
              }
          });

          $(document).on('click', '.eliminarButton', function () {
              var value = $(this).attr('id');
              $('#tr-' + value).remove();
          });

      });

      $(document).on('click', '#addButton', function () {
          var array_usuarios_del_grupo = []; // ARRAY CON LOS USUARIOS SELECCIONADOS A AGREGAR.
          var integrantes = document.getElementById('integrantes'); // OBJETO TBODY.
          var tds = integrantes.getElementsByTagName('td'); // OBJETOS TD DENTRO DEL TBODY.
          var cant_usuarios = tds.length;
          for (i = 0; i < cant_usuarios; i++)
          {
              //alert(tds[i].innerHTML.substring(0, tds[i].innerHTML.indexOf('<')));
              array_usuarios_del_grupo.push(tds[i].innerHTML.substring(0, tds[i].innerHTML.indexOf('<'))); //EXTRAIGO EL NOMBRE LOS USUARIOS
          }
          var array_id_usuarios_a_agregar = []; // ARRAY CON LOS IDS DE LOS USUARIOS A AGREGAR AL GRUPO.
          for (j = 0; j < cant_usuarios; j++)
          {
              //alert(array_usuarios_id[array_usuarios.indexOf(array_usuarios_del_grupo[j])]);
              array_id_usuarios_a_agregar.push(array_usuarios_id[array_usuarios.indexOf(array_usuarios_del_grupo[j])]); ///BUSCO EL ID DEL USUARIO.
          }
          var data = {}; // Variable que encapsula.
          data.usuarios = array_id_usuarios_a_agregar.join(","); // EL ARRAY LO PASO A STRING.
          data.nombre = $("#nombre").val(); // PASO EL NOMBRE DEL GRUPO.
          data.administrador_id = array_id_usuarios_a_agregar[0]; // POR DEFECTO EL ADMINISTRADOR ES EL PRIMER USUARIO DE LA LISTA.
          $.ajax({
              type: 'POST',
              url: 'Services/Service.asmx/Set_Grupo',
              contentType: 'application/json;charset=utf-8',
              dataType: 'json',
              data: JSON.stringify(data),
              success: function (response) {
                  alert(response.d);
              }
          });
      });

      
  </script>