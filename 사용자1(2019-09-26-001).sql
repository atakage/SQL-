-- 여기는 user1 화면입니다


CREATE TABLE tbl_addr(

    name varchar2(10),
    addr varchar2(125),
    tel varchar2(20),
    age number,
    chain varchar2(20)
    
);


SELECT * FROM tbl_addr;

INSERT INTO tbl_addr(name, addr, tel, age, chain) VALUES('홍길동', '서울시', '010-111-1111', '33','친구');
UPDATE tbl_addr SET addr = '광주광역시'      -- tbl_addr table의 addr 컬럼에 저장된 값을 변경

DELETE FROM tbl_addr;