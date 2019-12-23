-- 여기는 iolist 화면


CREATE TABLE tbl_iolist(

io_seq	NUMBER	NOT NULL	PRIMARY KEY,
io_date	VARCHAR2(10)	NOT NULL	,
io_pname	nVARCHAR2(50)	NOT NULL,	
io_dname	nVARCHAR2(50)	NOT NULL,	
io_dceo	nVARCHAR2(20)		,
io_inout	NUMBER(1)	NOT NULL,	
io_qty	NUMBER	NOT NULL	,
io_price	NUMBER		,
io_amt	NUMBER		



);


SELECT io_inout, COUNT(*) FROM tbl_iolist GROUP BY io_inout;



SELECT DECODE(io_inout, 1, '매입', 2, '매출') AS 구분, COUNT(*) FROM tbl_iolist GROUP BY DECODE(io_inout, 1, '매입',2, '매출');

SELECT DECODE(io_inout, 1, '매입', DECODE(io_inout, 2, '매출')) FROM tbl_iolist;

SELECT DECODE(io_inout, 1, '매입', 2, '매출') FROM tbl_iolist;



/*


IF(컬럼 == 값){
        T표시
    }else if(컬럼 == 값2){
        T표시2
    }
    
    
   DECODE(컬럼, 값1, T결과1, DECODE(컬럼, 값2, T결과2......   
   DECODE(컬럼, 값1, T결과1, 값2, T결과2......      



*/



SELECT DECODE(io_inout, 1, '매입', 2, '매출') AS 거래구분 , SUM(DECODE(io_inout, 1, io_amt, 0)) AS 매입합계, SUM(DECODE(io_inout, 2, io_amt, 0)) AS 매출합계 FROM tbl_iolist GROUP BY DECODE(io_inout, 1, '매입', 2, '매출');



SELECT SUM(DECODE(io_inout, 1, io_amt, 0)) AS 매입합계, SUM(DECODE(io_inout, 2, io_amt, 0)) AS 매출합계 FROM tbl_iolist;

SELECT  SUM(DECODE(io_inout, 1, io_amt, 0)) AS 매입합계, SUM(DECODE(io_inout, 2, io_amt, 0)) AS 매출합계 FROM tbl_iolist GROUP BY io_date;

SELECT SUBSTR(io_date, 0, 7) AS 월, SUM(DECODE(io_inout, 1, io_amt, 0)) AS 매입합계, SUM(DECODE(io_inout, 2, io_amt, 0)) AS 매출합계,
SUM(DECODE(io_inout, 2, io_amt, 0)) - SUM(DECODE(io_inout, 1, io_amt, 0)) AS 마진
FROM tbl_iolist GROUP BY SUBSTR(io_date,0,7) ORDER BY SUBSTR(io_date,0,7);       --LEFT: 왼쪽부터 문자열 자르기