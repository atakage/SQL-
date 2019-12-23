-- USER3 화면입니다

CREATE TABLE tbl_student(

    st_num	VARCHAR2(3)		PRIMARY KEY,
    st_name	nVARCHAR2(50)	NOT NULL,
    st_tel	VARCHAR2(20),		
    st_addr	nVARCHAR2(125),		
    st_grade	NUMBER(1),		
    st_dept	VARCHAR2(3)		



);

SELECT * FROM tbl_student;
SELECT COUNT(*) FROM tbl_student;


SELECT * FROM tbl_score;

-- student 테이블과 JOIN을 실행해서 성적정보 확인


SELECT * FROM tbl_score, tbl_student WHERE tbl_score.s_num = tbl_student.st_num;

-- 현재 score 테이블의 s_num 컬럼의 모든 데이터가 student 테이블의 st_num 컬럼에 모두 있기 때문에 EQ_JOIN 실행해서 데이터 확인 가능

SELECT * FROM tbl_score SC, tbl_student ST WHERE SC.s_num = ST.st_num;  -- 테이블명에 Alias를 설정해 SELECT


SELECT SC.s_num, ST.st_name, SC.s_kor, SC.s_eng, SC.s_math FROM tbl_score SC, tbl_student ST WHERE SC.s_num = ST.st_num;    -- *보다 보고자 하는 컬럼을 나열하는 것이 효율성면에서 좋음

INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math) VALUES('101', 90, 88, 77); -- tbl_student 테이블에 새로운(101) 학생 정보를 추가하지 않은 상태에서 성적테이블의 정보만 추가한 경우
                                                                            -- EQ JOIN을 실행하면 새로운 학생 정보(101)의 성적은 출력X, 참조무결성 유지X
 
 
SELECT * FROM tbl_score SC 
LEFT JOIN tbl_student ST  -- 연결해서 보고자 하는 보조 데이터(sub,detail)                                                                       
ON SC.s_num = ST.st_num; -- 연계할 조건
                                                                            
SELECT SC.s_num, ST.st_name, SC.s_kor, SC.s_eng, SC.s_math, SC.s_kor + Sc.s_eng + SC.s_math AS 총점, ROUND((SC.s_kor + SC.s_eng + SC.s_math)/3,0) AS 평균 FROM tbl_score SC 
LEFT JOIN tbl_student ST 
ON SC.s_num = ST.st_num;                               


DESC tbl_score2;

SELECT * FROM tbl_score2;

SELECT SC.s_num, ST.st_name, SC.s_dept, SC.s_kor, SC.s_eng, SC.s_math, SC.s_kor + Sc.s_eng + SC.s_math AS 총점, ROUND((SC.s_kor + SC.s_eng + SC.s_math)/3,0) AS 평균
FROM tbl_score2 SC LEFT JOIN tbl_student ST ON SC.s_num = ST.st_num;


INSERT INTO tbl_dept(d_num, d_name, d_pro) VALUES('001', '컴퓨터공학', '홍길동');
INSERT INTO tbl_dept(d_num, d_name, d_pro) VALUES('002', '영어영문', '성춘향');
INSERT INTO tbl_dept(d_num, d_name, d_pro) VALUES('003', '경영학', '임꺽정');
INSERT INTO tbl_dept(d_num, d_name, d_pro) VALUES('004', '정치경제', '장보고');
INSERT INTO tbl_dept(d_num, d_name, d_pro) VALUES('005', '군사학', '이순신');


ALTER TABLE tbl_dept MODIFY (d_pro nVARCHAR2(3));


-- VARCHAR2(3) : 영문기준으로 3글자, 한글 3글자 입력X
-- nVARCHAR2(3) : 유니코드 기준 3글자, 한글 3글자 입력 가능

SELECT SC.s_num, DP.d_name, DP.d_pro, SC.s_kor FROM tbl_score2 SC LEFT JOIN tbl_dept DP ON sc.s_dept = DP.d_num;


SELECT SC.s_num, ST.st_name, SC.s_dept, DP.d_name, DP.d_pro, SC.s_kor, SC.s_eng, SC.s_math, SC.s_kor + Sc.s_eng + SC.s_math AS 총점, ROUND((SC.s_kor + SC.s_eng + SC.s_math)/3,0) AS 평균
FROM tbl_score2 SC LEFT JOIN tbl_student ST ON SC.s_num = ST.st_num LEFT JOIN tbl_dept DP ON SC.s_dept = DP.d_num;      -- 성적테이블(주), 학생정보(보조), 학과정보(보조)을 JOIN


SELECT SC.s_num, ST.st_name, SC.s_dept, DP.d_name, DP.d_pro, SC.s_kor, SC.s_eng, SC.s_math, SC.s_kor + Sc.s_eng + SC.s_math AS 총점, ROUND((SC.s_kor + SC.s_eng + SC.s_math)/3,0) AS 평균
FROM tbl_score2 SC LEFT JOIN tbl_student ST ON SC.s_num = ST.st_num LEFT JOIN tbl_dept DP ON SC.s_dept = DP.d_num WHERE DP.d_name = '컴퓨터공학'

CREATE VIEW view_score
AS
(
SELECT SC.s_num, ST.st_name, SC.s_dept, DP.d_name, DP.d_pro, SC.s_kor, SC.s_eng, SC.s_math, SC.s_kor + Sc.s_eng + SC.s_math AS 총점, ROUND((SC.s_kor + SC.s_eng + SC.s_math)/3,0) AS 평균
FROM tbl_score2 SC LEFT JOIN tbl_student ST ON SC.s_num = ST.st_num LEFT JOIN tbl_dept DP ON SC.s_dept = DP.d_num
);



SELECT * FROM view_score;           -- SELECT SQL 수행해서 결과 얻고자 할 때 복잡한 SQL문을 매번 실행하는 것은 비효율적(코딩적)
                                -- DBMS에서는 SELECT 문을 마치 물리적 table인 것처럼 취급할 수 있도록 VIEW OBJECT를 제공 
                                -- VIEW OBJECT를 SELECT 실행하면 DBMS는 실제 table에서 VEIW OBJECT에서 설정된 SQL문 실행해 결과 보여줌(실제 데이터를 가지고 잇는 것은 아님)
                                -- 단, VIEW 만들기 위한 SQL 문에는 ORDER BY 삽입 불가
                                

SELECT * FROM view_score WHERE d_name = '컴퓨터공학';
SELECT * FROM view_score ORDER BY s_num;

DESC view_score;

-- 한번 view로 생성해 두면 물리적 table이 있는 것과 같이 작동을 하며 SELECT문의 다양한 옵션 사용해 데이터 조회 가능

SELECT * FROM view_score WHERE 평균 > 80;
SELECT * FROM view_score WHERE 평균 BETWEEN 70 AND 90;
SELECT * FROM view_score WHERE 평균 >= 70 AND 평균 <=90;
SELECT * FROM view_score WHERE s_dept IN('001', '003') ORDER BY d_name;
SELECT * FROM view_score WHERE s_dept = '001' OR s_dept = '003' ORDER BY d_name;
SELECT * FROM view_score WHERE s_dept BETWEEN '001' AND '003' ORDER BY s_dept;       -- 컬럼의 데이터가 문자열일 경우 모든 데이터의 자릿수가 같으면 BETWEE 사용해 범위 조회 가능



SELECT * FROM view_score WHERE d_name LIKE '컴퓨터%'; -- d_name 컬럼 값이 '컴퓨터' 문자열로 시작되는 데이터
SELECT * FROM view_score WHERE d_name LIKE '%공학';       -- LIKE에서 %가 나오는 조회 명령문은 사용 자제

SELECT s_num || ':' || st_name FROM view_score;     -- 값과 값을 연결해 하나의 문자열처럼 출력

/*

SELECT s_num || ':' || st_name FROM view_score; -- 오라클
SELECT s_num & ':' & st_name FROM view_score;
SELECT s_num + ':' + st_name FROM view_score;
*/

SELECT * FROM view_score WHERE d_name LIKE '컴퓨터' || '%';        -- Java 등 프로그래밍 코딩으로 SQL 작성할 때는 LIKE 키워드 문자열을 연결 문자열로 작성해야 함
SELECT DISTINCT s_dept, d_name FROM view_score ORDER BY s_dept;     -- 해당 컬럼의 데이터가 다수 존재할 때 중복되지 않는 데이터만 출력

SELECT DISTINCT s_dept, d_name, s_num FROM view_score ORDER BY s_dept;     -- 다수의 컬럼을 DISTINCT로 묶으면 원하는 결과X
SELECT s_dept, d_name FROM view_score GROUP BY s_dept, d_name ORDER BY s_dept;


-- GROUP BY
-- 특정 컬럼을 기준으로 집계를 할 때 사용하는 명령

SELECT s_dept, d_name, d_pro, SUM(s_kor) FROM view_score GROUP BY s_dept, d_name, d_pro ORDER BY s_dept;    -- GROUP BY로 묶어서 부분합을 보고자 할 때 기준으로 하는 커럶 이외에 SELECT 문에
                                                                                                            --  나열된 컬럼들 중 집계함수로 감싸지 않응ㄴ 컬럼은 GROUP BY절 다음에 나열해야 함
                                                                                                            
                                                                                                            
SELECT s_num, s_dept, d_name, d_pro , SUM(s_kor) FROM view_score GROUP BY s_num, s_dept, d_name, d_pro ORDER BY s_dept;    -- 학번, 학과 코드로 묶어서 보여주는 데이터는 의미없는 명령문이다
                                                                                                                    -- GROUP으로 묶어서 집계를 낼 떄는 어떤 컬럼들을 묶을 것인지에 대한 고민해야함
                                                                                                           
                                                                                                           
                                                                                                           
SELECT s_dept, d_name, d_pro , SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_math) AS 수학총점 FROM view_score 
WHERE d_name IN ('컴퓨터공학', '영어영문') GROUP BY  s_dept, d_name, d_pro ORDER BY s_dept;      -- GROUP BY실행할 때 조건을 부여하는 방법 WHERE 조건을 부여하는 방법 HAVING 조건을 부여하는 방법