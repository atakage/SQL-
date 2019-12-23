-- FK, 참조무결성
-- 참조무결성: 2개 이상의 테이블을 EQ JOIN 실행했을 때 연관 정보가 원하는 모든 데이터가 보여진다라는 조건
-- FK 설정되는 TABLE은 1:N의 관계
-- 테이블을 FK지정하여 참조무결 관계를 설정하려 할 때 MySQL의 경우 ENGINE옵션을 추가해 주는 것이 좋음 , CREATE TABLE ()ENGINE = InnoDB character set = 'UTF-8';

-- FK 설정하기 위해서는 컬럼들의 Type, 크기 같게 생성되어야 함
-- 1:N의 관계일 때 1에 해당하는 table의 컬럼은 반드시 PK로 선언해야 함, N에 해당하는 컬럼은 가급적 NOT NULL
USE myDB;

DESC tbl_score2;
-- s_id	int(11)	NO	PRI		auto_increment
-- s_std	varchar(5)	NO			
-- s_subject	varchar(5)	NO	MUL		
-- s_score	int(3)	NO			
-- s_remark	varchar(50)	YES			

DESC tbl_subject;
-- sb_code	varchar(5)	NO	PRI
-- sb_name	varchar(20)	NO	
-- sb_pro	varchar(20)	YES	

ALTER TABLE tbl_score2 DROP FOREIGN KEY FK_SCORE_SUBJECT;

ALTER TABLE tbl_score2 ADD CONSTRAINT FK_01 FOREIGN KEY (s_subject) REFERENCES tbl_subject(sb_code);

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE table_name = 'tbl_score2';

-- tbl_score2와 tbl_subject를 FK로 설정
SELECT * FROM tbl_score2;
SELECT * FROM tbl_subject;
INSERT INTO tbl_score2(s_std, s_subject, s_score) VALUES('S0001','B0100', 100);		-- 아직 tbl_subject 테이블에 B0100 코드데이터가 없는 상태에서 tbl__score2를 입력하면서 B0100과목의 점수를 등록하려고 하니
																				-- FK 조건에 위배돼어 데이터 추가X
                                                                                
INSERT INTO tbl_subject(sb_code, sb_name) VALUES('B0100' , '화학');               

UPDATE tbl_subject SET sb_code = 'B0005' WHERE sb_code = 'B0100';                                                                 


-- 			****************************************************************************************
-- 						tbl_score(s_subject)						tbl_subject(sb_code)
--							있다(B0005)					>>				반드시 있다
--							있을 수도 있다							<<				있다(B0100)
--							절대 없다							<<				없다
--							있어도						>>				코드수정, 삭제 불가
--		코드 수정, 삭제 자유로움								<<				있으면

-- *******************************************************************************************************


-- 만약 subject 테이블에 데이터를 추가하면서 sb_code값을 잘못 지정했을 경우, subject 테이블에만 데이터가 저장되었다면 자유롭게 UPDATE, DELETE가 수행됨
-- 그러나 score 테이블에도 잘못된 sb_code값에 기반한 데이터가 입력되어있다면 subject 테이블의 sb_code 변경 불가 

INSERT INTO tbl_score2(s_std, s_subject, s_score) VALUES('S0001','B2000', 100);	

SELECT * FROM tbl_subject;
SELECT * FROM tbl_score2;
ALTER TABLE tbl_score2 DROP FOREIGN KEY FK_01;
ALTER TABLE tbl_score2 ADD CONSTRAINT FK_01 FOREIGN KEY (s_subject) REFERENCES tbl_subject(sb_code) ON UPDATE CASCADE;	-- subject 컬럼의 코드를 UPDATE하면 연관된 모든 table의 값을 같이 자동으로 UPDATE

UPDATE tbl_subject SET sb_code = 'B3000' WHERE sb_code = 'B2000';


ALTER TABLE tbl_score2 ADD CONSTRAINT FK_01 FOREIGN KEY (s_subject) REFERENCES tbl_subject(sb_code) ON UPDATE CASCADE ON DELETE CASCADE;	-- subject 컬럼의 코드를 UPDATE, DELETE하면 연관된 모든 table의 값을 같이 자동으로 UPDATE, DELETE

-- FK 설정에서 ON UPDATE CASCADE와 ON DELETE CASCADE는 DB 설계 당시 어떻게 정책을 수립하느냐에 따라 결정해서 사용하면 됨

