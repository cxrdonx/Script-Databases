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
    constraint fk_depto_trabajo foreign key(depto_trabajo) references depto_trabajo(codigo_dpto_trabajo),
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

create table historial_puesto(
    codigo_historial_puesto number(6) not null,
    empleado number(6) not null,
    contratacion 
    departamento
    escolaridad
)

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

create table historial_puesto(
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
    pk_codigo_historial primary key(codigo_historial),
    empleado fk_empleado references empleados(codigo_empleado),
    puesto fk_puesto references puestos(codigo_puesto)

);

/*rollback*/
/*commit*/




