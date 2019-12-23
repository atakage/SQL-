-- 여기는 USER2


DROP TABLE tbl_student;

CREATE TABLE tbl_student(

    st_num	VARCHAR2(5)  	PRIMARY KEY,
    st_name	nVARCHAR2(30)	NOT NULL,
    st_addr	nVARCHAR2(125),
    st_grade	NUMBER(1),		
    st_height	NUMBER(3),		
    st_weight	NUMBER(3),		
    st_nick	nVARCHAR2(20),		
    st_nick_rem	nVARCHAR2(50),		
    st_dep_no	VARCHAR2(3)	NOT NULL	



);


INSERT INTO tbl_student(st_num, st_name, st_dep_no, st_grade) VALUES('A0001', '홍길동', '001', 3);
INSERT INTO tbl_student(st_num, st_name, st_dep_no, st_grade) VALUES('A0002', '이몽룡', '002', 2);
INSERT INTO tbl_student(st_num, st_name, st_dep_no, st_grade) VALUES('A0003', '성춘향', '003', 1);
INSERT INTO tbl_student(st_num, st_name, st_dep_no, st_grade) VALUES('A0004', '임꺽정', '004', 4);
INSERT INTO tbl_student(st_num, st_name, st_dep_no, st_grade) VALUES('A0005', '장보고', '005', 3);

SELECT * FROM tbl_student;
SELECT * FROM tbl_student ORDER BY st_name;

SELECT * FROM tbl_student WHERE st_num >= 'A0002' AND st_num <= 'A0004';
SELECT * FROM tbl_student WHERE st_num BETWEEN 'A0002' AND 'A0004'
SELECT * FROM tbl_student WHERE st_grade = 2;

SELECT * FROM tbl_student WHERE st_num BETWEEN 'A0002' AND 'A0004' ORDER BY st_name;

SELECT * FROM tbl_student WHERE st_num BETWEEN 'A0002' AND 'A0004' ORDER BY st_grade DESC ;

SELECT COUNT(*) FROM tbl_student;       -- tbl_student의 테이블에 저장된 데이터 레코드는 모두 몇 개?
SELECT COUNT(*) FROM tbl_student WHERE st_grade = 2;
SELECT MAX(st_grade) FROM tbl_student;
SELECT MIN(st_grade) FROM tbl_student;

SELECT SUM(st_grade) FROM tbl_student;
SELECT AVG(st_grade) FROM tbl_student;

SELECT 30 + 40 FROM dual;   -- 오라클 이외의 다른 DBMS에서는 간단한 연산 등을 수행할 때 SELECT 연산 형식으로 사용됨(FROM 없이 사용 가능)
SELECT 30 * 40 FROM tbl_student;    

-- 레코드 셋(Record Set, ResultSet): SELECT 명령이 실행된 후 보이는 리스트

SELECT * FROM tbl_student;

UPDATE tbl_student SET st_addr = '광주광역시' WHERE st_name = '성춘향';
UPDATE tbl_student SET st_addr = '익산시' WHERE st_name = '이몽룡';
UPDATE tbl_student SET st_addr = '서울특별시' WHERE st_name = '홍길동';

INSERT INTO tbl_student(st_num, st_name, st_grade, st_dep_no) VALUES('A0006', '성춘향', 2, '001');

UPDATE tbl_student SET st_addr = '광주광역시' WHERE st_name = '성춘향' AND st_grade = 1;

INSERT INTO tbl_student(st_num, st_name, st_grade, st_dep_no) VALUES('A0007', '성춘향', 1, '001');

UPDATE tbl_student SET st_addr = '광주광역시' WHERE st_name = '성춘향' AND st_grade = 1 AND st_dep_no = '003';  


-- UPDATE를 수행하고자 할 때는 학생테이블의 PK로 설정된 학생의 학번(st_num)을 알고 학번을 기준으로 UPDATE를 수행해야만 한다(데이터의 신뢰도 유지 = 개체 무결성 보장)

