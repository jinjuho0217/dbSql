select ename, sal, deptno,
row_number() over(partition by deptno order by sal desc) rank
from emp;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
select *
from emp;

--RANK : 동일값에 동일순위(1등이 2명이면 다음이 3등)
select ename, sal, deptno, RANK()OVER (PARTITION BY deptno order by sal) rank
from emp;
--DENSE_RANK :  동일값에 동일순위(1등이 2명이면 다음이 2등)
select ename, sal, deptno, DENSE_RANK()OVER (PARTITION BY deptno order by sal) rank
from emp;
--ROW_NUMBER : 동일값이라도 별도의 순위를 부여
select ename, sal, deptno, ROW_NUMBER()OVER (PARTITION BY deptno order by sal) rank
from emp;
-- PARTITION BY는 없어도 됨

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--♠실습 WINDOW함수  실습 1)
SELECT *
FROM EMP;
-- 결과가 같을 경우 다음 기준을 주려면(ORDER BY SAL DESC, EMPNO)이런식으로 , 뒤에 다음 기준이 되는 조건을 적어두면 된다.
SELECT ENAME, SAL, EMPNO, ROW_NUMBER() OVER(ORDER BY SAL DESC, EMPNO) row_number,
                    RANK() OVER(ORDER BY SAL DESC, EMPNO) rank,
                    DENSE_RANK() OVER( ORDER BY SAL DESC, EMPNO) dense_rank
FROM EMP;

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--♠실습 WINDOW함수  실습 2)

select  b.empno, b.ename, b.deptno,a.cnt
from
        (select deptno, count(*) cnt  from emp  group by deptno) a 
    join
        (select empno, ename, deptno  from emp) b  on(a.deptno = b.deptno)
order by deptno;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--분석함수를 통한 부서별 직원수(COUNT)
select ename, empno, deptno /*,cnt*/
        , COUNT(*) OVER (partition by deptno) cnt
from emp;

--부서별 사원의 급여 합계
--SUM 분석함수
select ename, empno, deptno,SAL
        , SUM(SAL) OVER (partition by deptno) SUM_SAL
from emp;

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--♠실습 WINDOW함수  실습 2)
-- ROUND사용후 소수점 몇번째 자리까지인지 입력하기 round(avg(sal)over (partition by deptno),2) --> 소수점 2번째 자리
-- GROUP BY일 경우에는 그냥 AVG까지만 사용하면되고, WINDOW함수에는 OVER (PARTITION BY)까지 사용해야 한다.
select *
from emp;


select empno, ename, sal, deptno, round(avg(sal)over (partition by deptno),2) avg_sal
from emp;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--♠실습 WINDOW함수  실습 3)
select empno, ename, sal, deptno
            , max(sal) over (partition by deptno) max_sal
            , min(sal) over (partition by deptno)min_sal
from emp;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------


-- 부서별 사원번호가 가장 빠른 사람
-- 부서별 사원번호가 가장 느린 사람
select empno, deptno
from emp
order by deptno;
-- 재확인해야됨
select empno, ename, deptno
        ,first_value(empno) over(partition by deptno order by empno) f_emp,
        last_value(empno) over(partition by deptno ) l_emp
from emp;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--LAG(이전행)
-- 현재행
--LEAD(다음행)
--급여가 높은 순으로 정렬 했을때 자기보다 한단게 급여가 낮은 사람의 급여, 
--급여가 높은 순으로 정렬 했을때 자기보다 한단게 급여가 높은 사람의 급여, 

SELECT empno, ename, sal, LAG(sal) OVER (ORDER BY sal) lag_sal,
                                    LEAD(sal) OVER (ORDER BY sal) lead_sal
from emp;

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--♠실습 WINDOW함수  실습 5)
select empno, ename, hiredate, sal, lead(sal) over(order by sal desc, hiredate)lead_sal
from emp;


------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--♠실습 WINDOW함수  실습 6)
select empno, ename, hiredate, job, sal
        , lag(sal) over (partition by job order by sal , hiredate)lag_sal
from emp;

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
select empno, ename, sal
from emp;


select empno, ename, sal, rownum rn
from
(select empno, ename, sal
from emp
order by sal);


select a.empno, a.ename, a.sal, b.rn
from
    (select empno, ename, sal, rownum rn
    from
    (select empno, ename, sal
    from emp
    order by sal)a)a
join
    (select empno, ename, sal, rownum-1 rn
    from
    (select empno, ename, sal
    from emp
    order by sal)b)b on (a.ename = b.ename);

select ename, empno, sal, rn
from
(select a.ename, a.empno, a.sal, b.rn
from
(
select a.*, rownum rn
from
    (select empno, ename, sal
    from emp
    order by sal, empno)a)a
join
    (select b.*, rownum rn
    from
    (select empno, ename, sal
    from emp
    order by sal, empno)b)b on(a.rn >= b.rn))
    order by sal;
    
    


------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
-- WINDOWING
-- UNBOUNDED PRECEDING : 현재 행을 기준으로 선행하는 모든 행 - 자기기준보다 급여가 낮은거
-- CURRENT ROW : 현재행
-- UNBOUNDED FOLLOWING : 현재 행을 기준으로 후행하는 모든 행 - 자기기준보다 급여가 높은거
-- N(정수) PRECEDING : 현재 행을 기준으로 선행하는 N개의 행
-- N(정수) FOLLOWING : 현재 행을 기준으로 후행하는 N개의 행

SELECT empno, ename, sal
    ,sum(sal) over(order by sal, empno 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)sum_sal
    
     ,sum(sal) over(order by sal, empno 
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)sum_sal2

   ,sum(sal) over(order by sal, empno 
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)sum_sal3 -- 자신의 선행하는 행과 후행하는 행을 합한값

FROM emp;

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--♠실습 WINDOW함수  실습 7)
SELECT EMPNO, ENAME, DEPTNO, SAL
            ,SUM(sal) OVER(
                PARTITION BY deptno order by sal, empno 
                ROWS BETWEEN UNBOUNDED PRECEDING AND
                CURRENT ROW)c_sal            
FROM EMP;

SELECT EMPNO, ENAME, DEPTNO, SAL
            ,SUM(sal) OVER(
                PARTITION BY deptno order by sal, empno 
                )c_sal            --ROWS BETWEEN UNBOUNDED PRECEDING AND  CURRENT ROW 는 DEFUALT값이여서 없어도 결과가 같음
               
FROM EMP;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------

SELECT EMPNO, ENAME, DEPTNO, SAL,
    SUM(SAL) OVER (ORDER BY SAL 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) row_sum,
    
    
    SUM(SAL) OVER (ORDER BY SAL 
    ROWS UNBOUNDED PRECEDING) row_sum, -- 위와 동일한 결과가 나온다. between을 쓰지 않아도 자기행까지는 기준이 된다, rows는 같은 값일 경우 다른 행으로 인식
    
    
    SUM(SAL) OVER (ORDER BY SAL 
    range BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) row_sum, -- 중복값이 생기는 구간에서 값이 달라짐, range는 같은 값일 경우 같은 행으로 인식
    
    
    SUM(SAL) OVER (ORDER BY SAL 
    range UNBOUNDED PRECEDING) row_sum 



FROM emp;




