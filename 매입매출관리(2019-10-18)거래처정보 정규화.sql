-- 여기는 IOLIST 화면
-- 거래처정보 제2정규화 수행


-- 매입매출정보에는 거래처명과 대표명 두 개의 컬럼 있음, 거래처명이 같은데 대표가 다른 거래처가 있을 수 있기 때문에


SELECT io_dname, io_dceo FROM tbl_iolist;
SELECT io_dname, io_dceo FROM tbl_iolist GROUP BY io_dname, io_dceo ORDER BY io_dname;






CREATE TABLE tbl_dept(                              

d_code	VARCHAR2(5)		PRIMARY KEY,
d_name	nVARCHAR2(50)	NOT NULL	,
d_ceo	nVARCHAR2(20)	NOT NULL	,
d_tel	VARCHAR2(20)		,
d_addr	nVARCHAR2(125)		,
d_man	nVARCHAR2(20)		,
CONSTRAINT UQ_name_ceo UNIQUE (d_name, d_ceo)  -- 거래처명이 같고 대표자명이 다른 데이터를 UNIQE 설정, 입력할 때 거래명(2)과 대표자명(2)이 서로 같은 데이터는 INSERT 되지 않도록
                                                    --  테이블 생ㄷ성 후에 추가할 경우, ALTER TABLE tbl_dept ADD CONSTRAINT UQ_name_ceo UNIQUE (d_name, d_ceo);
);


SELECT COUNT(*) FROM tbl_dept;


SELECT d_name, COUNT(*), COUNT(d_name) FROM tbl_dept GROUP BY d_name HAVING COUNT(*) > 1; -- 거래처명이 같고 CEO가 다른 거래처가 있는지 확인, COUNT가 2이상인 데이터


SELECT COUNT(*) FROM tbl_iolist, tbl_dept WHERE io_dname = d_name AND io_dceo = d_ceo;

ALTER TABLE tbl_iolist ADD io_dcode VARCHAR2(5);

UPDATE tbl_iolist SET io_dcode = ( SELECT d_code FROM tbl_dept WHERE io_dname = d_name AND io_dceo = d_ceo);


SELECT COUNT(*) FROM tbl_iolist, tbl_dept WHERE io_dcode = d_code;

SELECT * FROM tbl_iolist;

ALTER TABLE tbl_iolist DROP COLUMN io_dname;
ALTER TABLE tbl_iolist DROP COLUMN io_dceo;

SELECT * FROM tbl_iolist;

SELECT * FROM tbl_iolist IO LEFT JOIN tbl_product P ON IO.io_pcode = P.p_code LEFT JOIN tbl_dept D ON IO.io_dcode = D.d_code ORDER BY IO.io_date, IO.io_pcode;

CREATE VIEW VIEW_IOLIST AS(
SELECT 

IO_SEQ AS SEQ,
IO_DATE AS IODATE, -- date 키워드 사용 금지
IO_INOUT AS INOUT,
IO_DCODE AS DCODE,
D_NAME AS DNAME,
D_CEO AS DCEO,
D_TEL AS DTEL,
IO_PCODE AS PCODE,
P_NAME AS PNAME,



IO_QTY AS QTY,
P_IPRICE AS IPRICE,
P_OPRICE AS OPRICE,
IO_PRICE AS PRICE,
IO_AMT AS AMT

FROM tbl_iolist IO
LEFT JOIN tbl_product P ON IO.io_pcode = P.p_code LEFT JOIN tbl_dept D ON IO.io_dcode = D.d_code  -- ORDER BY IO.io_date, IO.io_pcode
);


DROP VIEW view_iolist;

SELECT * FROM view_IOLISt;


SELECT DECODE(INOUT, 1, '매입', 2, '매출'), DCODE, DNAME, DCEO, PCODE, PNAME, QTY, PRICE, AMT FROM view_iolist;

SELECT DCODE, DNAME, SUM(DECODE(INOUT, 1, AMT, 0)) AS 매입합계, SUM(DECODE(INOUT,2,AMT,0)) AS 매출합계 FROM view_iolist GROUP BY DCODE, DNAME ORDER BY DNAME;


SELECT SUBSTR(IODATE, 0, 7)AS 월, TO_CHAR(SUM(DECODE(INOUT, 1, AMT)), '999,999,999,999') AS 매입합계, -- SUBSTR(컬럼, 시작, 개수)
TO_CHAR(SUM(DECODE(INOUT, 2, AMT)), '999,999,999,999') AS 매출합계  FROM view_iolist GROUP BY SUBSTR(IODATE, 0, 7) ORDER BY SUBSTR(IODATE, 0 , 7);              

-- TO_CHAR()는 SQLD에서 일반적으로 화면보기용으로 사용하되 다른 언어와 연동되는 부분에서는 가급적 사용 자제, 숫자를 문자열화하여 계산할 때 어려움이 있을 수 있음


SELECT SEQ, IODATE, DNAME, PNAME, DECODE(INOUT, 1, AMT) AS 매입, DECODE(INOUT, 2, AMT) AS 매출 FROM view_iolist;

SELECT SUM(DECODE(INOUT,1,AMT,0)) AS 총매입합계, SUM(DECODE(INOUT,2,AMT,0)) AS 총매출합계 FROM view_iolist WHERE iodate BETWEEN '2018-01-01' AND '2018-12-31' ;   

SELECT SUM(DECODE(INOUT,1,AMT,0)) AS 총매입합계, SUM(DECODE(INOUT,2,AMT,0)) AS 총매출합계 FROM view_iolist WHERE iodate LIKE '2018%'; 

SELECT IPRICE, OPRICE, DECODE(INOUT, 1, PRICE, 0)  매입, DECODE(INOUT, 2, PRICE, 0)  매출 FROM view_iolist;

SELECT PCODE, PNAME, IPRICE, DECODE(INOUT, 1, PRICE, 0)  매입, DECODE(INOUT, 1, PRICE, 0) -  DECODE(INOUT, 1, PRICE, 0) AS 매입차액, OPRICE , DECODE(INOUT, 2, PRICE, 0)  매출,
 DECODE(INOUT, 2, PRICE, 0) - DECODE(INOUT, 2, PRICE, 0) AS 매출차액 FROM view_iolist ORDER BY PCODE;      -- 상품정보와 매입매출 테이블의 입출단가의 차액을 계산해보는 SQL