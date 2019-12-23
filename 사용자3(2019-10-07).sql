-- 여기는 USER3 화면


CREATE TABLE tbl_books(

b_isbn	VARCHAR2(13)		PRIMARY KEY,
b_title	nVARCHAR2(50)	NOT NULL,	
b_comp	nVARCHAR2(50)	NOT NULL,	
b_writer	nVARCHAR2(50)	NOT NULL,	
b_price	NUMBER(5),		
b_year	VARCHAR2(10),		
b_genre	VARCHAR2(3)		


);


INSERT INTO tbl_books (b_isbn, b_title, b_comp, b_writer, b_price) VALUES('979-001', '오라클 프로그래밍', '생능출판사', '서진수', 30000);
INSERT INTO tbl_books (b_isbn, b_title, b_comp, b_writer, b_price) VALUES('979-002', 'Do it 자바', '이지퍼블리싱', '박은종', 25000);
INSERT INTO tbl_books (b_isbn, b_title, b_comp, b_writer, b_price) VALUES('979-003', 'SQL 활용', '교육부', '교육부', 10000);
INSERT INTO tbl_books (b_isbn, b_title, b_comp, b_writer, b_price) VALUES('979-004', '무궁화 꽃이 피었습니다', '새움', '김진명', 15000);
INSERT INTO tbl_books (b_isbn, b_title, b_comp, b_writer, b_price) VALUES('979-005', '직지', '쌤앤파커스', '김진명', 12600);


SELECT * FROM tbl_books;

SELECT * FROM tbl_books ORDER BY b_isbn;

-- DDL의 3대 키워드(CREATE, DROP, ALTER)


ALTER TABLE tbl_books MODIFY(b_price NUMBER(7));          -- tbl_books 테이블에 있는  b_price 컬럼의 데이터형식 자릿수 변경

INSERT INTO tbl_books (b_isbn, b_title, b_comp, b_writer, b_price) VALUES('978-801', 'effective java', 'Addison', 'Joshua Bloch', 159000);

SELECT * FROM tbl_books;

ALTER TABLE tbl_books ADD(b_remark nVARCHAR2(125));

DESC tbl_books;

ALTER TABLE tbl_books DROP COLUMN b_remark;     -- 컬럼 삭제, 기존에 사용하던 table에서 컬럼을 삭제하면 저장된 데이터가 변형되어 문제가 발생할 수 있음
ALTER TABLE tbl_books RENAME COLUMN b_remark TO b_rem;      -- 컬럼의 이름 변경, 컬럼 이름을 변경하는 것은 데이터 변형이 발생하지 않지만 다른 SQL 명령문이나, 내장 프로시저, Java 프로그래밍에서
                                                                    --table에 접근하여 데이터를 CRUD할 때 문제가 발생할 수 있음

-- MODIFY는 컬럼의 타입을 변경하는 것으로 저장된 데이터가 변형될 수 있음, 자릿수를 줄이면 보통 실행 오류가 발생하고 그렇지 않은 경우도 있는데 이때는 저장된 데이터의 일부가 잘릴 수 있음
-- 또 기존 데이터 형식이 변경되면서 데이터가 손실, 소실될 수도 있는데 특히 CHAR형과 VARCHAR2 사이에서 타입을 변경하면 기존의 SQL(SELECT)명령 결과가 전혀 엉뚱하게 나타나거나 데이터를 못 찾을 수도

ALTER USER user3 IDENTIFIED BY 1234;


CREATE TABLE tbl_genre(

    g_code	VARCHAR2(3)		PRIMARY KEY,
    g_name	nVARCHAR2(15)	NOT NULL,	
    g_remark	nVARCHAR2(125)		


);

ALTER TABLE tbl_genre MODIFY(g_name nVARCHAR2(50));

INSERT INTO tbl_genre(g_code, g_name) VALUES('001', '프로그래밍');
INSERT INTO tbl_genre(g_code, g_name) VALUES('002', '데이터베이스');
INSERT INTO tbl_genre(g_code, g_name) VALUES('003', '장편소설');

SELECT * FROM tbl_genre;
DESC tbl_books;

ALTER TABLE tbl_books MODIFY (b_genre nVARCHAR2(10));

SELECT * FROM tbl_books;

UPDATE tbl_books SET b_genre = '데이터베이스' WHERE b_isbn = '979-001';            -- UPDATE를 실행할 때 2개 이상의 레코드에 영향을 미치도록 명령을 수행하는 것은 지양
UPDATE tbl_books SET b_genre = '프로그래밍' WHERE b_isbn = '979-002' ;            -- UPDATE 수행은 먼저 PK를 확인한 후 WHERE 절에 PK조건을 설정하여  하자
UPDATE tbl_books SET b_genre = '데이터베이스' WHERE b_isbn = '979-003';
UPDATE tbl_books SET b_genre = '장편소설' WHERE b_isbn = '979-004';
UPDATE tbl_books SET b_genre = '장편소설' WHERE b_isbn = '979-005';
UPDATE tbl_books SET b_genre = '프로그래밍' WHERE b_isbn = '978-801';

SELECT * FROM tbl_books WHERE b_genre = '장편소설';

UPDATE tbl_books SET b_genre = '장르소설' WHERE b_genre = '장편소설';

INSERT INTO tbl_books(b_isbn, b_title, b_comp, b_writer, b_price, b_genre) VALUES('979-006', '황태자비 납치사건' , '새움','김진명' , 25000, '장르소설');

SELECT * FROM tbl_books;

UPDATE tbl_books SET b_genre = '장르 소설' WHERE b_isbn = '979-006';        -- 일부 데이터에 빈칸 등이 잘못 삽입돼 데이터 조회 시 문제 발생 이러한 논리적 문제 해결 위해 
                                                                                -- 장르 테이블을 별도로 생성하고 books 테이블의 정규화 과정을 통해 조회 오류 발생 대비

SELECT * FROM tbl_books WHERE b_genre = '장르소설';

SELECT * FROM tbl_genre;

SELECT * FROM tbl_books WHERE b_genre = '데이터베이스';
UPDATE tbl_books SET b_genre = '002' WHERE b_genre = '데이터베이스';
UPDATE tbl_books SET b_genre = '001' WHERE b_genre = '프로그래밍';
UPDATE tbl_books SET b_genre = '003' WHERE b_genre = '장르소설';
UPDATE tbl_books SET b_genre = '003' WHERE b_genre = '장르 소설';

SELECT * FROM tbl_books;

-- JOIN: 2개 이상의 테이블을 서로 연계하여 하나의 리스트로 보여주는 것(Relationship)

SELECT * FROM tbl_books, tbl_genre WHERE tbl_books.b_genre = tbl_genre.g_code;


SELECT tbl_books.b_isbn,tbl_books.b_title, tbl_books.b_comp, tbl_books.b_writer, tbl_books.b_genre, tbl_genre.g_name FROM tbl_books, tbl_genre  WHERE tbl_books.b_genre = tbl_genre.g_code;

SELECT B.b_isbn,B.b_title, B.b_comp, B.b_writer, B.b_genre, G.g_name FROM tbl_books B, tbl_genre G WHERE B.b_genre = G.g_code;  -- ANSI tbl_books AS b, tbl_genre AS G, Table 명에 Alias 설정

INSERT INTO tbl_books(b_isbn, b_title, b_comp, b_writer, b_genre) VALUES('979-007', '자바의 정석' , '도울출판', '남궁성', '004'); 

SELECT * FROM tbl_books;

SELECT * FROM [table1], [table2] WHERE table1.col = table2.col; -- 완전Join, EQ Join이라고 하며 결과를 카티션곱이라고 표현함, table1과 table2를 Relation할 때 서로 연결하는 컬럼의 값이 두 테이블에 존재할 때
                                                                    -- 정상적인 결과를 낼 수 있음