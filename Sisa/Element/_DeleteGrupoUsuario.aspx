<!-- Trigger the modal with a button -->
<button type="button" class="btn btn-danger" id="<% Response.Write(grupo.Key);%>" data-toggle="modal" data-target="#myModal"><i class="fas fa-sign-out-alt" data-toggle="tooltip" data-placement="auto" title="Salir del grupo"></i></button>

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Salir del grupo</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <p>Estás seguro que querés salir del grupo?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary deleteButton" data-dismiss="modal">Aceptar</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
      </div>
    </div>

  </div>
</div>


<script type="text/javascript">

    $('.deleteButton').click(function () {
        var data = {};
        data.grupo_id = $(this).attr('id');
        
        $.ajax({
            type: 'POST',
            url: 'Services/Service.asmx/Delete_Grupo_Usuario',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                $('#grupo-' + data.grupo_id).remove();
            }
        });
    });

</script>