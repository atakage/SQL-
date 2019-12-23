SELECT * FROM tab;
DESC dept;
SELECT empno, ename, 2 FROM emp;
SELECT ename, 'SALESMAN' from emp;
SELECT DISTINCT deptno FROM emp;

SELECT job, ename FROM emp ORDER BY 1, 2;
SELECT ename || job FROM emp;