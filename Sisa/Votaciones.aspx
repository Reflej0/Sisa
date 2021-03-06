﻿<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Votaciones.aspx.cs" Inherits="Sisa.Votaciones" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <!-- Contenido -->
    <div class="container pagina-contenido">
        <div class="titulo-formulario">
            <h3>Sanciones Pendientes</h3>
        </div>
        <br />
        <div class="form-group separacionFooter">
            <%if (StringSanciones.Count.Equals(0))
                {%>
            <div class="text-center">
                <img class="img-responsive pull-left altura-error" src="img/errorLogo.png" />
                <h3 class="pull-right d-inline">No hay sanciones pendientes</h3>
            </div>
            <%}
                else
                {%>
            <table id="resultados" class="table table-hover text-center">
                <thead>
                    <tr>
                        <th>Grupo</th>
                        <th>Nombre</th>
                        <th>Motivo</th>
                        <th>Si</th>
                        <th>No</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <% try
                            {
                                foreach (List<string> item in StringSanciones)
                                {%>
                        <input type="hidden" id="grupo_id" value="<% Response.Write(item[0]);%>" />
                        <tr id="row-<% Response.Write(item[3]);%>">
                            <td><% Response.Write(Grupos[Convert.ToInt32(item[0])]);%></td>
                            <td><% Response.Write(item[1]);%></td>

                            <td><% Response.Write(item[2]);%></td>

                            <td>
                                <button class="btn btn-success" name="1" onclick="Votar(this.id, this.name)" id="<% Response.Write(item[3]);%>"><i class="fas fa-check"></i></button>
                            </td>
                            <td>
                                <button class="btn btn-danger" name="0" onclick="Votar(this.id, this.name)" id="<% Response.Write(item[3]);%>"><i class="fas fa-times"></i></button>
                            </td>
                            <%
                                }%>
                        </tr>
                        <%}
                            catch (Exception e)
                            {
                                Console.WriteLine(e);
                            }%>
                    </tr>
                </tbody>
            </table>
            <%}%>
            <div id="divNoSanciones" class="text-center d-none">
                <img class="img-responsive pull-left altura-error" src="img/errorLogo.png" />
                <h3 class="pull-right d-inline">No hay sanciones pendientes</h3>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content contenido-modal">
                <div class="modal-header titulo-modal ">
                    <h4 class="modal-title" id="myModalLabel"><i class="fas fa-info-circle"></i>Información </h4>
                </div>
                <div class="modal-body">
                    <label id="mensajeModal"></label>
                </div>
                <div class="modal-footer">
                    <button id="cerrarButton" type="button" class="btn btn-outline-dark" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
    <script type="text/javascript">
        /*$(':radio').each(function () { DEBUG
            alert($(this).val());
            alert($(this).attr('id'));
        });*/
        function Votar(sancion_id, si_no) {
            var data = {}; // Variable que encapsula.
            data.voto_valor = si_no; // Los checkbox tienen un atributo si_no. si_no = 1 es Voto a Favor.
            data.sancion_id = sancion_id // Obtengo el id de la sanción.
            data.grupo_id = $("#grupo_id").val(); // Obtengo el id del grupo.
            $.ajax({
                type: 'POST',
                url: 'Services/Service.asmx/Set_Voto_Sancion',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function (response) {
                    $("#cerrarButton").attr("name", sancion_id)
                    $("#basicModal").modal('show');
                    $("#mensajeModal").text(response.d);
                }
            });
        }

        function hide_row_event(sancion_id) {
            $("#row-" + sancion_id).fadeOut();
            $("#row-" + sancion_id).fadeOut("slow");
            $("#row-" + sancion_id).fadeOut(3000);

        }

        $('#basicModal').on('hidden.bs.modal', function () {
            var sancion_id = $("#cerrarButton").attr("name");
            hide_row_event(sancion_id);
            //Cuento la cantida de sanciones visibles
            var count = $('tbody>tr:visible').length - 2;

            if (count === 0) {
                $("#resultados").addClass("d-none");
                $("#divNoSanciones").removeClass("d-none");
            }
        })

        $("#cerrarButton").on("click", function () {
            var sancion_id = $(this).attr("name");
            hide_row_event(sancion_id);
        });

    </script>
</asp:Content>
