sqlplus / as sysdba;

sqlplus system/Manager1

alter session set "_ORACLE_SCRIPT"=true;
conn recursos/admin



CREATE TABLESPACE EMPLEADOS
	DATAFILE 'C:\Datos\empleados01.dbf' SIZE 250M
	AUTOEXTEND ON NEXT 1M MAXSIZE 300M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 200K
	SEGMENT SPACE MANAGEMENT AUTO;
    
CREATE TABLESPACE EMPLEADOS2
	DATAFILE '/u01/ordata/bdEmpleados/dat/empleados02.dbf' SIZE 250M
	AUTOEXTEND ON NEXT 1M MAXSIZE 300M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 200K
	SEGMENT SPACE MANAGEMENT AUTO;

create table departamentos(
codigo_depto number(6) not null,
nombre_depto varchar2(30) not null,
constraint pk_depto primary key(codigo_depto)
);

insert into departamentos(codigo_depto, nombre_depto) values(0101, 'Guatemala');
select * from departos;

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

create table puestos(                                               
    codigo_puesto number(6) not null,
    departamento_puesto varchar2(45) not null,
    descripcion varchar2(45) not null,
    constraint pk_codigo_puesto primary key(codigo_puesto)
);

create table sueldos(
    codigo_sueldo number(6) not null,
    puesto number(6) not null,
    sueldo_minimo number(6) not null,
    sueldo_maximo number(6) not null,
    constraint pk_codigo_sueldo primary key(codigo_sueldo),
    constraint fk_puestos foreign key(puesto) references puestos(codigo_puesto)
);










