/* see Oracle.md if starting here doesn't work */

/*
## The code here was tested in SQL Plus on Windows.

## The following links didn't help:
* https://docs.oracle.com/database/121/SQLRF/statements_6010.htm#SQLRF55686
* https://oracle-base.com/articles/12c/multitenant-create-and-configure-pluggable-database-12cr1
*/

/* connect to root database */
CONN / AS SYSDBA

/* create a new pluggable database */
/* FILE_NAME_CONVERT is only necessary if you are not using "oracle managed files." (ORACLE-BASE.COM, 2015)*/
/*
create pluggable database wdpdb admin user pbappsetup identified by arst2020#PW
FILE_NAME_CONVERT=('/u01/app/oracle/oradata/cdb1/pdbseed/',
                   '/u01/app/oracle/oradata/cdb1/wdpdb/');
*/
/*(ORACLE-BASE.com, 2015)*/
/* If on Windows, the command above results in an error:
ORA-65005: missing or invalid file name pattern for file -
C:\APP\OWNER\PRODUCT\18.0.0\ORADATA\XE\PDBSEED\SYSTEM01.DBF
 */
/*(ORACLE-BASE.com, 2015)*/
create pluggable database wdpdb admin user pbappsetup identified by arst2020#PW
    FILE_NAME_CONVERT=(
        'C:\APP\OWNER\PRODUCT\18.0.0\ORADATA\XE\pdbseed',
        'C:\APP\OWNER\PRODUCT\18.0.0\ORADATA\XE\wdpdb'
    );


select pdb_name, status
from dba_pdbs
order by pdb_name;
/* should show:
 PDB$SEED NORMAL
 WDPDB NEW
 XEPDB1 NORMAL
*/
/* since NEW, initialize: */
alter pluggable database wdpdb open read write;
/* the previous query should now show:
 PDB$SEED NORMAL
 WDPDB NORMAL
 XEPDB1 NORMAL
*/

select name, open_mode
from v$pdbs
order by name;
/*(ORACLE-BASE.com, 2015)*/
/* The open_mode for the database should now be:
READ WRITE */

/*The password cannot have quotes.*/
/*
Only global users require a container,
so ignore these commented statements.
create user c##pbappsetup identified by arst1906#DB;
create user c##pbapp identified by arst2020#PW;
*/
/* Connect to the pluggable database (in XE--
`select name from V$database`
or `select * from global_name;` only list XE)
connect sys/oracle@localhost:1521/wdpdb as sysdba
*/
connect pbappsetup/arst1906#DB@localhost:1521/wdpdb as sysdba
/* above should work */
/* (MUST BE CAPITALIZED) should show WDAPPSETUP, but only when connected: */
select username from all_users where username like '%WD%';

/* below will only work in SQL Plus if as a single line */
/* login fails unless as sysdba so skip these commented statements
grant CONNECT, CREATE SESSION, CREATE TABLE, UNLIMITED TABLESPACE, CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE to pbappsetup;
disconnect
connect / as sysdba
grant CREATE SESSION to pbappsetup;
connect pbappsetup/arst1906#DB@localhost:1521/wdpdb */



/* A common role can be granted to a common or local user
in a container database (CDB) that contains a PDB
(pluggable database), but only a local role or user
is required in order to have priveleges to the 
PDB (Hall, n.d.).
WDPDB is a container AND a pdb:
select name from V$CONTAINERS;
select name from V$PDBS;
*/
alter session set container = wdpdb;


/*
create role c##WD_DBA_ROLE;
grant c##WD_DBA_ROLE to c##pbapp;
*/
/* pbapp does not exist */
/* c##pbapp does not exist */
/*TODO: instead of above, do something like:
create role c##WD_PUBLISH_SCHEDULE_ROLE;
create role c##WD_DBA_ROLE;
grant c##WD_PUBLISH_SCHEDULE_ROLE to pbapp;
grant c##WD_DBA_ROLE to pbappsetup;
*/

/*
grant WD_DBA_ROLE to owner;
grant WD_PUBLISH_SCHEDULE_ROLE to owner;
*/

/*
create database pbappdb
    user pbapp identified by 'arst2020#PW'
   LOGFILE GROUP 1 ('C:\Users\Owner\oradata\wddb\redo01.log') SIZE 100M,
           GROUP 2 ('C:\Users\Owner\oradata\wddb\redo02.log') SIZE 100M,
           GROUP 3 ('C:\Users\Owner\oradata\wddb\redo03.log') SIZE 100M
   MAXLOGFILES 5
   MAXLOGMEMBERS 5
   MAXLOGHISTORY 1
   MAXDATAFILES 100
   CHARACTER SET US7ASCII
   NATIONAL CHARACTER SET AL16UTF16
   EXTENT MANAGEMENT LOCAL
   DATAFILE 'C:\Users\Owner\oradata\wddb\system01.dbf' SIZE 325M REUSE
   SYSAUX DATAFILE 'C:\Users\Owner\oradata\wddb\sysaux01.dbf' SIZE 325M REUSE
   DEFAULT TABLESPACE users
      DATAFILE 'C:\Users\Owner\oradata\wddb\users01.dbf'
      SIZE 500M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
   DEFAULT TEMPORARY TABLESPACE tempts1
      TEMPFILE 'C:\Users\Owner\oradata\wddb\temp01.dbf'
      SIZE 20M REUSE
   UNDO TABLESPACE undotbs
      DATAFILE 'C:\Users\Owner\oradata\wddb\undotbs01.dbf'
      SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
*/
/*
CREATE DATABASE pbappdb
   USER SYS IDENTIFIED BY sys_password
   USER SYSTEM IDENTIFIED BY system_password
   LOGFILE GROUP 1 ('C:\Users\Owner\oradata\wddb\redo01.log') SIZE 100M,
           GROUP 2 ('C:\Users\Owner\oradata\wddb\redo02.log') SIZE 100M,
           GROUP 3 ('C:\Users\Owner\oradata\wddb\redo03.log') SIZE 100M
   MAXLOGFILES 5
   MAXLOGMEMBERS 5
   MAXLOGHISTORY 1
   MAXDATAFILES 100
   CHARACTER SET US7ASCII
   NATIONAL CHARACTER SET AL16UTF16
   EXTENT MANAGEMENT LOCAL
   DATAFILE 'C:\Users\Owner\oradata\wddb\system01.dbf' SIZE 325M REUSE
   SYSAUX DATAFILE 'C:\Users\Owner\oradata\wddb\sysaux01.dbf' SIZE 325M REUSE
   DEFAULT TABLESPACE users
      DATAFILE 'C:\Users\Owner\oradata\wddb\users01.dbf'
      SIZE 500M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
   DEFAULT TEMPORARY TABLESPACE tempts1
      TEMPFILE 'C:\Users\Owner\oradata\wddb\temp01.dbf'
      SIZE 20M REUSE
   UNDO TABLESPACE undotbs
      DATAFILE 'C:\Users\Owner\oradata\wddb\undotbs01.dbf'
      SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
*/
/*(“Database administrator’s guide,” n.d.)*/

/*                 References

Database administrator’s guide. (n.d.). Retrieved June 23, 2019, from https://docs.oracle.com/cd/B28359_01/server.111/b28310/create003.htm#i1008985

Hall, T. (n.d.). Multitenant : manage users and privileges for container databases (CDB) and pluggable databases (PDB) in oracle database 12c release 1(12.1). Retrieved June 24, 2019, from oracle-base.com website: https://oracle-base.com/articles/12c/multitenant-manage-users-and-privileges-for-cdb-and-pdb-12cr1

ORACLE-BASE.com (Director). (2015). *Multitenant : create a pluggable database (PDB)*. Retrieved from https://www.youtube.com/watch?v=dPHerZHvUyk

*/
