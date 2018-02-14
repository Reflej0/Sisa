CREATE PROCEDURE Get_Grupos
AS
BEGIN
    SELECT id, nombre, descripcion, administrador_id FROM Grupos
END

CREATE PROCEDURE Get_Usuarios
AS
BEGIN
    SELECT id, usuario, email, password FROM Usuarios
END

CREATE PROCEDURE Get_Usuarios_Grupo @v_Grupo_id int
AS
BEGIN
    SELECT U.id, U.usuario, U.password, U.email FROM Usuarios AS U
    INNER JOIN Grupos_usuarios AS GU
    ON U.id = GU.usuario_id
    WHERE GU.grupo_id = @v_Grupo_id
END

CREATE PROCEDURE Get_Sancion_Usuario @v_Usuario_id int, @v_Grupo_id int
AS
BEGIN
    SELECT S.id, S.grupo_id, S.usuario_creador_id, S.usuario_sancionado_id, S.motivo, S.estado, S.fecha_creacion FROM Sanciones AS S
    INNER JOIN Usuarios AS U
    ON S.usuario_sancionado_id = U.id
    WHERE U.id = @v_Usuario_id
    AND S.grupo_id = @v_Grupo_id
    AND S.estado = 2
END

CREATE PROCEDURE Get_Administrador_Grupo @v_Grupo_id int
AS
BEGIN
    SELECT administrador_id FROM Grupos
    WHERE Grupos.id = @v_Grupo_id
END

CREATE PROCEDURE Get_Grupos_Usuario @v_Usuario_id int
AS
BEGIN
    SELECT G.id, G.nombre, G.descripcion, G.administrador_id FROM Grupos AS G
    INNER JOIN Grupos_usuarios AS GU
    ON G.id = GU.grupo_id
    WHERE GU.usuario_id = @v_Usuario_id
END

CREATE PROCEDURE Get_Usuario @v_Usuario varchar(50), @v_Password varchar(50)
AS
BEGIN
    SELECT U.id FROM Usuarios AS U
    WHERE U.usuario = @v_Usuario AND U.password = @v_Password
END

CREATE PROCEDURE Get_Usuario_Email @v_Usuario varchar(50), @v_Email varchar(50)
AS
BEGIN
    SELECT 1 FROM Usuarios AS U
    WHERE U.usuario = @v_Usuario AND U.email = @v_Email
END


CREATE PROCEDURE Get_Password_Email @v_Usuario varchar(50), @v_Email varchar(50)
AS
BEGIN
    SELECT U.password FROM Usuarios AS U
    WHERE U.usuario = @v_Usuario AND U.email = @v_Email
END

CREATE PROCEDURE Get_Sanciones_Activas_Grupos @v_Grupo_id int, @v_Hoy date, @v_Ayer date
AS
BEGIN
    SELECT S.id, S.grupo_id, S.usuario_creador_id, S.usuario_sancionado_id, S.motivo, S.estado, S.fecha_creacion
    FROM Sanciones AS S
    WHERE S.grupo_id = @v_Grupo_id
    AND S.estado = 1 AND (S.fecha_creacion BETWEEN @v_Ayer AND @v_Hoy)
END

CREATE PROCEDURE Get_Sanciones_Activas_Grupos_Usuario @v_Grupo_id int, @v_Usuario_id int, @v_Hoy date, @v_Ayer date
AS
BEGIN
    SELECT S.id, S.grupo_id, S.usuario_creador_id, S.usuario_sancionado_id, S.motivo, S.estado, S.fecha_creacion
    FROM Sanciones AS S
    LEFT JOIN Votos AS V
    ON S.id = V.sancion_id
    WHERE S.grupo_id = @v_Grupo_id AND S.id NOT IN (SELECT sancion_id FROM Votos WHERE usuario_id = @v_Usuario_id)
AND S.estado = 1 AND (S.fecha_creacion BETWEEN @v_Ayer AND @v_Hoy)
END

CREATE PROCEDURE Get_Grupo_Determinado_Usuario @v_Usuario_id int
AS
BEGIN
    SELECT TOP 1 G.id, G.nombre, G.descripcion, G.administrador_id
    FROM Grupos AS G
    INNER JOIN Grupos_Usuarios AS GU
    ON G.id = GU.grupo_id
    WHERE GU.usuario_id = @v_Usuario_id
END

CREATE PROCEDURE Get_Cantidad_Sanciones_Usuarios_Grupo @v_Grupo_id int
AS
BEGIN
    SELECT U.usuario, COUNT(*) AS cant
    FROM Sanciones AS S
	INNER JOIN Usuarios AS U ON U.id = S.usuario_sancionado_id
    WHERE S.grupo_id = @v_Grupo_id
	GROUP BY U.usuario
	ORDER BY cant
END

CREATE PROCEDURE Get_Nombre_Usuario @v_Usuario_id int
AS
BEGIN
    SELECT usuario FROM Usuarios AS U
    WHERE U.id = @v_Usuario_id
END

CREATE PROCEDURE Get_Votos_Sanciones @v_Sancion_id int
AS
BEGIN
	SELECT COUNT(V.id) FROM Votos AS V
	INNER JOIN Sanciones AS S
	ON V.sancion_id = S.id
	WHERE V.valor = 1 AND S.id = @v_Sancion_id
END

CREATE PROCEDURE Get_Cant_Usuarios_Grupos @v_Grupo_id int
AS
BEGIN
	SELECT COUNT(GU.id) FROM Grupos_Usuarios AS GU
	WHERE GU.grupo_id = @v_Grupo_id
END

CREATE PROCEDURE Set_Usuario @v_Usuario varchar(255), @v_Password varchar(255), @v_Email varchar(255)
AS
BEGIN
    INSERT INTO Usuarios(usuario, password, email) VALUES (@v_Usuario, @v_Password, @v_Email)
    SELECT SCOPE_IDENTITY()
END

CREATE PROCEDURE Set_Grupo @v_Nombre varchar(255), @v_Descripcion varchar(255), @v_Administrador_id int
AS
BEGIN
    INSERT INTO Grupos(nombre, descripcion, administrador_id) VALUES (@v_Nombre, @v_Descripcion, @v_Administrador_id)
    SELECT SCOPE_IDENTITY()
END

CREATE PROCEDURE Set_Usuario_Grupo @v_Grupo_id int, @v_Usuario_id int
AS
BEGIN
    INSERT INTO Grupos_Usuarios(grupo_id, usuario_id) VALUES (@v_Grupo_id, @v_Usuario_id)
    SELECT SCOPE_IDENTITY()
END

CREATE PROCEDURE Set_Sancion @v_Grupo_id int, @v_Usuario_creador_id int, @v_Usuario_sancionado_id int, @v_Motivo varchar(255), @v_Estado int, @v_Fecha_creacion DATETIME
AS
BEGIN
    INSERT INTO Sanciones(grupo_id, usuario_creador_id, usuario_sancionado_id, motivo, estado, fecha_creacion) VALUES (@v_Grupo_id, @v_Usuario_creador_id, @v_Usuario_sancionado_id, @v_Motivo, @v_Estado, @v_Fecha_creacion)
    SELECT SCOPE_IDENTITY()
END

CREATE PROCEDURE Update_Sancion @v_Sancion_id int
AS
BEGIN
	UPDATE Sanciones SET estado = 2 WHERE Sanciones.id = @v_Sancion_id
END

CREATE PROCEDURE Delete_Grupo_Usuario @v_Usuario_id int, @v_Grupo_id int
AS
BEGIN
	DELETE FROM Grupos_Usuarios 
	WHERE grupo_id = @v_Grupo_id AND usuario_id = @v_Usuario_id
END
