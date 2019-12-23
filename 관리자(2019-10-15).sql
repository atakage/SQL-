-- 여기는 관리자 화면


CREATE TABLESPACE grade_db
DATAFILE '/bizwork/oracle/data/grade.dbf'
SIZE 10M AUTOEXTEND ON NEXT 10K;




CREATE USER grade IDENTIFIED BY grade
DEFAULT TABLESPACE grade_db;
GRANT DBA TO grade;


SELECT * FROM all_users WHERE username = 'GRADE';

