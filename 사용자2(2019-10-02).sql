-- 여기는 USER2 화면

SELECT * FROM tbl_address;

INSERT INTO tbl_address(id, name, tel, address) VALUES('1', '홍길동', '서울특별시', '서울특별시');


UPDATE tbl_address SET age = 33 WHERE id = 5;
UPDATE tbl_address SET age = 0 WHERE id = 4;

SELECT * FROM tbl_address WHERE age IS NULL;

SELECT * FROM tbl_address WHERE age IS NOT NULL;    -- 데이터를 다량으로 추가한 후 혹시 중요한 데이터를 누락시키지 않았나 판별하고자 할 때 사용

UPDATE tbl_address SET chain = '' WHERE id = 3;     -- 오라클에서는 ''(아무런 문자열이 없는 형태)는 NULL과 같은 의미로 봄

UPDATE tbl_address SET chain = ' ' WHERE id = 3;    -- 중간에 공백이 있는 문자열을 컬럼에 저장하면 NULL 기호가 사라지고 빈칸으로 보임(WHITE SPACE)

SELECT * FROM tbl_address;

SELECT * FROM tbl_address WHERE address  IS NULL;
SELECT * FROM tbl_address WHERE address IS NOT NULL;

UPDATE tbl_address SET chain = '001' WHERE id = 1;
UPDATE tbl_address SET chain = '001' WHERE id = 2;
UPDATE tbl_address SET chain = '002' WHERE id = 3;
UPDATE tbl_address SET chain = '003' WHERE id = 4;
UPDATE tbl_address SET chain = '003' WHERE id = 5;


SELECT id, name, address,chain, DECODE(chain, '001', '가족', DECODE(chain, '002', '친구', DECODE(chain, '003', '이웃'))) AS 관계 FROM tbl_address;    -- chain 칼럼이 001이면 가족이라 보이고 아닐 경우 002인지 검사하고
                                                                                                            -- 002이면 친구라고 보여라
                                                                                            

INSERT INTO tbl_address (id, name, tel, chain) VALUES(6, '장보고', '010-777-7777', '101');         -- 테스트를 위해  SQL문을 수행하면서 chain 컬럼에 고의로 값을 잘못 저장

                                                                                            
SELECT id, name, address,chain, DECODE(chain, '001', '가족', DECODE(chain, '002', '친구', DECODE(chain, '003', '이웃'))) AS 관계 FROM tbl_address
 WHERE DECODE(chain, '001', '가족', DECODE(chain, '002', '친구', DECODE(chain, '003', '이웃'))) IS NULL;      -- chain 컬럼에 데이터는 NULL이 아니지만 조건 검색문을 실행하는 과정에서 chain에 원하지 않는 값이
                                                                                                        -- 저장되어 있음을 확인, 이렇게 SELECT를 데이터 검증하는 도구로 활용하기도 함
 
-- 리스트 = 레코드 = row

INSERT INTO tbl_address(id, name, tel) VALUES('10', '조덕배', '010-222-2222');
INSERT INTO tbl_address(id, name, tel) VALUES('9', '조용필', '010-333-2222');
INSERT INTO tbl_address(id, name, tel) VALUES('8', '양희은', '010-123-1234');

SELECT * FROM tbl_address;

SELECT * FROM tbl_address ORDER BY id;
SELECT * FROM tbl_address ORDER BY name, address;       -- 일단 name 칼럼으로 오름차순 정렬하고 만약 name 컬럼의 값이 같은 리스트가 2개 이상 있으면 address 컬럼으로 오름차순 정렬
                                                        -- 아무런 키워드가 없으면 ASCENDING 이 생략된 것
                                                        
                                                    
COMMIT; -- 데이터를 추가하고 수정한 사항을 storage에 저장(물리적 저장)하기 위함                                                