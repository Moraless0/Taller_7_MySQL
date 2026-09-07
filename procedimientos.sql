-- =============================================
-- TALLER 7 - VETERINARIA (Procedimientos Almacenados)
-- =============================================

USE veterinaria;

DELIMITER //

-- 1. Insertar Cliente
CREATE PROCEDURE InsertarCliente(
    IN p_nombre VARCHAR(100),
    IN p_direccion VARCHAR(100),
    IN p_correo VARCHAR(100)
)
BEGIN
    INSERT INTO clientes (nombre, direccion, correoElectronico, activo)
    VALUES (p_nombre, p_direccion, p_correo, 1);
END //

-- 2. Actualizar Estado del Cliente
CREATE PROCEDURE ActualizarEstadoCliente(
    IN p_id INT,
    IN p_activo TINYINT(1)
)
BEGIN
    UPDATE clientes SET activo = p_activo WHERE ID = p_id;
END //

-- 3. Contar Mascotas por Cliente
CREATE PROCEDURE ContarMascotasPorCliente(
    IN p_idCliente INT,
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*) INTO p_total FROM mascotas WHERE ID_Cliente = p_idCliente;
END //

-- 4. Listar Servicios de una Mascota
CREATE PROCEDURE ListarServiciosDeMascota(
    IN p_idMascota INT
)
BEGIN
    SELECT s.ID, s.nombre, s.precio, ms.fecha
    FROM servicios s
    INNER JOIN mascota_servicio ms ON s.ID = ms.ID_Servicio
    WHERE ms.ID_Mascota = p_idMascota;
END //

-- 5. Registrar Servicio a Mascota
CREATE PROCEDURE RegistrarServicioMascota(
    IN p_idMascota INT,
    IN p_idServicio INT,
    IN p_fecha DATE
)
BEGIN
    INSERT INTO mascota_servicio (ID_Mascota, ID_Servicio, fecha)
    VALUES (p_idMascota, p_idServicio, p_fecha);
END //

-- 6. Eliminar Mascota
CREATE PROCEDURE EliminarMascota(
    IN p_id INT
)
BEGIN
    DELETE FROM mascota_servicio WHERE ID_Mascota = p_id;
    DELETE FROM mascotas WHERE ID = p_id;
END //

-- 7. Actualizar Precio de Servicio
CREATE PROCEDURE ActualizarPrecioServicio(
    IN p_id INT,
    IN p_precio DECIMAL(10,2)
)
BEGIN
    UPDATE servicios SET precio = p_precio WHERE ID = p_id;
END //

-- 8. Contar Servicios por Mascota
CREATE PROCEDURE ContarServiciosPorMascota(
    IN p_idMascota INT,
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*) INTO p_total FROM mascota_servicio WHERE ID_Mascota = p_idMascota;
END //

-- 9. Incrementar Precio de Servicios (por porcentaje)
CREATE PROCEDURE IncrementarPrecioServicios(
    IN p_porcentaje DECIMAL(5,2)
)
BEGIN
    UPDATE servicios SET precio = precio + (precio * p_porcentaje / 100);
END //

-- 10. Repetir Registro de Servicio (REPEAT)
CREATE PROCEDURE RepetirRegistroServicio(
    IN p_idMascota INT,
    IN p_idServicio INT,
    IN p_veces INT
)
BEGIN
    DECLARE contador INT DEFAULT 0;
    DECLARE fecha_actual DATE DEFAULT '2025-02-01';

    REPEAT
        INSERT INTO mascota_servicio (ID_Mascota, ID_Servicio, fecha)
        VALUES (p_idMascota, p_idServicio, DATE_ADD(fecha_actual, INTERVAL contador DAY));
        SET contador = contador + 1;
    UNTIL contador >= p_veces
    END REPEAT;
END //

-- 11. Verificar Existencia de Correo Electronico
CREATE PROCEDURE VerificarCorreo(
    IN p_correo VARCHAR(100)
)
BEGIN
    IF EXISTS (SELECT * FROM clientes WHERE correoElectronico = p_correo) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El correo electronico ya esta registrado';
    ELSE
        SELECT 'El correo esta disponible' AS mensaje;
    END IF;
END //

-- 12. Aumentar Estatura de Mascotas (WHILE)
CREATE PROCEDURE AumentarEstaturaMascotas(
    IN p_aumento FLOAT
)
BEGIN
    DECLARE contador INT DEFAULT 1;
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM mascotas;

    WHILE contador <= total DO
        UPDATE mascotas SET estatura = estatura + p_aumento WHERE ID = contador;
        SET contador = contador + 1;
    END WHILE;
END //

-- 13. Clasificar Mascotas por Estatura (IF-THEN-ELSE)
CREATE PROCEDURE ClasificarMascotas()
BEGIN
    DECLARE contador INT DEFAULT 1;
    DECLARE total INT;
    DECLARE est FLOAT;
    DECLARE nombre_m VARCHAR(20);
    DECLARE clasificacion VARCHAR(10);

    SELECT COUNT(*) INTO total FROM mascotas;

    WHILE contador <= total DO
        SELECT estatura, nombre INTO est, nombre_m FROM mascotas WHERE ID = contador;

        IF est >= 0.50 THEN
            SET clasificacion = 'Alta';
        ELSE
            SET clasificacion = 'Baja';
        END IF;

        SELECT nombre_m AS mascota, est AS estatura, clasificacion;
        SET contador = contador + 1;
    END WHILE;
END //

-- 14. Contar Clientes Activos
CREATE PROCEDURE ContarClientesActivos(
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*) INTO p_total FROM clientes WHERE activo = 1;
END //

-- 15. Actualizar Mascota
CREATE PROCEDURE ActualizarMascota(
    IN p_id INT,
    IN p_nombre VARCHAR(20),
    IN p_estatura FLOAT
)
BEGIN
    UPDATE mascotas SET nombre = p_nombre, estatura = p_estatura WHERE ID = p_id;
END //

-- 16. Eliminar Servicio por Nombre
CREATE PROCEDURE EliminarServicioPorNombre(
    IN p_nombre VARCHAR(50)
)
BEGIN
    IF EXISTS (SELECT * FROM servicios WHERE nombre = p_nombre) THEN
        DELETE FROM mascota_servicio
        WHERE ID_Servicio = (SELECT ID FROM servicios WHERE nombre = p_nombre);
        DELETE FROM servicios WHERE nombre = p_nombre;
        SELECT 'Servicio eliminado correctamente' AS mensaje;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El servicio no existe';
    END IF;
END //

-- 17. Listar Mascotas por Cliente
CREATE PROCEDURE ListarMascotasPorCliente(
    IN p_idCliente INT
)
BEGIN
    SELECT ID, nombre, nPatas, estatura FROM mascotas WHERE ID_Cliente = p_idCliente;
END //

-- 18. Transferir Mascota a Otro Cliente
CREATE PROCEDURE TransferirMascota(
    IN p_idMascota INT,
    IN p_idNuevoCliente INT
)
BEGIN
    UPDATE mascotas SET ID_Cliente = p_idNuevoCliente WHERE ID = p_idMascota;
END //

-- 19. Registrar Multiples Servicios (LOOP)
CREATE PROCEDURE RegistrarMultiplesServicios(
    IN p_idMascota INT,
    IN p_inicio INT,
    IN p_fin INT
)
BEGIN
    DECLARE actual INT DEFAULT 0;
    SET actual = p_inicio;

    bucle: LOOP
        IF actual > p_fin THEN
            LEAVE bucle;
        END IF;

        INSERT INTO mascota_servicio (ID_Mascota, ID_Servicio, fecha)
        VALUES (p_idMascota, actual, CURDATE());

        SET actual = actual + 1;
    END LOOP bucle;
END //

DELIMITER ;

CALL InsertarCLiente('Pedro Sanchez', 'Calle 13', 'pedrosanchez@gmail.com');

SELECT * FROM clientes;

CALL ActualizarEstadoCliente(11,0);

CALL ContarMascotasPorCliente(4, @total); SELECT @total;

CALL ListarServiciosDeMascota(1);

CALL RegistrarServicioMascota(1, 2, '2025-02-03');

-- =============================================
-- EJEMPLOS DE PRUEBA
-- =============================================

-- CALL InsertarCliente('Nuevo Cliente', 'Calle 1', 'nuevo@gmail.com');
-- CALL ActualizarEstadoCliente(4, 1);
-- CALL ContarMascotasPorCliente(1, @total); SELECT @total;
-- CALL ListarServiciosDeMascota(1);
-- CALL RegistrarServicioMascota(1, 2, '2025-02-01');
-- CALL EliminarMascota(10);
-- CALL ActualizarPrecioServicio(1, 55000);
-- CALL ContarServiciosPorMascota(1, @total2); SELECT @total2;
-- CALL IncrementarPrecioServicios(10);
-- CALL RepetirRegistroServicio(2, 10, 3);
-- CALL VerificarCorreo('juan@gmail.com');
-- CALL AumentarEstaturaMascotas(0.05);
-- CALL ClasificarMascotas();
-- CALL ContarClientesActivos(@activos); SELECT @activos;
-- CALL ActualizarMascota(1, 'Firulais Jr', 0.65);
-- CALL EliminarServicioPorNombre('Guarderia');
-- CALL ListarMascotasPorCliente(1);
-- CALL TransferirMascota(2, 5);
-- CALL RegistrarMultiplesServicios(3, 1, 4);
