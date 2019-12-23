-- 여기는 USER3 화며

SELECT * FROM TAB;          -- 현재 USER3 사용자가 사용할 수 있는 Table 목록


/*


            TABLE                   VIEW                   
-----------------------------------------------------------
    실제 저장된 데이터              가상의 데이터(테이블로부터 SELECT 실행한 후 보여주는 형태)
    
    CRUE 가능                         READ(SELECT)만 가능
    
    원본 데이터                      TABLE로부터 새로 생성된 보기 전용 데이터
------------------------------------------------------------    




*/

SELECT * FROM tbl_score;


--JOIN: 학번과 연계된 학생테이블로부터 학생 이름을 연결하고 학과와 연계된 학과 테이블로부터 학과이름을 연결하여 마치 한 개의 데이터 Sheet처럼 보기 위한 SQL


DESC tbl_student;

-- 현재 학생테이블에 학과 코드 컬럼이 있음에도 SQL 편의성 고려해 성적테이블에 학과 코드를 추가하여 관리함(tbl_score2)
-- 이런 상황이 되면 자칫 잘못해 tbl_score2 테이블에 등록된 학과 코드가 실제 학생의 학과 코드가 아닌 값이 등록될 수 있음(조회 시 실제 데이터와 차이 발생 가능)

-- tbl_score 테이블과 tbl_student를 JOIN하고 그 결과에서 학과 코드를 기준으로 다시 tbl_dept와 JOIN 수행

SELECT * FROM tbl_score SC LEFT JOIN tbl_student ST ON SC.s_num = ST.st_num;


DELETE FROM tbl_student;

SELECT * FROM tbl_student;

SELECT ST.st_num, ST.st_name, ST.st_dept, DP.d_name, DP.d_pro FROM tbl_student ST LEFT JOIN tbl_dept DP ON ST.st_dept = dp.d_num ORDER BY ST.st_num;        -- 학생테이블과 학과테이블 JOIN, 보고자하는 컬럼만 리스트로 나열
                                                                                                                                                                -- 결과를 학번순으로 정렬하여 보기
                                                                                                                                                                
                                                                                                                                                                
                                                                                                                                                                 
                                                                                                                                                                
CREATE VIEW view_st_dept AS(
SELECT ST.st_num 학번, ST.st_name 이름, ST.st_dept 학과코드, DP.d_name 학과이름, DP.d_pro 담임교수
FROM tbl_student ST LEFT JOIN tbl_dept DP ON ST.st_dept = dp.d_num        -- SQL을 VIEW로 생성하기 위해서는 ORDER BY 삭제, 각 커럼에 별도의 Alias 설정, SQL문을 ()감싸기, CREATE VIEW AS 키워드를 추가
);


SELECT * FROM view_st_dept;
SELECT * FROM view_st_dept WHERE 학과이름 = '컴퓨터공학';

SELECT * FROM view_st_dept WHERE 학과이름 LIKE '컴퓨터%' ORDER BY 학번;

SELECT 학과코드, 학과이름, COUNT(학과코드) FROM view_st_dept GROUP BY 학과코드, 학과이름 ORDER BY 학과코드;

SELECT 학과코드, 학과이름, COUNT(학과코드) FROM view_st_dept GROUP BY 학과코드, 학과이름 ORDER BY COUNT(학과코드);


-- 집계함수(SUM, COUNT, MAX< MIN, AVG)를 사용할 때 만약 집계함수로 감싸지 않은 컬럼을 Projection에 표시하려고 하면 그 컬럼들은 반드시 GROUP BY절에 컬럼들을 나열해 주어야 함


SELECT 학번, 이름, COUNT(*) FROM view_st_dept GROUP BY 학번, 이름;      -- 이 SQL에서는 학번은 현재 view에서 절대 중복된 값이 없으므로 GROUP BY가 아무런 효과X

SELECT 학과코드, 학과이름, COUNT(*) FROM view_st_dept GROUP BY 학과코드, 학과이름 HAVING COUNT(*) >= 20;    -- 학과별로 학생수 계산을 하고 학생수 20명 이상인 과만 출력

SELECT 학과코드, 학과이름, COUNT(*) FROM view_st_dept GROUP BY 학과코드, 학과이름 HAVING 학과이름 = '컴퓨터공학';    -- HAVING절은 GROUP BY가 이루어지고 집계함수가 계산된 후 조건을 설정하여 리스트를 추출
                                                                                                                        -- 원본 데이터를 먼저 GROUP하는 연산이 수행되고 그 결과에 대하여 조건을 설정
                                                                                                                    -- 만약 기존의 컬럼을 기준으로 조건을 설정하려면 HAVING이 아닌 WHERE에서 조건을 설정해
                                                                                                                    -- 추출되는 LIST 개수를 줄이고 추출된 LIST만 가지고 GROUP, 집계함수 연산을 수행하는 것이
                                                                                                                    -- SQL 수행 효율면에서 매우 유리
SELECT 학과코드, 학과이름, COUNT(*) 
FROM view_st_dept                       -- 첫 번째 실행
WHERE 학과이름 = '컴퓨터공학'            -- 두 번째 실행
GROUP BY 학과코드, 학과이름;            -- 세 번째 실행                  -- WHERE에 의한 제한된 LIST만 가지고 GROUP BY 실행

CREATE VIEW view_sc_st AS(
SELECT SC.s_num AS 학번, ST.st_name AS 이름, ST.st_dept AS 학과코드, SC.s_kor AS 국어, SC.s_eng  AS 영어, SC.s_math AS 수학 FROM tbl_score SC LEFT JOIN tbl_student ST ON SC.s_num = ST.st_num
);


SELECT * FROM view_sc_st;
SELECT * FROM view_st_dept;

SELECT SC.학번, SC.이름, SC.학과코드, DP.학과이름, SC.국어, SC.영어, SC.수학 FROM view_sc_st SC-- 주 테이블
LEFT JOIN view_st_dept DP -- 보조 테이블
ON sc."학과코드" = dp."학과코드" ORDER BY sc."학번" ;                         -- 2개의 VIEW를 JOIN했더니 결과가 이상하게 생성



SELECT * FROM tbl_score SC LEFT JOIN tbl_student ST ON SC.s_num = ST.st_num LEFT JOIN tbl_dept DP ON ST.st_dept = DP.d_num;

SELECT SC.s_num, ST.st_name, DP.d_name, DP.d_pro, SC.s_kor, SC.s_eng, SC.s_math FROM tbl_score SC LEFT JOIN tbl_student ST ON SC.s_num = ST.st_num LEFT JOIN tbl_dept DP ON ST.st_dept = DP.d_num;


CREATE VIEW view_성적일람표 AS(
SELECT SC.s_num 학번, ST.st_name 학생이름, ST.st_dept 학과코드, DP.d_name 학과이름, DP.d_pro 담임교수, SC.s_kor 국어, SC.s_eng 영어, SC.s_math 수학, sc.s_kor + sc.s_eng + SC.s_math AS 총점, ROUND((sc.s_kor + sc.s_eng + SC.s_math)/3, 2) AS 평균, RANK() OVER (ORDER BY (sc.s_kor + sc.s_eng + SC.s_math) DESC) AS 석차
FROM tbl_score SC LEFT JOIN tbl_student ST ON SC.s_num = ST.st_num LEFT JOIN tbl_dept DP ON ST.st_dept = DP.d_num
);



SELECT * FROM view_성적일람표;

DROP VIEW view_성적일람표;


SELECT SUM(국어), SUM(영어), SUM(수학) FROM view_성적일람표;

SELECT 학과코드, 학과이름, SUM(국어), SUM(영어), SUM(수학) FROM view_성적일람표 GROUP BY 학과코드, 학과이름;

SELECT 학과코드, 학과이름, SUM(국어), SUM(영어), SUM(수학), SUM(총점) FROM view_성적일람표 GROUP BY 학과코드, 학과이름;

SELECT 학과코드, 학과이름, SUM(국어) AS 국어총점, SUM(영어) AS 영어총점, SUM(수학) AS 수학총점,  SUM(총점) AS 전체총점, ROUND(AVG(평균),2) AS 전체평균 FROM view_성적일람표 GROUP BY 학과코드, 학과이름;

SELECT 학과코드, 학과이름, SUM(국어) AS 국어총점, SUM(영어) AS 영어총점, SUM(수학) AS 수학총점,  SUM(총점) AS 전체총점, ROUND(AVG(평균),2) AS 전체평균 
FROM view_성적일람표 WHERE 학과코드 IN ('002','005') GROUP BY 학과코드, 학과이름;        -- WHERE, HAVING으로 어떤 조건 부여할 때는 길이가 가변적인 값으로 하기보다는 고정된 길이의 값으로 부여하는 것이
                                                                                    -- 결과가 더 확실(학과이름X, 학과코드O)
                                                                                    
                                                                                    
                                                                                    
DELETE tbl_score;                                                                                    

SELECT * FROM tbl_score;



SELECT 학과코드, 학과이름, SUM(국어) AS 국어총점, SUM(영어) AS 영어총점, SUM(수학) AS 수학총점,  SUM(총점) AS 전체총점, ROUND(AVG(평균),2) AS 전체평균 
FROM view_성적일람표 GROUP BY 학과코드, 학과이름 HAVING ROUND(AVG(평균),2) > 75;           -- GROUP으로 묶고 집계 수행한 결과를 조건으로 설정



SELECT 학과코드, 학과이름, SUM(국어) AS 국어총점, SUM(영어) AS 영어총점, SUM(수학) AS 수학총점,  SUM(총점) AS 전체총점, ROUND(AVG(평균),2) AS 전체평균 
FROM view_성적일람표 WHERE 학과코드 BETWEEN '002' AND '005' GROUP BY 학과코드, 학과이름 ORDER BY 학과코드;

SELECT 학과코드, 학과이름 FROM view_성적일람표 GROUP BY 학과코드, 학과이름 ;         -- view_성적일람표에 어떤 학과들이 있나

SELECT 학과코드, 학과이름, COUNT(*) 학생수, MAX(총점) AS 최고점, MIN(총점) AS 최저점, SUM(총점), ROUND(AVG(평균),2) FROM view_성적일람표 GROUP BY 학과코드, 학과이름 ORDER BY 학과코드;

