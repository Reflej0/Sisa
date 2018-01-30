CREATE PROCEDURE Get_Grupos
AS
BEGIN
    SELECT id, nombre, descripcion, administrador_id FROM Grupos
END

CREATE PROCEDURE Get_Usuarios_Grupo @v_Grupo_id int
AS
BEGIN
    SELECT U.id, U.usuario, U.password, U.email FROM Usuarios AS U
    INNER JOIN Grupos_usuarios AS GU
    ON U.id = GU.usuario_id
    WHERE GU.grupo_id = @v_Grupo_id
END

CREATE PROCEDURE Get_Sancion_Usuario @v_Usuario_id int
AS
BEGIN
    SELECT S.id, S.grupo_id, S.usuario_creador_id, S.usuario_sancionado_id, S.motivo, S.estado, S.fecha_creacion FROM Sanciones AS S
    INNER JOIN Usuarios AS U
    ON S.usuario_sancionado_id = U.id
    WHERE U.id = @v_Usuario_id
END

CREATE PROCEDURE Get_Administrador_Grupo @v_Grupo_id int
BEGIN
    SELECT administrador_id FROM Grupos
    WHERE Grupos.id = @v_Grupo_id
END



        
