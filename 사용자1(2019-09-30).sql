-- 여기는 USER1 화면
-- 테이블은 java의 VO와 같은 개념의 데이터 저장소
-- 각 요소들: 컬럼, java에서 필드변수 개념


CREATE TABLE tbl_test(
    num nVARCHAR2(20) NOT NULL UNIQUE PRIMARY KEY,
    name nVARCHAR2(50) NOT NULL,
    age NUMBER(3) NOT NULL
    );
    
    
DROP TABLE tbl_test;    -- table을 삭제

INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel) VALUES ('A0001', '홍길동', '서울특별시', '010-111-1234');
INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel) VALUES ('A0002', '이몽룡', '익산시', '010-222-1234');
INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel) VALUES ('A0003', '성춘향', '남원시', '010-333-1234');
INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel) VALUES ('A0004', '장길산', '충청남도', '010-444-1234');
INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel) VALUES ('A0005', '장보고', '해남군', '010-555-1234');
INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel) VALUES ('A0006', '임꺽정', '010-666-1234', '함경도');


-- 데이터를 추가할 때 [table](컬럼리슻트)와 VALUES(값 리스트)는  반드시 개수와 순서가 일치되어야 함

SELECT * FROM tbl_student;

SELECT st_num, st_name, st_addr, st_tel FROM tbl_student; -- 특정 컬럼만 리스트에 보여줌
SELECT st_name, st_num, st_tel, st_addr FROM tbl_student;  -- 컬럼 리스트 입력 순서대로 보여줌
SELECT st_num AS 학번, st_name AS 이름, st_tel AS 전화번호, st_addr AS 주소 FROM tbl_student; -- 컬럼에 별칭 붙여 출력(오라클에서는 AS생략해도 됨)

SELECT * FROM tbl_student WHERE st_name = '홍길동';

INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel) VALUES ('A0007', '홍길동', '부산광역시', '010-777-1234');
SELECT st_num, st_name, st_tel FROM tbl_student WHERE st_name ='홍길동';


-- SELECT 명령문 사용할 때 컬럼 리스트를 *로 사용하지 않고 필요한 컬럼 나열하는 것이 데이터 조회 속도면에서 유리
-- projection: 컬럼리스트를 나열하는 것
-- 위치(index)로 컬럼 값을 추출하면 후에 그 값을 응용프로그램에서 사용하려고 할 때 정확히 원하는 위치의 값을 보장하여 오류를 줄일 수 있음


SELECT * FROM tbl_student WHERE st_name ='홍길동' OR  st_name = '이몽룡';  -- 다중 조건 조회
SELECT * FROM tbl_student WHERE st_name ='홍길동' AND  st_addr = '서울특별시';
SELECT * FROM tbl_student WHERe st_name ='홍길동' OR st_addr = '서울특별시';

SELECT st_num || ' + ' || st_name || ' + ' || st_tel AS 컬럼 FROM tbl_student; -- 컬럼 값들을 서로 연결해서 문자열처럼 출력

-- LIKE: SELECT 조회 명령이 실행될 때 데이터가 많으면 속도가 느려짐

SELECT * FROM tbl_student WHERE st_addr = '서울시';
SELECT * FROM tbl_student WHERE st_addr  LIKE '서울%';        -- '서울'이라는 문자열로 시작되는 데이터 출력
SELECT * FROM tbl_student WHERE st_addr  LIKE '%시';     -- '시'라는 문자열로 끝나는 데이터 출력
SELECT * FROM tbl_student WHERE st_name LIKE '%길동%'; -- '길동'이라는 문자열 포함하는 데이터 출력
SELECT * FROM tbl_student WHERE st_addr  LIKE '%길동'; -- '길동이', '길동이가' 등등 출력 안 됨

SELECT * FROM tbl_student WHERE st_tel >= '010-111-0000' AND st_tel <= '010-333-9999'; -- SQL에서는 문자열로 지정된 컬럼에 데이터가 일정한 길이를 갖고 있을 때
                                                                                                    -- 비교연산자를 사용하여 값을 조회 가능
                                                                                                    
SELECT * FROM tbl_student WHERE st_num BETWEEN 'A0003' AND 'A0006';

SELECT * FROM tbl_student WHERE st_addr in('익산시', '남원시', '해남군');

-- PRIMARY KEY로 설정된 컬럼을 조건으로 하여 데이터를 조회하면 TABLE에 데이터가 얼마나 저장돼 있던 간에 출력되는 리스트는 1개이거나 없음... 개체 무결성
-- PK는 절대 2개 이상 출력X

COMMIT; -- DBMS의 임시저장소에 저장된 데이터를 storage에 저장하는 명령(DCL, TCL(Transaction Controll Language 명령)