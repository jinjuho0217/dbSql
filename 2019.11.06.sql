--그룹함수
-- multi row function : 여러개의 행을 입력으로 하나의 결과 행을 생성
-- SUM, MAX, MIN, AVG, COUNT
-- GROUP BY col | express
-- SELECT 절에는 GROUP BY 절에 기술된 COL, EXPRESS표기가능

-- 직원 중 가장 높은 급여 조회
-- 14개의 행이 입력으로 들어가 하나의 결과가 도출
SELECT MAX(SAL) max_sal
FROM emp;

-- 부서별로 가장 높은 급여 조회
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;

--♠실습 FUNCTION NULL실습 fn2)
select *
from dept;

SELECT 
            DECODE(deptno, 30, 'SALES', 20, 'RESEARCH', 10,'ACCOUNTING') dname,
            max(sal) max_sal, 
            min(sal) min_sal, 
           round( avg(sal),2) avg_sal, 
            sum(sal) sum_sal, 
            count(sal), 
            count(mgr) mgr_sal, 
            count(*) count_all
FROM emp
GROUP BY deptno
ORDER BY max_sal DESC;
-------------------------------------------실행결과
ACCOUNTING	5000	    1300	    2916.67	    8750	    3  	2	3
RESEARCH	    3000	    800	    2175	        10875	5	5	5
SALES	        2850	    950	    1566.67	    9400	    6	6	6
---------------------------------------------

--♠실습 FUNCTION NULL실습 fn3)
SELECT TO_CHAR (hiredate,'YYYY/MM'), 
            count(hiredate) cnt
FROM emp
group by TO_CHAR (hiredate,'YYYY/MM');
----------실행결과
1981/02	    2
1983/01	    1
1980/12	    1
1981/04	    1
1981/05	    1
1981/09	    2
1982/12	    1
1982/01	    1
1981/12	    2
1981/06	    1
1981/11	    1
----------


--♠실습 FUNCTION NULL실습 fn4)
SELECT TO_CHAR (hiredate,'YYYY') hdate, 
            count(hiredate) cnt
FROM emp
group by TO_CHAR (hiredate,'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');
---------실행결과
1980	    1
1981	    10
1982	    2
1983	    1
----------

--♠실습 FUNCTION NULL실습 fn5)
select count(deptno) cnt
from dept;

SELECT  distinct deptno
FROM   emp;
이름       널?       유형           
-------- -------- ------------ 실행결과
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    

--JOIN
--emp 테이블에는 dname 컬럼이 없다. --> 부서번호(deptno)밖에 없음
desc emp;

ALTER TABLE    emp  ADD(dname VARCHAR2(14)); --> emp 테이블에 dname컬럼 추가
이름       널?       유형           
-------- -------- ------------ 실행결과
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    
DNAME             VARCHAR2(14) 
--------------------------
select *
from emp;

UPDATE emp SET dname ='ACCOUNTING' WHERE deptno =10;
UPDATE emp SET dname ='RESEARCH' WHERE deptno =20;
UPDATE emp SET dname ='SALES' WHERE deptno =30;
----------------------------------------------실행결과
7369	SMITH	    CLERK	    7902	80/12/17	800		        20  	RESEARCH
7499	ALLEN	SALESMAN	7698	81/02/20	1600	    300	30  	SALES
7521	WARD	    SALESMAN	7698	81/02/22	1250	    500	30  	SALES
7566	JONES	MANAGER	7839	81/04/02	2975		        20  	RESEARCH
7654	MARTIN	SALESMAN	7698	81/09/28	1250	   1400	30  	SALES
7698	BLAKE	MANAGER	7839	81/05/01	2850		        30  	SALES
7782	CLARK	MANAGER	7839	81/06/09	2450		        10  	ACCOUNTING
7788	SCOTT	ANALYST	    7566	82/12/09	3000		        20  	RESEARCH
7839	KING	    PRESIDENT		    81/11/17	5000		        10  	ACCOUNTING
7844	TURNER	SALESMAN	7698	81/09/08	1500		        30  	SALES
7876	ADAMS	CLERK	    7788	83/01/12	1100		        20  	RESEARCH
7900	JAMES	CLERK	    7698	81/12/03	950		        30  	SALES
7902	FORD	    ANALYST	    7566	81/12/03	3000		        20  	RESEARCH
7934	MILLER	CLERK	    7782	82/01/23	1300		        10  	ACCOUNTING
---------------------------------------------------

COMMIT;

SELECT dname, max(sal) max_sal
FROM emp
GROUP BY dname;

ALTER TABLE   emp   DROP COLUMN DNAME; -- 해당 컬럼을 삭제한다.

SELECT *
FROM EMP;

--ansi natural join : 조인하는 테이블의 컬럼명이 같은 컬럼을 기준으로 JOIN

SELECT DEPTNO, ENAME, DNAME
FROM EMP NATURAL JOIN DEPT;

--ORACLE JOIN
SELECT e.empno, e.deptno, d.dname, d.loc --원하는 컬럼을 가지고 올 수 있다.
FROM emp e, dept d -- 뒤에 별칭을 주면 별칭으로 불러올 수도 있다.
WHERE e.deptno = d.deptno;

SELECT emp.empno, emp.deptno, dept.dname, dept.loc 
FROM emp, dept 
WHERE emp.deptno = dept.deptno;



SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept  USING( deptno); --> ansi 문법

--form절에 조인 대상 테이블 나열
-- where절에 조인조건 기술
-- 기존에 사용하던 조건 제약도 기술가능
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--job이 salesman인 사람만 대상으로 조회  : ansi, orcle사용법 둘 다 알아야 된다.
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE EMP.deptno = dept.deptno and emp.job = 'SALESMAN';--> orcle 문법


SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.job = 'SALESMAN' and  EMP.deptno = dept.deptno; -- 순서가 없어서 뭘 뭔저 쓰는지 상관없음

--JOIN with ON (개발자가 조인 컬럼을 ON절에 직접 기술)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--self join : 같은 테이블끼리 조인하는 거
--emp테이블의 mgr 정보를 참고하기 위해서 emp 테이블과 조인을 해야한다.
-- A : 직원 정보 , B : 관리자
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno)
WHERE a.empno between 7369 and 7698;

--SELECT emp.empno, emp.ename, dept.dname
--FROM emp, dept
--WHERE EMP.deptno = dept.deptno and emp.job = 'SALESMAN';
--orcle
SELECT a.empno, a.ename, a.mgr , b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno
    AND a.empno between 7369 and 7698;
---------------------------실행결과
7654	MARTIN	7698	7698	BLAKE
7521	WARD    	7698	7698	BLAKE
7499	ALLEN	7698	7698	BLAKE
7698	BLAKE	7839	7839	KING
7566	JONES	    7839	7839	KING
7369	SMITH	    7902	7902	FORD
------------------------------

--non-equijoing(등식 조인이 아닌 경우)
SELECT *
FROM salgrade;

--직원의 급여 등급은(같은 컬럼이 없음)?

SELECT *
FROM emp;

SELECT emp.empno,  emp.ename,  emp.sal,  salgrade.*
FROM emp, salgrade 
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

SELECT emp.empno,  emp.ename,  emp.sal,  salgrade.*
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT emp.ename, emp.empno, dept.deptno, dept.dname -- oracle : ansi에서 join에 들어간게 where절로 빠짐
FROM emp,dept
WHERE emp.deptno = dept.deptno;

SELECT emp.ename, emp.empno, dept.deptno, dept.dname -- ansi : from절에 join이 들어감
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.empno = 7369; -- join조건을 기술하지 않아 가능한 모든 경우의 수가 나와서 14개가 나온다.

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE b.empno = 7369; -- join조건을 기술하지 않아 가능한 모든 경우의 수가 나와서 14개가 나온다.

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.empno = 7369 and b.empno = 7369; -- join조건을 기술하지 않아 가능한 모든 경우의 수가 나와서 14개가 나온다.

--♠실습 FUNCTION NULL실습 fn6)
SELECT*
FROM emp;
SELECT*
FROM dept;

SELECT empno, ename, deptno, dname 
FROM emp join dept using(deptno); -- join, using ansi에서 사용하는 거고 using 서로 비교해서 같은 컬럼이 있을 때 출력

select *
from salgrade;


select empno, ename, deptno, loc
from emp natural join dept;-- 모든 컬럼을 출력함

