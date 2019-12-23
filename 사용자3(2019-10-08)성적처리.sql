-- 여기는 USER3 화면

CREATE TABLE tbl_score(

    s_num	VARCHAR2(3)		PRIMARY KEY,
    s_kor	NUMBER(3),		
    s_eng	NUMBER(3),		
    s_math	NUMBER(3)		




);


DESC tbl_score;


INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math) VALUES('001', 90, 80, 70);

INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math) VALUES('002', 90, 80, 70);
INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math) VALUES('003', 90, 80, 70);
INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math) VALUES('004', 90, 80, 70);
INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math) VALUES('005', 90, 80, 70);
INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math) VALUES('006', 90, 80, 70);
INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math) VALUES('007', 90, 80, 70);
INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math) VALUES('008', 90, 80, 70);

SELECT * FROM tbl_score;

SELECT s_kor + s_eng + s_math AS 총점, (s_kor + s_eng + s_math)/3 AS 평균 FROM tbl_score;


UPDATE tbl_score SET s_kor = ROUND( DBMS_RANDOM.VALUE(50, 100), 0), s_eng = ROUND( DBMS_RANDOM.VALUE(50, 100), 0), s_math = ROUND( DBMS_RANDOM.VALUE(50, 100), 0);  -- 50부터 100ㄲ지의 임의 점수 생성

UPDATE tbl_score SET s_math = 100 WHERE s_math = 94;

SELECT * FROM tbl_score;

UPDATE tbl_score SET s_math = 94 WHERE s_num = '008';

SELECT s_num, s_kor, s_eng, s_math, s_kor + s_eng + s_math AS 총점, (s_kor + s_eng + s_math)/3 AS 평균 FROM tbl_score;


SELECT s_num, s_kor, s_eng, s_math, s_kor + s_eng + s_math AS 총점, ROUND((s_kor + s_eng + s_math)/3, 2) AS 평균 FROM tbl_score;

SELECT s_num, s_kor, s_eng, s_math, s_kor + s_eng + s_math AS 총점, ROUND((s_kor + s_eng + s_math)/3, 2) AS 평균 FROM tbl_score WHERE (s_kor + s_eng + s_math)/3 >= 80;

SELECT s_num, s_kor, s_eng, s_math, s_kor + s_eng + s_math AS 총점, ROUND((s_kor + s_eng + s_math)/3, 2) AS 평균 FROM tbl_score WHERE (s_kor + s_eng + s_math)/3 BETWEEN 70 AND 80;


-- 통계, 집계함수
-- SUM(), COUNT(), AVG(), MAX(), MIN()

SELECT SUM(s_kor) FROM tbl_score;

SELECT SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_math) AS 수학총점 FROM tbl_score;

SELECT SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_math) AS 수학총점, SUM(s_kor + s_eng + s_math) AS 전체총점 FROM tbl_score;

SELECT SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_math) AS 수학총점, SUM(s_kor + s_eng + s_math) AS 전체총점, ROUND(AVG((s_kor + s_eng + s_math)/3), 1) AS 전체평균 FROM tbl_score;

SELECT COUNT(*) FROM tbl_score;

SELECT COUNT(s_num), COUNT(s_kor), COUNT(s_eng) FROM tbl_score;

SELECT MAX(s_kor + s_eng + s_math) AS 최고점, MIN(s_kor + s_eng + s_math) AS 최저점 FROM tbl_score;

SELECT s_kor, s_eng, s_math, (s_kor + s_eng + s_math) AS 총점, RANK(s_kor + s_eng + s_math) AS 석차 FROM tbl_score;


SELECT SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_math) AS 수학총점, SUM(s_kor + s_eng + s_math) AS 전체총점, ROUND(AVG((s_kor + s_eng + s_math)/3), 1) AS 전체평균 FROM tbl_score WHERE s_kor + s_eng + s_math >= 200;
SELECT SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_math) AS 수학총점, SUM(s_kor + s_eng + s_math) AS 전체총점, ROUND(AVG((s_kor + s_eng + s_math)/3), 1) AS 전체평균 FROM tbl_score WHERE (s_kor + s_eng + s_math)/3 >= 70;

SELECT s_num, s_kor + s_eng + s_math AS 총점, RANK() OVER(ORDER BY (s_kor + s_eng + s_math) DESC) AS 석차 FROM tbl_score ORDER BY s_num;    -- RANK() OVER 실행으러 총점 내림차순 정렬 -> 다시 s_num 정렬

-- 공동 1위가 있는경우 1위, 1위, 3위로 처리할 수 있고 (이것이 RANK)
-- 공동 1위가 있는경우 1위, 1위, 2위로 처리할 수 있다 (이것이 DENSE_RANK)



CREATE TABLE tbl_score2(

    s_num	VARCHAR2(3)		PRIMARY KEY,
    s_dept	VARCHAR2(3),		
    s_kor	NUMBER(3),		
    s_eng	NUMBER(3),		
    s_math	NUMBER(3)		
);

CREATE TABLE tbl_dept(

    d_num	VARCHAR2(3)		PRIMARY KEY,
    d_name	nVARCHAR2(20)	NOT NULL,
    d_pro	VARCHAR2(3)		



);