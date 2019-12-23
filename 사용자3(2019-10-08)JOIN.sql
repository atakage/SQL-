-- 여기는 USER3 화면

-- JOIN은 2개 이상의 테이블에 나뉘어서 보관 중인 데이터를 서로 연계해 하나의 리스트처럼 출력하는 명령 

SELECT * FROM tbl_books B, tbl_genre G WHERE b.b_genre = g.g_code;      -- EQ, 완전(내부)조인으로 두 테이블에 연계된 컬럼이 모두 존재할 경우, 두 테이블간에 완전 참조무결성이 보장되는 경우
                                                                        -- 이 조인이 표시하는 리스트를 카티션곱이라고 표현
                                                                        -- EQ조인의 경우 두 테이블이 완전 참조무결성 조건에 위배되는 경우 결과는 신뢰성을 잃는다
                                                                        
                                                                        

/*

참조 무결성


원본 TABLE(컬럼)            =           참조 TABLE(컬럼)
----------------------------------------------------------

값이 있다                   >>                  반드시 있다
있을 수도 있다              <<                있다
절대 있을 수 없다           <<                없다


참조 무결성 조건은 테이블간 EQ JOIN을 실행했을 때 결과의 신뢰성을 보장하는 조건
*/


-- 두 테이블간에 참조무결성을 무시하고 JOIN실행
-- 새로운 도서가 입고되었는데 그동안 사용하던 장르와 다른 분야로 새로운 장르코드(010)를 생성해 사용하기로 결정

INSERT INTO tbl_books(b_isbn, b_title, b_comp, b_writer, b_genre) VALUES('979-009', '아침형인간', '하늘소식', '이몽룡', '010'); -- 만약 tbl_books 테이블과 tbl_genre 테이블간 참조무결성 조건을 설정해 두었더라면
                                                                                                -- tbl_books 테이블에는 INSERT를 수행하지 못함
                                                                                                -- 하지만 아직 참조무결성 조건 설정하지 않았기에 INSERT 가능

SELECT * FROM tbl_books B, tbl_genre G WHERE b.b_genre = g.g_code;  -- 새로 등록한 도서리스트가 누락되어 출력(신뢰성 저하)

-- 이런 상황 발생했을 경우 참조무결성을 무시하고 (일부)신뢰성이 있는 리스트를 보기 위해 다른 JOIN 수행

SELECT * FROM tbl_books B -- 리스트를 확인하고자 하는 table (전체 표시)
LEFT JOIN tbl_genre G   -- 참조할 TABLE (조건에 일치하는 값이 있는 경우 표시 그렇지 않으면 NULL로 표시)
ON B.b_genre = G.g_code ORDER BY B.b_isbn;    -- 참조할 커럼 연계

SELECT * FROM tbl_books B LEFT JOIN tbl_genre G ON b.b_genre = g.g_code WHERE b.b_title = '아침형인간';

SELECT B.b_isbn, B.b_title, b.b_comp, B.b_writer, G.g_code, G.g_name FROM tbl_books B LEFT JOIN tbl_genre G ON B.b_genre = g.g_code WHERE B.b_title LIKE 'SQL%' ORDER BY B.b_title; 

SELECT B.b_isbn, B.b_title, b.b_comp, B.b_writer, G.g_code, G.g_name FROM tbl_books B LEFT JOIN tbl_genre G ON B.b_genre = G.g_code WHERE G.g_name = '장편소설';



 

UPDATE tbl_genre SET g_name = '장르소설' WHERE g_code = '003';      -- 장르가 '장편소설'인 도서정보를 '장르소설'로 명칭을 변경하고 싶ㅇ을 때는 두 TABLE이 각각 books와 genre로 나뉘어 있고 두 테이블을 JOIN해서 사용하는 중이기 때문에
                                                                    --tbl_genre 이블의 g_name 컬럼값을 변경
SELECT B.b_isbn, B.b_title, b.b_comp, B.b_writer, G.g_code, G.g_name FROM tbl_books B LEFT JOIN tbl_genre G ON B.b_genre = G.g_code

