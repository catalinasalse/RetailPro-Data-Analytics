# RetailPro — Proyecto de Data Analytics

Proyecto académico de análisis de ventas orientado a transformar registros transaccionales en información útil para decisiones comerciales.

## Objetivo
Analizar facturación mensual, productos destacados, recurrencia de clientes y evolución de ventas mediante SQL y Power BI.

## Herramientas y alcance
- SQL para creación y consulta de datos (los scripts del repositorio usan sintaxis PostgreSQL; adaptar antes de ejecutar en SQL Server).
- Power Query para limpieza y transformación de datos.
- Power BI y DAX para modelo de relaciones, calendario, KPIs y validación.
- GitHub para versionar scripts y documentar el proyecto.

## Archivos principales
- `ventas_tech_db.sql`: estructura y datos de referencia de la base.
- `m4_consultas_negocio.sql`: resumen mensual, ranking de productos, clientes recurrentes y comparación con promedio.
- `m5_consultas_joins.sql`: consultas con JOIN para integrar tablas y analizar registros relacionados.

## Cómo ejecutar los scripts SQL
1. Abrir el gestor SQL compatible con el motor del script y crear una base de datos de trabajo.
2. Ejecutar `ventas_tech_db.sql` para preparar las tablas y los datos.
3. Ejecutar `m4_consultas_negocio.sql` y revisar los resultados.
4. Ejecutar `m5_consultas_joins.sql` después de verificar que las tablas y las claves estén disponibles.
5. Si se utiliza SQL Server, adaptar elementos de PostgreSQL como `EXTRACT`, `LIMIT` y el esquema `public` cuando corresponda.

## Hallazgos documentados del módulo 4
En el conjunto de resultados documentado para enero–abril, la facturación total fue de 8.963; marzo concentró 6.444 y el producto con ID 1 registró 4.800 de facturación. Estos resultados corresponden a esa consulta y período, no a una predicción ni a todos los datos futuros.

## Criterios de calidad
Los resultados deben verificarse contra la base utilizada; no se atribuyen causas comerciales a una variación mensual sin evidencia adicional. Las sugerencias de IA se revisan antes de incorporarlas.

## Próximos pasos
Conectar y validar el modelo en Power BI, documentar medidas DAX y consolidar el dashboard ejecutivo.
