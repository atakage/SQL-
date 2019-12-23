-- GRADE 화면

-- DB이론상 정규화 과정

/*


1. 실무에ㅓㅅ 사용하던 엑셀 데이터
===========================
        학생이름        학년      학과      취미
===================================================
        홍길동           3        컴공과    낚시, 등산, 독서
        
        
        
2. 엑셀 데이터를 단순히 DBMS의 테이블로 구현
        -- 만약 취미가 4개인 학생은 4개 중 3개만 선택해야 하고, 취미가 3개 미만인 학생은 사용하지 않는 컬럼이 있어 낭비
=====================================================================
        학생이름        학년      학과      취미1     취미2     취미3
=====================================================================
        홍길동           3        컴공과    낚시     등산         독서        



3. 제1정규화가 수행된 TABLE 스키마
=====================================================================
        학생이름        학년      학과      취미
=====================================================================
        홍길동           3        컴공과    낚시
        홍길동           3        컴공과    등산
        홍길동           3        컴공과    독서


테이블의 고정값을 다른 테이블로 분리하고 테이블간 JOIN을 통해 VIEW 생성하도록 구조적 변경을 하는 작업(제2정규화)
tbl_student
=====================================================================
        학생이름        학년      학과      취미
=====================================================================
        홍길동           3        001          001
        홍길동           3        001          002
        홍길동           3        001          003
        성춘향           2        002          003
        
tbl_hobby
==================================================
CODE        취미
==================================================
001         낚시
002         등산
003         독서


tbl_dept
=================================================
CODE        학과명     담임교수
=================================================
001         컴공과
002         경제학과

*/



DESC tbl_score;


/*

성적일람표 테이블 구조     
--------- -------- ------------- 
S_ID      NOT NULL NUMBER        
S_STD     NOT NULL NVARCHAR2(50) 
S_SUBJECT NOT NULL NVARCHAR2(50) 
S_SCORE   NOT NULL NUMBER(3)     
S_REMARK           NVARCHAR2(50) 

*/

SELECT s_subject FROM tbl_score GROUP BY s_subject;




CREATE TABLE tbl_subject(

sb_code	VARCHAR2(4)		PRIMARY KEY,
sb_name	nVARCHAR2(20)	NOT NULL,	
sb_pro	nVARCHAR2(20)		

);

-- 아래 두 SQL문 결과 값이 같으면 정상 수행
SELECT COUNT(*) FROM tbl_score;
SELECT COUNT(*) FROM tbl_score SC, tbl_subject SB WHERE SC.s_subject = sb.sb_name;




ALTER TABLE tbl_score ADD s_sbcode VARCHAR2(4);     -- 임시 컬럼 추가(tbl_subject의 sb_code 컬럼과 구조가 같은 컬럼)


SELECT * FROM tbl_score;
UPDATE tbl_score SC SET s_sbcode = (SELECT sb_code FROM tbl_subject SB WHERE SC.s_subject = SB.sb_name);                -- tbl_subject 테이블에서 과목명을 조회하여 해당하는 과목코드를 tbl_score 테이블의
                                                                                                                        -- s_sbcode 컬럼에 UPDATE 수행



SELECT SC.s_sbcode, SB.sb_code, SC.s_subject,  SB.sb_name FROM tbl_score SC, tbl_subject SB WHERE SC.s_sbcode = SB.sb_code;

ALTER TABLE tbl_score DROP COLUMN s_subject;
ALTER TABLE tbl_score RENAME COLUMN s_sbcode TO s_subject;

SELECT * FROM tbl_score;                        -- 제2정규화 완료

SELECT s_std, s_subject, SB.sb_name, SB.sb_pro, s_score FROM tbl_score SC, tbl_subject SB WHERE SC.s_subject = SB.sb_code;


-- Table을 JOIN할 때 이름이 같은 컬럼이 존재하면 반드시 컬럼이 어떤 TABLE에 있는 커럶인지 명시해 주어야 함


/*

TABLE1 : num, name, dept
TABLE2 : num, subject, pro

SELECT * FROM TABLE1, TABLE2 WHERE dept = num    -- 라는 형식은 num의 누구의 table인지 알 수 없어 문법 오류 발생

*/

SELECT s_id, s_std, s_subject, s_score, s_remark FROM tbl_score;

SELECT * FROM tbl_score WHERE s_id > 600;

DELETE FROM tbl_score WHERE s_id > 600;

COMMIT;