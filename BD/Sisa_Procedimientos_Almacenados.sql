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
AS
BEGIN
    SELECT administrador_id FROM Grupos
    WHERE Grupos.id = @v_Grupo_id
END

CREATE PROCEDURE Get_Usuario @v_Usuario varchar(50), @v_Password varchar(50)
AS
BEGIN
    SELECT 1 FROM Usuarios AS U
    WHERE U.usuario = @v_Usuario AND U.password = @v_Password
END

CREATE PROCEDURE Set_Usuario @v_Id int, @v_Usuario varchar(255), @v_Password varchar(255), @v_Email varchar(255)
AS
BEGIN
    INSERT INTO Usuarios(usuario, password, email) VALUES (@v_Usuario, @v_Password, @v_Email)
END

CREATE PROCEDURE Set_Usuario_Grupo @v_Grupo_id int, @v_Usuario_id int
AS
BEGIN
    INSERT INTO Grupos_Usuarios(grupo_id, usuario_id) VALUES (@v_Grupo_id, @v_Usuario_id)
END

CREATE PROCEDURE Set_Sancion @v_Grupo_id int, @v_Usuario_creador_id int, @v_Usuario_sancionado_id int, @v_Motivo varchar(255), @v_Estado int, @v_Fecha_creacion DATETIME
AS
BEGIN
    INSERT INTO Sanciones(grupo_id, usuario_creador_id, usuario_sancionado_id, motivo, estado, fecha_creacion) VALUES (@v_Grupo_id, @v_Usuario_creador_id, @v_Usuario_sancionado_id, @v_Motivo, @v_Estado, @v_Fecha_creacion)
END

        
