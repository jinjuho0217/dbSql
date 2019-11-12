--smith, ward
SELECT *
FROM emp
WHERE deptno  in(10, 20);

SELECT *
FROM emp
WHERE deptno = 10 or deptno = 20;


SELECT *
FROM emp
WHERE deptno in(SELECT deptno FROM emp WHERE ename in (:name1, :name2));

-- ANY : SET 중에 만족하는게 하나라고 있으면 참으로 (크기비교)
-- SMITH, WARD 두 사람의 급여보다 적은 급여를 받는 직원 정보 조회
SELECT *
FROM emp
WHERE sal < any (
        SELECT sal 
        FROM emp
        WHERE ename IN ('SMITH', 'WARD'));


-- SMITH와 WARD보다 급여가 놓은 직원 조회
-- SMITH보다도 급여가 놓고 WARD보다도 급여가 높은사람(AND)
SELECT *
FROM emp --> 1250보다 급여가 높은 사람 조회
WHERE sal > ALL (
        SELECT sal 
        FROM emp
        WHERE ename IN ('SMITH', 'WARD'));

-- NOT IN
SELECT mgr
FROM emp;

select *
from emp;

--관리자의 직원정보
-- 1. 관리자인 사람만 조회
--  .mgr 컬럼에 값이 나오는 직원
-- DISTINCT -> 중복제거
select DISTINCT mgr
from emp
order by mgr;

-- 어떤 직원의 관리자 역할을 하는 직원정보 조회
SELECT *
FROM emp
WHERE empno in(7566,7698,7782,7788,7839,7902);
-------------------------------------------실행결과
7566	JONES	    MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7782	CLARK	MANAGER	7839	81/06/09	2450		10
7788	SCOTT	ANALYST	    7566	82/12/09	3000		20
7839	KING	    PRESIDENT		    81/11/17	5000		10
7902	FORD	    ANALYST	    7566	81/12/03	3000		20
---------------------------------------------
SELECT *
FROM emp
 WHERE empno in(
    SELECT mgr
    FROM emp );
-------------------------------------------실행결과
7566	JONES	    MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7782	CLARK	MANAGER	7839	81/06/09	2450		10
7788	SCOTT	ANALYST	    7566	82/12/09	3000		20
7839	KING	    PRESIDENT		    81/11/17	5000		10
7902	FORD	    ANALYST	    7566	81/12/03	3000		20
---------------------------------------------

--관리자가 아닌 사람들 조회
-- NULL 때문에 아무값도 나오지 않음
SELECT *
FROM emp
 WHERE empno NOT IN(
 
    SELECT mgr
    FROM emp );


-- 관리자 역할을 하지 않는 평사원 정보 조회
-- 단 NOT IN 연산자 사용시 NULL이 포함될 경우 정상적으로 동작하지 않는다.
-- NULL 처리 함수나 WHERE 절을 통해 NULL값을 처리한 후 사용
SELECT *
FROM emp
 WHERE empno NOT IN(
    SELECT NVL(mgr,-9999)
    FROM emp );
-------------------
SELECT *
FROM emp
 WHERE empno not IN(
    SELECT mgr
    FROM emp 
    WHERE mgr IS NOT NULL);
    

--pair wise
-- 사번 7499, 7782 인 직원의 관리자, 부서번호 조회
SELECT mgr, deptno
FROM emp
WHERE empno in(7499,7782);
----------실행결과
7698	30
7839	10
---------
-- 관리자와 부서번호가(7698,30) 이거나 (7839,10)인 사람 mgr, deptno컬럼을 <동시>에 만족시키는 직원정보 조회
-- (7839,10),(7698,30) 2가지의 경우만
SELECT *
FROM emp
WHERE(mgr, deptno) in(
                                SELECT mgr, deptno
                                FROM emp
                                WHERE empno in(7499,7782));
                                

-- mgr따로 deptno따로
-- (7698,30), (7698,10), (6839,30), (7839,10) 4가지의 경우
SELECT *
FROM emp
WHERE mgr in(SELECT mgr
                             FROM emp
                               WHERE empno in(7499,7782))
and deptno in(SELECT deptno
                             FROM emp
                               WHERE empno in(7499,7782));

--SCALAR SUBQUERY : SELECT 절에 등장하는 서브 쿼리(단 값이 하난의 행, 하나의 컬럼)
--직원의 소속 부서명을 JOIN을 사용하지 않고 조회
SELECT empno, ename, deptno, (SELECT dname
                                          FROM dept
                                          WHERE deptno =emp.deptno) dname -- join을 사용할 수 없을 때 사용 / emp.deptno 때문에 독자적으로 조회가 불가능하다. emp.deptno는 메인쿼리에서 가지고왔음
FROM emp;


SELECT dname
FROM dept
WHERE deptno =20;

--서브4 데이터 생성

INSERT INTO dept VALUES(99, 'ddit', 'daejeon');
COMMIT;

--♠실습 서브 쿼리 실습 4)
SELECT *
FROM emp
order by deptno;

SELECT deptno, dname, loc
FROM dept
where deptno not in(10,20,30);      --emp테이블이 수정되면 입력한 값을 수정해야되서
-----------------------실행결과
99	    ddit	                    daejeon
40	    OPERATIONS	            BOSTON
---------------------------


SELECT deptno, dname, loc
FROM dept
where deptno not in(
                            select deptno
                            from emp);

-----------------------실행결과
99	    ddit	                    daejeon
40	    OPERATIONS	            BOSTON
---------------------------


--♠실습 서브 쿼리 실습 5)
select *
from cycle;

select *
from product;

select *
from customer;


-- not in 안에 있는 게 안에 있는 조건이랑 다를때 / in 은 안에있는 조건이랑 일치할 때(조건이 2개 있을 때는 하나라도 조건이 같으면 출력됨)
select pid, pnm
from product
where pid not in(select pid 
                        from cycle 
                        where cid = 1); 
                        
--♠실습 서브 쿼리 실습 6)
select cid,pid
from cycle
where pid =100;


select *
from cycle
where pid in (select pid
                  from cycle
                  where pid =100) and cid =1;
------------실행결과
1	100	6	1
1	100	4	1
1	100	2	1
------------                    

--♠실습 서브 쿼리 실습 7)
select cycle.pid, day, cnt, cycle.cid, pnm, cnm
from cycle join product on(cycle.pid = product.pid) and join customer on(cycle.cid = customer.cid)
where pid in (select pid
                  from cycle
                  where pid =100) and cid =1;
                  
                  
--EXISTS MAIN쿼리의 컬럼을 사용해서 SUBQUERY에 만족하는 조건이 있는지 체크
-- 만족하는 값이 하나라도 존재하면 더이상 진행하지 않고 멈추기 때문에 성능면에서 유리

-- MGR가 존재하는 직원 조회
SELECT *
FROM emp a
WHERE EXISTS (SELECT 'X' 
                    FROM emp
                    WHERE empno = a.mgr);
                    
                    
                    
-- MGR가 존재하지 않는 직원 조회
SELECT *
FROM emp a
WHERE NOT EXISTS (SELECT 'X' 
                    FROM emp
                    WHERE empno = a.mgr);
                    
                    
--♠실습 서브 쿼리 실습 7)
-- 매니저가 존재하는 직원 조회
SELECT *
FROM emp
WHERE mgr is not null;

select *
from emp a
where exists(select 'x'
                from emp b
                where b.empno = a.mgr);
                
-- 부서에 소속된 직원이 있는 부서 정보 조회
select *
from dept
where deptno in(10,20,30);

select *
from dept;

select *
from dept 
where exists(select 'x'
                    from emp
                    where deptno = dept.deptno); -- emp에서의 deptno와 dept에서 deptno
-----------------------실행결과
20	RESEARCH	    DALLAS
30	SALES	            CHICAGO
10	ACCOUNTING	NEW YORK
-----------------------

select *
from emp;

select *
from dept 
where deptno in(select deptno
                    from emp);
                    
                    
--집합연산
-- union : 합집합, 중복을 제거
--         : DBMS에서는 중복을 제거하기 위해 데이터를 정리한다.
-- union all : union과 같은 개념, 중복을 제거하지 않고 위 아래 집합을 결합만함
-- 위 아래 중복된 데이터가 없다는 것을 확신하면 사용한다.
-- union연산자보다 성능면에서 유리



-- 사번이 7566 또는 7698인 사원 조회(사번이랑 이름만 조회)
SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698;


-- 사번이 7369. 7499인 사원 조회(사번, 이름)
SELECT empno, ename
FROM emp
WHERE empno = 7369 or empno = 7499;



--------------
SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698
union
SELECT empno, ename
FROM emp
WHERE empno = 7369 or empno = 7499;



--------------------중복을 제거한다.
SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698
union
SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698;
-----------실행결과
7566	JONES
7698	BLAKE
-----------

SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698
union all -- 중복을 제거하지 않는다.
SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698;
----------실행결과
7566	JONES
7698	BLAKE
7566	JONES
7698	BLAKE
----------

-- INTERSECT(교집합 : 위 아래 집합 간 공통 데이터)

SELECT empno, ename
FROM emp
WHERE empno IN( 7566 , 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN( 7566 ,7698, 7499);
------------------------------------
--MINUS(차집합 : 위집합에서 아래집합을 제거)
-- 순서가 존재(위아래 집합의 방향을 바꾸면 결과가 바뀔 수 있음)
SELECT empno, ename
FROM emp
WHERE empno IN( 7566 , 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN( 7566 ,7698, 7499);
---------실행결과
7369	SMITH
----------

--------------------------------------

SELECT empno, ename
FROM emp
WHERE empno IN( 7566 ,7698, 7499)
MINUS
SELECT empno, ename
FROM emp
WHERE empno IN( 7566 , 7698, 7369);
---------실행결과
7499	ALLEN
----------


SELECT *
FROM USER_CONSTRAINTS
WHERE OWNER = 'PC123'
AND TABLE_NAME IN('PROD', 'LPROD')
AND CONSTRAINT_TYPE IN ('P','R');



--♠실습 서브 쿼리 실습 7)
-- join으로 먼저 cycle.pid와 product.pid를 묶고, 나머지 customer.cid랑 조인을 함

select a.cid,cnm,a.pid, pnm, day, cnt 
from 
(select cycle.pid, day, cnt, cycle.cid, pnm
from cycle join product on (cycle.pid = product.pid))a join customer on(a.cid = customer.cid)
where a.pid in (select a.pid
                  from cycle
                  where a.pid =100) and a.cid =1;


--♠실습 서브 쿼리 실습 9)

select pid, pnm
from product
where not exists (select 'x'
                    from cycle
                    where pid = product.pid and cycle.cid =1);

                
select *
from cycle;

select *
from product;

