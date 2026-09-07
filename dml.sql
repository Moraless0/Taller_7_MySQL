-- =============================================
-- TALLER 7 - VETERINARIA (DML)
-- Inserción de datos de prueba (10 por tabla)
-- =============================================

USE veterinaria;

INSERT INTO clientes (nombre, direccion, correoElectronico, activo) VALUES
('Juan Perez', 'Calle 10 #5-20', 'juan@gmail.com', 1),
('Maria Lopez', 'Carrera 7 #12-30', 'maria@gmail.com', 1),
('Carlos Ruiz', 'Calle 5 #8-15', 'carlos@gmail.com', 1),
('Ana Torres', 'Avenida 3 #4-10', 'ana@gmail.com', 0),
('Luis Gomez', 'Calle 20 #1-50', 'luis@gmail.com', 1),
('Sofia Diaz', 'Carrera 15 #6-40', 'sofia@gmail.com', 1),
('Pedro Mora', 'Calle 8 #9-25', 'pedro@gmail.com', 0),
('Laura Castro', 'Avenida 11 #3-60', 'laura@gmail.com', 1),
('Diego Rojas', 'Calle 30 #2-45', 'diego@gmail.com', 1),
('Camila Vega', 'Carrera 2 #14-80', 'camila@gmail.com', 1);

INSERT INTO mascotas (ID_Cliente, nombre, nPatas, estatura) VALUES
(1, 'Firulais', 4, 0.60),
(1, 'Rocky', 4, 0.45),
(2, 'Michi', 4, 0.25),
(3, 'Luna', 4, 0.35),
(4, 'Toby', 4, 0.55),
(5, 'Coco', 4, 0.30),
(6, 'Nala', 4, 0.70),
(7, 'Max', 4, 0.50),
(8, 'Kira', 4, 0.40),
(9, 'Piolin', 2, 0.15);

INSERT INTO servicios (nombre, precio) VALUES
('Consulta general', 50),
('Vacuna', 35),
('Baño', 25),
('Peluqueria', 40),
('Desparasitacion', 30),
('Cirugia menor', 200),
('Radiografia', 80),
('Limpieza dental', 60),
('Esterilizacion', 150),
('Guarderia', 20);

INSERT INTO mascota_servicio (ID_Mascota, ID_Servicio, fecha) VALUES
(1, 1, '2025-01-10'),
(2, 2, '2025-01-11'),
(3, 3, '2025-01-12'),
(4, 4, '2025-01-13'),
(5, 5, '2025-01-14'),
(6, 1, '2025-01-15'),
(7, 6, '2025-01-16'),
(8, 7, '2025-01-17'),
(9, 8, '2025-01-18'),
(10, 9, '2025-01-19');