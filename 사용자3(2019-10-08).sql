-- 여기는 user3 화면


--  오라클 전용 System 쿼리,

SELECT * FROM v$database;   -- 현재 사용 중인 DBMS 엔진의 전역적 명칭(정보 확인)

SELECT * FROM TAB;       -- 현재 사용자가 접근(CRUD)할 수 있는 TABLE 목록

SELECT * FROM ALL_TABLES;       -- DBA급 이상의 사용자가 리스트를 확인할 수 있는 명령

DESC tbl_books;     -- 테이블 구조
DESCRIBE tbl_books;

SELECT * FROM user_tables;          -- SELECT * FROM TAB과 유사, 사용자 권한에 따라 FROM TAB과 다른 리스트가 출력되기도