CREATE DATABASE gimnasio;
USE gimnasio;
CREATE TABLE entrenadores (
    idEntrenador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    especialidad VARCHAR(100),
    estado BOOLEAN DEFAULT TRUE
);
CREATE TABLE clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    estado BOOLEAN DEFAULT TRUE
);
CREATE TABLE asignacionesEntrenadorCliente (
    idAsignacion INT AUTO_INCREMENT PRIMARY KEY,
    idEntrenador INT,
    idCliente INT,
    estado BOOLEAN DEFAULT TRUE,
    
    FOREIGN KEY (idEntrenador) REFERENCES entrenadores(idEntrenador),
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);
CREATE TABLE asistencia (
    idAsistencia INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    fecha DATE,
    
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);
DELIMITER $$

CREATE TRIGGER evitar_doble_entrenador
BEFORE INSERT ON asignacionesEntrenadorCliente
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM asignacionesEntrenadorCliente 
        WHERE idCliente = NEW.idCliente 
        AND estado = TRUE
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente ya tiene un entrenador activo';
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER evitar_asistencia_duplicada
BEFORE INSERT ON asistencia
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM asistencia 
        WHERE idCliente = NEW.idCliente 
        AND fecha = NEW.fecha
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Asistencia duplicada para el mismo día';
    END IF;
END$$

DELIMITER ;
INSERT INTO entrenadores (nombre, especialidad) VALUES
('Juan Perez', 'Pesas'),
('Maria Lopez', 'Cardio');

INSERT INTO clientes (nombre) VALUES
('Carlos'),
('Ana');
INSERT INTO clientes (nombre)
SELECT CONCAT('Cliente_', FLOOR(RAND()*1000))
FROM information_schema.tables
LIMIT 120;
INSERT INTO entrenadores (nombre, especialidad)
SELECT 
    CONCAT('Entrenador_', FLOOR(RAND()*1000)),
    'General'
FROM information_schema.tables
LIMIT 120;
INSERT INTO asignacionesEntrenadorCliente (idEntrenador, idCliente)
SELECT 
    FLOOR(1 + RAND()*10),
    idCliente
FROM clientes
LIMIT 100;
INSERT INTO asistencia (idCliente, fecha)
SELECT 
    idCliente,
    CURDATE()
FROM clientes
LIMIT 100;

SELECT * FROM entrenadores;
SELECT * FROM clientes;
SELECT * FROM asignacionesEntrenadorCliente;
SELECT * FROM asistencia;

SELECT COUNT(*) FROM asistencia;

SELECT * FROM asistencia WHERE idCliente IS NULL;

DELETE FROM asistencia WHERE idCliente IS NULL;

INSERT INTO asignacionesEntrenadorCliente (idEntrenador, idCliente)
VALUES (1, 1);

INSERT INTO asistencia (idCliente, fecha)
VALUES (1, CURDATE());





