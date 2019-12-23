-- MYSQL 실행화면

-- MYSQL과 Oracle의 차이

/*
 MYSQL					Oracle
Database				TABLESPACE


*/

USE mysql;				-- mySQL에 포함된 table들을 사용
SHOW Tables;		-- mysql DB에 저장돼 있는 TABLE들의 전체 목록 표시


CREATE DATABASE myDB;			-- TABLESPACE처럼 데이터를 저장할 공간 설정

USE myDB;				-- 지금부터 myDB에서 사용

SHOW TABLES;

CREATE TABLE tbl_test(
id int PRIMARY KEY AUTO_INCREMENT,			-- AUTO_INCREMENT는 int형 PK에 설정, mysql의 정수형 데이터는 최대 11자리까지 저장
name nVARCHAR(50) NOT NULL,
tel VARCHAR(20),
addr nVARCHAR(125)
);
						
DESC tbl_test;
INSERT INTO tbl_test(id, name) VALUES(0, '홍길동');

SELECT * FROM tbl_test;
SELECT * FROM tbl_test WHERE name = '홍길동';

SELECT * FROM tbl_test WHERE id BETWEEN 1 AND 2;

SELECT * FROM tbl_test WHERE name LIKE '홍%';

SELECT 30 + 40;					-- 단순 연산을 수행할 때 FROM을 포함하지 않아도 됨
SELECT '대한' & '민국';
SELECT '대한' + '민국';