-- 사용자4 화면

SELECT * FROM tbl_books;

/*

PRIMARY KEY(DBMS에서 객체 무결성 보장 위한)

객체 무결성: 어떤 데이터를 조회했을 때 나타나는 데이터는 내가 필요로 했던 데이터라는 보장

PK를 WHERE 조건으로 SELECT 했을 때 나타나는 데이터는 1개의 레코드이며 이 데이터는 내가 원하는 데이터라는 보장

PK는 1개의 컬럼을 지정하는 것이 원칙이지만 실제 상황에서 1개의 컬럼만으로 PK를 지정하지 못하는 경우 있음 이럴 때는 2개 이상의 컬럼을 묶어
PK로 지정하기도 함

복수의 컬럼을 PK로 지정하는 경우 UPDATE, DELETE를 수행할 때 PK를 WHERE조건으로 명령 수행할 때 상당히 번잡한 SQL을 구성해야 하는 경우도 있음

가급적 1개의 ㄱ컬럼을 PK로 지정하는 것이 좋고 PK로 지정할 컬럼을 선택할 수 없을 때는 
실제 존재하는 데이터가 아닌 새로운 컬럼(PK용)을 하나 추가해 그 컬럼을 PK로 설정하는 방법도 있음

컬럼은 실제 데이터와 관계없이 '일련번호', 'SN' 형식으로 지정하는 경우도 많음

보편적인 DBMS는 ID 컬럼을 최대 자릿수를 갖는 숫자형으로 지정하고 해당 컬럼에 AUTO INCREMENT라는 옵션을 지정해 INSERT를 수행할 때마다 자동으로 새로운 숫잣값이 생성되도록 할 수 있음

그러나 오라클 11이하에서는 AUTO INCREMENT 불가
대신 SEQUENCE Object를 생성하고 SEQUENCE의 NEXTVAL 값을 활용하여 데이터를 추가할 대 ID컬럼에 새로운 값이 만들어져 저장되도록 사용함

오라클의 SEQ는 한번 생성하면 그 상태를 영구히 보관하고 있다가 언제든 NEXTVAL을 호출하여 현재상태 + (INCREMENT BY로 지정한 값만큼) 연산을 수행해 새로운 값을 만들어 냄





*/

INSERT INTO tbl_books(b_code, b_name) VALUES(SYS_GUID(), 'GUID 연습');  -- 오라클에서 RANDOM, SEQ외에 사용할 수 있는 PK값 생성

SELECT SYS_GUID() FROM dual;
-- GUID(Global Unique Identified) 
-- 오라클에서는 GUID를 저장할 컬럼의 데이터 형식을 RAW(크기 제한X 바이너리 형태)값으로 지정하거나 nVARCHAR(125)이상으로 저장해 사용



/*

index: 자주 SELECT를 수행하는 컬럼이 있을 경우 해당 컬럼을 index라는 Object로 생성을 해 두면 SELECT를 수행할 때 index를 먼저 조회하고 index로부터
            해당 데이터가 저장된 Record에 주소를 얻고 주소를 통해서 table로 데이터를 가져와서 SELECT 수행 속도, 효율을 높이는 기법


TABLE을 생성할 때 PK를 지정하면 PK컬럼은 기본적으로 INDEX로 설정됨
*/

CREATE INDEX IDX_NAME ON tbl_books(b_name);
SELECT * FROM tbl_books WHERE b_name = '오라클';

CREATE INDEX IDX_NAME_WRITER ON tbl_books(b_name, b_writer); -- 2개 컬럼을 기준으로 INDEX 생성

DROP INDEX IDX_NAME_WRITER;

/*
    INDEX는 SELECT를 수행하는데 매우 효율적으로 작동되는 구조
    하지만 개발초기에 많은 양의 데이터를 INSERT 수행해야 할 경우 INDEX를 일단 설정하지 않고 사용하는 것이 효율적
    
    초기 데이터를 추가할 때 가급적 PK로 설정된 컬럼을 기준으로 정렬된 원본데이터로 INSERT를 수행하는 것이 효율적
    
    INDEX를 필요 이상으로 설정하면 INSERT UPDATE DELETEㅡㄹ 수행할 때 매우 비효율적으로 작동될 수 있고
    INDEX OBJECT가 문제를 일으키는 상황도 생김
    
    INDEX는 최소한으로
*/

DROP INDEX IDX_NAME;

CREATE UNIQUE INDEX IDX_NAME ON tbl_books(b_name);          -- UNIQUE INDEX는 마치 table을 생성할 때 해당하는 컬럼에 UNIQUE 제약조건을 설정한 것처럼 작동
                                                            -- 기존에 저장되어 있는 데이터가 UNIQUE 상태가 아니면 인덱스 생성되지 않음
                                                            
-- INDEX 손상 의심 시  DROP 후 CREATE
-- 상용 DBMS에서는 INDEX가 손상되면 DBMS 자체적으로 Rebuild하는 기능이 포함돼 있음