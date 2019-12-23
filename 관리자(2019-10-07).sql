-- 여기는 관리자 화면

-- 개념 Schema는 DBMS 차원에서 바라본 Schema로 Table 등과 같은 저장소 Object를 모아놓은 그룹
-- 오라클에서는 User가 개념 Schema 역할을 수행

CREATE TABLESPACE user3_db
DATAFILE '/bizwork/oracle/data/user3.dbf'
SIZE 10M AUTOEXTEND ON NEXT 1K;


CREATE USER user3 IDENTIFIED BY 1234
DEFAULT TABLESPACE user3_db;

GRANT DBA TO user3;