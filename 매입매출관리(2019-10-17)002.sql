-- 매입매출관리
-- 상품정보 제2정규화


 SELECT io_pname FROM tbl_iolist GROUP BY io_pname ORDER BY io_pname ; 
 
 
 
 
 
 CREATE TABLE tbl_product(
 
p_code	VARCHAR2(6)	NOT NULL	PRIMARY KEY,
p_name	nVARCHAR2(50)	NOT NULL	,
p_iprice	NUMBER		,
p_oprice	NUMBER		



);


SELECT * FROM tbl_iolist;
SELECT * FROM tbl_product;


SELECT io_inout, COUNT(*) FROM tbl_iolist IO, tbl_product P WHERE IO.io_pname = p.p_name GROUP BY io_inout;


SELECT io_inout, IO.io_pname, IO.io_price, COUNT(*) FROM tbl_iolist IO, tbl_product P WHERE IO.io_pname = p.p_name AND IO.io_inout = 1 GROUP BY io_inout, io_pname, io_price;

UPDATE tbl_product P SET p_iprice = ( SELECT MAX(IO.io_price) FROM tbl_iolist IO WHERE io_inout = 1 AND P.p_name = IO.io_pname );
UPDATE tbl_product P SET p_oprice = ( SELECT MAX(IO.io_price) FROM tbl_iolist IO WHERE io_inout = 2 AND P.p_name = IO.io_pname );



/*
    매입단가에서 매출단가 생성하기
    공산품일 경우 매입단가의 약 18%를 더해서 매출단가를 계산 그리고 여기에 10%의 VAT를 붙여서 다시 
    매출단가 = (매입단가 + (매입단가 * 0.18) * 1.1
    
    매출단가에서 매입단가 생성
    매출단가에서 부가세를 제외하고 그 금액에서 18%를 빼서 매입단가 계산
    
    매입단가 = (매출단가 / 1.1) - ((매출단가 / 1.1) * 0.18)
    매입단가 = (매출단가 / 1.1) * 0.82
*/


UPDATE tbl_product SET p_iprice = ROUND((p_oprice / 1.1),0) * 0.82 WHERE p_iprice IS NULL; 

UPDATE tbl_product SET p_oprice = ROUND((p_iprice + (p_iprice * 0.18)) * 1.1,2)  WHERE p_oprice IS NULL; 

UPDATE tbl_product SET p_iprice = ROUND(p_iprice, 0), p_oprice = ROUND(p_oprice, 0);

SELECT * FROM tbl_product;