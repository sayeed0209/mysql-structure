
-- queries tienda
 SELECT codigo_fabricante FROM producto;
 SELECT DISTINCT codigo_fabricante FROM producto;
SELECT fabricante.nombre FROM fabricante ORDER BY fabricante.nombre ASC;
 SELECT fabricante.nombre FROM fabricante ORDER BY fabricante.nombre DESC;
 SELECT * FROM producto ORDER BY nombre ASC,precio DESC;
 SELECT *  FROM producto  LIMIT 5;
 SELECT * FROM producto LIMIT 2 offset 3;
 SELECT * FROM producto  GROUP BY precio ORDER BY precio LIMIT 1;
 SELECT * FROM producto  GROUP BY precio ORDER BY precio  DESC LIMIT 1;
SELECT * FROm producto WHERE  codigo_fabricante=2;
 SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
 SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre ASC ;
 SELECT * FROM producto JOIN fabricante  WHERE fabricante.nombre= 'Lenovo';
SELECT  fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio > 200;
 SELECT * FROM producto JOIN fabricante  ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Seagate' OR  fabricante.nombre = 'Hewlett-Packard';
SELECT * FROM producto JOIN fabricante  ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre IN('Asus','Seagate','Hewlett-Packard');
 SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%e';
 SELECT * FROM producto JOIN fabricante  ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%w%';
 SELECT producto.nombre,producto.precio,fabricante.nombre FROM producto JOIN fabricante  ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.precio DESC ,producto.nombre ASC;
  SELECT fabricante.codigo,fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo GROUP BY fabricante.nombre;
 SELECT fabricante.codigo,fabricante.nombre,producto.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo GROUP BY fabricante.nombre;
SELECT fabricante.codigo,fabricante.nombre,producto.nombre FROM producto RIGHT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
 SELECT fabricante.codigo,fabricante.nombre,producto.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre='Lenovo';
 SELECT fabricante.codigo,fabricante.nombre,producto.nombre,producto.precio FROM producto LEFT JOIN fabricante  ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre='Lenovo' OR producto.precio >= 559 ;
SELECT *, MAX(producto.precio) FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre='Lenovo';
SELECT fabricante.codigo,fabricante.nombre,producto.nombre, MIN(producto.precio) FROM producto   JOIN fabricante  ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre='Hewlett-Packard'  ;
SELECT * FROM producto  JOIN fabricante  ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= (SELECT precio FROM fabricante JOIN producto ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo'  LIMIT 1);
SELECT * FROM producto  JOIN fabricante  ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus' AND  producto.precio < (SELECT AVG(producto.precio) FROM producto WHERE fabricante.nombre = 'Asus' ) ORDER BY producto.precio DESC  LIMIT 1;

  


-- Base de datos Universidad
 SELECT * , nombre,apellido1,apellido2 FROM universidad.persona WHERE tipo= 'alumno' ORDER BY apellido1,apellido2,nombre;
 SELECT nombre,apellido1,apellido2 FROM universidad.persona WHERE telefono IS NULL AND tipo= 'alumno';
 SELECT * FROM universidad.persona WHERE fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31' AND tipo= 'alumno' ;
 SELECT * FROM universidad.persona WHERE telefono IS NULL AND nif LIKE '%K' AND tipo='profesor';
 SELECT * FROM asignatura WHERE id_grado=7;
 SELECT persona.apellido1,persona.apellido2,persona.nombre,departamento.nombre AS departamento FROM persona JOIN profesor JOIN departamento ON departamento.id = profesor.id_profesor WHERE persona.tipo='profesor' ORDER BY apellido1,apellido2,persona.nombre;
 SELECT * FROM persona JOIN curso_escolar JOIN asignatura ON asignatura.id= curso_escolar.id WHERE  persona.nif ='26902806M';
 SELECT * FROM profesor JOIN persona  JOIN grado JOIN departamento ON persona.id = profesor.id_profesor WHERE grado.nombre='Grado en Ingeniería Informática (Plan 2015)' GROUP BY persona.id;
 SELECT * FROM persona JOIN alumno_se_matricula_asignatura JOIN curso_escolar ON persona.id = alumno_se_matricula_asignatura.id_alumno WHERE anyo_inicio=2018 AND anyo_fin =2019 GROUP BY persona.id;
 -- Resuelva las 6 siguientes consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN. 
 SELECT departamento.nombre,persona.apellido1,persona.apellido2,persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON departamento.id = profesor.id_departamento ORDER BY departamento.nombre ;
 SELECT profesor.id_profesor,persona.nombre,departamento.nombre AS departamento FROM profesor LEFT JOIN departamento ON profesor.id_profesor = departamento.id  LEFT JOIN persona ON persona.id = profesor.id_profesor WHERE departamento.nombre IS NULL;
 SELECT departamento.nombre FROM profesor RIGHT JOIN departamento ON profesor.id_departamento = departamento.id WHERE id_profesor IS NULL ;
 SELECT * FROM profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor  WHERE asignatura.id_profesor is null;
 SELECT * FROM asignatura LEFT JOIN profesor ON profesor.id_profesor = asignatura.id_profesor  WHERE asignatura.id_profesor is null;
 SELECT departamento.nombre as d ,curso_escolar.anyo_inicio,curso_escolar.anyo_fin,asignatura.nombre  FROM departamento  LEFT JOIN asignatura ON departamento.id = asignatura.curso LEFT JOIN curso_escolar ON asignatura.curso = curso_escolar.id GROUP BY d;
 
 -- Consulta resumen 
 
 SELECT COUNT(*) AS total_alumno FROM persona WHERE tipo='alumno';
 SELECT COUNT(*) AS nacieron_en_1999 FROM persona WHERE tipo = 'alumno' AND  fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';
 SELECT departamento.nombre,count(profesor.id_profesor)AS total_profesor FROM departamento  JOIN profesor ON departamento.id= profesor.id_departamento group by departamento.nombre;
 SELECT  grado.nombre  , COUNT(*) FROM asignatura RIGHT JOIN grado ON grado.id = asignatura.id_grado group by grado.nombre;
 SELECT  grado.nombre  , COUNT(*)  FROM asignatura RIGHT JOIN grado ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(*)> 40 ;
 SELECT grado.nombre,asignatura.tipo ,COUNT(asignatura.creditos) FROM grado JOIN asignatura ON grado.id = asignatura.id_grado group by asignatura.tipo;
SELECT curso_escolar.anyo_inicio ,COUNT(alumno_se_matricula_asignatura.id_alumno) FROM alumno_se_matricula_asignatura JOIN asignatura ON alumno_se_matricula_asignatura.id_alumno = asignatura.id JOIN curso_escolar group by id_alumno

	
