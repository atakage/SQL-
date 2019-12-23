
CREATE TABLE tbl_addr(

    id NUMBER PRIMARY KEY,
    name nVARCHAR2(50) NOT NULL,
    tel VARCHAR2(20),
    addr nVARCHAR2(125),
    chain nVARCHAR2(10)

);

CREATE SEQUENCE SEQ_ADDR START WITH 1 INCREMENT BY 1;


INSERT INTO tbl_addr(id, name, tel, addr, chain) VALUES(0045, '인간', '0a15', '대전', '가족');


UPDATE tbl SET tbl.n = tbl.n+1

commit;