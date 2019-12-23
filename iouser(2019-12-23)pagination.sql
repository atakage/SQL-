-- iouser
-- pagination을 위한 오ㅓ라클 SQL


/*


pagination

전체레코드를 모두 읽어서 화면에 보여주는 것은 실제 상황에서 매우 비효율적
메모리 문제가 될 수도 있고 성능면에서도 상당히 여러 문제를 일으킴

적당한 크기(1page 분량의 리스트를 읽어들이고 처리를 한 후 더 많은 내용을 보고 싶으면 더 보기, 다른 페이지르 선택해서 읽어 들이도록 SQL 수행)


MySQL: limit라는 속성으로 매우 편리하게 pagination을 구현할 수 있음
mssql: offset과 limit라는 속성
기타 DBMS: limit, offset과 같은 개념들이 있어서 편하게 구현이 가능함


오라클은 limit, offset 등을 실제적으로 지원하지 않음
오라클은 개발자, DBA가 limit등을 수행하지 않아도 엔진 자체에서 optimizer 기능이 있어 어느 정도는 자체 커버가 됨

실제 SELECT * FROM TABLE을 수행하더라도 보통 200개 단위로 구분하여 fetch(읽어들이기)를 수행하는 기능이 담겨있음


SELECT * FROM [TABLE] ORDER BY를 사용할 경우 자체 엔진이 상당히 무리하게 작동함
하지만 오라클에서는 order by와 where절을 강이 사용하지만 않으면 자체 opt엔진이 나름의 방법대로 정렬을 수행

오라클 pagination에서는 정렬 따로 where 따로 만들어 사용을 함(sub query)

*/

SELECT * FROM tbl_product;                      -- p_code 칼럼은 PK로 선언 , PK로 선언된 항목은 내부에 index가 자동으로 생성된 상태
                                                    -- PK를 상대로 ORDER BY를 수행하면 다른 컬럼에 비해 성능이 나은 편

SELECT * FROM tbl_product ORDER BY p_code DESC;         -- 표준 SQL을 사용한 내림차순 정렬

SELECT /*+ INDEX_DESC(P) FIRST_ROWS */ * FROM tbl_product P;       -- 오라클의 Hint라는 기능을 사용하여 PK를 기준으로 내림차순 정렬한 SQL

/*
    IDEX_DESC([table] [index이름])  -- [index이름]으로 설정된 인덱스를 사용하여 내림차순 정렬한 후 보여달라
    
    FIRST_ROWS  -- 데이터가 많을 때 순서가 앞에 있는 레코드를 먼저 찾는 옵티마이저 알고리즘을 작동시켜라
    
    
    
    
*/


SELECT /*+ FISRT_ROWS */ROWNUM, IP.* FROM(                                              -- from에 테이블 대신 다른 SEELECT 쿼리를 사용한 SQL 작성, from 절에 사용한 SELECT를 inline view라고 함
SELECT /*+ INDEX_DESC(P) */ * FROM tbl_product P       
) IP WHERE ROWNUM <= 100;

SELECT * FROM
(
SELECT /*+ FISRT_ROWS */ROWNUM AS NUM, IP.* FROM(                                              -- from에 테이블 대신 다른 SEELECT 쿼리를 사용한 SQL 작성, from 절에 사용한 SELECT를 inline view라고 함
    SELECT /*+ INDEX_DESC(P) */ * FROM tbl_product P       
) IP WHERE ROWNUM <= 50
)TBL WHERE NUM >= 41;
/*

    FIRST_ROWS
    where절에서 ROWNUM의 가상 컬럼 값을 N이하로 설정하면 처음부터 N까지 데이터를 가져오는데 최소 비용을 투입하는 알고리즘을 작동하여라는 의미
    9i이하에서는 cost base로 옵티마이저 실행
    10 이상에서는 index base로 옵티마져 실행해서 table에 index가 없거나 레코드의 개수가 현저히 적으면 오히려 옵티마이저를 하지 않은 것보다 늦게 나오는 경우가 있음
    
    FIRST_ROWS(정수) 옵티마이저를 제한
    11이상에서는 FIRST_ROWS_10, FIRST_ROWS_100, FIRST_ROWS_1000 형식으로 작성해야 좀 더 효율적으로 작동이 됨
    

    -- &변수를 사용하면 커리 실행에서 입력창이 나타나 값을 입력할 수 있음

*/



SELECT /*+ FISRT_ROWS */ROWNUM, IP.* FROM(                                              -- FIRST_ROWS는 
SELECT /*+ INDEX_DESC(P) */ * FROM tbl_product P       
) IP WHERE ROWNUM BETWEEN 91 AND 100;
