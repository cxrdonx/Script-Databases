/*database dptos 1) tables:
catalgo de departamentos con codigo y nombre 
*/
/*primera entidad: departamentos*/
/* segunda entidad: depto_trabajo
tercera entidad: puestos
cuarta entidad: empleados 
quinta entidad: historial_puestos
sexta entidad: sueldo_empleado100
septima entidad: sueldo_empleado 103
*/

alter session set "_ORACLE_SCRIPT" = true;

create tablespace empleados2 datafile '/opt/oracle/oradata/XE/empleados001.dbf' size 350M;

create user recursos
profile default identified by admin
default tablespace empleados2
temporary tablespace temp account unlock;

GRANT CONNECT TO recursos;
GRANT RESOURCE TO recursos;
ALTER USER recursos QUOTA UNLIMITED on empleados2;

conn recursos/admin;

create table departamentos(
codigo_depto number(6) not null,
nombre_depto varchar2(30) not null,
constraint pk_depto primary key(codigo_depto)
);

create table municipios(
    codigo_municipio number(6) not null,
    codigo_depto number(6) not null,
    nombre_municipio varchar2(30) not null,
    constraint pk_municipios primary key(codigo_municipio),
    constraint fk_departamentos foreign key(codigo_depto) references departamentos(codigo_depto)
);


alter table municipios modify(
    nombre_municipio varchar2(45)
);

create table depto_trabajo(
    codigo_dpto_trabajo number(6) not null,
    descripcion varchar2(30) not null,
    constraint pk_depto_trabajo primary key(codigo_dpto_trabajo)
);

create table puestos(                                               /*la tabla puestos depende de la tabla sueldos y viceversa y esto no puede ser asi */
    codigo_puesto number(6) not null,
    departamento varchar2(45) not null,
    descripcion varchar2(45) not null,
    constraint pk_codigo_puesto primary key(codigo_puesto),
);

create table sueldos(
    codigo_sueldo number(6) not null,
    puesto number(6) not null,
    sueldo_minimo number(6) not null,
    sueldo_maximo number(6) not null,
    constraint pk_codigo_sueldo primary key(codigo_sueldo),
    constraint fk_puestos foreign key(puesto) references puestos(codigo_puesto)
);

create table jefes(
    codigo_jefe number(6) not null,
    nombre_jefe varchar2(45) not null,   /*nombre jefe no es llave foramea(hasta ahora)*/
    constraint pk_codigo_jefe primary key(codigo_jefe),
);

create table empleados(
    codigo_empleado number(6) not null,
    depto_trabajo number(6) not null,
    puesto number(6) not null,
    salario number(6) not null,
    jefe_inmediato number(6),
    departamento number(6) not null,
    municipio number(6) not null,
    nombre varchar2(30) not null,
    dpi int not null,
    correo varchar2(45) not null,
    direccion varchar2(45) not null,
    telefono_casa int not null,
    telefono_celular int not null,
    constraint pk_codigo_empleado primary key (codigo_empleado),
    constraint depto_trabajo foreign key(depto_trabajo) references depto_trabajo(codigo_depto_trabajo),
    constraint fk_puesto foreign key (puesto) references puestos(codigo_puesto),
    constraint fk_salario foreign key (salario) references sueldos(codigo_sueldo),
    constraint fk_jefe_inmediato foreign key (jefe_inmediato) references jefes(codigo_jefe),
    constraint fk_departamento foreign key (departamento) references departamentos(codigo_depto),
    constraint fk_municipio foreign key (municipio) references municipios(codigo_municipio)
             /*eliminar fecha de contrataciones y realizar su propia tabla ???*/
);

create table contrataciones(
    codigo_contratacion number(6) not null,
    empleado number(6) not null,
    fecha_inicio date not null,
    fecha_fin date not null,
    constraint pk_codigo_contratacion primary key(codigo_contratacion),
    constraint fk_empleado foreign key(empleado) references empleados(codigo_empleado)
);

create table escolaridad(
    codigo_escolaridad number(6) not null,
    titulo_obtenido varchar2(20) not null,
    escolaridad varchar2(20) not null,
    anio_culminacion date,
    constraint pk_codigo_escolaridad primary key(codigo_escolaridad)
);
)

create table historial_puesto(
    codigo_historial_puesto number(6) not null,
    empleado number(6) not null,
    contratacion number(6) not null, 
    departamento number(6) not null,
    escolaridad number(6) not null,
    constraint pk_codigo_historial_puesto primary key(codigo_historial_puesto),
    constraint fk_empleado_historial foreign key(empleado) references empleados(codigo_empleado),
    constraint fk_contratacion_historial foreign key(contratacion) references contrataciones(codigo_contratacion),
    constraint fk_departamento_historial foreign key(departamento) references departamentos(codigo_depto),
    constraint fk_escolaridad_historial foreign key(escolaridad) references escolaridad(codigo_escolaridad)
);

create table escolaridad(
    codigo_escolaridad number(6) not null,
    titulo_obtenido varchar2(45) not null,
    escolaridad varchar2(30) not null,
    año_culminacion date,
    constraint pk_codigo_escolaridad primary key(codigo_escolaridad)
);

create table descuentos(
    codigo_descuento number(6) not null,
    descripcion_descuento varchar2(45) not null,
    cantidad number(6) not null,
    constraint pk_codigo_descuento primary key(codigo_descuento)
);

create table historial_sueldo(
    codigo_historial number(6) not null,
    empleado number(6) not null,
    puesto number(6) not null,
    periodo_trabajado varchar2(20) not null,
    fecha_pago date,
    sueldo_base number(15) not null,
    dias_trabajados number(10) not null,
    bonificacion number(8) not null,
    igss number(10) not null,
    otros_descuentos number(6) not null,
    sueldo_neto number(10) not null,
    constraint pk_codigo_historial_sueldo primary key(codigo_historial),
    constraint fk_empleado_historial_sueldo foreign key(empleado) references empleados(codigo_empleado),
    constraint fk_puesto_historial_sueldo foreign key(puesto) references puestos(codigo_puesto),
    constraint fk_descuentos_sueldo foreign key(otros_descuentos) references descuentos(codigo_descuento)
);

 

insert into departamentos values(010,'Guatemala');
insert into departamentos values(020,'El progreso');
insert into departamentos values(030, 'Sacatepequez');
insert into departamentos values(040, 'Chimaltenango');
insert into departamentos values(050, 'Escuintla');
insert into departamentos values(060, 'Santa Rosa');
insert into departamentos values(070, 'Solola');
insert into departamentos values(080, 'Totonicapan');
insert into departamentos values(090, 'Quetzaltenango');
insert into departamentos values(100, 'Suchitepequez');
insert into departamentos values(110, 'Retalhuleu');
insert into departamentos values(120, 'San Marcos');
insert into departamentos values(130, 'Huehuetenango');
insert into departamentos values(140, 'Quiche');
insert into departamentos values(150, 'Baja Verapaz');
insert into departamentos values(160, 'Alta Verapaz');
insert into departamentos values(170, 'Peten');
insert into departamentos values(180, 'Izabal');
insert into departamentos values(200, 'Chiquimula');
insert into departamentos values(210, 'Jalapa');
insert into departamentos values(220, 'Jutiapa');

/*
010 DEPARTAMENTO DE GUATEMALA
Código Municipios
0101 Municipio de Guatemala
0102 Santa Catarina Pinula
0103 San José Pinula
0104 San José del Golfo
0105 Palencia
0106 Chinautla
0107 San Pedro Ayampuc
0108 Mixco
0109 San Pedro Sacatepéquez
0110 San Juan Sacatepéquez
0111 San Raimundo
0112 Chuarrancho
0113 Fraijanes
0114 Amatitlán
0115 Villa Nueva
0116 Villa Canales
0117 Petapa
*/

insert into municipios values(0101, 010, 'Municipio de Guatemala');
insert into municipios values(0102, 010, 'Santa Catarina Pinula');
insert into municipios values(0103, 010, 'San Jose Pinula');
insert into municipios values(0104, 010, 'San José del Golfo');
insert into municipios values(0105, 010, 'Palencia');
insert into municipios values(0106, 010, 'Chinautla');
insert into municipios values(0107, 010, 'San Pedro Ayampuc');
insert into municipios values(0108, 010, 'Mixco');
insert into municipios values(0109, 010, 'San Pedro Sacatepéquez');
insert into municipios values(0110, 010, 'San Juan Sacatepéquez');
insert into municipios values(0111, 010, 'San Raimundo');
insert into municipios values(0112, 010, 'Chuarrancho');
insert into municipios values(0113, 010, 'Fraijanes');
insert into municipios values(0114, 010, 'Amatitlán');
insert into municipios values(0115, 010, 'Villa Nueva');
insert into municipios values(0116, 010, 'Villa Canales');
insert into municipios values(0117, 010, 'Petapa');
/*
020 DEPARTAMENTO DE EL PROGRESO
Código Municipios
0201 Guastatoya
0202 Morazán
0203 San Agustín Acasaguastlán
0204 San Cristobal Acasaguastlán
0205 El Jícaro
0206 Sansare
0207 Sanarate
0208 San Antonio La Paz
*/

insert into municipios values(0201, 020, 'Guastatoya');
insert into municipios values(0202, 020, 'Morazan');
insert into municipios values(0203, 020, 'San Agustín Acasaguastlan');
insert into municipios values(0204, 020, 'San Cristobal Acasaguastlan');
insert into municipios values(0205, 020, 'El Jicaro');
insert into municipios values(0206, 020, 'Sansare');
insert into municipios values(0207, 020, 'Sanarate');
insert into municipios values(0208, 020, 'San Antonio La Paz');

/*
030 DEPARTAMENTO DE SACATEPÉQUEZ
Código Municipios
0301 Antigua Guatemala
0302 Jocotenango
0303 Pastores
0304 Sumpango
0305 Santo Domingo Xenacoj
0306 Santiago Sacatepéquez
0307 San Bartolomé Milpas Altas
0308 San Lucas Sacatepéquez
0309 Santa Lucia Milpas Altas
0310 Magdalena Milpas Altas
0311 Santa María de Jesus
0312 Ciudad Vieja
0313 San Miguel Dueñas
0314 Alotenango
0315 San Antonio Aguas Calientes
0316 Santa Catalina Barahona
*/

insert into municipios values(0301, 030, 'Antigua Guatemala');
insert into municipios values(0302, 030, 'Jocotenango');
insert into municipios values(0303, 030, 'Pastores');
insert into municipios values(0304, 030, 'Sumpango');
insert into municipios values(0305, 030, 'Santo Domingo Xenacoj');
insert into municipios values(0306, 030, 'Santiago Sacatepéquez');
insert into municipios values(0307, 030, 'San Bartolomé Milpas Altas');
insert into municipios values(0308, 030, 'San Lucas Sacatepéquez');
insert into municipios values(0309, 030, 'Santa Lucia Milpas Altas');
insert into municipios values(0310, 030, 'Magdalena Milpas Altas');
insert into municipios values(0311, 030, 'Santa María de Jesus');
insert into municipios values(0312, 030, 'Ciudad Vieja');
insert into municipios values(0313, 030, 'San Miguel Dueñas');
insert into municipios values(0314, 030, 'Alotenango');
insert into municipios values(0315, 030, 'San Antonio Aguas Calientes');
insert into municipios values(0316, 030, 'Santa Catalina Barahona');

/*
040 DEPARTAMENTO DE CHIMALTENANGO
Código Municipios
0401 Chimaltenango
0402 San José Poaquil
0403 San MartÍn Jilotepeque
0404 Comalapa
0405 Santa Apolonia
0406 Tecpan Guatemala
0407 Patzun
0408 Pochuta
0409 Patzicía
0410 Santa Cruz Balanya
0411 Acatenango
0412 Yepocapa
0413 San Andrés Itzapa
0414 Parramos
0415 Zaragoza
0416 El Tejar

*/
insert into municipios values(0401, 040, 'Chimaltenango');
insert into municipios values(0402, 040, 'San José Poaquil');
insert into municipios values(0403, 040, 'San Martín Jilotepeque');
insert into municipios values(0404, 040, 'Comalapa');
insert into municipios values(0405, 040, 'Santa Apolonia');
insert into municipios values(0406, 040, 'Tecpan Guatemala');
insert into municipios values(0407, 040, 'Patzun');
insert into municipios values(0408, 040, 'Pochuta');
insert into municipios values(0409, 040, 'Patzicia');
insert into municipios values(0410, 040, 'Santa Cruz Balanya');
insert into municipios values(0411, 040, 'Acatenango');
insert into municipios values(0412, 040, 'Yepocapa');
insert into municipios values(0413, 040, 'San Andrés Itzapa');
insert into municipios values(0414, 040, 'Parramos');
insert into municipios values(0415, 040, 'Zaragoza');
insert into municipios values(0416, 040, 'El Tejar');

/*050 DEPARTAMENTO DE ESCUINTLA
Código Municipios
0501 Escuintla
0502 Santa Lucía Cotzumalguapa
0503 La Democracia
0504 Siquinala
0505 Masagua
0506 Tiquisate
0507 La Gomera
0508 Guanagazapa
0509 San José
0510 Iztapa
0511 Palín
0512 San Vicente Pacaya
0513 Nueva Concepción
*/

insert into municipios values(0501, 050, 'Escuintla');
insert into municipios values(0502, 050, 'Santa Lucía Cotzumalguapa');
insert into municipios values(0503, 050, 'La Democracia');
insert into municipios values(0504, 050, 'Siquinala');
insert into municipios values(0505, 050, 'Masagua');
insert into municipios values(0506, 050, 'Tiquisate');
insert into municipios values(0507, 050, 'La Gomera');
insert into municipios values(0508, 050, 'Guanagazapa');
insert into municipios values(0509, 050, 'San José');
insert into municipios values(0510, 050, 'Iztapa');
insert into municipios values(0511, 050, 'Palín');
insert into municipios values(0512, 050, 'San Vicente Pacaya');
insert into municipios values(0513, 050, 'Nueva Concepción');









