CREATE TABLE Usuarios (
    id int NOT NULL PRIMARY KEY,
    email varchar(255),
    password varchar(255),
    usuario varchar(255)
);

CREATE TABLE Grupos (
    id int NOT NULL PRIMARY KEY,
    nombre varchar(255),
    descripcion varchar(255),
    administrador_id int FOREIGN KEY REFERENCES Usuarios(id)
);

CREATE TABLE Grupos_usuarios (
    id int NOT NULL PRIMARY KEY,
    grupo_id int FOREIGN KEY REFERENCES Grupos(id),
    usuario_id int FOREIGN KEY REFERENCES Usuarios(id)
);

CREATE TABLE Sanciones (
    id int NOT NULL PRIMARY KEY,
    grupo_id int FOREIGN KEY REFERENCES Grupos(id),
    usuario_creador_id int FOREIGN KEY REFERENCES Usuarios(id),
    usuario_sancionado_id int FOREIGN KEY REFERENCES Usuarios(id),
    motivo varchar(255),
    estado int,
    fecha_estado DATETIME
);

CREATE TABLE Votos (
    id int NOT NULL PRIMARY KEY,
    usuario_id int FOREIGN KEY REFERENCES Usuarios(id),
    sancion_id int FOREIGN KEY REFERENCES Sanciones(id),
    valor int
);