USE Ventas_Tech_DB;
GO

-- === CONSULTA 1: RESUMEN EJECUTIVO MENSUAL ===

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- === CONSULTA 2: RANKING DE PRODUCTOS ===

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- === CONSULTA 3: CLIENTES RECURRENTES ===

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;


-- === CONSULTA 4: PRODUCTOS POR ENCIMA/DEBAJO DEL PROMEDIO ===

WITH facturacion_por_producto AS (
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)

SELECT
    id_producto,
    total_facturado,
    CASE
        WHEN total_facturado > (
            SELECT AVG(total_facturado)
            FROM facturacion_por_producto
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM facturacion_por_producto
ORDER BY total_facturado DESC;

-- === HALLAZGOS ===

-- 1. En marzo se facturaron $6.444 en 10 pedidos, con un ticket promedio de $644,40.
-- 2. El producto 1 fue el de mayor facturación, generando $3.600 con 3 unidades vendidas.
-- 3. Solo los productos 1 y 3 tuvieron una facturación por encima del promedio por producto.