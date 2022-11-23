/*
                    CURSOR
Que muestre los fármacos disponibles y los que son similares o tengan la 
misma acción en la persona. Donde debe mostrar en una columna los nombres 
del fármaco, en otra los que tienen la misma acción en la persona, y en otra 
columna la cantidad de compuestos que coinciden.
*/

set serveroutput on;
DECLARE 
    
    CURSOR PRODUCTOS_REPETIDOS is 
    
    SELECT LISTAGG(P.NOMBRE,',') WITHIN GROUP(ORDER BY P.NOMBRE) AS PRODUCTOS ,C.NOMBRE AS COMPUESTO, COUNT (LI.FK_ID_COMPUESTO) as producto_repetido
    FROM PRODUCTO_COMPUESTO_DESCUENTO LI
    INNER JOIN COMPUESTOS C
    ON C.ID_COMPUESTO = LI.FK_ID_COMPUESTO
    INNER JOIN PRODUCTOS P
    ON P.ID_PRODUCTO = LI.FK_ID_PRODUCTO
    GROUP BY C.NOMBRE,LI.FK_ID_COMPUESTO
    HAVING COUNT (LI.FK_ID_COMPUESTO)>=2;
    
	total int;
BEGIN 
    total:=0;

    for Datos in PRODUCTOS_REPETIDOS 
	loop
        total:= total +Datos.producto_repetido;      
        dbms_output.put_line('Los productos '||Datos.PRODUCTOS ||' contienen '||Datos.producto_repetido||' compuestos de '||Datos.COMPUESTO);
    	end loop;
	dbms_output.put_line('Cantidad de productos repetidos : ' || total);
END;
