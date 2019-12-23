-- 여기는 GRADE화면

DESC tbl_score;


/*


이름        널?       유형            
--------- -------- ------------- 
S_ID      NOT NULL NUMBER        
S_STD     NOT NULL NVARCHAR2(50) 
S_SCORE   NOT NULL NUMBER(3)     
S_REMARK           NVARCHAR2(50) 
S_SUBJECT          VARCHAR2(4)   



DBMS의 UPDATE 권장 패턴에서는 여러 개의 레코들르 수정, 변경하는 것을 지양하도록 함
또한, 학생정보에 다른 정보를 포함하고 싶을 때는 tbl_score 테이블에 컬럼을 추가하는 등의 방식으로 처리를 해야 하는데 이 또한 좋은 방식이 아님

학생정보 테이블을 생성하고 학생 코드를 만들어준 다음 tbl_score의 s_std 컬럼 값을 학생코드로 변경하여 제2정규화 수행(s_std에 동명이인 없다고 가정)

*/

SELECT s_std FROM tbl_score GROUP BY s_std;


CREATE TABLE tbl_student(

st_num	VARCHAR2(5)		PRIMARY KEY,
st_name	nVARCHAR2(50)	NOT NULL,	
st_tel	VARCHAR2(20),		
st_addr	nVARCHAR2(125),		
st_grade	NUMBER(1)	NOT NULL,	
st_dept	VARCHAR2(5)	NOT NULL	

);


SELECT COUNT(*) FROM tbl_student;

ALTER TABLE tbl_score ADD s_stcode VARCHAR2(5);

SELECT COUNT(*) FROM tbl_score SC, tbl_student ST WHERE sc.s_std = st.st_name;

UPDATE tbl_score SC SET sc.s_stcode = (SELECT ST.st_num FROM tbl_student ST WHERE ST.st_name = SC.s_std);      -- tbl_score 테이블의 list를 나열하고 각 레코드의 s_std 컬럼의 값을 SUBQ로 전달하고
                                                                                                                -- tbl_student 테이블에 해당하는 이름이 있으면 st_num 컬럼의 값을 추출해 
                                                                                                                -- tbl_score 테이블의 s_stcode 컬럼에 저장
                                                                                                                
                                                                                                                
                                                                                                                
SELECT SC.s_stcode, ST.st_num, SC.s_std, ST.st_name FROM tbl_score SC, tbl_student ST WHERE SC.s_stcode = ST.st_num;   


ALTER TABLE tbl_score DROP COLUMN s_std;
ALTER TABLE tbl_score RENAME COLUMN s_stcode TO s_std;


SELECT SC.s_id, SC.s_std, ST.st_name, ST.st_grade, ST.st_dept, SC.s_score FROM tbl_score SC, tbl_Student ST WHERE SC.s_std = ST.st_num;


SELECT SC.s_id, SC.s_std, ST.st_name, ST.st_grade, ST.st_dept, SC.s_subject, SB.sb_name,  SC.s_score FROM tbl_score SC
LEFT JOIN tbl_student ST ON SC.s_std = ST.st_num LEFT JOIN tbl_subject SB ON SC.s_subject = SB.sb_code ORDER BY ST.st_name, SB.sb_name;












CREATE TABLE  tbl_dept(


d_num	VARCHAR2(5)		PRIMARY KEY,
d_name	nVARCHAR2(30)	NOT NULL,	
d_pro	nVARCHAR2(20),		
d_tel	VARCHAR2(20)		

);

SELECT * FROM tbl_dept;





SELECT SC.s_id, SC.s_std, ST.st_name, ST.st_grade, ST.st_dept, DP.d_name, DP.d_tel, SC.s_subject, SB.sb_name,  SC.s_score FROM tbl_score SC
LEFT JOIN tbl_student ST ON SC.s_std = ST.st_num LEFT JOIN tbl_subject SB ON SC.s_subject = SB.sb_code LEFT JOIN tbl_dept DP ON ST.st_dept = DP.d_num ORDER BY ST.st_name, SB.sb_name;



DROP VIEW view_score;
CREATE VIEW view_score AS(
SELECT SC.s_id, SC.s_std, ST.st_name, ST.st_grade, ST.st_dept, DP.d_name, DP.d_tel, SC.s_subject, SB.sb_name,  SC.s_score FROM tbl_score SC
LEFT JOIN tbl_student ST ON SC.s_std = ST.st_num LEFT JOIN tbl_subject SB ON SC.s_subject = SB.sb_code LEFT JOIN tbl_dept DP ON ST.st_dept = DP.d_num
);

SELECT * FROM view_score;
SELECT * FROM tbl_subject;

SELECT s_std, st_name, d_name, st_grade, SUM(DECODE(s_subject, 'S001', s_score)) AS 과학, SUM(DECODE(s_subject, 'S002', s_score)) AS 수학, SUM(DECODE(s_subject, 'S003', s_score)) AS 국어,
SUM(DECODE(s_subject, 'S004', s_score)) AS 국사, SUM(DECODE(s_subject, 'S005', s_score)) AS 미술, SUM(DECODE(s_subject, 'S006', s_score)) AS 영어, SUM(s_score) AS 총점,
ROUND(AVG(s_score),1) AS 평균, RANK() OVER (ORDER BY SUM(s_score) DESC) AS 석차 FROM VIEW_SCORE GROUP BY s_std, st_name, d_name, st_grade ORDER BY s_std;


/*

    DECODE(컬럼, 값, T결과, F결과)
    if(컬럼 == 깂)
        print(T결과)
    else
        print(F결과)
        
        
        
        
    DECODE(컬럼, 값, T결과)
    if(컬럼 == 값)
        print(T결과)
    else
        print(NULL)

*/

SELECT * FROM tbl_student;
SELECT * FROM tbl_subject;
SELECT * FROM tbl_score;


SELECT * FROM( SELECT s_std, st_name, d_name, st_grade, s_subject, s_score FROM view_score) PIVOT ( SUM(s_score) FOR s_subject IN ('S001' AS 과학,
'S002' AS 수학, 'S003' AS 국어, 'S004' AS 국사, 'S005' AS 미술, 'S006' AS 영어));


CREATE VIEW view_score_pv AS(
SELECT s_std, st_name, d_name, st_grade, SUM(DECODE(s_subject, 'S001', s_score)) AS 과학, SUM(DECODE(s_subject, 'S002', s_score)) AS 수학, SUM(DECODE(s_subject, 'S003', s_score)) AS 국어,
SUM(DECODE(s_subject, 'S004', s_score)) AS 국사, SUM(DECODE(s_subject, 'S005', s_score)) AS 미술, SUM(DECODE(s_subject, 'S006', s_score)) AS 영어, SUM(s_score) AS 총점,
ROUND(AVG(s_score),1) AS 평균, RANK() OVER (ORDER BY SUM(s_score) DESC) AS 석차 FROM VIEW_SCORE GROUP BY s_std, st_name, d_name, st_grade
);


SELECT * FROM view_score_pv;

SELECT * FROM tbl_score;

ALTER TABLE tbl_score ADD CONSTRAINT FK_SCORE_SUBJECT FOREIGN KEY(s_subject) REFERENCES tbl_subject(sb_code);

ALTER TABLE tbl_score ADD CONSTRAINT FK_SCORE_STUDENT FOREIGN KEY(s_std) REFERENCES tbl_student(st_num);

ALTER TABLE tbl_student ADD CONSTRAINT FK_STUDENT_DEPT FOREIGN KEY(st_dept) REFERENCES tbl_dept(d_num);