-- ===============================================================================================================================================
-- Consultas Operativas (Funcionamiento del Hospital)
-- ===============================================================================================================================================

-- 1. ¿Qué especialidad médica atiende a más pacientes?
SELECT e.nombre_especialidad, COUNT(DISTINCT c.id_paciente) AS número_de_pacientes
FROM cita c
JOIN medicos m ON c.id_medico = m. id_medico
JOIN medico_especialidad me ON m.id_medico = me.id_medico
JOIN especialidades e ON me.id_especialidad = e.id_especialidad
GROUP BY e.nombre_especialidad
ORDER BY número_de_pacientes DESC;

    -- Resultado:
      -- La especialidad médica con mayor demanda en el hospital es Medicina General, seguida por Endocrinología. Esto evidencia que estas áreas presentan una mayor carga de atención en comparación con los demás servicios.
    
-- 2. ¿Cuántas citas hay por especialidad?
SELECT e.nombre_especialidad, COUNT(c.id_cita) AS número_de_citas
FROM cita c
JOIN medicos m ON c.id_medico = m. id_medico
JOIN medico_especialidad me ON m.id_medico = me.id_medico
JOIN especialidades e ON me.id_especialidad = e.id_especialidad
GROUP BY e.nombre_especialidad
ORDER BY número_de_citas DESC;

    -- Resultado:
      -- Las especialidades médicas que presentan una mayor demanda en el hospital son Medicina General y Endocrinología. Esto evidencia que estas áreas presentan una mayor carga de atención en comparación con los demás servicios prestados por la entidad.
      -- Cabe resaltar que la pregunta 1 y la pregunta 2 arrojan resultados iguales; sin embargo, están planteadas desde perspectivas diferentes. La primera evalúa la cantidad de pacientes atendidos por especialidad, mientras que la segunda evalúa la cantidad de citas registradas por especialidad.

-- 3. ¿Qué consultorios son los más usados?
SELECT cn.piso_consultorio, cn.numero_consultorio, COUNT(c.id_cita) AS número_de_citas
FROM cita c
JOIN consultorio cn ON c.id_consultorio = cn.id_consultorio
GROUP BY cn.piso_consultorio, cn.numero_consultorio
ORDER BY número_de_citas DESC;

    -- Resultado:
      -- El hospital cuenta con varios consultorios, los cuales son utilizados para la atención de citas médicas. Debido a que todos registran uso dentro de la operación de la institución, es importante realizar mantenimientos periódicos a estos espacios para garantizar una atención de calidad y condiciones adecuadas para los pacientes.

-- 4. ¿Cuántas citas fueron atendidas por mes?
SET lc_time_names = 'es_ES';
SELECT YEAR(fecha_cita) AS año, MONTHNAME(fecha_cita) AS mes, COUNT(id_cita) AS número_citas
FROM cita
WHERE estado_cita = 'Atendida'
GROUP BY YEAR(fecha_cita), MONTHNAME(fecha_cita), MONTH(fecha_cita)
ORDER BY YEAR(fecha_cita), MONTH(fecha_cita);

    -- Resultado:
      -- El hospital registra la siguiente cantidad de citas atendidas por mes: enero 7, febrero 4, marzo 3 y abril 2. Los resultados muestran una disminución progresiva en el número de atenciones durante el período analizado. Esta situación hace recomendable investigar las posibles causas de la reducción, ya sean factores internos de la institución o cambios en la demanda de los servicios de salud.

-- 5. ¿Qué médicos atendieron más citas?
SELECT CONCAT(nombre_medico, ' ', apellido_medico) AS medico,
	   COUNT(c.id_cita) AS total_citas
FROM medicos m
JOIN cita c ON c.id_medico = m.id_medico
WHERE c.estado_cita = 'Atendida'
GROUP BY medico
ORDER BY total_citas DESC;

    -- Resultado: 
      -- Los médicos con mayor número de pacientes atendidos fueron: el Dr. Juan Carlos Martínez Gámez (Medicina general), la Dra. Daniela Alejandra Vargas Castro (Neurología), el Dr. Camilo Andrés Cruz Salazar (Medicina interna) y la Dra. Tatiana Alejandra Medina López (Medicina familiar), indicando de esta forma que estos profesionales concentran una mayor cantidad de pacientes atendidos con respecto a los demas médicos, por lo que es relevante analizar su carga de trabajo, para así mismo garantizar una adecuada distribución de las citas médicas. 

-- 6. ¿Cuántas citas fueron canceladas por cada especialidad?
SELECT e.nombre_especialidad, COUNT(c.id_cita) AS número_citas_canceladas
FROM cita c
JOIN medico_especialidad me ON c.id_medico = me.id_medico
JOIN especialidades e ON me.id_especialidad = e.id_especialidad
WHERE c.estado_cita = 'Cancelada'
GROUP BY e.nombre_especialidad
ORDER BY número_citas_canceladas DESC;

    -- Resultado:
      -- Las diferentes especialidades que ofrece el hospital a los pacientes presentan al menos una cita cancelada. Esta información es útil para analizar posibles factores que afecten la asistencia de los pacientes a las correspondientes citas o la disponibilidad de los servicios médicos a los pacientes.

-- 7. ¿Cuántos médicos tienen asignados dos o más asistentes?
SELECT CONCAT(nombre_medico, ' ', apellido_medico) AS medico,
       COUNT(DISTINCT a.id_asistente) AS número_de_asistentes
FROM cita c
JOIN medicos m ON c.id_medico = m.id_medico
JOIN asistente_cita ac ON c.id_cita = ac.id_cita
JOIN asistentes a ON ac.id_asistente = a.id_asistente
GROUP BY m.id_medico, medico
HAVING COUNT(DISTINCT a.id_asistente) >= 2
ORDER BY número_de_asistentes DESC;

    -- Resultado:
      -- Los médicos que tienen bajo su cargo dos o más asistentes son: el Dr. Juan Carlos Martínez Gómez (Medicina interna) y el Dr. Sebastián Giraldo Cárdenas (Endocrinología), esto debido a la carga de trabajo que presentan, ya que diariamente atienden una gran cantidad de pacientes por lo que mencionados asistentes posibilitan agilizar los procesos de atención médica.

-- 8. ¿Cuántos asistentes existen?
SELECT COUNT(id_asistente) AS Número_Asistentes
FROM asistentes;

    -- Resultado:
      -- Actualmente, el hospital cuenta con 24 asistentes, quienes brindan apoyo al personal médico en los consultorios y contribuyen a agilizar los procesos de atención. Esta información permite evaluar la disponibilidad del personal de apoyo y analizar la distribución de la carga de trabajo entre médicos y asistentes, con el fin de mejorar la eficiencia de los servicios prestados por la institución.

-- 9. ¿Cuántos practicantes hay?
SELECT COUNT(id_asistente) AS Número_Practicantes
FROM asistentes
WHERE tipo_ayudante = 'Practicante';

    -- Resultado:
      -- Actualmente, el hospital cuenta con 9 practicantes, quienes no solo brindan apoyo al personal médico en los consultorios, sino que también contribuyen a agilizar los procesos de atención a los pacientes. Esta información permite evaluar la disponibilidad de personal de apoyo y su aporte a la prestación de los servicios de salud, favoreciendo una mejor organización de las actividades asistenciales.

-- ================================================================================================================================================
-- Consultas de Facturación (Dinero y Cobros)
-- ================================================================================================================================================

-- 1. ¿Cúanto dinero fue recaudado por mes?
SET lc_time_names = 'es_ES';
SELECT YEAR(fecha_factura) AS año, MONTHNAME(fecha_factura) AS mes, SUM(valor_factura) AS dinero_facturado
FROM facturacion
WHERE estado_factura = 'pagada'
GROUP BY YEAR(fecha_factura), MONTH(fecha_factura), MONTHNAME(fecha_factura)
ORDER BY YEAR(fecha_factura), MONTH(fecha_factura);

    -- Resultado:
      -- Se observa una notable reducción en los ingresos facturados durante los primeros cuatro meses del año 2026, indicando de esta forma la necesidad de investigar las posibles causas para así adoptar estrategias que conlleven a mejorar el desempeño financiero.

-- 2. ¿Cúanto dinero fue recaudado por trimestre?
SET lc_time_names = 'es_ES';
SELECT YEAR(fecha_factura) AS año, QUARTER(fecha_factura) AS trimestre, SUM(valor_factura) AS dinero_facturado
FROM facturacion
WHERE estado_factura = 'pagada'
GROUP BY YEAR(fecha_factura), QUARTER(fecha_factura)
ORDER BY YEAR(fecha_factura), QUARTER(fecha_factura);

    -- Resultado:
      -- El análisis trimestral permite realizar una evaluación del rendimiento financiero del hospital a corto plazo. Los resultados evidencian que durante el primer trimestre del año 2026 se generaron mayores ingresos que en el segundo trimestre. Por ello, resulta importante analizar los factores que influyeron en esta variación y evaluar si las estrategias implementadas están produciendo los resultados esperados o si es necesario realizar ajustes que contribuyan a mejorar los ingresos de la institución.

-- 3. ¿Cúal es el promedio de las facturas pagadas? 
SELECT AVG(valor_factura) AS promedio_de_facturas
FROM facturacion
WHERE estado_factura = 'Pagada';

    -- Resultado:
      -- Se registró un valor promedio de $125.125 en las facturas del hospital. Este indicador permite conocer el comportamiento general de la facturación de la institución y sirve como apoyo para la planificación financiera y presupuestal. Además, facilita la estimación de ingresos y la evaluación del desempeño económico del hospital, contribuyendo a la toma de decisiones orientadas al mejoramiento de los servicios prestados.

-- 4. ¿Cuántas multas se generaron?
SELECT COUNT(id_facturacion) AS número_de_facturas
FROM facturacion
WHERE tipo_factura = 'Multa';

    -- Resultado:
      -- Se registraron 6 facturas correspondientes a multas, que fueron generadas debido a que los pacientes no asistieron a las citas previamente programas ni realizaron el tramite de cancelación de mencionadas citas, por lo que estos datos permiten identificar situaciones que generan cobros adicionales y así mismo facilitan el seguimiento de los compromisos financieros que se encuentran pendientes por parte de los pacientes. 

-- 5. ¿Cuál es el valor total de las multas generadas?
SELECT SUM(valor_factura) AS total_multas
FROM facturacion
WHERE tipo_factura = 'Multa';

    -- Resultado:
      -- Las multas generaron un valor total de $300.000 pesos. Este resultado permite observar el impacto económico que tiene este tipo de cobros sobre la facturación del hospital. 

-- 6. ¿Qué cobertura es la mayormente utilizada por los pacientes?
SELECT f.tipo_cobertura, COUNT(DISTINCT p.id_paciente) AS número_de_pacientes
FROM facturacion f
JOIN cita c ON f.id_cita = c.id_cita
JOIN pacientes p ON c.id_paciente = p.id_paciente
GROUP BY f.tipo_cobertura
ORDER BY número_de_pacientes DESC;

    -- Resultado:
      -- La cobertura más utilizada por los pacientes que acceden a los servicios del hospital es la EPS, seguida de la modalidad particular. Estos resultados permiten identificar la distribución de los pacientes según su tipo de cobertura y conocer cuáles son las modalidades de atención más representativas dentro de la institución.

-- 7.¿Qué cobertura se utiliza más en las atenciones/facturación?
SELECT tipo_cobertura, COUNT(tipo_cobertura) AS cobertura_utilizada
FROM facturacion
GROUP BY tipo_cobertura
ORDER BY cobertura_utilizada DESC;

    -- Resultado:
      -- La cobertura que genera más atenciones médicas es la EPS, seguida de la modalidad particular. Esta información permite observar aquellas coberturas que le generan mayores ingresos a la institución de salud, lo que a su vez posibilita apoyar la planificación financiera.

-- 8. ¿Cuáles son los ingresos recaudados por cada cobertura?
SELECT tipo_cobertura, SUM(valor_factura) AS ingresos_recaudados
FROM facturacion
WHERE estado_factura = 'Pagada'
GROUP BY tipo_cobertura
ORDER BY ingresos_recaudados DESC;

    -- Resultado:
      -- Los ingresos recaudados por cada una de las coberturas registradas dentro del sistema hospitalario son: EPS con $1.105.000, seguido de SOAT con $497.000 y ARL con $400.000. Esta información permite validar que la cobertura que registra el mayor volumen de ingresos es de la EPS, ya que un gran porcentaje de la población se encuentra afiliada a alguna EPS, permitiéndoles de esta forma ser atendido con una cobertura total o parcial según sea el caso. Este tipo de reportes posibilita reconocer aquella cobertura que apoya a la planificación financiera de la institución.

-- 9. ¿Cúantas facturas están pendientes?
SELECT COUNT(id_facturacion) AS número_de_facturas
FROM facturacion
WHERE estado_factura = 'Pendiente';

    -- Resultado:
      -- Se registraron en el sistema 4 facturas correspondientes a multas, esta información brinda la oportunidad de identificar las situaciones que generan cobros adicionales y facilitan el seguimiento a aquellos pacientes que tienen compromisos financieros pendientes con la institución por la prestación de sus servicios.

-- ================================================================================================================================================
-- Consultas de Pacientes (demográfia y administrativa)
-- ================================================================================================================================================

-- 1. ¿Cúal es la EPS con más pacientes?
SELECT a.entidad, COUNT(DISTINCT p.id_paciente) AS número_de_pacientes
FROM pacientes p
JOIN afiliaciones a ON p.id_afiliacion = a.id_afiliacion
GROUP BY a.entidad
ORDER BY número_de_pacientes DESC
LIMIT 1;

    -- Resultado:
      -- La EPS Salud Total registra el mayor número de pacientes afiliados, tanto del régimen contributivo como subsidiado. Esta información permite identificar la entidad con mayor representación dentro de la población atendida por el hospital.

-- 2. ¿Cuántos pacientes hay por cada EPS?
SELECT a.entidad, COUNT(DISTINCT p.id_paciente) AS número_de_pacientes
FROM pacientes p
JOIN afiliaciones a ON p.id_afiliacion = a.id_afiliacion
GROUP BY a.entidad
ORDER BY número_de_pacientes DESC;

    -- Resultado:
      -- Los pacientes afiliados por cada una de las EPS son los siguientes: Salud Total 6, Capital Salud 5, Compensar 5, Famisanar 5, Nueva EPS 5, Sanitas 5 y Fomag 1. Esta información permite no solo conocer la distribución de los pacientes afiliados por cada EPS, sino también reconocer aquellas entidades que tienen una mayor representación dentro de la población atendida por la institución de salud.

-- 3. ¿Cuántos pacientes hay por régimen?
SELECT a.regimen, COUNT(DISTINCT p.id_paciente) AS número_de_pacientes
FROM pacientes p
JOIN afiliaciones a ON p.id_afiliacion = a.id_afiliacion
GROUP BY a.regimen
ORDER BY número_de_pacientes DESC;

    -- Resultado:
      -- El número de pacientes vinculados a cada régimen es el siguiente: contributivo 18, subsidiado 13 y especial 1. Esta información permite conocer la distribución de los pacientes según su régimen de afiliación e identificar cuál de ellos tiene una mayor representación dentro de la población atendida por el hospital.

-- 4. ¿Cuántos pacientes son menores de edad?
SELECT COUNT(id_paciente) AS pacientes_menores_de_edad
FROM pacientes
WHERE TIMESTAMPDIFF(YEAR, fecha_nacimiento_paciente, CURDATE()) < 18;

    -- Resultado:
      -- El número de pacientes menores de edad registrados en el sistema hospitalario es de 15. Esta información permite identificar la población pediátrica atendida por la institución y apoyar la planificación de programas de promoción y prevención orientados a niños y adolescentes.

-- 5. ¿Cuántos pacientes son adultos mayores?
SELECT COUNT(id_paciente) AS pacientes_menores_de_edad
FROM pacientes
WHERE TIMESTAMPDIFF(YEAR, fecha_nacimiento_paciente, CURDATE()) > 60;

    -- Resultado:
      -- El número de pacientes adultos mayores registrados en el sistema hospitalario es de 15. Esta información no solo permite reconocer la población mayor atendida por la institución de salud, sino también desarrollar y fortalecer programas de promoción, prevención y seguimiento de salud orientados a este grupo poblacional.
