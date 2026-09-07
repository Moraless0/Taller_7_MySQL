-- =============================================
-- TALLER 7 - VETERINARIA (DDL)
-- Creación de la base de datos y tablas
-- =============================================

DROP DATABASE IF EXISTS veterinaria;
CREATE DATABASE veterinaria;
USE veterinaria;

CREATE TABLE clientes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    correoElectronico VARCHAR(100),
    activo TINYINT(1) DEFAULT 1
);

CREATE TABLE mascotas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    nombre VARCHAR(20),
    nPatas INT,
    estatura FLOAT,
    FOREIGN KEY (ID_Cliente) REFERENCES clientes(ID)
);

CREATE TABLE servicios (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2)
);

CREATE TABLE mascota_servicio (
    ID_Mascota INT,
    ID_Servicio INT,
    fecha DATE,
    PRIMARY KEY (ID_Mascota, ID_Servicio, fecha),
    FOREIGN KEY (ID_Mascota) REFERENCES mascotas(ID),
    FOREIGN KEY (ID_Servicio) REFERENCES servicios(ID)
);
