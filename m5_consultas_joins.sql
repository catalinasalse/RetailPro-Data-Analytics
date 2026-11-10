USE Ventas_Tech_DB;
GO

-- === CONSULTA 1: VISTA BASE DEL PROYECTO ===
-- Propósito: crear una vista enriquecida de las ventas para usar como fuente principal en Power BI.

SELECT
    v.fecha_venta,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    v.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

-- Hallazgo: La vista consolidada reúne las 10 ventas registradas con información de cliente,
-- producto, categoría y ciudad, quedando lista como fuente enriquecida para Power BI.

-- === CONSULTA 2: CLIENTES SIN VENTAS ===
-- Propósito: detectar clientes registrados que nunca compraron, para que CRM pueda identificarlos.

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: No se encontraron clientes sin ventas; los 5 clientes registrados realizaron al menos una compra.
-- Esto indica que CRM no tiene actualmente clientes registrados pendientes de conversión.


-- === CONSULTA 3: PRODUCTOS SIN VENTAS ===
-- Propósito: identificar productos del catálogo que no registraron ventas, para evaluar su movimiento comercial.

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- Hallazgo: No se encontraron productos sin ventas; los 6 productos del catálogo registraron al menos una venta.
-- Esto indica que el área de Producto no tiene actualmente artículos sin movimiento comercial.

-- === CONSULTA 4: CONSOLIDADO POR PERÍODO ===
-- Propósito: comparar la facturación de dos períodos utilizando UNION ALL.

SELECT
    canal,
    SUM(total) AS total_canal
FROM (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Primera mitad' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Segunda mitad' AS canal
    FROM ventas
    WHERE fecha_venta > '2024-03-10'
) AS consolidado
GROUP BY canal;

-- Hallazgo: La primera mitad del período facturó $3.620, mientras que la segunda facturó $2.824.
-- La primera mitad generó una facturación mayor, con una diferencia de $796.