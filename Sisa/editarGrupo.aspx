<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editarGrupo.aspx.cs" Inherits="Sisa.editarGrupo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>SiSa</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    <script src="JS/jquery-3.2.1.min.js"></script>
    <script src="JS/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <link href="CSS/estilos.css" rel="stylesheet" />
    <style>
        td{padding: 5px;}
    </style>
</head>

<body>
    <!-- #include file="~/Element/_Navbar.aspx" -->

    <!-- Contenido -->
    <div class="pagina-contenido">
        <div class="titulo-formulario">
            <h3>Editar grupo</h3>
            <br/>
        </div>
        <div>
            <div class="form-group col col-md-6">
            
                <div>
            
                    <p>Nombre grupo: </p>
                    <input class="form-control" id="nombre"/>

                </div>
                <div>
            
                    <p>Descripción: </p>
                    <input class="form-control" id="descrip"/>

                </div>
                <div>
            
                    <p>Administrador: </p>
                    <select class="form-control" style="height: 34px" id="admin">

                    </select>
                </div>
                <hr />
                <div>
                    <p>Agregar usuario: </p>
                    <input class="form-control" id="usuario"/>
                </div>
            </div>

            <div class="form-group col col-md-6">
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
                <button type="button" title="Guardar" class="btn btn-success" id="saveButton">Guardar <i class="fas fa-pen-square"></i></button>
        </div>
    </div>

</body>
</html>

<script type="text/javascript">

    var listaIntegrOrig = [];

    $(document).ready(function () {
        var data = {};
        data.grupo_id = 2;
        var o = {};
        var listaIntegr = {};
        //obtengo datos del grupo:
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Grupo',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
            success: function (e) {
                //alert(e);
                o = JSON.parse(e.d);
                $('#nombre').val(o.Nombre);
                $('#descrip').val(o.Descripcion);
            }
        });

        //obtengo los integrantes del grupo para mostrar y seleccionar al administrador.
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Usuarios_Grupos',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                listaIntegr = JSON.parse(response.d);

                //muestro en la lista los integrantes y el Admin queda seleccionado.
                for (var x in listaIntegr) {
                    if (listaIntegr[x].Id == o.Administrador_id) {
                        $('#admin').append('<option value="' + listaIntegr[x].Id + '" selected>' + listaIntegr[x]._Usuario + '</option>');
                    } else {
                        $('#admin').append('<option value="' + listaIntegr[x].Id + '">' + listaIntegr[x]._Usuario + '</option>');
                    }
                    //esta lista es auxiliar para mandar los datos y saber quién quedó agregado al final.
                    listaIntegrOrig[x] = listaIntegr[x].Id;
                }
                //luego cargo todos los integrantes en la columna "Integrantes"
                for (var x in listaIntegr) {

                    //creo una fila.
                    var trIntegrante = document.createElement('tr');
                    trIntegrante.setAttribute('id', 'tr-' + listaIntegr[x].Id +'-' + listaIntegr[x]._Usuario);
                    $('#integrantes').append(trIntegrante);

                    //le agrego una columna:
                    var tdIntegrante = document.createElement('td');
                    //tdIntegrante.setAttribute('class', 'integrantes');
                    tdIntegrante.append(listaIntegr[x]._Usuario);
                    trIntegrante.append(tdIntegrante);

                    //tengo que agregar el botón "Eliminar"
                    var tdEliminar = document.createElement('td');
                    //tdEliminar.setAttribute('class', 'integrantes');
                    var btnEliminar = document.createElement('button');
                    btnEliminar.setAttribute('class', 'btn btn-sm btn-danger eliminarButton');
                    btnEliminar.setAttribute('id', listaIntegr[x].Id+'-'+ listaIntegr[x]._Usuario);
                    tdEliminar.append(btnEliminar);
                    trIntegrante.append(tdEliminar);
                    
                    var iTrash = document.createElement('i');
                    iTrash.setAttribute('class', 'fa fa-trash');
                    iTrash.setAttribute('aria-hidden', 'true');
                    btnEliminar.append(iTrash);
                } 
            }
        });
        //listo los usuarios existentes en el sistema.
        var listaUsuarios = [];
        var tempUsuarios = {};
        var listaIdUsuario = [];
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Usuarios',
            dataType: 'json',
            data: JSON.stringify(),
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                tempUsuarios = JSON.parse(response.d);
                //alert(response.d);
                //alert(tempUsuarios[0]);
                for (var x in tempUsuarios) {
                    listaUsuarios.push(tempUsuarios[x]._Usuario);
                    listaIdUsuario.push(tempUsuarios[x].Id);
                }
           }
        });
        //autocomplete de todos los usuarios.
        $('#usuario').autocomplete({
            source: listaUsuarios,
            select: function (event, ui) {
                var indice = listaUsuarios.indexOf(ui.item.value);
                alert(listaIdUsuario[indice]);
                var idTr = 'tr-' + listaIdUsuario[indice] +'-' + ui.item.value;

                var elemExistente = document.getElementById(idTr);
                //si no existe un elemento con ese id, se puede agregar al grupo.
                if (elemExistente == null) {
                    //creo una fila.
                    var trIntegrante = document.createElement('tr');
                    trIntegrante.setAttribute('id', 'tr-' + listaIdUsuario[indice] + '-' + ui.item.value);
                    $('#integrantes').append(trIntegrante);

                    //le agrego una columna:
                    var tdIntegrante = document.createElement('td');
                    //tdIntegrante.setAttribute('class', 'integrantes');
                    tdIntegrante.append(ui.item.value);
                    trIntegrante.append(tdIntegrante);

                    //tengo que agregar el botón "Eliminar"
                    var tdEliminar = document.createElement('td');
                    //tdEliminar.setAttribute('class', 'integrantes');
                    var btnEliminar = document.createElement('button');
                    btnEliminar.setAttribute('class', 'btn btn-sm btn-danger eliminarButton');
                    btnEliminar.setAttribute('id', listaIdUsuario[indice] + '-' + ui.item.value);
                    tdEliminar.append(btnEliminar);
                    trIntegrante.append(tdEliminar);

                    var iTrash = document.createElement('i');
                    iTrash.setAttribute('class', 'fa fa-trash');
                    iTrash.setAttribute('aria-hidden', 'true');
                    btnEliminar.append(iTrash);
                }
                else {
                    //informo el error:
                    alert("El usuario que desea agregar ya pertenece al grupo");
                }
            }
        });
    });
    $(document).on('click', '.eliminarButton', function () {
        var value = $(this).attr('id');
        alert(value);
        $('#tr-' + value).remove();
    });
    $('#saveButton').click(function () {
        //guardo los datos y después vuelvo a mis grupos.
        //acá va el ajax para modificar los datos, 
        //dentro del success, vuelve a "misGrupos.aspx".
        //primero genero una lista con los integrantes agregados:

        var listaIntegrsFinal = [];

        //var algo = {};
        var algo = document.getElementsByTagName("tr");
        
        for (var x in algo) {
            if (x > 0) {
                listaIntegrsFinal[x-1] = algo[x].getAttribute("id").split("-")[1];
                console.log(listaIntegrsFinal[x-1]);
            }    
        }
        var dataGrupo = {};
        dataGrupo.grupo_id = 1;
        dataGrupo.nombre = $("#nombre").val();
        dataGrupo.descripcion = $("#descrip").val();
        dataGrupo.admin_id = $("#admin :selected").val();
        dataGrupo.listaIntegrOrig = listaIntegrOrig;
        dataGrupo.listaIntegrsFinal = listaIntegrsFinal;
        console.log(dataGrupo.listaIntegrsFinal);
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Update_Grupo',
            dataType: 'json',
            data: JSON.stringify(dataGrupo),
            contentType: 'application/json;charset=utf-8',
            success: function () {
                alert("funciono!");
              //  window.location.replace("/misGrupos.aspx");
            },
            error: function () {
                alert("ha fallao en modificar el grupo D:");
            }
            //vuelvo a misgrupoz
        });



//REVISAR DESDE ACÁ
        /*for (var x in listatmp) {
            listaIntegrsFinal[x] = listatmp[x].getAttribute("id");
        }*/
        /*
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Usuarios_Grupos',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
        });*/

    });

</script>

<!-- Voy a buscar el nombre de grupo, la lista de  integrantes y los integrantes del grupo
    para esto tengo que: crear método Get_Grupo. Empiezo por esto [o] Listo!
    para los integrantes del grupo uso: Get_Usuarios_Grupo [o] Listo!
    para obtener todos los integrantes: Get_Usuarios [o] Listo!

    -->