--숫자비교 연산
-- 부서번호가 30번 보다 크거나 같은 부서에 속한 직원 조회

SELECT *
FROM emp
WHERE deptno >=30;

SELECT *
FROM dept;

--부서번호가 30번보다 작은 부서에 속한 직원 조회

SELECT *
FROM emp
WHERE deptno < 30;

--입사일자가 1982년 1월 1일 이후인 직원 조회
SELECT *
FROM emp
--WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD'); --3명
--WHERE hiredate < TO_DATE('1982/01/01', 'YYYY/MM/DD'); --11명
--WHERE hiredate >= TO_DATE('01011982', 'MMDDYYYY'); --3명
WHERE hiredate < '82/01/01';--11명, hiredate안쓰고 문자열인데 날짜로 인정되는 건 툴마다 다를 수도 있음

--BETWEEN  X AND Y 연산
--컬럼의 값이 X보다 크거나 같고, Y보다 작거나 같은 데이터
--급여(sal)가 1000보다 크거나 같고, y보다 작거나 같은 데이터를 조회
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000; -- BETWEEN과 AND는 그 값을 포함함

--위의 BETWEEN AND 연산자는 아래의 <=, >= 조합과 같다

SELECT *
FROM emp
WHERE sal >=1000 --1000을 포함하지 않으려면 BETWEEN보다는 이렇게 하는게 좋다.
AND  sal <= 2000
AND deptno = 30;
 
 --♠실습 where1)
SELECT ename,hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01') AND TO_DATE('1983/01/01');
--WHERE hiredate BETWEEN '1982/01/01' AND '1983/01/01';

--♠실습 where2)
SELECT ename, hiredate
FROM emp
WHERE hiredate > TO_DATE('1982/01/01', 'YYYY/MM/DD') AND hiredate < TO_DATE('1983/01/01', 'YYYY/MM/DD');


-- IN 연산자
-- COL IN (values...)
-- 부서번호가 10 혹은 20인 직원 조회

SELECT *
FROM emp
WHERE deptno In (10,20);

--IN 연산자는 OR연산자로 표현할 수 있다.
SELECT *
FROM emp
WHERE deptno =10 OR deptno =20;

--♠실습 in1)
SELECT userid 아이디, usernm 이름
FROM users
--WHERE userid = 'brown' or userid = 'cony' or userid = 'sally';
WHERE userid IN('brown', 'cony','sally');

-- COL LIKE 'S%'
-- COL의 값이 대문자 S로 시작하는 모든 값
-- COL LIKE 'S____'(_4개있음)
--COL의 값이 대문자 S로 시작하고 이어서 4개의 문자열(_)이 존재하는 값

-- emp 테이블에서 직원이름이s로 시작하는 모든 직원 조회
SELECT *
FROM emp
WHERE ename LIKE 'S%';
--WHERE ename = 'SMITH';
--WHERE ename = 'smith';는 다름

SELECT *
FROM emp
WHERE ename LIKE 'S____';

--♠실습 WHERE4)
SELECT  mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%'; --'신'으로 시작하는 모든문자

--♠실습 WHERE5)
SELECT  mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%'; --'이'가 들어가는 모든 문자

-- NULL 비교
-- COL IS NULL
-- EMP 테이블에서 MGR정보가 없는 사람(NULL) 조회
-- 자바에서 쓰는 !=은 안되고 IS라고 쓴다.

--♠실습 IS NULL WHERE)
SELECT *
FROM emp
WHERE MGR IS NULL;

--♠실습 IS NOT NULL WHERE6)
SELECT *
FROM emp
WHERE comm IS NOT NULL; -- NULL이 아니다 IS NOT NULL

--AND / OR
--관리자(mgr) 사번이 7698이고 급여가 1000이상인 사람
SELECT *
FROM emp
WHERE mgr = 7698 AND sal >= 1000;

--emp 테이블에서 관리자(mgr) 사번이 7698이거나 급여가(sal)사 1000 이상인 직원 조회
SELECT *
FROM emp
WHERE mgr = 7698 OR sal >= 1000;


--emp테이블에서 관리자 (mgr) 사번이 7698이 아니고, 7839가 아닌 직원들 조회
SELECT *
FROM emp
WHERE mgr NOT IN(7698,7839); -->  IN = OR

--위의 쿼리를 AND/OR 연산자로 변환
SELECT *
FROM emp
WHERE mgr != 7698 AND mgr != 7839;

--IN , NOT IN연산자의 NULL 처리
-- emp 테이블에서 관리자(mgr) 사번이 7698, 7839 또는 null이 아닌 직원들 조회

SELECT *
FROM emp
WHERE mgr NOT IN(7698,7839) AND  mgr IS NOT NULL;


--♠실습 AND OR WHERE7)
--DESC EMP; -- 데이터의 타입을 볼 수있음
SELECT *
FROM emp
WHERE job IN('SALESMAN') AND hiredate > TO_DATE('1981/06/01', 'YYYY/MM/DD');


--♠실습 AND OR WHERE8)
SELECT *
FROM emp
WHERE deptno != 10 AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


--♠실습 AND OR WHERE9)
SELECT *
FROM emp
WHERE deptno NOT IN (10) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--♠실습 AND OR WHERE10)
SELECT *
FROM emp
WHERE deptno IN (20,30) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
--WHERE deptno IN (20,30) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD') AND deptno NOT IN(10);

--♠실습 AND OR WHERE11)
SELECT *
FROM emp
WHERE job IN('SALESMAN') OR hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--♠실습 AND OR WHERE12)
SELECT *
FROM emp
WHERE job IN('SALESMAN') OR empno LIKE('78%');



select user_id, usernm, reg_dt, reg_dt + 5
from users;
