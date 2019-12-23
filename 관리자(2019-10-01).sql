-- 관리자 화면
-- 관리자 계정으로 접속된 상태에서 TableSpace, User 등을 생성 (DDL(Data Definition Language))

CREATE TABLESPACE user2_DB          -- 다른 DBMS에서는 TABLESPACE 키워드 대신 DATABASE라는 키워드를 사용
DATAFILE 'C:/bizwork/oracle/data/user2.dbf'         -- 디렉터리 구분문자는 '\'나 '/'를 사용 가능(윈도우는 '\' 보편적으로 운영체제는 '/')
                                                        -- 맨 앞에 '/'만 사용하면 윈도우에서는 'C:/'와 같은 의미
                                                        
SIZE 10M AUTOEXTEND ON NEXT 10K     -- user2_DB라는 이름으로 tableSpace를 생성하고  /bizwork/oracle/data/ 폴더에 user2.dbf라는 파일을 생성
                                    -- 초기 크기는 10MByte로 하고 용량이 부족하면 10KByte씩 자동 확장
                                    
CREATE USER user2 IDENTIFIED BY 1234    -- 생성한 user2_DB 테이블 스페이스의 데이터를 관리할 사용자 계정을 생성, 비밀번호 1234
DEFAULT TABLESPACE user2_DB;        -- user2가 table을 생성하고 데이터를 저장할 때 user2_DB tablespace를 사용하도록 지정
                                -- 만약 DEFAULT TABLESPACE를 설정하지 않으면 user2 사용자가 table을 생성하고 데이터를 저장할 때 그 데이터들은
                                -- 오라클DBMS의 SYSTEM 영역에 저장을 함, 작은 규모에서는 문제가 없으나 실무에서는 위험
                                
                                
-- 오라클에서는 새로운 사용자 계정을 등록했을 때 아무런 활동을 할 수 없는 상태로 DCL 명령을 통해 사용자에게 권한을 부여해야 함
-- 11gXE 환경에서느느 외부접속으로 인한 보안 문제가 크지 않으므로 DBA권한을 사용자에게 부여(실습 편의성)

GRANT DBA TO user2;         -- DBA: SYSTEM 관련 정보를 조회할 수 있는 권한, DCL명령으로 자신의 영역에 TABLE 등 DB Object 들을 생성, 삭제 변경 가능
                            --  DML 명령을 활용하여 데이터 관리를 할 수 있는 권한, 일부 DCL 명령 가능
                            
                            