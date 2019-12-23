CREATE TABLE tbl_user(           -- 사용자 정보


u_id	VARCHAR2(125)	NOT NULL	PRIMARY KEY,
u_nick	nVARCHAR2(125)		,
u_name	nVARCHAR2(125)	NOT NULL,	
u_password	nVARCHAR2(125)	NOT NULL,	
u_tel	VARCHAR2(20)		,
u_grade	VARCHAR2(5)		
	




);




CREATE TABLE tbl_uhobby(            -- 사용자 취미 정보


uh_seq	NUMBER	NOT NULL	PRIMARY KEY,
uh_id	VARCHAR2(125)	NOT NULL	,
uh_code	VARCHAR2(5)	NOT NULL	



);



CREATE SEQUENCE SEQ_UHOBBY
START WITH 1 INCREMENT BY 1;






CREATE TABLE tbl_hobby(         -- 취미

h_code	VARCHAR2(5)	NOT NULL	PRIMARY KEY,
h_name	nVARCHAR2(125)	NOT NULL	,
h_rem	nVARCHAR2(125)		

);




SELECT * FROM tbl_hobby;

