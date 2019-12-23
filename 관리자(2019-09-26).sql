-- SQL 명령들을 사용해서 DBMS 학습을 진행
-- 11g의 명령세트를 학습
-- 현재 최신 오라클은 19c, 18c인데 현업에서 사용하는 오라클 DBMS SW들이 아직 하위버전을 사용하고 있어서
-- 11위주의 명령세트를 학습

-- 마이그레이션
-- 버전업, 업그레이드
-- 하위버전에서 사용하던 데이터베이스((물리적 storage에 저장된 데이터들)를 상위버전 또는 다른회사의 DBMS에서 사용할 수 있도록
-- 변환, 변경, 이전하는 것들

-- 오라클 DBMS SW(오라클DB, 오라클)를 이용해 DB관리 명령어 연습하기 위해서 연습용 데이터 공간을 생성
-- 오라클에서는 storage에 생성한 물리적 저장공간을 TABLESPACE라고 함
-- 기타 MySQL, MSSQL 등의 DBMS SW들은 물리적 저장공간을 DATABASE라고 함

-- DDL 명령을 사용해서 TABLESPACE를 생성
-- DDL 명령을 사용하는 DBA(DataBase Administrator, 데이터 베이스 관리자)


-- DDL 명령에서 '생성'은 'CREATE'(물리적 SCHEMA를 생성)
CREATE TABLESPACE_; --TABLESPACE를 생성
CREATE USER; 새로운 접속 사용자를 생성
CREATE TABLE; 구체적인 데이터 저장할 공간을 생성

-- DDL 명령에서 '삭제, 제거'는 'DROP'
-- DDL 명령에서 '변경'은 'ALTER'

-- C:\bizwork\oracle\data
-- C:/bizwork/oracle/data/user1.dbf 파일 이름으로 물리적 저장소를 생성
CREATE TABLESPACE user_1_DB
DATAFILE 'C:/bizwork/oracle/data/user1.dbf'
SIZE 100M;

DROP TABLESPACE user_1_DB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

CREATE TABLESPACE user_1_DB             
DATAFILE 'C:/bizwork/oracle/data/user1.dbf'
SIZE 100M AUTOEXTENDS ON NEXT 100k; -- 초기에 100MB만큼의 공간을 확보 만약 사용 중에 용량이 부족하면 100k씩 공간 


-- 현재 이 화면에서 명령을 수행하는 사용자는 SYSDBA 권한을 가진 사람이다 SYSDBA 권한은 System DB등을 삭제하거나 변경할 수 있기 때문에
-- 실습환경에서는 꼭 필요한 명령 외에는 사용하지 않는 것ㅎ이 좋음ㄴ



CREATE USER user1 IDENTIFIED BY 1234 -- 실습을 위해 새로운 사용자 생성, 오라클에서는 관리자가 새로운 사용자를 생성하면 아무런 권한도 없는 상태이기 때문에
                                                -- id, password를 입력해도 접속 자체 되지 않음, 관리자는 새로 생성된 사용자에게 DBMS에 접속할 수 있는 권한ㅇ르 부여(DCL)
                                                
                                                --권한 부여: GRANT , 권한 뺏기: REVOKE
DEFAULT TABLESPACE user_1_DB;

GRANT CREATE SESSION TO user1;

-- DBA는 SYSDBA에 비해 상당히 제한적으로 권한을 부여받는다 일부 DDL, DML, DCL 명령 사용

GRANT DBA TO user1;
REVOKE DBA FROM user1;