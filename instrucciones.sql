/*  MATAR SESIONES DE USUARIOS */
SQL> SELECT a.USERNAME, a.SID, a.SERIAL#, b.SPID
       FROM v$session a, v$process  b
       WHERE  a.PADDR= b.ADDR
       ORDER by 1;

    ALTER SYSTEM KILL SESSION 'SID, SERIAL#';

/*MATAR LA SESION LUEGO DE IDENTIFICARLA EN unix: */
#kill -9 56061



SQL> insert into depto_trabajo values(111, 'Gerencia General');

1 row created.

SQL> insert into depto_trabajo values(112, 'Financiero');

1 row created.

SQL> insert into depto_trabajo values(113, 'Tecnologia de informacion');

1 row created.

SQL> select * from depto_trabajo;

CODIGO_DEPTO_TRABAJO DESCRIPCION
-------------------- ------------------------------
                 111 Gerencia General
                 112 Financiero
                 113 Tecnologia de informacion

SQL>



SQL> insert into puestos values(001, 1, 'Gerente General');                                         
1 row created.

SQL> insert into puestos values(002, 1, 'Sub gerente general');

1 row created.

SQL> insert into puestos values(003, 1, 'Gerente It');

1 row created.

SQL> insert into puestos values(004, 3, 'Jefe base de datos');

1 row created.

SQL> insert into puestos values(005, 3, 'Jefe de desarrollo');

1 row created.

SQL>


 1  create sequence id
  2* start with 90 increment bi 12
SQL> create sequence id
  2  start with 90
  3  increment by 12
  4  cache 1200;
