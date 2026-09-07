# Taller 7 - Veterinaria MySQL

Proyecto del taller de bases de datos para una veterinaria. Incluye DDL, DML y 19 procedimientos almacenados en MySQL.

## Archivos

| Archivo | Contenido |
|---------|-----------|
| `ddl.sql` | Creación de la base de datos y las tablas |
| `dml.sql` | Inserción de datos de prueba (10 registros por tabla) |
| `procedimientos.sql` | Creación de los 19 procedimientos almacenados y ejemplos `CALL` |

## Tablas

- **clientes**: información de los dueños de las mascotas.
- **mascotas**: mascotas asociadas a un cliente.
- **servicios**: servicios ofrecidos por la veterinaria.
- **mascota_servicio**: tabla intermedia que relaciona mascotas y servicios con fecha.

## Procedimientos incluidos

1. `InsertarCliente`
2. `ActualizarEstadoCliente`
3. `ContarMascotasPorCliente`
4. `ListarServiciosDeMascota`
5. `RegistrarServicioMascota`
6. `EliminarMascota`
7. `ActualizarPrecioServicio`
8. `ContarServiciosPorMascota`
9. `IncrementarPrecioServicios`
10. `RepetirRegistroServicio` (REPEAT)
11. `VerificarCorreo`
12. `AumentarEstaturaMascotas` (WHILE)
13. `ClasificarMascotas` (IF-ELSE)
14. `ContarClientesActivos`
15. `ActualizarMascota`
16. `EliminarServicioPorNombre`
17. `ListarMascotasPorCliente`
18. `TransferirMascota`
19. `RegistrarMultiplesServicios` (LOOP)

## Cómo ejecutar

1. Abrir MySQL Workbench o la terminal.
2. Ejecutar en orden:

```bash
mysql -u root -p < ddl.sql
mysql -u root -p < dml.sql
mysql -u root -p < procedimientos.sql
```

3. Probar los procedimientos con los `CALL` que están comentados al final de `procedimientos.sql`.

## Video demostrativo

🔗 [Enlace al video](PEGAR_AQUI_EL_ENLACE_DEL_VIDEO)

## Autor

- Henry Morales
