-- 여기는 USER1 사용자 화면


SELECT 30 + 40 FROM dual;
SELECT * FROM DBA_ROLE_PRIVS;   -- 현재 부여된 권한이 무엇인지 알려달라, USER1에게는 CREATE SESSION권한만을 부여했기 때문에 여러 명령들 사용 불가
SELECT * FROM DBA_TAB_PRIVS;            --이후에 사용할 수 있는 명령어들을 일일이 부여해 주어야 함
SELECT * FROM USER_TAB_PRIVS;
SELECT * FROM USER_ROLE_PRIVS;


