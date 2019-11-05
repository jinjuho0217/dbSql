-- LAST_DAY(DATE) 해당 날짜가 속한 월의 마지막 일자
SELECT SYSDATE, LAST_DAY(SYSDATE) LAST_DAY,
          LAST_DAY( ADD_MONTHS (SYSDATE, 1)) LAST_DAT_12
FROM dual;

-- 년월 파라미터가 주어졌을 때 해당년월의 일수를 구하는 문제
--201911--> 30/201912--> 31
-- 한달 더한 후 원래값을 빼면 일수
-- 마지막 날짜 구한 후 --> DD만 추출

--SELECT TO_CHAR(LAST_DAY(TO_DATE('201911', 'YYYYMM')), 'DD')  day_cnt
SELECT :yyyymm as param, TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') dt -- 원하는 달의 마지막 날짜를 알 수 있다.
FROM DUAL;



explain plan for
SELECT *
FROM emp
WHERE empno = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
 
Note
-----
   - dynamic sampling used for this statement (level=2)
   
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR( empno) = '7369';
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT  empno, ename, sal, TO_CHAR(sal, 'L000999,999.99') sal_fmt -- 숫자표시를 9로 한다.
FROM emp;

select * from nls_session_parameters
;

alter session set NLS_CURRENCY = '\';


--function null
--nvl(coll, null일 경우 대체할 값)
SELECT empno, ename, sal, comm, nvl(comm, 0) nvl_comm,     -- comm이 null이면 옆에 0이 오게
            sal + comm,
            sal +nvl(comm, 0),
            nvl(sal + comm, 0)
FROM emp;

--nvl2(coll, coll이 null이 아닐경우 표현되는 값, coll null일 경우 표현되는 값)
SELECT empno, ename, sal, comm, nvl2(comm, comm, 0) + sal
FROM emp;

--NULLIF(exper1, exper2)
-- exper1 == exper2 같으면 null
-- else : exper1

SELECT empno, sal, ename, comm, NULLIF(sal, 1250) -- 두개의 값이 같으면 강제로 null을 만든다.
FROM emp;


--COALESCE(exper1, exper2, exper3....) , 자바의 가변인자 같은거
-- 함수 인자 중 null이 아닌 첫번째 인자
SELECT empno, ename, sal, comm, coalesce(comm, sal)
FROM emp;

--♠실습 FUNCTION NULL실습 fn1)
SELECT empno, ename, mgr, coalesce(mgr, 9999) mgr_n, 
             nvl(mgr, 9999) mgr_n1, 
             nvl2(mgr, mgr, 9999) mgr_n2 -- 첫번째 인자가 null이 아닐경우 표현되는 값
FROM emp;
-------------------------------실행 결과
7369	SMITH 	7902	7902	7902	7902
7499	ALLEN	7698	7698	7698	7698
7521	WARD	    7698	7698	7698	7698
7566	JONES	7839	7839	7839	7839
7654	MARTIN	7698	7698	7698	7698
7698	BLAKE	7839	7839	7839	7839
7782	CLARK	7839	7839	7839	7839
7788	SCOTT	7566	7566	7566	7566
7839	KING		9999	9999	9999
7844	TURNER	7698	7698	7698	7698
7876	ADAMS	7788	7788	7788	7788
7900	JAMES	7698	7698	7698	7698
7902	FORD	    7566	7566	7566	7566
7934	MILLER	7782	7782	7782	7782
--------------------------------

SELECT userid, usernm, reg_dt
FROM users;

--♠실습 FUNCTION NULL실습 fn2)
SELECT userid, usernm, reg_dt, nvl(reg_dt, sysdate) N_REG_DT
FROM users;
-------------------------------- 실행결과
brown	브라운	19/01/28	19/01/28
cony	코니	    19/01/28	19/01/28
sally	샐리	    19/01/28	19/01/28
james	제임스	19/01/28	19/01/28
moon	문		     (null)         19/11/05
--------------------------------


--case when
SELECT empno, ename, job, sal,
        case
            when job = 'SALESMAN' then sal * 1.05
            when job = 'MANAGER' then sal * 1.10
            when job = 'PRESIDENT' then sal * 1.20
            else sal
        end case_sal
FROM emp;
------------------------------------실행결과
7369	SMITH  	CLERK	    800	800
7499	ALLEN	SALESMAN	1600	1680
7521	WARD 	SALESMAN	1250	1312.5
7566	JONES	MANAGER	2975	3272.5
7654	MARTIN	SALESMAN	1250	1312.5
7698	BLAKE	MANAGER	2850	3135
7782	CLARK	MANAGER	2450	2695
7788	SCOTT	ANALYST	    3000	3000
7839	KING	    PRESIDENT	5000	6000
7844	TURNER	SALESMAN	1500	1575
7876	ADAMS	CLERK	    1100	1100
7900	JAMES	CLERK	    950	950
7902	FORD	    ANALYST	    3000	3000
7934	MILLER	CLERK	    1300	1300
-------------------------------------

--decode(col, search1, return1, search2, return2.....defult)
SELECT empno, ename, job, sal,
        DECODE( job, ' SALESMAN', sal*1.05 ,  'MANAGER', sal *1.10 ,  'PRESIDENT', sal*1.20,
            sal) decode_sal
FROM emp;

--♠실습 FUNCTION condition 실습1)
SELECT empno, ename,
        DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS', 'DDIT') DNAME
FROM EMP;
-------------------------실행결과
7369	SMITH 	RESEARCH
7499	ALLEN	SALES
7521	WARD 	SALES
7566	JONES	RESEARCH
7654	MARTIN	SALES
7698	BLAKE	SALES
7782	CLARK	ACCOUNTING
7788	SCOTT	RESEARCH
7839	KING	    ACCOUNTING
7844	TURNER	SALES
7876	ADAMS	RESEARCH
7900	JAMES	SALES
7902	FORD	    RESEARCH
7934	MILLER	ACCOUNTING
--------------------------

--♠실습 FUNCTION condition 실습2)
-- 올 해수는 짝수인가 홀수인가
-- 1. 올해 연도 구하기(DATE --> TO_CHAR(DATE, FORMAT))
-- 2. 올해 년도가 짝수인지 계산
-- 어떤 수를 2로 나누면 나머지는 항상 2보다 작다
-- 2로 나눌 경우 나머지는 0, 1
-- MOD(대상, 나눌값)
SELECT empno, ename, hiredate,
    decode(MOD(SUBSTR(hiredate, 0,2), 2),0, '건강검진 비대상자',1, '건강검진 대상자')건강검진,
FROM emp;

SELECT MOD(TO_CHAR(SYSDATE, 'YYYY'),2)
FROM DUAL;

-- EMP 테이블에서 입사일자가 홀수년도 있지 짝수년도 인지 확인
SELECT empno, ename, hiredate, 
    case
        WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =  MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
            then '건강검진 대상'
            else '건강검진 비대상'
        end concat_to_doctor
FROM emp;
----------------------실행결과
7369	SMITH   	80/12/17	건강검진 비대상
7499	ALLEN	81/02/20	건강검진 대상
7521	WARD    	81/02/22	건강검진 대상
7566	JONES	81/04/02	건강검진 대상
7654	MARTIN	81/09/28	건강검진 대상
7698	BLAKE	81/05/01	건강검진 대상
7782	CLARK	81/06/09	건강검진 대상
7788	SCOTT	82/12/09	건강검진 비대상
7839	KING	    81/11/17	건강검진 대상
7844	TURNER	81/09/08	건강검진 대상
7876	ADAMS	83/01/12	건강검진 대상
7900	JAMES	81/12/03	건강검진 대상
7902	FORD    	81/12/03	건강검진 대상
7934	MILLER	82/01/23	건강검진 비대상
------------------------------


--♠실습 FUNCTION condition 실습3)
SELECT userid, usernm, alias, reg_dt,
    case
        when MOD(TO_CHAR(reg_dt, 'YYYY'), 2) = MOD(TO_CHAR (SYSDATE, 'YYYY'), 2)
            THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
            END concat_to_doctor
FROM USERS;
----------------------------실행결과
brown	브라운		19/01/28	건강검진 대상자
cony	코니		    19/01/28	건강검진 대상자
sally	샐리		    19/01/28	건강검진 대상자
james	제임스		19/01/28	건강검진 대상자
moon	문			     (NULL)      건강검진 비대상자
-----------------------------

-- 그룹함수(AVG, MAX, MIN, SUM, COUNT)
-- 그룹함수는 NULL값을 계산대상에서 제외한다.
--SUM(COMM), COUNT(*), COUNT(MGR)
SELECT *
FROM emp;

--직원 중 가장 높은 급여를 받는 사람
SELECT MAX(sal) max_sal
FROM emp;
--직원 중 가장 낮은 급여를 받는 사람
SELECT MIN(sal) min_sal
FROM emp;

SELECT empno, ename, sal
FROM emp
ORDER BY sal;

-- 부서별 가장 높은 급여를 받는 사람의 급려
--  GROUP BY 절에 기술되지 않은 컬럼이 SELECT절에 기술될 경우 에러
SELECT deptno, MIN(ename), MAX(SAL) max_sal
FROM emp
GROUP BY deptno;

-- 직원의 급여평균, 소수점 셋째 자리까지 반올림
SELECT MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(SAL), 2), SUM(SAL) SUM_SAL
FROM emp;

--직원의 숫자 카운트
SELECT MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(SAL), 2), SUM(SAL) SUM_SAL,
            COUNT(*) EMP_CNT, COUNT(SAL) SAL_CNT, COUNT(MGR) MGR_CNT
            , SUM(COMM) COMM_SUM
FROM emp;

SELECT deptno, MIN(ename), MAX(SAL) max_sal,ROUND(AVG(SAL), 2), SUM(SAL) SUM_SAL,
            COUNT(*) EMP_CNT, COUNT(SAL) SAL_CNT, COUNT(MGR) MGR_CNT
            , SUM(COMM) COMM_SUM
FROM emp
GROUP BY deptno;
-------------------------------------실행결과
30	ALLEN	2850	1566.67	9400    	6	6	6	2200
20	ADAMS	3000	2175	    10875	5	5	5	(NULL)
10	CLARK	5000	2916.67	8750	    3	3	2	(NULL)
-------------------------------------


-- 부서별 최대 급여
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY   deptno
HAVING MAX(sal) > 3000;


--♠실습 GROUP FUNCTION grp 실습1)
SELECT max(sal) max_sal, 
            min(sal) min_sal, 
            round(avg(sal), 2) avg_sal, 
            sum(sal) sum_sal,
            count(sal) count_sal, 
            count(mgr) count_mgr,
            count(*) count_all
FROM emp;
----------------------------실행결과
5000	800	2073.21	29025	14	    13  	14
----------------------------------

--♠실습 GROUP FUNCTION grp 실습2)
SELECT deptno,
            max(sal) max_sal, 
            min(sal) min_sal, 
           round( avg(sal),2) avg_sal, 
            sum(sal) sum_sal, 
            count(sal), 
            count(mgr) mgr_sal, 
            count(*) count_all
FROM emp
GROUP BY  deptno;

--------------------------------------실행결과
30	    2850	    950	    1566.67	   9400	    6	6	6
20 	3000	    800	    2175	       10875	5	5	5
10 	5000	    1300	    2916.67	   8750	    3	2	3
---------------------------------------