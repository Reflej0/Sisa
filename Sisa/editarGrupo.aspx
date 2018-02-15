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
    <link href="CSS/estilos.css" rel="stylesheet" />
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
            
            <p>Nombre grupo: </p>
            <input class="form-control" id="nombre"/>

        </div>
        <div>
            
            <p>Descripción: </p>
            <input class="form-control" id="descrip"/>

        </div>
        <div>
            
            <p>Administrador: </p>
            <select class="form-control" id="admin">

            </select>

        </div>
        <hr />
        <div>
            <p>Agregar usuario: </p>
            <input class="form-control" id="usuario"/>
        </div>
    </div>

</body>
</html>

<script type="text/javascript">
    $(document).ready(function () { 
        var data = {};
        data.grupo_id = 1;
        var o = {};
        var listaIntegr = {};
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
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Usuarios_Grupos',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                listaIntegr = JSON.parse(response.d);
                //alert(response.d);
                //var arrayIntegr = [];
                for (var x in listaIntegr) {
                    if (listaIntegr[x].Id == o.Administrador_id) {
                        $('#admin').append('<option value="' + listaIntegr[x].Id + '" selected>' + listaIntegr[x]._Usuario + '</option>');
                    } else {
                        $('#admin').append('<option value="' + listaIntegr[x].Id + '">' + listaIntegr[x]._Usuario + '</option>');
                    }
                }
            }
        });
        var listaUsuarios = [];
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Get_Usuarios',
            dataType: 'json',
            data: JSON.stringify(),
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                var tempUsuarios = JSON.parse(response.d);
                //alert(response.d);
                //alert(tempUsuarios[0]);
                for (var x in tempUsuarios) {
                    listaUsuarios.push(tempUsuarios[x]._Usuario);
                }
            }
        });
        $('#usuario').autocomplete({
            source: listaUsuarios
        })
       /* $('#usuario').autocomplete({
            source: listaUsuarios
        })  */          
    })

</script>

<!-- Voy a buscar el nombre de grupo, la lista de  integrantes y los integrantes del grupo
    para esto tengo que: crear método Get_Grupo. Empiezo por esto [o] Listo!
    para los integrantes del grupo uso: Get_Usuarios_Grupo [o] Listo!
    para obtener todos los integrantes: Get_Usuarios (Ahora tengo que traer todos los usuarios :(

    -->