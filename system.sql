GRANT CREATE VIEW TO SCOTT;

GRANT CREATE SYNONYM TO SCOTT;

CREATE USER ORCLSTUDY
IDENTIFIED BY orcl;

GRANT SELECT, INSERT ON EMP TO ORCLSTUDY;

GRANT RESOURCE, CREATE SESSION, CREATE TABLE, CONNECT TO ORCLSTUDY;

CREATE USER PARK
IDENTIFIED BY tiger;

GRANT RESOURCE, CONNECT TO PARK;