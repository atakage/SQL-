-- 사용자4 화면


CREATE TABLE tbl_books(             -- TABLE 생성ㅇ에서 기본키를 항상 고민
    
    b_code NUMBER PRIMARY KEY,                              -- ISBN과 별도로 자체적인 일련번호를 부여하여 관리, 입력순으로 번호 부여
    b_name nVARCHAR2(50) NOT NULL,
    b_comp nVARCHAR2(50),
    b_wirter nVARCHAR2(20),
    b_price NUMBER DEFAULT 0     -- b_price는 숫잣값인데 입력 없이 값이 추가되면 null형태가 됨, 이럴 경우 프로그래밍 언어에서 데이터를 가져다 쓸 때 문제 일으킴
                                -- 그렇기 때문에 INSERT 수행할 때 값이 없으면 0으로 세팅
                                
                                

);



INSERT INTO   tbl_books(b_code, b_name, b_comp, b_wirter) VALUES (1, '자바입문' , '이지퍼블' , '박은종');

SELECT * FROM tbl_books;

INSERT INTO tbl_books VALUES(2, '오라클', '생능', '서진수', 35000); -- 테이ㅣ블의 컬럼 순서가 정확하다는 보장이 있고 모든 컬럼에 데이터가 있다라느 보장이 있을 때는
                                                                    -- INSERT 명령문에 Projection(컬럼을 리스트)하지 않아도 데이터만 정확히 나열하면 명령 수행 가능
                                                                    -- 가급적 사용 자제
                                                                    
                                                                    
-- 데이터를 추가할 때마다 b_code 컬럼의 값을 새로 생성하고 싶음                

-- 일련번호를 순서대로 자동 생성하도록 컬럼을 설정하는 것은 오라클 11g 이하 불가능
-- AUTO_INCREMENT 는 오라클 12g 이상만 가능


INSERT INTO tbl_books(b_code, b_name) VALUES( ROUND( DBMS_RANDOM.VALUE(10000000000, 99999999999),0), '연습도서'); --  RANDOM 부여


CREATE SEQUENCE SEQ_BOOKs START WITH 1 INCREMENT BY 1; -- SEQUENCE 객체를 생성하여 번호 붙이기, 다른 DBMS의 AUTO INCREMENT 기능을 대체하여 사용하는 방법
                                                    -- 1부터(START WITH), 1씩 증가(INCREMENT BY 1)
                                                    
SELECT SEQ_BOOKS.NEXTVAL FROM DUAL;

ALTER SEQUENCE SEQ_BOOKS INCREMENT BY 1;

INSERT INTO tbl_books(b_code, b_name)
VALUES ( SEQ_BOOKS.NEXTVAL, '시퀀스연습');

SELECT * FROM tbl_books;


-- 기존에 생성된 테이블에 SEQ 적용
-- 1. 기존 데이터의 SEQ 컬럼의 최댓값이 얼마냐 확인(ex)589))
-- 2. 새로운 시퀀스를 생성할 때 START WITH : 600으로 설정

CREATE SEQUENCE SEQ_IOLIST START WITH 1 INCREMENT BY 1;

ALTER SEQUENCE SEQ_IOLIST START WITH 600; -- 만약 실수로 SEQ 시작값을 잘못 설정했을 경우
ALTER SEQUENCE SEQ_IOLIST INCREMENT BY 600; -- 증가값을 최댓값보다 큰값으로 일단 설정
SELECT SEQ_IOLIST .NEXTVAL FROM DUAL;
ALTER SEQUENCE SEQ_IOLIST INCREMENT BY 1;       -- 다시 증가값을 1로 설정

-- 쉬운 방법
DROP SEQUENCE SEQ_IOLIST;
CREATE SEQUENCE SEQ_IOLIST START WITH 1000 INCREMENT BY 1;

SELECT SEQ_IOLIST.CURRVAL FROM DUAL; -- 현재 SEQ_IOLIST 값 

-- TABLE에 특정할 수 있는 PK가 있는 경우는 해당하는 값을 INSERT를 수행하며 입력하는 것이 좋고, 그렇지 못한 경우 SEQUENCE를 사용하여 일련번호 형식ㅇ로 저장


DROP TABLE tbl_books;



CREATE TABLE tbl_books(            
    
    b_code VARCHAR(5) PRIMARY KEY,                              
    b_name nVARCHAR2(50) NOT NULL,
    b_comp nVARCHAR2(50),
    b_wirter nVARCHAR2(50),
    b_price NUMBER DEFAULT 0                                    
                                

);



INSERT INTO tbl_books(b_code, b_name) VALUES('B' || TRIM(TO_CHAR(SEQ_BOOKS.NEXTVAL, '0000')), '시퀀스연습'); -- b.code: B0001~ 생성하기

-- TRIM(); 문자열의 앞과 뒤의 공백제거, 중간공백 제거 불가

SELECT * FROM tbl_books;


-- 오라클의 고정길이 문자열 생성
/*
원랫값이 숫자형일 경우는 TO_CHAR(값, 포맷형)

원래 길이 다양한 경우(LPAD(값 총길이, 채움문자)


*/


SELECT LPAD(30,10, '*') FROM DUAL;          -- 
SELECT RPAD(30,10, 'A') FROM DUAL;          -- 
SELECT 'B' || LPAD(SEQ_BOOKS.NEXTVAL, 4, '0') FROM DUAL;


SELECT RPAD('우리' , 20, ' ') FROM DUAL
UNION ALL SELECT RPAD('대한민국', 20, ' ')FROM DUAL
UNION ALL SELECT RPAD('미연합방중국', 20, ' ')FROM DUAL
UNION ALL SELECT RPAD('중화인민공화국', 20, ' ')FROM DUAL;

SELECT LPAD('우리' , 20, ' ') FROM DUAL
UNION ALL SELECT LPAD('대한민국', 20, ' ')FROM DUAL
UNION ALL SELECT LPAD('미연합방중국', 20, ' ')FROM DUAL
UNION ALL SELECT LPAD('중화인민공화국', 20, ' ')FROM DUAL;

SELECT * FROM tbl_books;

INSERT INTO tbl_books(b_code, b_name) VALUES('B' || TRIM(TO_CHAR(SEQ_BOOKS.NEXTVAL, '0000')), '시퀀스연습'); 
INSERT INTO tbl_books(b_code, b_name) VALUES('B' || LPAD(SEQ_BOOKS.NEXTVAL,4, '0'), '시퀀스연습'); 