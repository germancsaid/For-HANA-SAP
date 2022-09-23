--esto suma los disponibles de almacen DIS-CEN && DIS-OR
--solo de un articulo que es la variable
SELECT SUM("Disponible") 
FROM(SELECT T0."ItemCode", T0."WhsCode",(T0."OnHand"-T0."IsCommited"+T0."OnOrder") AS "Disponible" 
    FROM OITW T0 
    WHERE T0."WhsCode" = 'DIS-CEN' OR T0."WhsCode" = 'DIS-OR' 
    ORDER BY T0."ItemCode")
WHERE "ItemCode" = 'CER0000116' --AQUI VA UNA VARIABLE
