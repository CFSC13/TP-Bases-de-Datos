1. 
select nombre, apellido1, apellido2 
from profesores
where departamento = 1

2.
select nombre, apellido1, apellido2
from profesores
where departamento <> 3

3.
select nombre, apellido1, apellido2
from profesores
where fecha_nacimiento > '1970-01-01'

4.
select nombre, apellido1, apellido2
from profesores
where fecha_nacimiento > '1992-06-15'

5.
select NOMBRE, APELLIDO1
from alumnos
where email is null

6. 
select 'el alumno ' || NOMBRE ||' ' || APELLIDO1 ||' no dispone de correo electrónico'
from alumnos
where email is null

7.
select alumno, calificacion
from matricular
where calificacion is not null and asignatura = 112
order by alumno desc

8.
SELECT nombre
FROM asignaturas
WHERE nombre 
LIKE '%Bases De Datos%'

9.
select nombre, creditos
from asignaturas
where caracter like 'o_'

10.
select nombre, creditos, round((practicos::numeric/creditos::numeric)*100,2) as "% Proporción Practicos", 
round((teoricos::numeric/creditos::numeric)*100,2) as "% Proporción teóricos" 
FROM asignaturas
WHERE curso=3;	

11.
select A.nombre "Nombre Asignatura" , I.PROFESOR "PROFESOR"
FROM ASIGNATURAS A LEFT JOIN IMPARTIR I
ON (I.ASIGNATURA=A.CODIGO)
WHERE ((A.TEORICOS) + (A.PRACTICOS)) != (A.CREDITOS)

11.BIS.
select A.nombre "Nombre Asignatura" , I.PROFESOR "PROFESOR", P.APELLIDO1, P.NOMBRE
FROM ASIGNATURAS A 
JOIN IMPARTIR I ON (A.CODIGO=I.ASIGNATURA) 
JOIN PROFESORES P ON (I.PROFESOR=P.NRP) 
WHERE ((A.TEORICOS) + (A.PRACTICOS)) != (A.CREDITOS)

12.(CONSULTAR A LA PROFE)
select *
FROM PROFESORES P LEFT JOIN DIRECTORES D
ON (P.NRP=D.NRP)

13) Muestre en orden alfabético los nombres completos de todos los profesores 
y a su lado el de sus directores si es el caso (si no tenemos constancia de su director de 
tesis dejaremos este espacio en blanco, pero el profesor debe aparecer en el listado).

select
(P1.NOMBRE) || ' ' || (P1.APELLIDO1) ||' '|| (P1.APELLIDO2, ' ') "PROFESORES",
(P2.NOMBRE) || ' ' || (P2.APELLIDO1) ||' '|| (P2.APELLIDO2, ' ') "DIRECTORES DE TESIS"
FROM PROFESORES P1 LEFT OUTER JOIN PROFESORES P2 ON P1.DIRECTOR_TESIS=P2.NRP
ORDER BY P1.APELLIDO1, P1.APELLIDO2 ,P1.NOMBRE

14. 
Alumnos que tengan aprobada la asignatura 'Bases de Datos'

select A.Dni,A.Nombre, A.apellido1, A.apellido2, M.calificacion, A.sexo, A.direccion, A.telefono, A.email, A.fecha_nacimiento, A.fecha_prim_matricula
from alumnos A, matricular M, asignaturas asig
where a.dni=m.alumno and asig.codigo=m.asignatura and upper(asig.nombre)='BASES DE DATOS'
AND M.CALIFICACION >6

select A.Dni,A.Nombre, A.apellido1, A.apellido2, M.calificacion, A.sexo, A.direccion, A.telefono, A.email, A.fecha_nacimiento, A.fecha_prim_matricula
from alumnos A, matricular M, asignaturas asig
where a.dni=m.alumno and asig.codigo=m.asignatura and lower (asig.nombre)='bases de datos'
AND M.CALIFICACION >6

--upper para pasar el valor del campo a mayusculas, lower pasa a minusculas

15. 
Calcular el número de profesores de cada departamento.

SELECT d.nombre, COUNT(p.nrp) "NUMERO PROFESORES"
FROM departamentos d, profesores p
WHERE p.departamento=d.codigo
GROUP BY d.nombre

16-
SELECT m.asignatura "Codigo Asignatura", asig.nombre, ROUND((COUNT(alu.dni)::numeric/(SELECT COUNT(*)::numeric FROM matricular maux WHERE maux.asignatura=m.asignatura)*100),1) "PORCENTAJE MUJERES"
FROM ASIGNATURAS asig
JOIN MATRICULAR m ON (asig.CODIGO=m.ASIGNATURA) 
JOIN alumnos alu ON (m.alumno=alu.dni) 
WHERE alu.sexo='m'
GROUP BY m.asignatura, asig.nombre

 
