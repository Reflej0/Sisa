<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editarGrupo.aspx.cs" Inherits="Sisa.EditarGrupo" %>

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
    <div class=" container-fluid pagina-contenido">
        <div style="display: block">
            <div class="titulo-formulario">
                <h3>Editar grupo</h3>
                <br />
            </div>
            <div>
                <div class="form-group col col-md-6">
                    <div>
                        <p>Nombre grupo: </p>
                        <input class="form-control" type="text" runat="server" id="nombre"/>
                        <div class="error text-center" id="error-nombre"></div>

                    </div>
                    
                    <div>
            
                        <p>Descripción: </p>
                        <input class="form-control" id="descrip"/>
                        <div class="error text-center" id="error-descrip"></div>

                    </div>

                    <div>
            
                        <p>Administrador: </p>
                        <select class="form-control" style="height: 34px" id="admin"></select>
                    </div>

                    <hr />
                    <div>
                        <p>Agregar usuario: </p>
                        <input class="form-control" id="usuario"/>
                    </div>
                </div>

                <div class="form-group col col-md-6">
                    <h4>Integrantes</h4>
                    <table id="table">
                        <thead>
                            <tr>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="integrantes" class="integrantes">
                                <!-- Se llena por JS cuando se van agregando integrantes -->
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
        <div class="text-center" style="clear:both">
            <hr />
            <button type="button" title="Guardar" class="btn btn-success" id="saveButton">Guardar <i class="fas fa-pen-square"></i></button>
        </div>
    </div>
</body>
</html>

<script type="text/javascript">

    var listaIntegrOrig = [];
    var adminActual = {};
    var indiceAdminActual = {};
    var listaUsuarios = [];
    var regex = /^[a-z0-9 ]+$/i;
    var flagNombre = true;
    var flagDescr = true;

    $(document).ready(function () {

        var data = {};
        //data.grupo_id = =var_id_grupo%>;
        var o = {};
        var listaIntegr = {};
        var tempUsuarios = {};
        var listaIdUsuario = [];

        var grupo = {};
        grupo = <%=grupoString%>;
        $('#nombre').val(grupo.Nombre);
        $('#descrip').val(grupo.Descripcion);

        listaIntegr = <%=integrOrig%>;
        console.log(<%=integrOrig%>);
        console.log(listaIntegr);
        indiceAdminActual = grupo.Administrador_id;

        for (var x in listaIntegr) {
            if (listaIntegr[x].Id == grupo.Administrador_id) {
                adminActual = listaIntegr[x]._Usuario;
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
            trIntegrante.setAttribute('id', 'tr-' + listaIntegr[x].Id + '-' + listaIntegr[x]._Usuario);
            $('#integrantes').append(trIntegrante);

            //le agrego una columna para ícono:
            var tdAdmin = document.createElement('td');
            tdAdmin.setAttribute('style', 'width: 5px');
            trIntegrante.append(tdAdmin);

            //agrego columna para nombre.
            var tdIntegrante = document.createElement('td');
            tdIntegrante.append(listaIntegr[x]._Usuario);
            trIntegrante.append(tdIntegrante);

            //si no es admin, agrego los botones:
            if (listaIntegr[x].Id != grupo.Administrador_id) {

                //agrego columna para botón "Eliminar".
                var tdEliminar = document.createElement('td');

                //creo botón "Eliminar"
                var btnEliminar = document.createElement('button');
                btnEliminar.setAttribute('class', 'btn btn-sm btn-danger eliminarButton');
                btnEliminar.setAttribute('id', listaIntegr[x].Id + '-' + listaIntegr[x]._Usuario);
                //agrego elementos
                tdEliminar.append(btnEliminar);
                trIntegrante.append(tdEliminar);

                //agrego ícono.
                var iTrash = document.createElement('i');
                iTrash.setAttribute('class', 'fa fa-trash');
                iTrash.setAttribute('aria-hidden', 'true');
                btnEliminar.append(iTrash);
            } else {

                //agrego ícono de admin:
                var iQueen = document.createElement('i');
                iQueen.setAttribute('class', 'iconoAdmin fas fa-chess-queen');
                iQueen.setAttribute('aria-hidden', 'true');

                tdAdmin.append(iQueen);
            }
        }

        tempUsuarios = <%=usuarios%>;
        for (var x in tempUsuarios) {
            listaUsuarios.push(tempUsuarios[x]._Usuario);
            listaIdUsuario.push(tempUsuarios[x].Id);
        }

        //autocomplete de todos los usuarios.
        $('#usuario').autocomplete({
            source: listaUsuarios,
            select: function (event, ui) {

                var indice = listaUsuarios.indexOf(ui.item.value);
                var idTr = 'tr-' + listaIdUsuario[indice] +'-' + ui.item.value;
                var elemExistente = document.getElementById(idTr);

                //si no existe un elemento con ese id, se puede agregar al grupo.
                if (elemExistente == null) {

                    //creo una fila.
                    var trIntegrante = document.createElement('tr');
                    trIntegrante.setAttribute('id', 'tr-' + listaIdUsuario[indice] + '-' + ui.item.value);
                    $('#integrantes').append(trIntegrante);

                    //le agrego una columna para ícono:
                    var tdAdmin = document.createElement('td');
                    tdAdmin.setAttribute('style', 'width: 5px');
                    trIntegrante.append(tdAdmin);

                    //le agrego una columna para el nombre:
                    var tdIntegrante = document.createElement('td');
                    tdIntegrante.append(ui.item.value);
                    trIntegrante.append(tdIntegrante);

                    //agrego el botón "Eliminar"
                    var tdEliminar = document.createElement('td');
                    var btnEliminar = document.createElement('button');
                    btnEliminar.setAttribute('class', 'btn btn-sm btn-danger eliminarButton');
                    btnEliminar.setAttribute('id', listaIdUsuario[indice] + '-' + ui.item.value);
                    tdEliminar.append(btnEliminar);
                    trIntegrante.append(tdEliminar);

                    var iTrash = document.createElement('i');
                    iTrash.setAttribute('class', 'fa fa-trash');
                    iTrash.setAttribute('aria-hidden', 'true');
                    btnEliminar.append(iTrash);

                    $('#admin').append('<option value="' + listaIdUsuario[indice] + '">' + ui.item.value + '</option>');

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
        $('#tr-' + value).remove();
        var id = value.split('-')[0];

        //lo elimino del select de admins.
        $('#admin option[value=' + id + ']').remove();

    });

    $('#saveButton').click(function () {
        //guardo los datos y después vuelvo a mis grupos.
        //acá va el ajax para modificar los datos, 
        //dentro del success, vuelve a "misGrupos.aspx".

        var listaIntegrsFinal = [];
        var algo = document.getElementsByTagName("tr");

        for (var x in algo) {
            var al = algo[x];
            if (x > 0) {
                listaIntegrsFinal[x - 1] = algo[x].getAttribute("id").split("-")[1];
            }              
        }

        var dataGrupo = {};
        dataGrupo.grupo_id = 2;
        dataGrupo.nombre = $("#nombre").val();
        dataGrupo.descripcion = $("#descrip").val();
        dataGrupo.admin_id = $("#admin :selected").val();

        dataGrupo.listaIntegrOrig = listaIntegrOrig;
        dataGrupo.listaIntegrsFinal = listaIntegrsFinal;

        console.log(listaIntegrOrig);
        console.log(listaIntegrsFinal);

        
        if (flagNombre && flagDescr && dataGrupo.admin_id != null && listaIntegrOrig.length > 0 && listaIntegrsFinal.length > 0) {
           $.ajax({
                type: 'POST',
                url: 'Services/Service.asmx/Update_Grupo',
                dataType: 'json',
                data: JSON.stringify(dataGrupo),
                contentType: 'application/json;charset=utf-8',
                success: function (response) {
                    window.location.replace("/misGrupos.aspx");
                },
                error: function () {
                    alert(response.d);
                }

            });
        } else {
            alert("NO ENTROO!");
        }
    });

    $('#admin').change(function () {
        
        //en este punto var admin tiene el anterior:
        //remuevo el ícono:

        $('.iconoAdmin').remove();

        //agrego botón:
        //el indice lo tengo del aterior: 
        
        var trIntegrante = document.getElementById('tr-' + indiceAdminActual + '-' + adminActual);
        
        var tdEliminar = document.createElement('td');

        var btnEliminar = document.createElement('button');
        btnEliminar.setAttribute('class', 'btn btn-sm btn-danger eliminarButton');

        btnEliminar.setAttribute('id', indiceAdminActual + '-' + adminActual);
        tdEliminar.append(btnEliminar);
        trIntegrante.append(tdEliminar);

        var iTrash = document.createElement('i');
        iTrash.setAttribute('class', 'fa fa-trash');
        iTrash.setAttribute('aria-hidden', 'true');
        btnEliminar.append(iTrash);

        //ahora lo vuelvo a cambiar porque SI es el actual.
        indiceAdminActual = $('#admin option:selected').val();
        adminActual = $('#admin option:selected').text();

        //ahora agrego corona y quito botón:
        //remuevo botón:
        $('#' + indiceAdminActual + '-' + adminActual).parent().remove();

        var tr = $('#' + 'tr-' + indiceAdminActual + '-' + adminActual +' td');
        
        var iQueen = document.createElement('i');
        iQueen.setAttribute('class', 'iconoAdmin fas fa-chess-queen');
        iQueen.setAttribute('aria-hidden', 'true');
        tr.first().append(iQueen);
    })

    //faltan las validaciones:
    $('#nombre').change(function () {

        if ($('#nombre').val().search(/^[a-z0-9 ]+$/i) >= 0) {
            flagNombre = true;
            $("#error-nombre").hide();

        } else {
            flagNombre = false;
            $("#error-nombre").html("Debe ingresar caractéres válidos");
            $("#error-nombre").show();

        }
    });

    $('#descrip').change(function () {

        if ($('#descrip').val().search(/^[a-z0-9 ]+$/i) >= 0) {
            flagDescr = true;
            $("#error-descrip").hide();
        } else {
            flagDescr = false;
            $("#error-descrip").html("Debe ingresar caractéres válidos");
            $("#error-descrip").show();
        }
    });

    $('#Salir').click(function () {
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Logout',
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                window.location.href = "Login.aspx";
            }
        });
    });
</script>



