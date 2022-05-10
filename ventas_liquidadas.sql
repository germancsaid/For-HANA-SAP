/*-*-*-*-*-*-*-* VENTAS LIQUIDADAS v1.0 *-*-*-*-*-*-*/
SELECT
T1."DocDate",--fecha de factura
T1."NumAtCard" AS "N° Fact",--numero de factura
T1."U_ESTADOFC" AS "Estado",--estado de factura
T1."U_NROAUTOR",--numero de autorizacion
T1."U_NIT",--nit
T1."U_RAZSOC",--razon social
T1."U_CODCTRL",--codigo de control
T0."WhsCode" AS "Cod Almacén", --codigo de almacen
T2."WhsName", --nombre de almacen
T1."CardCode" AS "Cod Cliente", --codigo de cliente
T0."ItemCode" AS "Cod Producto", --codigo de articulo
T0."Dscription" AS "Producto", --descripcion o nombre del articulo
T0."Quantity", --cantidad vendida
T0."Volume" AS "Equivalencia en Litros", --volumen total vendido
T0."PriceAfVAT" AS "Precio facturado", --precio venta unitario = precio base + iva
T0."PriceBefDi" AS "Precio Base", --precio base
T0."GTotal" AS "Monto neto", -- precio facturado * cant
T0."VatSum" AS "Monto IVA", --total iva
T5."ESP" AS "Esp monto ICE", --ice especial
T5."PORC" AS "% monto ICE", --ice porcentual
T0."U_ICE_LINEA" AS "Monto ICE", --monto ice total ICE T0."U_ICE_LINEA"
((T0."U_ICE_LINEA")+(T0."GTotal")) AS "Monto bruto", --monto bruto = monto neto + monto ice
T4."PymntGroup" AS "Tipo de operacion", --nombre de la condicion de pago
T1."DocDueDate" AS "Fecha de vencimiento credito"--Fecha de vencimiento de la factura
FROM
INV1 T0  
INNER JOIN OINV T1 ON T0."DocEntry" = T1."DocEntry" 
INNER JOIN OWHS T2 ON T0."WhsCode" = T2."WhsCode" 
INNER JOIN OITM T3 ON T0."ItemCode" = T3."ItemCode" 
INNER JOIN OCTG T4 ON T1."GroupNum" = T4."GroupNum" 
INNER JOIN (SELECT
	 T0."DocEntry",
	 T0."LineNum",
	 SUM(CASE WHEN T0."ExpnsCode" = 3 THEN T0."LineTotal" END) AS ESP,
	 SUM(CASE WHEN T0."ExpnsCode" = 4 THEN T0."LineTotal" END) AS PORC
FROM INV2 T0
GROUP BY T0."DocEntry", T0."LineNum") T5 ON T0."DocEntry" = T5."DocEntry" AND T0."LineNum" = T5."LineNum"
WHERE T1."DocDate" >= [%0] AND T1."DocDate" <= [%1]
ORDER BY T1."NumAtCard";
