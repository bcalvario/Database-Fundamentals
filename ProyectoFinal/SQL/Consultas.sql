-- Escuela con seguro con costo menor a 5000 y mayor a 4000
SELECT seguro.razonsocial
FROM seguro
WHERE costo >= 4000 AND costo <=5000

-- Directores de escuelas publicas con bono mayor a 950
SELECT director.nombre
FROM director NATURAL JOIN escuela
WHERE escuela.tipo = 'publica' AND director.bono > 950

-- Grupo con docentes de contrato por Honorarios
SELECT docente.nombre, grupo.razonsocial
FROM docente NATURAL JOIN grupo
WHERE docente.tipocontrato = 'honorarios'

-- Docentes que trabajan en el estado de Texas y su sueldo es mayor a 2000 pesos
SELECT docente.nombre
FROM docente NATURAL JOIN laborar NATURAL JOIN escuela
WHERE escuela.estado = 'Texas' AND docente.pagocontrato > 2000 OR docente.sueldomensual > 2000

-- Nombre completo de alumnos regulares con calificacion mayor a 8
SELECT alumno.nombre, alumno.paterno, alumno.materno
FROM alumno NATURAL JOIN boleta
WHERE boleta.calificacion > 8

-- Nombre del docente, el alumno y la materia cuya calificacion es menor a 7
SELECT docente.nombre, alumno.nombre, boleta.materia
FROM docente FULL OUTER JOIN boleta ON docente.idacademico = boleta.idacademico
FULL OUTER JOIN alumno ON boleta.idalumno = alumno.idalumno
WHERE boleta.calificacion < 7

-- Nombre del seguro de escuelas publicas cuyo costo sea menor a 3000
SELECT seguro.nombre
FROM seguro NATURAL JOIN escuela
WHERE escuela.tipo = 'publica' AND seguro.costo < 3000

-- Nombre del alumno, el monto y la escuela del que no se esta al corriente en el pago
SELECT alumno.nombre, pagomensual.pagomensual, escuela.razonsocial
FROM alumno FULL OUTER JOIN pagomensual ON alumno.idalumno = pagomensual.idalumno
FULL OUTER JOIN escuela ON pagomensual.razonsocial = escuela.razonsocial
WHERE corriente = false

-- Suma de los sueldos de todos los directores
SELECT SUM(sueldo)
FROM director

-- Promedio de calificaciones de los alumnos de escuelas privadas
SELECT AVG(alumno.promedio)
FROM alumno NATURAL JOIN escuela
WHERE escuela.tipo = 'privada'

-- Numero de alumnos que pagan a escuelas privadas
SELECT COUNT(pagomensual.idalumno)
FROM pagomensual

-- Numero de Alumnos que estudian en escuelas publicas
SELECT COUNT(alumno.idalumno)
FROM alumno NATURAL JOIN escuela
WHERE escuela.tipo = 'publica'

-- Numero de docentes que trabajan en Illinois
SELECT COUNT(docente.idacademico)
FROM docente NATURAL JOIN laborar NATURAL JOIN escuela
WHERE escuela.estado = 'Illinois'

-- Numero de docentes activos
SELECT COUNT(docente.idacademico)
FROM docente
where docente.esactivo = true

-- Monto total de alumnos que no han pagado colegiaturas
SELECT SUM(alumno.cuota)
FROM alumno
WHERE alumno.corriente = false











