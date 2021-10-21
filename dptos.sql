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

create table departamentos(
codigo_depto integer not null,
nombre_depto varchar(30) not null,
constraint pk_depto primary key(codigo_depto)
);

create table municipios(
    codigo_municipio integer not null,
    codigo_depto integer not null,
    nombre_municipio varchar(30) not null,
    constraint pk_municipios primary key(codigo_municipio),
    constraint fk_departamentos foreign key(codigo_depto) references departamentos(codigo_depto)
);

create table depto_trabajo(
    codigo_depto integer not null,
    codigo_municipio integer not null,
    constraint pk_depto_trabajo primary key(codigo_depto,codigo_municipio),
    constraint fk_departamentos foreign key(codigo_depto) references departamentos(codigo_depto),
    constraint fk_municipios foreign key(codigo_municipio) references municipios(codigo_municipio)
);







