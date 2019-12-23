-- 여기는 user1 사용자 화면입니다
-- DBA 역할 중에서 데이터 저장소의 기초인 Table을 만드는 것

-- 학생 정보를 저장할 tbl_student Table 생성


-- tbl_student라는 이름으로 table(물리적 저장소)을 생성
-- 오라클에서는 대소문자 구별X
CREATE TABLE tbl_student(

        -- 칼럼: 필드(멤버)변수의 같은 개념
        -- 칼럼들은 콤마로 구분
        -- data type에는 () 사용하여 최대 지정할 크기를 byte 단위로 지정
    st_num CHAR(5),             -- CHAR은 고정길이 문자열 저장(저장될 데이터가 항상 일정한 길이를 갖고 있음이 보장), 최대 2000글자까지 지정 가능
    st_name nVARCHAR2(20),       -- VARCHAR 가변길이 문자열 저장 컬럼 , 4000글자까지 저장 가능
    st_addr nVARCHAR2(125),     -- VARCHAR2 유니코드와 다국어 지원 컬럼, 한글이 입력될 가능성이 있으면 사용
    st_tel VARCHAR2(20),
    st_grade INT,               -- 숫자 저장 컬럼으로 표준 SQL에서는 INT, FLOAT, LONG, DOUBLE 등의 keyword가 있음, 오라클도 표준 keyword 사용 가능하지만
                                -- 오라클 코드에서는 NUMBER라는 컬럼을 사용, INT라는 keyword를 사용하면 NUMBER(38)로 변환되어 생성
    st_dept nVARCHAR2(10),
    st_age NUMBER(3)             -- 제일 마지막 칼럼은 콤마X


);

-- 오라클에서 CHAR 컬럼에 순수 숫자로만 되어 있는 데이터 저장할 경우 문제 일으킬 수 있음
-- A0001 형식으로 지정하면 이것은 문자열로 인식
-- 0001 형식으로 저장하면 오라클DB에는 문자열로 저장이 되는데 JAVA를 통해 DB에 접속할 경우 숫자로 인식해 버리는 오류 발생



INSERT INTO tbl_student(st_num, st_name, st_addr) VALUES('00001', '성춘향', '익산시');
INSERT INTO tbl_student(st_num, st_name, st_addr) VALUES('00001', '성춘향', '남원시');

select * from tbl_student;

DROP TABLE tbl_student;   


CREATE TABLE tbl_student(           -- 학번이 0100인 학생의 데이터가 두 번 추가가 될 경우 이후 0100 학생의 데이터 2개가 조회됨(문제 발생)
                                    -- DB에서는 이런 문제가 발생하지 않도록 제약 조건 설정이 필요(학번이 동일한 데이터 2개 이상X)
                                    -- UNIQUE 제약 조건
    
    st_num CHAR(5) UNIQUE NOT NULL,          -- UNIQUE는 중복배제, 중복금지
    st_name nVARCHAR2(20) NOT NULL,          -- 값이 없는 컬럼이 존재하면 안 되는 상황을 대비해 NOT NULL
    st_addr nVARCHAR2(125),
    st_tel VARCHAR(20) NOT NULL,
    st_dept nVARCHAR2(20),
    st_grade NUMBER(1),
    st_age NUMBER(3)
);

-- st_num 칼럼은 Primary Key라는 조건을 설정함

INSERT INTO tbl_student(st_num, st_name, st_addr) VALUES('00001', '성춘향', '남원시');
INSERT INTO tbl_student(st_num, st_name, st_addr) VALUES('00001', '이몽룡', '서울시');

INSERT INTO tbl_student(st_num, st_tel) VALUES('20111', '010-111-1234');        --학번, 전화번호를 입력하고 이름이 없는 상태로 데이터 추가하려고 할 때 오류(st_name에 NOT NULL)

INSERT INTO tbl_student(st_num, st_name, st_tel) VALUES('00002', '이몽룡', '010-0000-1111');

select * from tbl_student;


DROP TABLE tbl_student;

CREATE TABLE tbl_student(           
    
    st_num CHAR(5) PRIMARY KEY, -- PRIMARY KEY로 설정한 컬럼은 UNIQUE와 NOT NULL 설정을 생략(모두 포함하기 때문) 
    st_name nVARCHAR2(20) NOT NULL,        
    st_addr nVARCHAR2(125),
    st_tel VARCHAR(20) NOT NULL,
    st_dept nVARCHAR2(20),
    st_grade NUMBER(1),
    st_age NUMBER(3)
);

DESCRIBE tbl_student;       -- 테이블 구조를 확인하는 명령문


-- PRIMARY KEY는 하나의 테이블에 하나만 정의할 수 있지만 UNIQUE는 여러 개를 정의할 수 있음
-- PRIMARY KEY 조건과 달리 UNIQUE는 NULL값이 허용됨


SELECT * from DBA_TABLES WHERE OWNER = 'USER1';     -- USER1 사용자가 생성한 테이블의 구조 확인

INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_age, st_dept) VALUES('00001', '홍길동', '010-111-111', '서울시', '66', '컴공과');
INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_age, st_dept) VALUES('00002', '성춘향', '010-112-211', '남원시', '33', '컴공과');
INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_age, st_dept) VALUES('00003', '이몽룡', '010-331-111', '익산시', '16', '컴공과');
INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_age, st_dept) VALUES('00004', '임꺽정', '010-444-111', '함경도', '56', '컴공과');

-- INTSERT INTO table(column, column) VALUES(