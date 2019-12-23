-- USER3 화면

SELECT '1' AS num, '홍길동' AS name, '컴공과' AS dept FROM dual;      -- dual: 시스템 table(Dummy)로 표준SQL에서는 일반적인 프로그래밍 코드에서 사용하는 
                                                                                    -- 간단한 연산을 SELECT문을 이용해서 실행할 수 있도록 함
                                                                                    
                                                                                
SELECT '1' AS num, '홍길동' AS name, '컴공과' AS dept FROM tbl_student;       -- 실제 데이터가 있는 table을 상대로 실행하면 table에 저장된 데이터 개수만큼
                                                                                -- 반복되어 실행이 됨, 그래서 1개의 레코드만 가진 dummy table을 준비해 두고 그 테이블을 활용해 코드를 실행하도록 하는 것
                                                                                
                                                                                
                                                                                
SELECT '1' AS num, '홍길동' AS name, '컴공과' AS dept FROM dual                   
UNION ALL SELECT '2' AS num, '이몽룡' AS name, '컴공과' AS dept FROM dual     -- UNION: 여러 테이블을 SELECT 해서 생성된 VIEW 결과를 묶어서 마치 하나의 결과처럼 보고자 할 때 사용
UNION ALL SELECT '3' AS num, '성춘향' AS name, '컴공과' AS dept FROM dual
UNION ALL SELECT '4' AS num, '장보고' AS name, '컴공과' AS dept FROM dual
UNION ALL SELECT '5' AS num, '임꺽정' AS name, '컴공과' AS dept FROM dual
UNION ALL SELECT '6' AS num, '장영실' AS name, '컴공과' AS dept FROM dual
UNION ALL SELECT '7' AS num, '장길산' AS name, '컴공과' AS dept FROM dual;

/*
SELECT * FROM tbl_score
UNION ALL SELECT '학번' AS 학번, '국어' AS 국어, '영어' AS 영어, '수학' AS 수학 FROM dual,
UNION ALL SELECT '===' AS 학번, '====' AS 국어, '====' AS 영어, '====' AS 수학 FROM dual,
UNION ALL SELECT s_num AS 학번, to_char( s_kor, '999') AS 국어, to_char(s_eng, '999') AS 영어, to_char(s_math, '999' )AS 수학 FROM tbl_score,
UNION ALL SELECT '---' AS 학번, '----' AS 국어, '----' AS 영어, '----' AS 수학 FROM dual,
UNION ALL SELECT '총점' AS 학번, to_char( SUM(s_kor), '99,999') AS 국어, to_char(SUM(s_eng), '99,999') AS 영어, to_char(SUM(s_math), '99,999' )AS 수학 FROM tbl_score;
*/

SELECT '=====' AS 학번,'====' AS 국어,'====' AS 영어,'====' AS 수학 FROM DUAL
UNION ALL SELECT '학번' AS 학번,'국어' AS 국어,'영어' AS 영어,'수학' AS 수학 FROM DUAL
UNION ALL SELECT '=====' AS 학번,'====' AS 국어,'====' AS 영어,'====' AS 수학 FROM DUAL
UNION ALL SELECT s_num AS 학번, to_char(s_kor,'999') AS 국어, 
                      to_char(s_eng,'999') AS 영어, 
                      to_char(s_math,'999') AS 수학 FROM tbl_score
UNION ALL SELECT '-----' AS 학번,'----' AS 국어,'----' AS 영어,'----' AS 수학 FROM DUAL
UNION ALL SELECT '총점' AS 학번, to_char(SUM(s_kor),'99,999') AS 국어, 
                      to_char(SUM(s_eng),'99,999') AS 영어, 
                      to_char(SUM(s_math),'99,999') AS 수학 FROM tbl_score 
UNION ALL SELECT '=====' AS 학번,'====' AS 국어,'====' AS 영어,'====' AS 수학 FROM DUAL;                

    -- to char(값, 형식): 숫자형 자료를 문자열형 자료로 변환시키는 cascading 함수
    -- 9: 숫자자릿수를 나타내는 형식으로 실제 출력되는 값의 자릿수만큼 개수를 지정해야 함, to_char(123, '99999') >> 123
    -- 0: 숫자자릿수를 나타내는 형식, 실제 출력되는 값보다 자릿수가 많으면 나머지는 0으로 채움, to_char(123, '00000') >> 00123
    -- ,: 천 단위 구분 기호, to_char(1234567, '9,999,999') >> 1,234,567
    
    
    
    -- 날짜형 데이터를 문자열형으로 바꿀 때
    -- YYYY: 연도형식
    -- RRRR: 연도형식
    -- MM: 월
    -- DD: 일
    -- HH: 12시간제
    -- HH24: 24시간제
    -- MI: 분
    -- SS: 초
    
    
SELECT to_char(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM dual;




/*

                    UNION                   UNION ALL
------------------------------------------------------------------------------------
            중복 데이터 배제                      무조건 결합
                                                중복 데이터 모두 표시
        내부적으로 SORT 작동
        
        중복 배제 작업으로
        쿼리가 늦어질 수 있음


*/


WITH tbl_temp AS (                                                      -- 임시로 사용할  테이블 생성
SELECT '1' AS num, '홍길동' AS name FROM dual
UNION ALL SELECT '2' AS num, '이몽룡' AS name FROM dual
UNION ALL SELECT '3' AS num, '성춘향' AS name FROM dual
UNION ALL SELECT '4' AS num, '임꺽정' AS name FROM dual
UNION ALL SELECT '5' AS num, '장보고' AS name FROM dual
)
SELECT * FROM tbl_temp;



SELECT * FROM (                                                                         -- 표준 SQL에서 사용하는 가장 간단한 SUBQUERY , 어떤 table의 결과를 FROM으로 받아서 다시 SELECT를 수행하는 SQL
SELECT '1' AS num, '홍길동' AS name FROM dual
UNION ALL SELECT '2' AS num, '이몽룡' AS name FROM dual
UNION ALL SELECT '3' AS num, '성춘향' AS name FROM dual
UNION ALL SELECT '4' AS num, '임꺽정' AS name FROM dual
UNION ALL SELECT '5' AS num, '장보고' AS name FROM dual
)





WITH tbl_temp AS (                                                      
SELECT '1' AS num, '홍길동' AS name FROM dual
UNION ALL SELECT '2' AS num, '이몽룡' AS name FROM dual
UNION ALL SELECT '3' AS num, '성춘향' AS name FROM dual
UNION ALL SELECT '4' AS num, '임꺽정' AS name FROM dual
UNION ALL SELECT '5' AS num, '장보고' AS name FROM dual
) SELECT * FROM tbl_temp WHERE num IN('3', '1', '5') ORDER BY name;


SELECT * FROM tbl_student WHERE st_name IN ('기은성', '남도예', '내세원', '갈한수', '방채호', '남동예'); 




WITH tbl_temp AS (                                                                      
SELECT  '기은성' AS name FROM dual
UNION ALL SELECT  '남동예' AS name FROM dual
UNION ALL SELECT  '내세원' AS name FROM dual
UNION ALL SELECT  '방채호' AS name FROM dual
UNION ALL SELECT  '배재호' AS name FROM dual
)   SELECT * FROM tbl_student WHERE st_name IN(SELECT name FROM tbl_temp);                  -- SUB SQUERY, WHERE 절에 사용하는 SUBQ로 SUBQ 중에 가장 많이 사용하는 것 중첩(서브)쿼리라고도 함



SELECT * FROM (SELECT * FROM tbl_student WHERE st_grade = '1');         -- FROM 절에 포함되는 SUBQ, 인라인뷰라고 하며 다른 table의 결과를 FROM 절에 사용하는 것으로 여러 table을 결합해
                                                                                -- 나오는 결과값들을 모아서 하나의 쿼리로 연결해 view로 보여줌(EQ JOIN을 대신해서 사용하기도 함)
                                                                                
                                                                                
SELECT * FROM tbl_score2 SC, tbl_student ST WHERE SC.s_num = ST.st_num;

SELECT * FROM tbl_student ST, (SELECT SC.s_num, SC.s_kor + SC.s_eng + SC.s_math FROM tbl_score2 SC) SC_S WHERE ST.st_num = SC_S.s_num;

SELECT st_num, (
SELECT SUM(s_kor + s_eng + s_math) FROM tbl_score SC WHERE ST.st_num = SC.s_num ) FROM tbl_student ST;          -- 스칼라서브 쿼리, SUBQ에서 절대 LIST를 출력하면 안 됨
                                                                                                                    -- SUBQ에서는 단 한 줄의 Record만 결과로 나와야 함 
                                                                                                                --  tbl_student 테이블을 for() 반복문으로 반복 -> tbl_student의 st_num 컬럼 값을 sub 쿼리에 전달, subq는 마치 method처럼 작동
                                                                                                                -- -> subq에 WHERE 절 실행해 데이터 추출 -> 결과(s_kor+s_eng+s_math) return -> main에서 st_num, (결과) 표시



SELECT s_num, s_kor, s_eng,(
SELECT SUM(s_kor + s_eng + s_math) FROM tbl_score SC WHERE SC_MAIN.s_num = SC.s_num ) AS 총점 FROM tbl_score SC_MAIN;


select * from tbl_score2;