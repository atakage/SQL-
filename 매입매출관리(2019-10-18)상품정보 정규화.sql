-- IOLIST 사용자 화면


SELECT * FROM tbl_product;


-- 상품정보 테이블에서 판매가격의 원단위를 제거하고 0으로 세팅, 판매가격 = ROUND(판매가격 / 10,) * 10

UPDATE tbl_product SET p_oprice = ROUND(p_oprice / 10, 0) * 10      -- 1개 이상의 데이터를 대상으로 UPDATE, DELETE 수행할 때는 신중하게 코드 검토해서 실행


-- 매입매출장과 상품정보를 JOIN하기 위해 매입매출장의 상품코드 컬럼을 추가하고, 상품이름과 연결된 상품코드로 업데이트하고, 상품이름 컬럼을 제거


ALTER TABLE tbl_iolist ADD io_pcode VARCHAR2(6);



-- 매입매출테이블 리스트를 나열하고 각 요소의 상품이름을 SUBQ로 전달 SUBQ에서는 상품테이블로부터 상품이름을 조회하여 일치하는 레코드가 1개 나타나면 해당 레코드의 상품코드 커럼의 값을
-- 매입매출커럼의 상품코드 컬럼에 업데이트
UPDATE tbl_iolist IO SET io_pcode = ( SELECT p_code FROM tbl_product P WHERE IO.io_pname = P.p_name);                          -- UPDATE를 수행하는 SUBQ의 SELECT Projection에는 컬럼을 1개만 사용해야 함(SUBQ에서 나타나는 레코드수도 반드시 1개만 나타나야 함)

SELECT *  FROM tbl_iolist, tbl_product where io_pcode = p_code;   

ALTER TABLE tbl_iolist DROP COLUMN io_pname;

/*
    오라클에서 INSERT, UPDATE, DELETE를 수행한 직후 아직 데이터가 COMMIT 도ㅓㅣ지 않아 실제 물리적 테이블이 저장되지 않은 상태, 이때는 ROLLBACK 수행하여 CUD 취소할 수 있음
    
    단, DDL 명령(CREATE, ALTER, DROP)을 수행하면 자동 COMMIT됨
    
    대량의 INSERT, UPDATE, DELETE를 수행한 후 데이터 검증이 완료되면 가급적 COMMIT 수행하고 다음으로 진행

*/


SELECT COUNT(*) FROM tbl_iolist, tbl_product WHERE io_pcode = p_code;


