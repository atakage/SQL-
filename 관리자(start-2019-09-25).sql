-- 주석(remark)문은 '--'로 시작
-- 모든 명령문이 끝나는 곳에 ;
-- 오라클의 모든 keyword는 대소문자 관계 없음

select 30 + 40 from dual;
SELECT 30 * 40 FROM dual;



SELECT 30+40, 30*40, 40*2, 50-10 from dual; -- 조회할 떄(SELECT 할 때) 콤마(,)로 구분을 하면 TABLE로 보여줄 때 Column으로 보여준다

SELECT '대한민국' FROM dual;    -- 문자열은 작은따옴표
SELECT '대한' || '민국' FROM dual;  --문자열을 연결하여 보여줄 때는 ||로 문자열을 이어서 사용
SELECT '대한', '민국', '만세', 'KOREA' from dual;



SELECT * FROM dual;
SELECT * FROM v$database;