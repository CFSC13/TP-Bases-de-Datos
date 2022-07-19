1. Hallar el nombre y los apellidos de los profesores del departamento de 
código.

select nombre, apellido1, apellido2 
from profesores
where departamento = 1

2. Hallar el nombre y los apellidos de los profesores de todos los 
departamentos excepto el de código.

select nombre, apellido1, apellido2
from profesores
where departamento <> 3

3. Hallar el nombre y los apellidos de los profesores que nacieran antes de 
1970.

select nombre, apellido1, apellido2
from profesores
where fecha_nacimiento > '1970-01-01'

4. Hallar el nombre y los apellidos de los profesores que tengan menos de 30 
años.

select nombre, apellido1, apellido2
from profesores
where fecha_nacimiento > '1992-06-15'

5. Mostrar la lista de alumnos que no disponen de correo electrónico.

select NOMBRE, APELLIDO1
from alumnos
where email is null

6. Haga la consulta anterior, pero muestre la lista como: El alumno ...... no 
dispone de Correo.

select 'el alumno ' || NOMBRE ||' ' || APELLIDO1 ||' no dispone de correo electrónico'
from alumnos
where email is null

7. Muestre la lista de las notas de la asignatura 112. Liste el código del alumno
junto a su nota ordenado por el primero.

select alumno, calificacion
from matricular
where calificacion is not null and asignatura = 112
order by alumno desc

8. Liste el nombre de todas las asignaturas que contienen en su nombre las 
palabras 'Bases de Datos'.

SELECT nombre
FROM asignaturas
WHERE nombre 
LIKE '%Bases De Datos%'

9. Muestre el nombre y créditos de todas las asignaturas obligatorias y 
optativas. 
Aproveche que obligatorias y optativas comienzan ambas por el mismo carácter para simplificar la 
consulta.

select nombre, creditos
from asignaturas
where caracter like 'o_'

10. Liste el nombre de las asignaturas de tercero, informando del total de 
créditos, de la proporción de teoría y de prácticas.

select nombre, creditos, round((practicos::numeric/creditos::numeric)*100,2) as "% Proporción Practicos", 
round((teoricos::numeric/creditos::numeric)*100,2) as "% Proporción teóricos" 
FROM asignaturas
WHERE curso=3;	

11. Busque una incongruencia en la base de datos, es decir, asignaturas en las 
que el número de créditos teóricos + prácticos no sea igual al número de créditos totales. 
Muestre también los profesores que imparten esas asignaturas.

select A.nombre "Nombre Asignatura" , I.PROFESOR "PROFESOR", P.APELLIDO1, P.NOMBRE
FROM ASIGNATURAS A 
JOIN IMPARTIR I ON (A.CODIGO=I.ASIGNATURA) 
JOIN PROFESORES P ON (I.PROFESOR=P.NRP) 
WHERE ((A.TEORICOS) + (A.PRACTICOS)) != (A.CREDITOS)

12. Muestre todos los datos de los profesores que no son directores de tesis.

select *
FROM PROFESORES P LEFT JOIN DIRECTORES D
ON (P.NRP=D.NRP)

13. Muestre en orden alfabético los nombres completos de todos los profesores 
y a su lado el de sus directores si es el caso (si no tenemos constancia de su director de 
tesis dejaremos este espacio en blanco, pero el profesor debe aparecer en el listado).

select
(P1.NOMBRE) || ' ' || (P1.APELLIDO1) ||' '|| (P1.APELLIDO2, ' ') "PROFESORES",
(P2.NOMBRE) || ' ' || (P2.APELLIDO1) ||' '|| (P2.APELLIDO2, ' ') "DIRECTORES DE TESIS"
FROM PROFESORES P1 LEFT JOIN PROFESORES P2 ON P1.DIRECTOR_TESIS=P2.NRP
ORDER BY P1.APELLIDO1, P1.APELLIDO2 ,P1.NOMBRE

-- Ver como mejorar esta consulta

14. Alumnos que tengan aprobada la asignatura 'Bases de Datos'

select A.Dni,A.Nombre, A.apellido1, A.apellido2, M.calificacion, A.sexo, A.direccion, A.telefono, A.email, A.fecha_nacimiento, A.fecha_prim_matricula
from alumnos A, matricular M, asignaturas asig
where a.dni=m.alumno and asig.codigo=m.asignatura and upper(asig.nombre)='BASES DE DATOS'
AND M.CALIFICACION >6

--upper para pasar el valor del campo a mayusculas, lower pasa a minusculas

15. Calcular el número de profesores de cada departamento.

SELECT d.nombre, COUNT(p.nrp) "NUMERO PROFESORES"
FROM departamentos d, profesores p
WHERE p.departamento=d.codigo
GROUP BY d.nombre

16. Calcular, por cada asignatura, qué porcentaje de sus alumnos son mujeres.

SELECT m.asignatura "Codigo Asignatura", asig.nombre, ROUND((COUNT(alu.dni)::numeric/(SELECT COUNT(*)::numeric FROM matricular maux WHERE maux.asignatura=m.asignatura)*100),1) "PORCENTAJE MUJERES"
FROM ASIGNATURAS asig
JOIN MATRICULAR m ON (asig.CODIGO=m.ASIGNATURA) 
JOIN alumnos alu ON (m.alumno=alu.dni) 
WHERE alu.sexo='f'
GROUP BY m.asignatura, asig.nombre

 
