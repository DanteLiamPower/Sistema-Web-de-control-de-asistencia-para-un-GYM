SELECT
    u.nombre,
    u.apellido,
    tm.nombre AS tipo_membresia,
    tm.precio,
    m.fechainicio,
    m.fechafin,
    m.estatus
FROM cliente c
JOIN usuario u ON u.usuarioid = c.usuarioid
JOIN membresia m ON m.clienteid = c.clienteid
JOIN tipo_membresia tm ON tm.tipomembresiaid = m.tipomembresiaid;