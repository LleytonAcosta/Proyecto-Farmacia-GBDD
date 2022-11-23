/*
--trigger
Que impida vender productos los cuales la persona no haya presentado prescripción especia para los fármacos que solicite.
*/
create or replace TRIGGER TR_RESTRICCION
BEFORE
INSERT ON RECETA
FOR EACH ROW
DECLARE
  estado VARCHAR2(50);
BEGIN
    
    estado := :new.PRESCRIPCION ;
    if (estado= 'DENEGADO') then
         RAISE_APPLICATION_ERROR(-20002,'DEBE DE POSEER UNA PRESCIPCION APROBADA');
    end if;
    
END TR_RESTRICCION;