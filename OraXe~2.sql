alter session set "_ORACLE_SCRIPT"=true;
conn recursos/admin

create table departamentos(
codigo_depto number(6) not null,
nombre_depto varchar2(30) not null,
constraint pk_depto primary key(codigo_depto)
);