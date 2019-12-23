SELECT D_CODE,
D_NAME,
D_CEO,
D_TEL,
D_ADDR FROM tbl_dept;




/*       tbl iolist - tbl_produect
            io-pcode       p_code
            
            tbl_iolist - tbl_dept
            io_dcode        d_code
            
            
제2정규화가 완료된 후 테이블들을 참조무결성을 보장하기 위해 FK 설정을 수행해야 함

*/        


ALTER TABLE tbl_iolist  -- 연동되는 TABLE
ADD CONSTRAINTS FK_PRODUCT 
FOREIGN KEY(io_pcode)   -- 연동되는 컬럼
REFERENCES tbl_product(p_code);     -- PK로 설정된 부분


ALTER TABLE tbl_iolist  -- 연동되는 TABLE
ADD CONSTRAINTS FK_DEPT 
FOREIGN KEY(io_pcode)   -- 연동되는 컬럼
REFERENCES tbl_product(p_code);     -- PK로 설정된 부분



/*
오라클의 LEVEL 기능
*/

SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= 10;          -- 오라클의 대치 연산자  사용자(SQL 실행하는)로부터 어떤 값을 입력받아서 SQL을 수행하기 위한 방법, 1부터 <= 변수까지 연속된 값을 레코드로 추출해주는 오라클 SQL
SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= &변수;          
SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= &value;          

SELECT LEVEL*10 FROM DUAL CONNECT BY LEVEL <= 10;    -- 10부터 100까지 
SELECT LEVEL*&시작 FROM DUAL CONNECT BY LEVEL <= &종료;          

SELECT (LEVEL-10) * -1 FROM DUAL CONNECT BY LEVEL < 10;


SELECT IO_SEQ,
IO_DATE,
IO_INOUT,
IO_QTY,
IO_PRICE,
IO_TOTAL,
IO_PCODE, IO_DCODE FROM tbl_iolist WHERE io_date BETWEEN '&시작일자' AND '&종료일자';

SELECT TO_DATE('20190101', 'YYYY-MM-DD') FROM DUAL; -- 문자열을 날짜 타입으로 변환, 날짜값을 문자열형태로 저장을 하는데 날짜값으로 어떤 연산을 수행하고자 할 때는 문자열을 날짜 타입으로 변환시킬 필요가 있음

SELECT TO_DATE('20190101', 'YYYY-MM-DD') + LEVEL FROM DUAL CONNECT BY LEVEL <= TO_DATE('2019-01-31', 'YYYY-MM-DD') - TO_DATE('2019-01-01', 'YYYY-MM-DD');       -- 2019-01-01부터 2019-01-31까지의 날짜값을 추출하는 연산

SELECT TO_DATE('20190101', 'YYYY-MM-DD') -1 + LEVEL FROM DUAL CONNECT BY LEVEL <= TO_DATE('2019-01-31', 'YYYY-MM-DD') - (TO_DATE('2019-01-01', 'YYYY-MM-DD') +1);

SELECT TO_CHAR(ADD MONTHS(TO_DATE('20190201', 'YYYY-MM-DD'), LEVEL -1), 'YYYY-MM')  FROM DUAL CONNECT BY LEVEL <= TO_DATE('2019-01-31', 'YYYY-MM-DD') - (TO_DATE('2019-01-01', 'YYYY-MM-DD') +1);

SELECT ADD_MONTHS(TO_DATE('2019-01-01', 'YYYY-MM-DD'), LEVEL -1) FROM DUAL CONNECT BY LEVEL <= 5;        -- ADD_MONTHS : 날짜값의 월에 +1을 해서 숫자형 날짜값으로 변환

-- 오라클에서 날짜와 관련된 연산을 수행할 때는 문자열 형태로는 불가능하므로 TO_DATE() 함수를 사용하여 날짜 type으로 변환시키고 연산을 수행해야 함

SELECT SYSDATE FROM DUAL;

SELECT LAST_DAY(SYSDATE) FROM DUAL;     -- 현재 달의 마지막 날짜

SELECT TRUNC(SYSDATE, 'month') + ( LEVEL -1) FROM DUAL CONNECT BY LEVEL <= (LAST_DAY(SYSDATE)) - TRUNC(SYSDATE, 'month') + 1;  -- 현재 날짜가 포함된 달의 첫번째 날짜부터 말일까지 리스트

SELECT ADD_MONTHS(TO_DATE('2018-01-01', 'YYYY-MM-DD'), LEVEL -1) AS 월 FROM DUAL CONNECT BY LEVEL <= 12;      -- 2018년 1월 1일부터 12달의 달수만 가져오기


SELECT * FROM tbl_iolist IO, (
SELECT ADD_MONTHS(TO_DATE('2018-01-01', 'YYYY-MM-DD'), LEVEL -1) FROM DUAL CONNECT BY LEVEL <= 12
) ;


SELECT ADD_MONTHS(TO_DATE(io_date, 'YYYY-MM-DD'), 0), 'YYYY-MM') FROM tbl_iolist;
SELECT SUBSTR(io_date, 0, 7) AS IO_월, SUM(io_total) FROM tbl_iolist GROUP BY SUBSTR(io_date, 0, 7);     -- 월별 합계


SELECT 월, SUM(io_total) FROM tbl_iolist IO,
(SELECT TO_CHAR(ADD_MONTHS(TO_DATE('2018-01-01', 'YYYY-MM-DD'), LEVEL -1) FROM DUAL CONNECT BY LEVEL <= 12)  WHERE 월 = SUBSTR(io_date, 0, 7) GROUP BY 월


SELECT MAX(io_total) FROM tbl_iolist; 

SELECT MIN(io_total), MAX(io_total) FROM tbl_iolist;


SELECT TOTAL, SUM(io_total), count(io_total) FROM tbl_iolist,
(SELECT LEVEL * 10000 AS TOTAL FROM DUAL CONNECT BY LEVEL <= 150)  SUB WHERE io_total >= SUB.TOTAL AND io_total < SUB.TOTAL + 10000 AND io_inout = '매출' GROUP BY TOTAL ORDER BY TOTAL; -- SUBQ 10000 ~ 1500000까지 10000씩 증가하는 값을 생성

SELECT * FROM tbl_score;



SELECT 점수, COUNT(SC.sc_score) FROM tbl_score SC, (SELECT LEVEL * 10 AS 점수 FROM DUAL CONNECT BY LEVEL <= 10) SUB WHERE  SC.sc_score >= 점수 AND SC.sc_score <= 점수 + 10 GROUP BY 점수 ORDER BY 점수;    -- SUBQ와 EQ JOIN으로 학생 수가 있는 점수대만 보여주기


SELECT 점수, COUNT(SC.sc_score) FROM (SELECT LEVEL * 10 AS 점수 FROM DUAL CONNECT BY LEVEL <= 10) SUB LEFT JOIN tbl_score SC ON  SC.sc_score >= 점수 AND SC.sc_score <= 점수 + 10 GROUP BY 점수 ORDER BY 점수;  -- SUBQ와 LEFT JOIN을 같이 묶어서 학생수가 없는 점수대의 점수제목도 같이 보여


SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= &변수;      -- 오라클에서 숫자를 연속된 값의 리스트로 만들 때

SELECT LEVEL * 0.1 FROM DUAL CONNECT BY LEVEL <= 10; 



SELECT * FROM(SELECT sc_name, sc_subject, sc_score FROM tbl_score) PIVOT( SUM(sc_score) FOR sc_subject IN ( '국어' AS 국어, '과학' AS 과학, '영어' AS 영어, '수학' AS 수학, '국사' AS 국사, '미술' AS 미술) );    -- sc.subject 컬럼에 들어있는 과목명의 리스트
                                                                                        -- 제1정규화가 되어있는 데이터를 보고서형태로 보여주는 SQL
SELECT sc_subject FROM tbl_score GROUP BY sc_subject ORDER BY sc_subject;




SELECT sc_name, SUM(DECODE(sc_subject, '과학', sc_score)) AS 과학, SUM(DECODE(sc_subject, '국사', sc_score)) AS 국사, SUM(DECODE(sc_subject, '국어', sc_score)) AS 국어,
     SUM(DECODE(sc_subject, '미술', sc_score)) AS 미술, SUM(DECODE(sc_subject, '수학', sc_score)) AS 수학, SUM(DECODE(sc_subject, '영어', sc_score)) AS 영어 FROM tbl_score GROUP BY sc_name;
            -- 학생 한 사람을 기준으로 과목을 나열하여 보여주기 위해 학생이름으로 GROUP BY를 수행해야 하고 나머지 항목에서도 GROUP BY를 수행하여야 SQL문이 정상으로 작동되는데
            -- 학생이름을 제외한 나머지 항목을 SUM() 묶어주면 GROUP BY 절에 나열하지 않아도 됨
          
          
SELECT sc_name, SUM(CASE WHEN sc_subject = '과학' THEN sc_score END) AS 과학, SUM(CASE WHEN sc_subject = '국사' THEN sc_score END) AS 국사,
SUM(CASE WHEN sc_subject = '국어' THEN sc_score END) AS 국어 SUM(CASE WHEN sc_subject = '미술' THEN sc_score END) AS 미술, 
SUM(CASE WHEN sc_subject = '수학' THEN sc_score END) AS 수학, SUM(CASE WHEN sc_subject = '영어' THEN sc_score END) AS 영어 FROM tbl_score GROUP BY sc_name;



SELECT io_inout, SUM(DECODE(io_inout, '매입', io_total)) AS 매입, SUM(DECODE(io_inout, '매출', io_total)) AS 매출 FROM tbl_iolist GROUP BY io_inout;

SELECT SUM(DECODE(io_inout, '매입', io_total)) AS 매입, SUM(DECODE(io_inout, '매출', io_total)) AS 매출 FROM tbl_iolist;


SELECT SUM(DECODE(io_inout, '매입', io_total,0)) AS 매입, SUM(DECODE(io_inout, '매출', io_total,0)) AS 매출, 
SELECT SUM(DECODE(io_inout, '매출', io_total,0))  - SUM(DECODE(io_inout, '매입', io_total,0)) AS 마진
FROM tbl_iolist;




SELECT SUBSTR(io_date, 0, 7), SUM(DECODE(io_inout, '매입', io_total)) AS 매입, SUM(DECODE(io_inout, '매출', io_total)) AS 매출 FROM tbl_iolist GROUP BY SUBSTR(io_date,0,7) ORDER BY SUBSTR(io_date,0,7) ;

SELECT io_dcode, d_name, d_ceo, d_tel, SUM(DECODE(io_inout, '매입', io_total)) AS 매입, SUM(DECODE(io_inout, '매출', io_total)) AS 매출 
FROM tbl_iolist IO LEFT JOIN tbl_dept D ON IO.io_dcode = D.d_code GROUP BY io_dcode, d_name, d_ceo, d_tel ORDER BY io_dcode ;   -- 거래처별로 매입매출 집계, 거래처 테이블과 JOIN




SELECT io_dcode, d_name || d_ceo || d_tel , SUM(DECODE(io_inout, '매입', io_total)) AS 매입, SUM(DECODE(io_inout, '매출', io_total)) AS 매출 
FROM tbl_iolist IO LEFT JOIN tbl_dept D ON IO.io_dcode = D.d_code GROUP BY io_dcode, d_name || d_ceo || d_tel ORDER BY io_dcode ;   -- SELECT의 Projection부분에서 계산식을 사용할 경우 GROUP BY에도
                                                                                                                            -- 계산식을 모두 기술해야 함 Alias 부분은 GROUP BY에서 인식X, HAVING도 계산식 기술
                                                                                                                            
                                                                                                                            
SELECT io_date, io_pcode, p_name, DECODE(io_inout, '매입', io_price) AS 매입단가, DECODE(io_inout, '매입', io_total) AS 매입합계, 
 DECODE(io_inout, '매출', io_price) AS 매출단가, DECODE(io_inout, '매출', io_total) AS 매출합계 FROM tbl_iolist, tbl_product WHERE io_pcode = p_code ORDER BY io_date;                                                                                                                    
 
 
SELECT io_date, io_dcode, d_name, io_pcode, p_name, DECODE(io_inout, '매입', io_price) AS 매입단가, DECODE(io_inout, '매입', io_total) AS 매입합계, 
 DECODE(io_inout, '매출', io_price) AS 매출단가, DECODE(io_inout, '매출', io_total) AS 매출합계 FROM tbl_iolist LEFT JOIN tbl_product ON io_pcode = p_code LEFT JOIN tbl_dept ON io_dcode = d_cdoe  ORDER BY io_date;                                                                                                                     