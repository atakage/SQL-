-- 사용자4
CREATE TABLE tbl_bbs(

    bs_idPK NUMBER PRIMARY KEY,
    bs_date VARCHAR2(10) NOT NULL,
    bs_time VARCHAR2(10) NOT NULL ,
    bs_writer nVARCHAR2(20) NOT NULL,
    bs_subject nVARCHAR2(125) NOT NULL,
    bs_text nVARCHAR2(1000) NOT NULL,
    bs_count NUMBER


);


CREATE SEQUENCE seq_bbs START WITH 1 INCREMENT BY 1;