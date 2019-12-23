-- USER3 화면


DESC tbl_student;



CREATE TABLE tbl_test_std AS SELECT * FROM tbl_student;                 -- 테이블 복제

SELECT * FROM tbl_test_std;


/*


이름       널?       유형             
-------- -------- -------------- 
ST_NUM   NOT NULL VARCHAR2(3)               PRIMARY KEY(NOT NULL + UNIQUE)
ST_NAME  NOT NULL NVARCHAR2(50)  
ST_TEL            VARCHAR2(20)   
ST_ADDR           NVARCHAR2(125) 
ST_GRADE          NUMBER(1)      
ST_DEPT           VARCHAR2(3)    


*/

DESC tbl_test_std;


/*


이름       널?       유형                                테스트를 위해 tbl_student를 복제하였는데
-------- -------- --------------                            PK 등 중요한 제약조건 들이 복제되지 않음
ST_NUM            VARCHAR2(3)                                
ST_NAME  NOT NULL NVARCHAR2(50)  
ST_TEL            VARCHAR2(20)   
ST_ADDR           NVARCHAR2(125) 
ST_GRADE          NUMBER(1)      
ST_DEPT           VARCHAR2(3)    




*/


ALTER TABLE tbl_test_std ADD (st_num nVARchar2(50) NOT NULL);
ALTER TABLE tbl_test_std ADD UNIQUE(st_num);                -- 중복값 허용X


-- PK로 설정된 컬럼은 내부적으로 INDEX라는 OBJECT가 생성됨


ALTER TABLE tbl_test_std ADD CONSTRAINT key_st_num PRIMARY KEY(st_num);         -- TABLE CREATE할 때는 단순히 PRIMARY KEY만 지정해주면 PK 컬럼을 설정할 수 있었는데
                                                                                    -- ALTER TABLE을 사용해서 PK를 추가할 때는 가급적 이름을 지정해 주는 것이 좋음(DBMS에 따라 이름 지정 안 할 시 실행 안되는 경우 있음)

-- 경우에 따라 PK를 다중 컬럼으로 설정하는 경우도 있음
-- ALTER TABLE tbl_test_std ADD CONSTRAINT KEY_ST_NAME_TEL PRIMARY(st_name, st_tel)

DESC tbl_test_std;



ALTER TABLE tbl_test_std ADD CONSTRAINT st_grade_check CHECK(st_grade BETWEEN 1 AND 4);             -- CHECK 제약조건, 데이터를 추가할 때 어떤 컬럼에 저장되는 데이터를 제한하고자 할 때 
                                                                                                -- st_grade 컬럼에 1부터 4까지의 숫자만 저장

-- ALTER TABLE tbl_test_std ADD CONSTRAINT st_gender_check CHECK(st_gender IN ('남', '여');      --  st_gender 컬럼에는 문자열 '남','여'만 입력할 수 있음                                                                                                
                                                                                                
-- CONSTRAINT 이름을 지정하지 않으면 나중에 조건이 필요 없어 삭제를 하고자 할 때 삭제가 힘들어질 수도 있음                                                                                                


ALTER TABLE tbl_test_std DROP UNIQUE(st_num);               -- UNIQUE 제약조건을 삭제

ALTER TABLE tbl_test_std DROP CONSTRAINT st_grade_check CASCADE;                -- st_grade_check 이름으로 등록된 제약조건 삭제, 
                                                                                --CASCADE: 연관된 모든 조건을 같이 삭제
                                                                                
                                                                                
ALTER TABLE tbl_score2 ADD CONSTRAINT fk_std_score2 FOREIGN KEY (s_num) REFERENCES tbl_test_std(st_num);           -- 참조 무결성 설정, tbl_score2에 데이터를 추가하거나 학번을 변경할 때
                                                                                                                -- tbl_test_std 테이블을 참조하여 학번(s_num, st_num)과의 관계를 명확히 하여
                                                                                                                -- EQ JOIN을 실행했을 때 결과가 신뢰성을 보장하는 제약조건 설정
                                                                                                                
                                                                                                                
/*
                    tbl_score                       tbl_test_std
================================================================================
             s.num                                   st_num
             있다                 >>                  반드시 있다
             있을 수도 있다       <<                   있다
            절대 없다              <<                없다



*/
                                                                                                                
                                                                                                                