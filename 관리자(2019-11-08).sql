-- ������ ȭ��
-- tablespace : userS_db, datafile : user5.dbf
-- size 10M , autoex next 1k
-- id : user5, password : user5
-- tablespace �� ������ �ʰ� ����ڸ� �����ϰ� �����͸� �����ϸ�
-- system�� tablespace�� �����Ͱ� ����Ǿ
-- ���ȵ��� ������ ����ų�� �ִ�
-- ����Ŭ������ ����ڸ� �����ϱ����� �׻� tablespace�� ���� ����϶��
-- ������ �Ѵ�
CREATE TABLESPACE user5_db
DATAFILE '/bizwork/oracle/data/user.dbf'
SIZE 10M AUTOEXTEND ON NEXT 1K;

-- ����ڸ� �����ϰ� �⺻ tablespace�� user5�� �����϶�
/*
����Ŭ DBMS������ user�� ����
Ÿ DBMS(mysql,mssql)����� �⺻���� Schema�� DATABASE��� �̸����� 
�����Ͽ� ������ �Ѵ�
����Ŭ������ �⺻ Schema�� USER�� ������ ������ �ִ�
USER = DataBase �⺻ Schema�� �������� ������ �ؾ� �Ѵ�
USER��
DBMS Object���� �����ϴ� ��ü
TABLE, VIEW, SEQUENCE, INDEX....
���� USER�� �����Ͽ� USER4�� ������ �ִ� � TABLE�� SELECT �ϰ� �ʹ�
SELECT * FROM USER4.TBL_TABLE
��, USER4�� ������ �ſ� ���ų�(DBA), USER5.TBL_TABLE�� SELECT ������ �־�� �Ѵ�
*/
CREATE USER user5 IDENTIFIED BY user5
DEFAULT TABLESPACE user5_db;

-- ������ ����ڿ��� ������ �ο�
GRANT DBA TO user5;