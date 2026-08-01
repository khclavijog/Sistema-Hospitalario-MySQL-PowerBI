CREATE DATABASE proyecto_hospital;

USE proyecto_hospital;

SHOW DATABASES;


-- Creación de las Tablas

CREATE TABLE Especialidades (
id_especialidad INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre_especialidad VARCHAR (60) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE Consultorio (
id_consultorio INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
numero_consultorio INT NOT NULL,
piso_consultorio INT NOT NULL
) ENGINE = InnoDB;

CREATE TABLE Afiliaciones (
id_afiliacion INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
entidad VARCHAR(20) NOT NULL,
plan_beneficios VARCHAR(20) NOT NULL,
regimen ENUM('Contributivo', 'Subsidiado', 'Especial') NOT NULL,
nivel_estrato VARCHAR(10) NULL
) ENGINE = InnoDB;

CREATE TABLE Responsables (
id_responsable INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
tipo_identificacion_responsable ENUM('CC', 'CE', 'Pasaporte') NOT NULL,
numero_identificacion_responsable VARCHAR(20) NOT NULL,
nombre_responsable VARCHAR(40) NOT NULL,
apellido_responsable VARCHAR(40) NOT NULL,
telefono_responsable VARCHAR(20) NOT NULL,
email_responsable VARCHAR(50) NULL,
direccion_responsable VARCHAR(60) NULL,

UNIQUE(tipo_identificacion_responsable, numero_identificacion_responsable)
) ENGINE = InnoDB;

CREATE TABLE Pacientes (
id_paciente INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
tipo_identificacion_responsable ENUM('CC', 'TI', 'CE', 'Pasaporte', 'Registro Civil', 'Adulto sin Ident.', 'Menor sin Ident.', 'Certificado Nacido Vivo') NOT NULL,
numero_identificacion_responsable VARCHAR(20) NULL,
nombre_paciente VARCHAR(40) NOT NULL,
apellido_paciente VARCHAR(40) NOT NULL,
telefono_paciente VARCHAR(20) NULL,
direccion_paciente VARCHAR(60) NULL,
email_paciente VARCHAR(50) NULL,
fecha_nacimiento_paciente DATE NULL,
genero_paciente VARCHAR(30) NULL,
id_responsable INT NULL,
id_afiliacion INT NULL,

UNIQUE(tipo_identificacion_responsable, numero_identificacion_responsable),

FOREIGN KEY(id_responsable) REFERENCES Responsables(id_responsable),
FOREIGN KEY(id_afiliacion) REFERENCES Afiliaciones(id_afiliacion)
) ENGINE = InnoDB;

CREATE TABLE Medicos (
id_medico INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
tipo_identificacion_medico ENUM('CC', 'CE', 'Pasaporte') NOT NULL,
numero_identificacion_medico VARCHAR(20) NOT NULL ,
nombre_medico VARCHAR (40) NOT NULL,
apellido_medico VARCHAR(40) NOT NULL,
telefono_medico VARCHAR(20) NOT NULL,
email_medico VARCHAR(50) NULL,
direccion_medico VARCHAR(60) NULL,
fecha_nacimiento_medico DATE NULL,
tarjeta_profesional VARCHAR(20) UNIQUE NOT NULL,

UNIQUE(tipo_identificacion_medico, numero_identificacion_medico)
) ENGINE = InnoDB;

CREATE TABLE Asistentes (
id_asistente INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
tipo_identificacion_asistente ENUM('CC', 'CE', 'Pasaporte') NOT NULL,
numero_identificacion_asistente VARCHAR(20) NOT NULL ,
nombre_asistente VARCHAR(40) NOT NULL,
apellido_asistente VARCHAR(40) NOT NULL,
telefono_asistente VARCHAR(20) NOT NULL, 
email_asistente VARCHAR(50) NULL,
direccion_asistente VARCHAR(60) NULL,
fecha_nacimiento_asistente DATE NULL,
tipo_ayudante ENUM('Enfermero', 'Auxiliar', 'Practicante') NOT NULL,
id_especialidad INT NOT NULL,

UNIQUE(tipo_identificacion_asistente, numero_identificacion_asistente),

FOREIGN KEY(id_especialidad) REFERENCES Especialidades(id_especialidad)
) ENGINE = InnoDB;

CREATE TABLE Cita (
id_cita INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
id_consultorio INT NOT NULL,
id_medico INT NOT NULL,
id_paciente INT NOT NULL,
fecha_cita DATE NOT NULL,
hora_cita TIME NOT NULL,
estado_cita ENUM('Agendada', 'Confirmada', 'Atendida', 'Cancelada', 'No Asistio') NOT NULL,

FOREIGN KEY(id_consultorio) REFERENCES Consultorio(id_consultorio),
FOREIGN KEY(id_medico) REFERENCES Medicos(id_medico),
FOREIGN KEY(id_paciente) REFERENCES Pacientes(id_paciente)
) ENGINE = InnoDB;

CREATE TABLE Facturacion (
id_facturacion INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
id_cita INT NOT NULL,
valor_factura DECIMAL(10,2) NOT NULL,
fecha_factura DATE NOT NULL,
estado_factura ENUM('Pendiente', 'Pagada', 'Anulada') NOT NULL,
tipo_cobertura ENUM('Particular', 'SOAT', 'ARL', 'EPS') NOT NULL,
tipo_factura ENUM('Consulta', 'Multa') NOT NULL,


FOREIGN KEY(id_cita) REFERENCES Cita(id_cita)
) ENGINE = InnoDB;

CREATE TABLE Historia_Clinica(
id_historia INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
id_cita INT NOT NULL,
motivo_consulta VARCHAR(60) NOT NULL,
enfermedad_actual VARCHAR(150) NOT NULL,
revision_examenes VARCHAR(150) NOT NULL,
antecedentes VARCHAR(250) NOT NULL,
examen_fisico VARCHAR(200) NOT NULL,
diagnostico VARCHAR(100) NOT NULL,
plan_manejo VARCHAR(200) NOT NULL,

FOREIGN KEY(id_cita) REFERENCES Cita(id_cita)
) ENGINE = InnoDB;

CREATE TABLE Medico_Especialidad (
id_especialidad INT NOT NULL,
id_medico INT NOT NULL,

PRIMARY KEY (id_especialidad, id_medico),

FOREIGN KEY (id_especialidad) REFERENCES Especialidades(id_especialidad),
FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)
) ENGINE = InnoDB;

CREATE TABLE Asistente_Cita (
id_asistente INT NOT NULL,
id_cita INT NOT NULL,

PRIMARY KEY(id_asistente, id_cita),

FOREIGN KEY(id_asistente) REFERENCES Asistentes(id_asistente),
FOREIGN KEY(id_cita) REFERENCES Cita(id_cita)
) ENGINE = InnoDB;


-- Inserción de Datos

INSERT INTO Especialidades (nombre_especialidad)
	 VALUES ('Medicina General'),
            ('Pediatría'),
            ('Ginecología'),
            ('Obstetricia'),
            ('Cardiología'),
            ('Neurología'),
            ('Dermatología'),
            ('Oftalmología'),
            ('Otorrinolaringología'),
            ('Psiquiatría'),
            ('Endocrinología'),
            ('Gastroenterología'),
            ('Neumología'),
            ('Medicina Interna'),
            ('Ortopedia'),
            ('Urología'),
            ('Medicina Familiar'),
            ('Anestesiología'),
            ('Fisiatría'),
            ('Odontología'),
            ('Auxiliar de Enfermería'),
            ('Enfermería General'),
            ('Enfermería Consulta Externa'),
            ('Enfermería de Triaje y Signos Vitales');

INSERT INTO Consultorio (numero_consultorio, piso_consultorio)
     VALUES (101, 1),
            (102, 1),
            (103, 1),
            (104, 1),
            (105, 1),
            (106, 1),
            (107, 1),
            (108, 1),
            (201, 2),
            (202, 2),
            (203, 2),
            (204, 2),
            (205, 2),
            (206, 2),
            (301, 3),
            (302, 3),
            (303, 3),
            (304, 3);
     
INSERT INTO Afiliaciones (entidad, plan_beneficios, regimen, nivel_estrato)
     VALUES ('Sanitas', 'PBS', 'Contributivo', NULL),               -- Regimen Contributivo
            ('Sanitas', 'Plan Premium', 'Contributivo', NULL),
            ('Sanitas', 'Plan Complementario', 'Contributivo', NULL),
            ('Nueva EPS', 'PBS', 'Contributivo', NULL),
			('Nueva EPS', 'Plan Premium', 'Contributivo', NULL),
			('Nueva EPS', 'Plan Complementario', 'Contributivo', NULL),
            ('Salud Total', 'PBS', 'Contributivo', NULL),
            ('Salud Total', 'Plan Premium', 'Contributivo', NULL),
            ('Salud Total', 'Plan Complementario', 'Contributivo', NULL),
            ('Compensar', 'PBS', 'Contributivo', NULL),
            ('Compensar', 'Plan Premium', 'Contributivo', NULL),
            ('Compensar', 'Plan Complementario', 'Contributivo', NULL),
            ('Capital Salud', 'PBS', 'Contributivo', NULL),
            ('Capital Salud', 'Plan Premium', 'Contributivo', NULL),
            ('Capital Salud', 'Plan Complementario', 'Contributivo', NULL),
            ('Famisanar', 'PBS', 'Contributivo', NULL),
            ('Famisanar', 'Plan Premium', 'Contributivo', NULL),
            ('Famisanar', 'Plan Complementario', 'Contributivo', NULL),
            ('Sanitas', 'PBS', 'Subsidiado', 'Nivel 1'),                -- Plan Subsidiado
            ('Sanitas', 'PBS', 'Subsidiado', 'Nivel 2'),                                                          
            ('Nueva EPS', 'PBS', 'Subsidiado', 'Nivel 1'),
            ('Nueva EPS', 'PBS', 'Subsidiado', 'Nivel 2'),
            ('Salud Total', 'PBS', 'Subsidiado', 'Nivel 1'),
            ('Salud Total', 'PBS', 'Subsidiado', 'Nivel 2'),
            ('Compensar', 'PBS', 'Subsidiado', 'Nivel 1'),
            ('Compensar', 'PBS', 'Subsidiado',  'Nivel 2'),
            ('Capital Salud', 'PBS', 'Subsidiado', 'Nivel 1'),
            ('Capital Salud', 'PBS', 'Subsidiado', 'Nivel 2'),
            ('Famisanar', 'PBS', 'Subsidiado', 'Nivel 1'),
            ('Famisanar', 'PBS', 'Subsidiado', 'Nivel 2'),
            ('Fomag', 'PBS', 'Especial', NULL);                       -- Plan Especial

INSERT INTO Responsables (tipo_identificacion_responsable, numero_identificacion_responsable, nombre_responsable, apellido_responsable, telefono_responsable, email_responsable, direccion_responsable)
     VALUES ('CC', '4185230', 'Juan David', 'Pérez Gómez', '3011457821', 'JuanPérez@gmail.com', 'Calle 1 #11- 22, Fusagasugá'),
            ('CC', '4284974', 'María Fernanda', 'Pérez Gómez', '3012144569', 'FernandaPerez23@gamil.com', 'Calle 1 #15 - 26, Fusagasugá'), 
            ('CE', 'A1236571', 'Carlos Andrés', 'Rodríguez López', '3013144220', 'CarlosRodriguezLopez@gmail.com', 'Calle 2 #20 - 36, Bogotá'),
            ('CE', 'B254317', 'Laura Camila', 'Martínez Torres', '3014412214', 'CamilaTorres05@gmail.com', 'Calle 2 #16 - 19, Bogotá'),
            ('CE', 'C3446551', 'Ándres Felipe', 'Rojas', '3015544795', 'FelipeRojas14@gmail.com', 'Calle 5 #56 - 69, Bogotá'),
            ('CC', '5354166', 'Paula Andrea', 'Ramírez Castro', '3016646210', 'PaulaAndreaCastro@gmail.com', 'Calle 7 #2 - 25, Bogotá'),
            ('CC', '5469989', 'Jorge Enrique', 'Gómez Herrera', '3017884513', 'EnriqueGómezHerrera@gmail.com', 'Calle 4 #5 - 12, Silvania'),
            ('Pasaporte', 'AB1549969', 'Natalia Andrea', 'Díaz Moreno', '3018989632', 'NataliaAndreaDíaz@gmail.com', 'Calle 3 #7 - 32, Silvania'),
            ('CC', '6541567', 'Sebastián', 'Vargas', '3019750311', 'SebasVargas@gmail.com', 'Calle 3 #7 - 20, Granada'),
            ('CC', '6688512', 'Mónica', 'Castillo Ruiz', '3010211010', 'MónicaRuiz@gmail.com', 'Calle 4 #12 - 25, Granada'),
            ('CE', 'D421131', 'Valentina', 'Torres Mendoza', '3021236410', 'ValentinaTorresMendoza@gmail.com', 'Calle 8 #3 - 23, Granada'),
            ('Pasaporte', 'DF2116577', 'Miguel Ángel', 'Giraldo Cárdenas', '3021645012', 'AngelGiraldo@gmail.com', 'Calle 10 #8 - 18, Sibaté'),
            ('CC', '7789666', 'Camilo Ándres', 'Rincón Pardo', '3022132210', 'CamiloPardo@gmail.com', 'Calle 9 #26 - 84, Sibaté'),
            ('CE', 'E546511', 'Diana Carolina', 'Herrera Silva', '3023114115', 'DianaCarolinaHerreraSilva@gmail.com', 'Calle 5, #22 - 64, Sibaté'),
            ('Pasaporte', 'AZ3441259', 'Martha', 'Navarro ortiz', '3024421444', 'MarthaNavarro46@gmail.com', 'Calle 10, #21 - 36, Bogotá');

INSERT INTO Pacientes (tipo_identificacion_responsable, numero_identificacion_responsable, nombre_paciente, apellido_paciente, telefono_paciente, direccion_paciente, email_paciente, fecha_nacimiento_paciente, genero_paciente, id_responsable, id_afiliacion)
     VALUES ('CC', '8126458', 'Juan Sebastián', 'Pérez Gómez', '3114598552', 'Calle 1 #12 - 26, Fusagasugá', 'JuanPerez@gmail.com', '1999-05-09', 'No Refiere', NULL, 1),
            ('CC', '8216459', 'María Camila', 'Rodríguez López', '3121210032', 'Calle 3 #7 - 20, Fusagasugá', 'CamilaLopez@gmail.com', '1960-12-20', 'Otro', NULL, 2),
            ('TI', '1003651024', 'Andrés Felipe', 'Martínez Torres', NULL, 'Calle 1 #11- 22, Fusagasugá', 'JuanPérez@gmail.com', '2020-09-01', 'Masculino', 1, 3),
            ('CE', '8426123', 'Laura Daniela', 'Sánchez Rojas', '+58 4102412589', 'Calle 10 #15 - 30, Fusagasugá', 'LauraDanielaRojas25@gmail.com', '1962-10-10', 'Femenino', NULL, 4),
            ('TI', '1012310544', 'Carlos Ándres', 'Ramírez Castro', NULL, 'Calle 1 #15 - 26, Fusagasugá', 'FernandaPerez23@gamil.com', '2019-01-20', 'Masculino', 2, 5),
            ('CC', '8689444', 'Daniela Fernanda', 'Gómez Herrera', '3132104569', 'Calle 20 #15 - 26, Fusagasugá', 'FernanadaGómez@gmail.com', '1970-09-25', 'No Refiere', NULL, 6),
            ('CC', '8821003', 'Luis Eduardo', 'Díaz Moreno', '3141116874', 'Calle 1 #3 - 15, Pasca', 'EduardoDíazMoreno@gmail.com', '1985-10-21', 'Otro', NULL, 7),
            ('CE', 'F712462', 'Paula Andrea', 'Vargas Jiménez', '+58 4201655960', 'Calle 4 #1 - 23, Pasca', 'PaulaVargas26@gmail.com', '1992-02-13', 'Femenino', NULL, 8),
            ('Pasaporte', 'AA1123559', 'Jorge Luis', 'Castillo Ruiz', '3150017999', 'Calle 7 #2 - 26, Silvania', 'LuisCastillo@gmail.com', '1950-04-28', 'Otro', NULL, 9),
            ('Certificado Nacido Vivo', 'NV - 2026 - 00012459', 'Natalia Fernanda', 'Torres Mendoza', NULL, 'Calle 2 #20 - 36, Bogotá', 'CarlosRodriguezLopez@gmail.com', '2026-01-06', 'Femenino', 3, 10),
            ('CC', '9512314', 'Sebastián', 'Giraldo Cárdenas', '3164462013', 'Calle 10 #1 - 11, Silvania', 'SebasGiraldo23@gmail.com', '1939-02-28', 'No Refiere', NULL, 11),
            ('TI', '1023115136', 'Valentina', 'Rincón Pardo', NULL, 'Calle 2 #16 - 19, Bogotá', 'CamilaTorres05@gmail.com', '2015-09-19', 'Femenino', 4, 12),
            ('TI', '1034112111', 'Miguel Ángel', 'Herrera Silva', NULL, 'Calle 5 #56 - 69, Bogotá', 'FelipeRojas14@gmail.com', '2018-10-20', 'Masculino', 5, 13),
            ('CE', 'G734561', 'Camilo Andrés', 'Navarro Ortiz', '+58 4256410211', 'Calle 14 #25 - 30, Granada', 'CamiloNavarro19@gmail.com', '1955-07-24', 'Otro', NULL, 14),
            ('Certificado Nacido Vivo', 'NV - 2026 - 00022144', 'Diana Carolina', 'Cruz Salazar', NULL, 'Calle 7 #2 - 25, Bogotá', 'PaulaAndreaCastro@gmail.com', '2025-12-31', 'Femenino', 6, 15),
            ('Pasaporte', 'BC2101644', 'Felipe Ándres', 'Morales Vega', '3178774503', 'Calle 15, # 3 - 13, Sibaté', 'FelipeMoralesVega@gmail.com', '1968-08-25', 'No Refiere', NULL, 16),
            ('CC', '9644218', 'Tatiana Alejandra', 'Castro León', '3189456221', 'Calle 20 #30 - 40, Tibacuy', 'TatiCastroLeón@gmail.com', '1973-12-13', 'Femenino', NULL, 17),
            ('Pasaporte', 'CV3122100', 'Kevin David', 'Ortiz Medina', '3191124469', 'Calle 16 #15 - 25, Tibacuy', 'KevinOrtiz15@gmail.com', '1989-11-11', 'Otro', NULL, 18),
            ('CC', '9711201', 'Juliana', 'Gómez Pineda', '3201469873', 'Calle 7 # 25 - 45, Tibacuy', 'JuliGómez64@gmail.com', '1954-12-12', 'Femenino', NULL, 19),
            ('TI', '1041131102', 'Esteban', 'Ramírez Suárez', NULL, 'Calle 4 #5 - 12, Silvania', 'EnriqueGómezHerrera@gmail.com', '2019-03-25', 'Masculino', 7, 20),
            ('TI', '1056641214', 'Angie Paola', 'Torres Ríos', NULL, 'Calle 3 #7 - 32, Silvania', 'NataliaAndreaDíaz@gmail.com', '2020-11-11', 'Femenino', 8, 21),
            ('CE', 'H845110', 'Nicolás', 'Herrera Gómez', '+593 996123049', 'Calle 25 #3 - 15, Pasca', 'NicoHerrera15@gmail.com', '1945-04-13', 'Otro', NULL, 22),
            ('CC', '9811277', 'Karen Juliana', 'López Díaz', '3210165978', 'Calle 30 #4 - 15, Tibacuy', 'KarenJulianaLopezDiaz@gmail.com', '1950-01-06', 'Otro', NULL, 23),
            ('Adulto sin Ident.', NULL, 'David Alejandro', 'Cárdenas Ruiz', '3222106556', 'Calle 42 #15 - 20, Granada', 'davidCardenas46@gmail.com', '1961-09-26', 'No Refiere', NULL, 24),
            ('TI', '1061145111', 'Laura Sofía', 'Méndez Vargas', NULL, 'Calle 3 #7 - 20, Granada', 'SebasVargas@gmail.com', '2021-07-28', 'Femenino', 9, 25),
            ('Menor sin Ident.', NULL, 'Juan Pablo', 'Rojas Castillo', NULL, 'Calle 4 #12 - 25, Granada', 'MónicaRuiz@gmail.com', '2017-08-14', 'Masculino', 10, 26),
            ('TI', '1078489122', 'Catalina', 'Pérez Hernández', NULL, 'Calle 8 #3 - 23, Granada', 'ValentinaTorresMendoza@gmail.com', '2017-07-21', 'Femenino', 11, 27),
            ('Menor sin Ident.', NULL, 'Andrés Camilo', 'Silva Romero', NULL, 'Calle 10 #8 - 18, Sibaté', 'AngelGiraldo@gmail.com', '2021-04-03', 'Masculino', 12, 28),
            ('Certificado Nacido Vivo', 'NV - 2026 - 00031469', 'Paula Jimena', 'Ortiz Castro', NULL, 'Calle 9 #26 - 84, Sibaté', 'CamiloPardo@gmail.com', '2026-02-01', 'Femenino', 13, 29),
            ('TI', '1081335199', 'Diego Fernando','Vargas León', NULL, 'Calle 5, #22 - 64, Sibaté', 'DianaCarolinaHerreraSilva@gmail.com', '2018-06-22', 'Masculino', 14, 30),
            ('Certificado Nacido Vivo', 'NV - 2026 - 00041658', 'Mariana', 'Rodríguez Pardo', NULL, 'Calle 10, #21 - 36, Bogotá', 'MarthaNavarro46@gmail.com', '2026-01-01', 'Femenino', 15, 31),
            ('CC', '9944111', 'Sergio', 'Medina Cruz', '3251420000', 'Calle 50 #1 - 15, Bogotá', 'SergioMedina@gmail.com', '1925-11-11', 'Masculino', NULL, 23);

INSERT INTO Medicos (tipo_identificacion_medico, numero_identificacion_medico, nombre_medico, apellido_medico, telefono_medico, email_medico, direccion_medico, fecha_nacimiento_medico, tarjeta_profesional)
     VALUES ('CC', '12648743', 'Juan Carlos', 'Martínez Gómez', '3261244698', 'JuanCarlosMartínez@gmail.com', 'Calle 1 #15 - 32, Bogotá', '1970-12-31', 'RM100001'),
			('CC', '13845210', 'María Fernanda', 'López Rodríguez', '3271456987', 'FernandaLópez@gmail.com', 'Calle 2 #6 - 19, Bogotá', '1960-11-12', 'RM100002'),
            ('CC', '14210001', 'Andrés Felipe', 'Torres Ramírez', '3281456988', 'AndrésTorres@gmail.com', 'Calle 3 #5 - 19, Bogotá', '1975-11-24', 'RM100003'),
            ('CC', '15631077', 'Laura Patricia', 'Sánchez Rojas', '3291156111', 'LauraSanchez@gmail.com', 'Calle 4 #9 - 29, Granada', '1990-10-01', 'RM100004'),
            ('CE', 'H964123', 'Carlos Eduardo', 'Herrera Díaz', '3301012369', 'CarlosEduardoHerreraDíaz@gmail.com', 'Calle 5 #7 - 27, Granada', '1985-09-15', 'RM100005'),
            ('CC', '16456147', 'Daniela Alejandra', 'Vargas Castro', '3151426987', 'DanielaVargasCastro@gmail.com', 'Calle 6 #12 - 25, Granada', '1974-08-16', 'RM100006'),
            ('CE', 'K333416', 'Luis Fernando', 'Gómez Moreno', '3001212103', 'LuisGomezMoreno@gmail.com', 'Calle 7 #4 - 24, Fusagasugá', '1988-07-21', 'RM100007'),
            ('CE', 'N697796', 'Paula Andrea', 'Jiménez Ruiz', '3000031698', 'PaulaJimenezRuiz@gmail.com', 'Calle 8 #16 - 36, Fusagasugá', '1979-06-29', 'RM100008'),
            ('Pasaporte', 'HZ1236632', 'Jorge Enrique', 'Castillo Pérez', '3222019785', 'JorgeCastillo@gmail.com', 'Calle 9 #36 - 46, Fusagasugá', '1969-06-09', 'RM100009'),
            ('CC', '17123411', 'Natalia Andrea', 'Mendoza Silva', '3300222198', 'NataliaMendozaSilva@gmail.com', 'Calle 10 #50 - 60, Fusagasugá', '1981-05-03', 'RM100010'),
            ('CC', '18569863', 'Sebastián', 'Giraldo Cárdenas', '3166614598', 'SebastiánGiraldoCátdenas@gmail.com', 'Calle 11 #60 - 70, Fusagasugá', '1995-04-13', 'RM100011'),
            ('Pasaporte', 'KM9874479', 'Valentina', 'Rincón Pardo', '3244223336', 'ValentinaRincónPardo@gmail.com', 'Calle 12 #15- 30, Pasca', '1990-03-14', 'RM100012'),
            ('CE', 'R845636', 'Miguel Ángel', 'Navarro Ortiz', '3011121039', 'ÁngelNavarroOrtiz@gmail.com', 'Calle 13 #1 - 16, Pasca', '1984-03-25', 'RM100013'),
            ('CC', '19230145', 'Camilo Andrés', 'Cruz Salazar', '3266969896', 'CamiloCruzSalazar@gmail.com', 'Calle 14 #6 - 10, Pasca', '1988-01-30', 'RM100014'),
            ('CC', '20478961', 'Diana Carolina', 'Morales Vega', '3051129998', 'CarolinaMoralesVega@gmail.com', 'Calle 15 #9- 20, Pasca', '1987-02-24', 'RM100015'),
            ('CE', 'V223189', 'Felipe Andrés', 'León Castro', '3501206987', 'FelipeLeón@gmail.com', 'Calle 16 #3 - 11, Silvania', '1974-01-11', 'RM100016'),
            ('Pasaporte', 'OP3633314', 'Tatiana Alejandra', 'Medina López', '3244446985', 'TatianaMedinaLópez@gmail.com', 'Calle 17 #8 - 18, Silvania', '1996-12-12', 'RM100017'),
            ('Pasaporte', 'VZ9786321', 'Kevin David', 'Ortiz Herrera', '3330362169', 'KevinOrtizHerrera@gmail.com', 'Calle 18 #20 - 28, Silvania', '1974-09-26', 'RM100018'),
            ('CC', '21239996', 'Juliana', 'Pineda Suárez', '3011699989', 'JulianaPineda@gmail.com', 'Calle 19 #6 - 22, Silvania', '1980-03-22', 'RM100019'),
            ('CC', '22987698', 'Esteban', 'Ramírez Torres', '3188969896', 'EstebanRamírezTorres@gmail.com', 'Calle 1 #4 - 16, Tibacuy', '1964-06-28', 'RM100020');

INSERT INTO Asistentes (tipo_identificacion_asistente, numero_identificacion_asistente,nombre_asistente, apellido_asistente, telefono_asistente, email_asistente, direccion_asistente, fecha_nacimiento_asistente, tipo_ayudante, id_especialidad)
     VALUES ('CC', '102398712', 'Andrea Milena', 'Torres Gómez', '3331261231', 'Andrea.Torres@gmail.com', 'Carrera 45 #34 - 56, Bogotá', '1999-12-06', 'Enfermero', 24), 
            ('CC', '110326978', 'Luis Alberto', 'Ramírez Pérez', '3321023663', 'LuisALberto.Ramírez@gmail.com', 'Carrera 03 #78 - 12, Bogotá', '2000-10-25', 'Practicante', 1),
            ('CC', '123015669', 'Diana Marcela', 'Vargas López', '3211151633', 'DianaVargas@gmail.com', 'Avenida Las Palmas #4 - 15, Fusagasugá', '1955-06-28', 'Enfermero', 22),
            ('CC', '132011123', 'Jorge Iván', 'Castillo Herrera', '3110126888', 'JorgeCastilloHerrera@gmail.com', 'Carrera 50 #14 - 14, Silvania', '2001-05-13', 'Auxiliar', 21),
            ('CC', '142036986', 'Paula Fernanda', 'Rojas Díaz', '3141023666', 'PaulaRojasDíaz@gmail.com', 'Carrera 15 #1 - 16, Tibacuy', '2002-01-12', 'Practicante', 1),
            ('CC', '153200010', 'Camilo Andrés', 'Medina Castro', '3151023333', 'CamiloMedinaCastro@gmail.com', 'Carrera 20 #12 - 26, Silvania', '1997-02-27', 'Enfermero', 23),
            ('CE', 'Z111213', 'Natalia', 'Gómez Pardo', '3181469997', 'NataliaGómez@gmail.com', 'Carrera 14 #01 - 23, Granada', '1992-03-28', 'Enfermero', 22),
            ('CC', '162298744', 'Kevin Andrés', 'Suárez Jiménez', '3201020111', 'Kevin.Súarez@gmail.com', 'Carrera 22 #06 - 36, Granada', '2005-02-28', 'Auxiliar', 21),
            ('CE', 'H665663', 'Laura Vanessa', 'Cruz Salazar', '3251023666', 'LauraVanessaCruzSalazar@gmail.com', 'Carrera 05 #12 - 02, Tibacuy', '1999-12-31', 'Practicante', 5),
            ('CC', '172236987', 'Sebastián', 'Ortiz Morales', '3291023303', 'Sebastián.Ortiz@gmail.com', 'Carrera 01 #02- 10, Pasca', '1998-07-14', 'Enfermero', 24),
            ('Pasaporte', 'AM2111036', 'Angie Carolina', 'León Vargas', '3011616000', 'Angie.León@gmail.com', 'Carrera 27 - 10, Bogotá', '1997-06-26', 'Practicante', 9),
            ('CC', '182369744', 'Felipe', 'Gómez Herrera', '3091121121', 'FelipeGómezHerrera@gmail.com', 'Avenida Boyacá #72-10, Bogotá', '1996-01-20', 'Practicante', 5),
            ('CC', '192333636', 'Daniela', 'Rincón Pineda', '3012019998', 'DanielaRincón@gmail.com', 'Carrera 10 #02 - 13, Silvania', '2000-04-19', 'Auxiliar', 21),
            ('Pasaporte', 'OO3201145', 'Andrés Felipe', 'Cárdenas Ruiz', '3300214444', 'ÁNdresCárdenas@gmail.com', 'Carrera 13 #50 - 28, Fusagasugá', '1999-03-05', 'Auxiliar', 21),
            ('CC', '201366200', 'Valentina', 'Navarro Díaz', '3221069999', 'ValentinaNavarroDíaz@gmail.com', 'Carrera 12 #46 - 65, Fusagasugá', '1998-11-11', 'Enfermero', 22),
            ('CE', 'M898874', 'Miguel Ángel', 'Torres Suárez', '3261616222', 'MiguelAngelTorres@gmail.com', 'Avenida El Dorado #100-52, Bogotá', '1998-12-24', 'Practicante', 14),
            ('Pasaporte', 'PQ2210008', 'Tatiana Alejandra', 'Castro Gómez', '3301010233', 'Tatiana.Castro@gmail.com', 'Carrera 22 #18 - 09, Tibacuy', '2003-06-21', 'Enfermero', 23),
            ('CC', '210365410', 'Juan Esteban', 'Ramírez López', '3291047777', 'JuanEstebanRamírezLópez@gmail.com', 'Carrera 07 # 14 - 18, Granada', '2004-08-04', 'Auxiliar', 21),
            ('CE', 'L369875', 'Paula Andrea', 'Herrera Silva', '3102102222', 'PaulaHerrera@gmail.com', 'Carrera 14A #10 - 12, Arbeláez', '2003-09-23', 'Practicante', 14),
            ('CE', 'P520100', 'Carlos Andrés', 'Jiménez Vega', '3169696666', 'CarlosJiménez@gmail.com', 'Carrera 20B #45 - 56, Pasca', '2000-06-25', 'Enfermero', 23),
            ('Pasaporte', 'RS2001986', 'Juliana', 'Pardo Rodríguez', '3166656693', 'JulianaPardoRodríguez@gmail.com', 'Carrera 10 # 2 - 17, Arbeláez', '1999-11-22', 'Practicante', 5),
            ('CC', '223696669', 'Nicolás', 'Vargas Mendoza', '3015068552', 'NicolásVargasMendoza@gmail.com', 'Carrera 14 # 58 - 41, Bogotá', '2004-01-24', 'Enfermero', 22),
            ('CC', '236337899', 'Diana Carolina', 'Ortiz Castro', '3181141112', 'DianaOrtiz@gmail.com', 'Carrera 2 # 05 - 14, Pasca', '2003-03-23', 'Auxiliar', 21),
            ('CC', '247779632', 'Esteban', 'Morales Ríos', '3277746981', 'Esteban.Morales@gmail.com', 'Carrera 08 #17 - 22, Sibaté', '1997-12-13', 'Practicante', 5);

INSERT INTO Cita (id_consultorio, id_medico, id_paciente, fecha_cita, hora_cita, estado_cita)
     VALUES (1, 1, 3, '2026-01-12', '07:00:00', 'Atendida'),
            (2, 1, 5, '2026-01-12', '07:30:00', 'Atendida'),
            (3, 2, 10, '2026-01-13', '08:20:00', 'Atendida'),
            (4, 1, 12, '2026-01-14', '08:40:00', 'No Asistio'),
            (5, 3, 4, '2026-01-15', '09:10:00', 'Atendida'),
            (6, 4, 8, '2026-01-16', '09:20:00', 'No Asistio'),
            (7, 5, 13, '2026-01-17', '09:40:00', 'Atendida'),
            (8, 6, 1, '2026-01-20', '09:50:00', 'Atendida'),
            (9, 7, 15, '2026-01-21', '10:00:00', 'Cancelada'),
            (10, 8, 20, '2026-01-22', '10:10:00', 'Atendida'),
            (11, 9, 21, '2026-02-23', '10:20:00', 'No Asistio'),
            (12, 10, 2, '2026-02-24', '10:40:00', 'Cancelada'),
            (13, 11, 6, '2026-02-27', '11:00:00', 'Confirmada'),
            (14, 11, 7, '2026-02-27', '11:10:00', 'Confirmada'),
            (15, 12, 29, '2026-02-28', '11:20:00', 'No Asistio'),
            (16, 13, 25, '2026-02-28', '11:30:00', 'Cancelada'),
            (17, 14, 9, '2026-02-28', '11:40:00', 'Atendida'),
            (18, 15, 26, '2026-02-02', '11:50:00', 'Atendida'),
            (1, 16, 32, '2026-02-03', '14:00:00', 'Atendida'),
            (2, 17, 30, '2026-02-04', '14:15:00', 'Atendida'),
            (3, 18, 9, '2026-03-05', '14:30:00', 'Agendada'),
            (4, 19, 31, '2026-03-06', '14:45:00', 'Cancelada'),
            (5, 20, 27, '2026-03-16', '15:20:00', 'Agendada'),
            (6, 1, 28, '2026-03-17', '15:45:00', 'Cancelada'),
            (7, 3, 17, '2026-03-18', '16:00:00', 'No Asistio'),
            (8, 4, 19, '2026-03-19', '16:15:00', 'Atendida'),
            (9, 6, 11, '2026-03-20', '16:30:00', 'Atendida'),
            (10, 10, 14, '2026-03-25', '16:45:00', 'Atendida'),
            (11, 11, 16, '2026-03-26', '17:00:00', 'Cancelada'),
            (12, 12, 18, '2026-03-27','17:10:00', 'No Asistio'),
            (13, 14, 22,'2026-04-6', '17:20:00', 'Atendida'),
            (14, 17, 23, '2026-04-7', '17:30:00', 'Atendida'),
            (15, 18, 24, '2026-04-8', '17:40:00', 'Agendada');

INSERT INTO Facturacion (id_cita, valor_factura, fecha_factura, estado_factura, tipo_cobertura, tipo_factura)
     VALUES (67, 70000.00, '2026-01-12', 'Pagada', 'EPS', 'Consulta'),
            (68, 70000.00, '2026-01-12', 'Pagada', 'EPS', 'Consulta'),
            (69, 120000.00, '2026-01-13', 'Pagada', 'EPS', 'Consulta'),
            (70, 50000.00, '2026-01-14', 'Pendiente', 'Particular', 'Multa'),
            (71, 150000.00, '2026-01-15', 'Pagada', 'EPS', 'Consulta'),
            (72, 50000.00, '2026-01-16', 'Anulada', 'Particular', 'Multa'),
            (73, 130000.00, '2026-01-17', 'Pagada', 'EPS', 'Consulta'),
            (74, 140000.00, '2026-01-20', 'Pagada', 'EPS', 'Consulta'),
            (76, 160000.00, '2026-01-22', 'Pagada', 'EPS', 'Consulta'),
            (77, 50000.00, '2026-02-23', 'Pendiente', 'Particular', 'Multa'),
            (81, 50000.00, '2026-02-28', 'Anulada', 'Particular', 'Multa'),
            (83, 110000.00, '2026-02-28', 'Pagada', 'SOAT', 'Consulta'),
            (84, 100000.00, '2026-02-02', 'Pagada', 'ARL', 'Consulta'),
            (85, 125000.00, '2026-02-03', 'Pagada', 'EPS', 'Consulta'),
            (86, 145000.00, '2026-02-04', 'Pagada', 'SOAT', 'Consulta'),
            (91, 50000.00, '2026-03-18', 'Pendiente', 'Particular', 'Multa'),
            (92, 155000.00, '2026-03-19', 'Pagada', 'ARL', 'Consulta'),
            (93, 140000.00, '2026-03-20', 'Pagada', 'EPS', 'Consulta'),
            (94, 132000.00, '2026-03-25', 'Pagada', 'SOAT', 'Consulta'),
            (96, 50000.00, '2026-03-27', 'Pendiente', 'Particular', 'Multa'),
            (97, 110000.00, '2026-04-06', 'Pagada', 'SOAT', 'Consulta'),
            (98, 145000.00, '2026-04-07', 'Pagada', 'ARL', 'Consulta');

INSERT INTO Historia_Clinica (id_cita, motivo_consulta, enfermedad_actual, revision_examenes, antecedentes, examen_fisico, diagnostico, plan_manejo)
     VALUES (67, 'Fiebre y malestar general', 'Paciente refiere fiebre y malestar general desde hace 5 días', 'No refiere', 'Niega enfermedades crónicas, alergias o cirugías previas.', 'Paciente consciente y orientado, con temperatura de 38.5 grados.', 'Infección respiratoria leve.', 'Manejo con analgésicos, hidratación y control por consulta externa.'),
            (68, 'Dolor de garganta', 'Paciente refiere dolor de garganta, acompañado de malestar general, sin fiebre, desde hace 10 días', 'No refiere', 'Paciente con antecedentes de EPOC y alergia a algunos alimentos.', 'Paciente con irritación en la garganta, ojos llorosos y debilidad al caminar.', 'Infección respiratoria aguda.', 'Manejo con analgésicos, reposo, hidratación y control en caso de persistencia de síntomas.'),
            (69, 'Control de crecimiento', 'Paciente en control de crecimiento y desarrollo.', 'Control pediátrico de rutina', 'Sin antecedentes patológicos relevantes para la edad.', 'Menor en buen estado general, sin signos de dificultad respiratoria.', 'Control de crecimiento y desarrollo normal', 'Control de crecimiento y desarrollo en 6 meses y recomendaciones nutricionales.'),
            (71, 'Dolor pélvico agudo', 'Paciente refiere dolor pélvico de inicio súbito desde hace 1 día, intensidad alta, sin sangrado asociado.', 'No refiere', 'Paciente que niega antecedenetes de enfermedades crónicas, alergias o cirugías previas.', 'Paciente con abdomen sólido, con dolor a la palpación, pero sin sangrado activo al momento de la valoración.', 'Inflamación pélvica.', 'Manejo con antibiótico, examen de la pelvis y control y seguimiento en 1 mes con resultados.'),
            (73, 'Revisión cardiológica', 'Paciente en control cardiológico por arritmia cardiaca.', 'Valoración de electrocardiograma y exámenes cardiovasculares.', 'Paciente con antecedente de hipertensión arterial controlada con medicamentos.', 'Paciente en buenas condiciones generales, consciente y orientado.', 'Control cardiovascular estable.', 'Examenes de ecocardiograma transtoracico y prueba holter, Control en 6 meses con resultados.'),
            (74, 'Migraña', 'Paciente refiere dolor de cabeza, de intensidad fuerte desde hace 15 días', 'No refiere', 'Paciente con antecedenetes familiares de migraña.', 'Paciente consciente y orientado, signos vitales estables, sin alteraciones neurológicas evidentes al examen físico.', 'Migraña sin aura.', 'Manejo con analgésicos, reposo, disminución de exposición a la luz y control por neurología.'),
            (76, 'Visión borrosa', 'Paciente refiere visión borrosa progresiva desde hace 1 mes, sin dolor ocular.', 'No refiere', 'Paciente con antecedenetes familiares de catarata.', 'Paciente con movimientos oculares conservados, sin secreciones, pero con dificultad al observar a largas distancias.', 'Astigmatismo y miopía leve', 'Uso de lágrimas artificiales, uso de lentes oftálmologicos y control oftalmológico en 1 año.'),
            (83, 'Control hipertensión', 'Paciente en control por hiértensión', 'Revisión de hemograma y perfil lipídico.', 'Paciente con antecedenetes de hipertensión arterial, arritmia cardíaca y colesterol controladas con medicamentos', 'Paciente en buenas condiciones generales, consciente y orientado.', 'Control de diabetes normal.', 'Manejo de tratamiento de diabetes y control de seguimiento en 1 año.'),
            (84, 'Dolor de rodilla', 'Paciente refiere dolor de rodilla que aumenta con el movimiento, desde hace 1 mes', 'Revisión de radiografía de rodilla.', 'Paciente con antecedenetes familiares de artritis y artrosis degenerativa.', 'Paciente con dolor a la palpación en las partes blandas de la rodilla.', 'Tendinitis rotuliana.', 'Manejo con analgésicos, reposos y terapia.'),
            (85, 'Infección urinaria', 'Dolor al orinar desde hace 3 días, acompañado de ardor y aumento en la frecuencia urinaria.', 'Revisión de examenes de parcial de orina, urocultivo, antígeno prostático (PSA) y creatinina.', 'Paciente con antecedentes de hipertensión arterial en madre y abuelo y diabetes en padre.', 'Abdomen sin dolor a la palpación, sin masas palpables.', 'Infección urinaria.', 'Manejo con antibiótico, examenes de orina y urocultivo en muestra limpia y control y seguimiento en 1 mes con resultados. '),
            (86, 'Chequeo general', 'Paciente asintomático que asiste a control de chequeo rutinario.', 'Revisión de hemograma y perfil lipídico.', 'Niega enfermedades crónicas, alergias o cirugías previas.', 'Paciente en buenas condiciones generales, consciente y orientado.', 'Paciente en buen estado, con examenes sin ninguna variación anormal.', 'Manejo antiparasitario.'),
            (92, 'Control prenatal', 'Paciente gestante asiste a control prenatal de rutina, sin síntomas asociados.', 'Revisión de ecografía y resultados hormonales.', 'Paciente que niega enfermedades crónicas, alergias o cirugías previas.', 'Paciente en buenas condiciones generales, consciente y orientado.', 'Embarazo de curso normal.', 'Continuar controles prenatales y suplementación vitamínica.'),
            (93, 'Desorientación', 'Paciente refiere desorientación por leves momentos durante el día desde hace aproximadamente un mes.', 'No refiere', 'Paciente con antecedente de migraña.', 'Paciente en buenas condiciones generales, consciente y orientado al momento de la consulta.', 'Hipoglucemia leve.', 'Manejo con alimentos altos en azúcares, examenes de sangre y control y seguimiento en 1 mes con resultados.'),
            (94, 'Estrés', 'Paciente refiere estrés desde hace varias semanas, con episodios de insomnio', 'No refiere', 'Paciente con antecedentes de ansiedad generalizada controlada con medicamentos.', 'Paciente con lenguaje coherente y adecuado contacto visual.', 'Estres postraumático tras un evento traumático para el paciente.', 'Manejo con antidepresivos y psicoterapia.'),
            (97, 'Control y seguimiento diabetes', 'Paciente en control de diabetes, asintomático actualmente', 'Revisión de hemograma y perfil lipídico', 'Paciente con antecedentes de diabetes en madre e hipertensión arterial en padre', 'Paciente en buenas condiciones generales, consciente y orientado.', 'Paciente estable en control de diabetes.', 'Manejo de medicamentos para la diabetes, examenes de laboratorio y control de seguimiento en 6 meses con resultados.'),
            (98, 'Control médico familiar', 'Paciente asiste a control de medicina familiar, actualmente sin sintomatología.', 'No refiere', 'Sin antecedentes patológicos relevantes para la edad.', 'Paciente en buenas condiciones generales, consciente y orientado.', 'Paciente sano en control.', 'Examenes de laboratorio y control en 6 meses con resultados.');

INSERT INTO Medico_Especialidad (id_especialidad, id_medico)
     VALUES (1, 1),
            (2, 2),
            (3, 3),
            (4, 4),
            (5, 5),
            (6, 6),
            (7, 7),
            (8, 8),
            (9, 9),
            (10, 10),
            (11, 11),
            (12, 12),
            (13, 13),
            (14, 14),
            (15, 15),
            (16, 16),
            (17, 17),
            (18, 18),
            (19, 19),
            (20, 20);

INSERT INTO Asistente_Cita ()
     VALUES (1, 67),
            (2, 68),
            (3, 69),
            (4, 70),
            (5, 71),
            (6, 72),
            (7, 73),
            (8, 74),
            (9, 75),
            (10, 76),
            (11, 77),
            (12, 78),
            (13, 79),
            (14, 80),
            (15, 81),
            (16, 82),
            (17, 83),
            (18, 84),
            (19, 85),
            (20, 86),
            (21, 87),
            (22, 88),
            (23, 89),
            (24, 90),
            (5, 91),
            (6, 92),
            (8, 93),
            (12, 94),
            (14, 95),
            (15, 96),
            (17, 97),
            (20, 98),
            (21, 99);
     
     
     ALTER TABLE facturacion
     ADD tipo_factura ENUM('Consulta', 'Multa') NOT NULL;
     
     SELECT 
    p.id_paciente,
    a.entidad,
    a.plan_beneficios,
    a.regimen,
    a.nivel_estrato
FROM pacientes p
JOIN afiliaciones a 
    ON p.id_afiliacion = a.id_afiliacion;
    
    SELECT *
    FROM Cita
    WHERE estado_cita = 'Atendida'