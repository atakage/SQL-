-- 관리자 화면

/*
    TABLESPACE 생성
    
*/

CREATE TABLESPACE USER4_DB DATAFILE '/bizwork/oracle/data/user4.dbf' SIZE 10M AUTOEXTEND ON NEXT 10K;


CREATE USER user4 IDENTIFIED BY user4 DEFAULT TABLESPACE user4_db;




-- 사용자를 생성하면서 DEFAULT TABLESPACE를 지정하지 않으면 SYSTEM(관리자, 오라클 DBMS가 사용하는 영역)의 TABLESPACE 영역을 사용, 작은 규모에서는 문제가 없지만
-- SYSTEM 영역을 사용하는 것은 여러가지(보안, 관리) 측면에서 좋은 방법이 아님


ALTER USER user4 DEFAULT TABLESPACE user4_db;       -- 이미 생성된 사용자ID의 TABLESPACE를 변경

-- 사용자를 생성하고, TABLE 등을 생성한 후 DEFAULT TABLESPACE를 변경하면 보통 DBMS에서 TABLE 등을 TABLESPACE로 옮겨줌
-- DATA 많거나 하면 문제를 일으키는 경우도 이음, 사용중(TABLE)인 경우에는 가급적 변경X

ALTER USER user4 IDENTIFIED BY user4; -- 사용자의 password를 변경


ALTER TABLE tbl_student MOVE TABLESPACE user4_db;        -- 기존의 TABLESPACE에 있는 TABLE 들을 수동으로 다른 TABLESPACE로 옮김


-- DEFAULT TABLESPACE를 생성하지 않고 데이터를 저장한 경우 새로운 TABLESPACE를 생성하고 사용중이던 TABLE을 새로운 TABLESPACE로 옮기고 DEFAULT SPACE를 변경하는 것이 좋음

-- TABLESPACE를 통째로 백업하고 다른 곳에 옮겨서 사용할 수 있도록 하는 방법(oracle 10g이상)


GRANT DBA TO user4;