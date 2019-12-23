-- 관리자 화면



CREATE TABLESPACE iolist_DB DATAFILE '/bizwork/oracle/data/iolist.dbf' SIZE 50M AUTOEXTEND ON NEXT 10K;


CREATE USER iolist IDENTIFIED BY iolist DEFAULT TABLESPACE iolist_DB;

GRANT DBA TO iolist;






