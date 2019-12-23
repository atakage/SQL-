-- root 사용자로 로그인이 된 상태
-- MySQL에서는 기본적으로 설치를 할 때 root 사용자가 활성화 된 상태이고
-- 일반적으로 MySQL Server가 원격에서 접속이 차단된 상태이므로 SQL 연습을 위해서는 그대로 사용
-- MySQL은 Schema 개념이 Database라는 것으로 집중됨
-- Oracle은 물리적 공간이 TableSpace로 설정되고 Data Schema는 사용자(user) ID를 생성함으로써 논리적으로 설정이 됨
-- MySQL root가 Schema 개념이 아님 , SQL DataBase가 물리적(내부), 논리적(개념) Schema를 같은 의미로 사용


-- 1. login(root) 절차를 수행하고
-- 2. 사용할 Database(DB)를 open 수행

SHOW databases; -- 현재 사용가능한 DB를 확인하는 명령 


CREATE DATABASE myDB_1;
SHOW DATABASES;

USE mydb; 		-- DB open, DB 접속


SHOW TABLES; -- 현재 접속한 DB에 포함된 TABLE들을 확인 


-- MySQL에서 DB는 사용자와 연관성이 Oracle에 비해 느슨, 권한만 있으면 어떤 DB에 접속하여 다양한 SQL 명령을 수행할 수 있음

SELECT * FROM tbl_test;


CREATE TABLE tbl_score(
s_id	INT		PRIMARY KEY	AUTO_INCREMENT,
s_std	nVARCHAR(50)	NOT NULL		,
s_subject	nVARCHAR(50)	NOT NULL	,	
s_score	INT(3)	NOT NULL		,
s_remark	nVARCHAR(50)			
);

SELECT * FROM tbl_score;

INSERT INTO tbl_score(s_id, s_std, s_subject, s_score) VALUES(0, '홍길동', '국어', 90); -- AUTO INCREMENT로 지정된 컬럼은 PK로 지정되어 있지만 INSERT를 수행할 때 0의 값을 지정해주면 자동으로 값을 생성하여 만들어 줌
INSERT INTO tbl_score(s_std, s_subject, s_score) VALUES('홍길동', '수학', 80);		

INSERT INTO tbl_score(s_id, s_std, s_subject, s_score) VALUES(2, '홍길동', '과학', 80);		-- INT PK에 auto_increment가 지정되어 있더라도 0이외의 값을 지정하면 지정한 값이 컬럼에 저장됨
																									-- 이때 PK로 설정된 상태에서 중복값이 발생하여 INSERT 오류가 발생할 수 있다

-- AUTO INCREMENT로 지정된 컬럼은 INT Type으로 지정을 해야하고 INSERT를 수행할 때 Projection에 컬럼을 지정하지 말거나 값을 0으로 지정하여 명령을 수행해야 함

SELECT * FROM tbl_score;																																																															

INSERT INTO tbl_score(s_id, s_std, s_subject, s_score) VALUES(3, '홍길동', '과학', 80);

INSERT INTO tbl_score(s_std, s_subject, s_score) VALUES('홍길동', '영어', 80);

INSERT INTO tbl_score(s_id, s_std, s_subject, s_score) VALUES(100, '홍길동', '과학', 80);

INSERT INTO tbl_score(s_std, s_subject, s_score) VALUES('홍길동', '과학', 80);

INSERT INTO tbl_score(s_id, s_std, s_subject, s_score) VALUES(88, '홍길동', '과학', 80);

DELETE FROM tbl_score WHERE s_id >= 100;

SELECT * FROM tbl_score;

INSERT INTO tbl_score(s_std, s_subject, s_score) VALUES('홍길동', '미술', 80);

-- AUTO INCREMENT로 지정된 컬럼은 한번 최댓값이 지정되고 나면 중간의 값들을 삭제 하더라도 최댓값보다 큰 값들이 생성

-- MySQL에서 ORDER BY를 사용하지 않고 SELECT를 수행하면 기본값으로 AUTO_INCREMENT로 설정된 PK순으로 정렬되어 보임

-- 실무에서 많은 TABLE을 JOIN하거나 SUBQUERY를 사용하는 SQL을 작성할 때 ORDER BY는 최소한으로 사용하는 것이 좋음
-- SELECT 결과가 ORDER BY를 수행하는 과정에서 딜레이가 발생하는 경우도 있음

SELECT * FROM tbl_score WHERE s_std = '홍길동';
SELECT s_std, SUM(s_score) FROM tbl_score GROUP BY s_std;

SELECT s_std, CASE WHEN s_subject = '국어' THEN s_score ELSE 0 END AS 국어, CASE WHEN s_subject = '수학' THEN s_score ELSE 0 END AS 수학, CASE WHEN s_subject = '과학' THEN s_score ELSE 0 END AS 과학 FROM tbl_score;

SELECT s_std, SUM(IF(s_subject = '국어', s_score, 0)) AS 국어, SUM(IF(s_subject = '영어', s_score, 0)) AS 영어, SUM(IF(s_subject = '수학', s_score, 0)) AS 수학,
SUM(s_score) AS 총점, ROUND(AVG(s_score)) AS 평균 FROM tbl_score  GROUP BY s_std;		-- ROUND(값), ROUND(값, 0) : 정수형으로
																								-- ROUND(값, 자릿수) : 소수이하 자릿수까지 표시, 이하에서 반올림


SELECT s_std, SUM(IF(s_subject = '국어', s_score, 0)) AS 국어, SUM(IF(s_subject = '영어', s_score, 0)) AS 영어, SUM(IF(s_subject = '수학', s_score, 0)) AS 수학,
SUM(s_score) AS 총점, TRUNCATE(AVG(s_score), 1) AS 평균 FROM tbl_score  GROUP BY s_std;		-- TRUNCATE(값, 0): 소수점이하 자르기
																							-- TRUNCATE(값, 1): 소수점이하 한 자리까지 표시, 반올림은 X
                                                                                            
                                                                                            
SELECT * FROM tbl_score;

UPDATE tbl_score SET s_score = 20 WHERE s_id = 3;                                                                                       

DELETE FROM tbl_score WHERE s_id = 3;      

-- UPDATE, DELETE는 반드시 WHERE 사용
-- 가급적 1개의 레코드를 대상으로 u d 수행
-- PK를 WHERE에서 사용한 SQL 권장



CREATE TABLE tbl_score2(

s_id	INT		PRIMARY KEY	AUTO_INCREMENT,
s_std	VARCHAR(5)	NOT NULL		,
s_subject	nVARCHAR(5)	NOT NULL	,	
s_score	INT(3)	NOT NULL		,
s_remark	nVARCHAR(50)			

);

DROP TABLE tbl_subject;
CREATE TABLE tbl_subject(

sb_code	VARCHAR(5)		PRIMARY KEY,
sb_name	nVARCHAR(20)	NOT NULL	,
sb_pro	nVARCHAR(20)		
		
);


SELECT * FROM tbl_score2;
SELECT * FROM tbl_subject;

INSERT INTO tbl_score2(s_id, s_std, s_subject, s_score) VALUES(0, 'S0001', 'B0001', 90);
INSERT INTO tbl_score2(s_id, s_std, s_subject, s_score) VALUES(0, 'S0001', 'B0002', 80);
INSERT INTO tbl_score2(s_id, s_std, s_subject, s_score) VALUES(0, 'S0001', 'B0003', 70);
INSERT INTO tbl_score2(s_id, s_std, s_subject, s_score) VALUES(0, 'S0001', 'B0004', 66);

INSERT INTO tbl_subject(sb_code, sb_name) VALUES('B0001', '국어');
INSERT INTO tbl_subject(sb_code, sb_name) VALUES('B0002', '영어');
INSERT INTO tbl_subject(sb_code, sb_name) VALUES('B0003', '수학');
INSERT INTO tbl_subject(sb_code, sb_name) VALUES('B0004', '과학');



SELECT * FROM tbl_score2 AS SC, tbl_subject AS SB WHERE SC.s_subject = SB.sb_code;

SELECT SC.s_id, s_std, s_subject, sb_name, s_score FROM tbl_score2 AS SC, tbl_subject AS SB WHERE SC.s_subject = SB.sb_code;		-- 테이블들의 컬럼이름이 중복되지 않으면 Projection을 나열할 때 Alias를 사용하지 않아도 됨



SELECT SC.s_id, s_std, s_subject, sb_name, s_score FROM tbl_score2 AS SC LEFT JOIN tbl_subject AS SB ON SC.s_subject = SB.sb_code;	-- LEFT JOIN은 TABLE간 참조무결성이 보장되지 않을 경우, EQ JOIN을 했을 때 레코드가 누락될 수 있는 경우

CREATE VIEW  view_score AS (
SELECT SC.s_id AS id, s_std AS 학번, s_subject AS 과목코드, sb_name AS 과목명, s_score AS 점수 FROM tbl_score2 AS SC LEFT JOIN tbl_subject AS SB ON SC.s_subject = SB.sb_code
);

SELECT * FROM view_score;		-- VIEW는 복잡한 SELECT 쿼리를 마치 하나의 별도로 생성된 TABLE처럼 취급하기 위해서 만드는 Object(보기전용), INSERT UPDATE DELETE  불가, ALTER VIEW 불가


-- score table 과 subject table간에는 참조무결성 관계가 유지

ALTER TABLE tbl_score2 MODIFY s_subject VARCHAR(5) NOT NULL;		-- MySQL에서 FK를 설정할 때 SubTable(tbl_score2)의 컬럼 NOT NULL로 설정돼 있어야 함, INT형일 경우 NOT NULL DEFAULT = 0, 문자열일 경우 VARCHAR() NOT NULL

ALTER TABLE tbl_score2 ADD CONSTRAINT FK_SCORE_SUBJECT FOREIGN KEY(s_subject) REFERENCES tbl_subject(sb_code);