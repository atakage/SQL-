-- grade 화면


CREATE TABLE tbl_score(


s_id	NUMBER,
s_std	nVARCHAR2(50)	NOT NULL,	
s_subject	nVARCHAR2(50)	NOT NULL,	
s_score	NUMBER(3)	NOT NULL,	
s_remark	nVARCHAR2(50),
CONSTRAINT pk_score PRIMARY KEY(s_id)                   -- PK를 컬럼에 지정하지 않고 별도의 CONSTRAINT 추가 방식으로 지정
                                                        -- 표준 SQL에서는 PK 지정방식을 컬럼에 PRIMARY KEY 키워드 지정 방식으로 사용하는데 표준 SQL의 PK 지정방식이 안 되는 DBMS가 있음
                                                        -- 이런 경우에 사용

);





SELECT COUNT(*) FROM tbl_score;


SELECT * FROM tbl_score;


SELECT s_std, sum(s_score) AS 총점, ROUND(avg(s_score),2) AS 평균 FROM tbl_score GROUP BY s_std ORDER BY s_std;         -- 학생(s_std) 데이터가 같은 레코드를 묶기, 묶여진 그룹 내에서 총점과 평균 계산


SELECT s_subject FROM tbl_score GROUP BY s_subject ORDER BY s_subject;

/*

과학
국사
국어
미술
수학
영어


*/

SELECT s_std AS 학생, SUM(DECODE(s_subject, '과학', s_score)) AS 과학, SUM(DECODE(s_subject, '국사', s_score)) AS 국사, SUM(DECODE(s_subject, '국어', s_score)) AS 국어, SUM(DECODE(s_subject, '미술', s_score)) AS 미술,
SUM(DECODE(s_subject, '수학', s_score)) AS 수학, SUM(DECODE(s_subject, '영어', s_score)) AS 영어 FROM tbl_score  GROUP BY s_std ORDER BY s_std ;



-- 성적테이블을 각 과목이름으로 컬럼을 만들어 생성을 하면 데이터를 추가하거나 단순 조회를 할 때는 편리하게 사용할 수 있음
-- 그러나 사용 중 과목이 추가되거나 과목명 변경되는 경우 테이블의 컬럼을 변경해야 하는 상황이 발생, 컬럼 변경은 DBMS나 사용자 입장에서 많은 비용을 지불해야 하므로 컬럼 변경은 신중히
-- 실제 데이터는 고정된 컬럼으로 생성된 테이블에 저장을 하고 View로 확인을 할 떄 PIVOT 방식으로 펼쳐보면, 마치 실제 테이블에 컬럼이 존재하는 것처럼 사용할 수 있음



SELECT * FROM (SELECT s_std, s_subject, s_score FROM tbl_score) PIVOT(  -- 오라클 11g 이후의 PIVOT 전용 문법, SQL Developer에서 수행 명령에 제한 있음, main from 절에 SUB QUERY를 사용해 테이블 지정해야 함
    SUM(s_score)            -- 컬럼 이름 별로 분리하여 표시할 데이터
    FOR s_subject            -- 묶어서 펼칠 컬럼 이름
    IN                       
( '과학' AS 과학, '국사' AS 국사, '국어' AS 국어, '미술' AS 미술, '수학' AS 수학, '영어' AS 영어)) ORDER BY s_std;          



CREATE VIEW view_score AS(
SELECT s_std AS 학생, SUM(DECODE(s_subject, '과학', s_score)) AS 과학, SUM(DECODE(s_subject, '국사', s_score)) AS 국사, SUM(DECODE(s_subject, '국어', s_score)) AS 국어, SUM(DECODE(s_subject, '미술', s_score)) AS 미술,
SUM(DECODE(s_subject, '수학', s_score)) AS 수학, SUM(DECODE(s_subject, '영어', s_score)) AS 영어,
SUM(s_score) AS 총점, ROUND(AVG(s_score),2) AS 평균, RANK() OVER (ORDER BY SUM(s_score) DESC) AS 석차 FROM tbl_score  GROUP BY s_std
);


SELECT * FROM view_score ORDER BY 학생;