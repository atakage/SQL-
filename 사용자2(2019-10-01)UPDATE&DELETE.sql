-- 여기는 USER2 화면

CREATE TABLE tbl_address(

    name nVARCHAR2(20) NOT NULL,
    tel VARCHAR(20) NOT NULL,
    address nVARCHAR2(125),
    chain nVARCHAR2(10),

    age NUMBER(3)

);


DROP TABLE tbl_address;

INSERT INTO tbl_address(name, tel) VALUES('홍길동', '서울특별시');
INSERT INTO tbl_address(name, tel) VALUES('이몽룡', '익산시');
INSERT INTO tbl_address(name, tel) VALUES('성춘향', '남원시');
INSERT INTO tbl_address(name, tel) VALUES('장길산', '부산광역시');
INSERT INTO tbl_address(name, tel) VALUES('임꺽정', '함경남도');

COMMIT; -- 현재 Transaction(INSERT, UPDATE, DELETE)이 완료되었다는 것을 DBMS에 알리는 명령(DCL)

UPDATE tbl_address SET address = '서울특별시';   -- UPDATE 명령을 기본형으로 수행하면 모든 Record 데이터가 변경이 돼버림

ROLLBACK;   -- 데이터의 추가, 수정, 삭제를 취소하는 명령 DCL 명령, TCL(Transaction Controll Language)
            -- COMMIT이후 데이터의 추가, 수정, 삭제를 취소하는 명령

SELECT * FROM tbl_address;

UPDATE tbl_address SET address = '서울특별시' WHERE name='홍길동';
UPDATE tbl_address SET address = '남원시' WHERE name='성춘향';
UPDATE tbl_address SET address = '익산시' WHERE name='이몽룡';
COMMIT;
UPDATE tbl_address SET address = '' WHERE name='성춘향';

INSERT INTO tbl_address(name, tel) VALUES('홍길동', '서울특별시');

SELECT * FROM tbl_address;

CREATE TABLE tbl_address(

    id NUMBER PRIMARY KEY,          -- 실제 주소록에는 필요 없는 컬럼 추가하고 PK 선언
    name nVARCHAR2(20) NOT NULL,
    tel VARCHAR(20) NOT NULL,
    address nVARCHAR2(125),
    chain nVARCHAR2(10),
    rem nVARCHAR2(125),
    birth VARCHAR2(10),
    age NUMBER(3)

);

INSERT INTO tbl_address(id, name, tel) VALUES('1', '홍길동', '서울특별시');
INSERT INTO tbl_address(id, name, tel) VALUES('2', '홍길동', '서울특별시');
INSERT INTO tbl_address(id, name, tel) VALUES('3', '홍길동', '서울특별시');
INSERT INTO tbl_address(id, name, tel) VALUES('4', '이몽룡', '남원시');
INSERT INTO tbl_address(id, name, tel) VALUES('5', '성춘향', '익산시');

SELECT * FROM tbl_address;

UPDATE tbl_address SET address ='서울특별시' WHERE id =1;
UPDATE tbl_address SET address ='광주광역시' WHERE id =2;
UPDATE tbl_address SET address ='부산광역시' WHERE id =3;

COMMIT;

DELETE FROM tbl_address;        -- DELETE 명령도 UPDATE와 같이 기본형으로 실행 주의, PK 단위로 데이터 삭제

ROLLBACK;

SELECT * FROM tbl_address WHERE name = '홍길동';

DELETE FROM tbl_address WHERE id=1;

-- UPDATE나 DELETE 명령은 특별한 경우가 아니라면 2개 이상의 레코드에 대하여 동시에 적용되도록 명령 수행 자제

-- DBMS를 운영하는 과정에서 실수가 발생했을 때 데이터를 복구할 수 있는 해야 함
-- 백업: 업무가 종료되ㅏㄴ 후 데이터를 다른 저장소, 저장매체에 복사하여 보관
-- 복구: 백업해둔 데이터를 사용 중인 시스템에 다시 설치해 사용할 수 있도록 하는 것, 백업된 시점에 따라 완전 복구가 되지 않는 경우도 있음
-- 로그 기록: INSERT, UPDATE, DELETE의 모든 명령들을 별도의 파일로 기록(저널링 복구)
-- 이중화, 삼중화: 실제 운영 중인 운영체제, DBMS, Storage 등을 똑같은 구조로 만들고 설치 위치를 달리하여 동시에 운영하는 것, 재난이 발생하면 발생 지역 시스템 단절
-- 데이터 센터(데이터웨어 하우스): 대량의 데이터베이스를 운영하는 서버시스템을 모아서 통합 관리하는 곳