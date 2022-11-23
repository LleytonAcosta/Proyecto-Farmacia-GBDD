/*
-----CONSULTA 1
Mostrar los empleados desde el mas antiguo hasta el menos antiguo con los respectivos nombres y apellidos, el tiempo (años, meses, días) 
que ha trabajado en la cadena, y el estado de actividad para saber si esta o no trabajando en la empresa. 
*/

SELECT V.NOMBRES||' '|| V.APELLIDOS AS VENDEDOR ,V.AÑOS_LABORAL, V.ESTADO
FROM VENDEDOR V
order by V.AÑOS_LABORAL asc

/*
-----CONSULTA 2
Mostrar los casos de clientes atendidos con idéntico apellido paterno y materno, donde se mostrará 
los nombres y apellidos del cliente, y en otra columna la cantidad de coincidencias.
*/

SELECT  LISTAGG(C.NOMBRES,' , ') WITHIN GROUP(ORDER BY C.NOMBRES) AS NOMBRES_CLIENTES, --pivotar
C.APELLIDO_PATERNO ||' '|| C.APELLIDO_MATERNO AS APELLIDO_CLIENTE, COUNT (C.APELLIDO_PATERNO ||' '|| C.APELLIDO_MATERNO) AS SIMILITUD_APELLIDOS
FROM CLIENTE C
GROUP BY C.APELLIDO_PATERNO, C.APELLIDO_MATERNO


/*
-----CONSULTA 3
Mostrar los fármacos existentes y los fármacos con igual acción a él, donde se mostrará en una columna los nombres 
del fármaco y en otra los que tengan el mismo efecto, la cantidad de compuestos en los que coinciden. 
*/

    --EL SELECT SOLO MUESTRA LOS PRODUCTOS CON SU COINCIDENCIA
    SELECT LISTAGG(P.NOMBRE,',') WITHIN GROUP(ORDER BY P.NOMBRE) AS PRODUCTOS ,C.NOMBRE ||' = '|| COUNT (LI.FK_ID_COMPUESTO) as producto_repetido
    FROM PRODUCTO_COMPUESTO_DESCUENTO LI
    INNER JOIN COMPUESTOS C
    ON C.ID_COMPUESTO = LI.FK_ID_COMPUESTO
    INNER JOIN PRODUCTOS P
    ON P.ID_PRODUCTO = LI.FK_ID_PRODUCTO
    GROUP BY C.NOMBRE,LI.FK_ID_COMPUESTO
    HAVING COUNT(LI.FK_ID_COMPUESTO) >=2
    
    UNION ALL
    
    --ESTE MUESTRA LOS PRODUCTOS CON EL TOTAL DE EFECTOS
    SELECT P.NOMBRE AS PRODUCTOS, P.EFECTO ||' = '|| COUNT(P.EFECTO) AS producto_repetido
    FROM PRODUCTO_COMPUESTO_DESCUENTO LI
    INNER JOIN PRODUCTOS P
    ON P.ID_PRODUCTO = LI.FK_ID_PRODUCTO
    GROUP BY P.NOMBRE, P.EFECTO

/*
-----CONSULTA 4  
Mostrar los datos de pago de los empleados, donde se reflejará en una columna los nombres y apellidos del empleado, 
en otra columna la cantidad de horas trabajadas por el empleado, en otra columna la cantidad de horas extras trabajadas por el empleado.
*/    

SELECT V.NOMBRES ||' '|| V.APELLIDOS AS EMPLEADO,V.JORNADA_LABORAL, P.HORAS_LABORADAS, P.HORAS_EXTRAS
FROM VENDEDOR V
INNER JOIN PAGOS P
ON P.FK_ID_VENDEDOR = V.ID_VENDEDOR

