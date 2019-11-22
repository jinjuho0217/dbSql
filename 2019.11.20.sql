--GROUPING (cube, rollup 절의 사용된 컬럼)
-- 해당ㅋ털럼이 소계 계산에 사용된 경우 1
-- 사용되지 않은 경우 0

--job컬럼
--case1.  grouping(deptno)=1 and grouping(job) =1
--              job --> '총계'
--case esle
--              job-->job
select case when grouping(job)=1 and
                            grouping(deptno) =1 then '총계'
                else job
            end job, deptno,
         grouping(deptno),grouping(job), sum(sal) sal
from emp
group by rollup(job ,deptno);


--♠실습 group function  실습 2)
SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

select case when grouping(job) = 1 and grouping(deptno) =1 then '총계' 
    
            else job
            end job, 
            case when grouping(job) =0 and grouping(deptno) =1 then job || '소계'
            else to_char(deptno)
            end deptno
            ,deptno, sum(sal) sal
 from emp
group by rollup(job ,deptno);

------------------------------------------------------------------




------------------------------------------------------------------
--♠실습 group function  실습 3)
select deptno,job,
         sum(sal) sal
from emp
group by rollup( deptno,job)
order by deptno;

------------------------------------------------------------------



------------------------------------------------------------------
--cube (col1,col2...)
-- cube 절에 나열된 컬럼의 가능한 모든 조합에 대해 서브 그룹으로 생성
-- cube에 나열된 컬럼에 대해 방향성은 없다(rollup과의 차이)
--group by cube(job, deptno)
-- oo : group by job, deptno
-- ox : group by job
-- xo : deptno
-- xx : group by -- 모든 데이터

--group by cube(job, deptno,mgr)

select job, deptno, sum(sal)
from emp
group by cube(job, deptno);
------------------------------------------------------------------



------------------------------------------------------------------

select *
from emp;

select deptno, sum(sal)
from emp
group by deptno;

select deptno, job,sum(sal)
from emp
group by (deptno, job)
order by deptno;



select *
from emp_test;

drop table emp_test;

select *
from emp_test;

--emp테이블의 데이터를 포함해서 모든 컬럼을 이용하셔 emp_test테이블로 생성

create table emp_test as 
select *
from emp;


--emp_test테이블에 dept테이블에서 가지고 있는 dname( VARCHAR2(14) )컬럼을 추가
desc dept;

--컬럼추가
alter table emp_test add (dname varchar2(14));

select *
from emp_test;

--emp_test테이블의  dname컬럼을 dept테이블의 dname 컬럼 값으로 업데이트하는 쿼리  작성
update emp_test set dname = (select dname from dept where dept.deptno = emp_test.deptno  );

------------------------------------------------------------------



------------------------------------------------------------------




--♠실습 서브쿼리  실습 3)
-- dept_test테이블 생성
--empcnt(number) 컬럼추가
-- 서브쿼리를 이용하여 dept_test테이블의 empcnt컬럼에 해당 부서원 수를 update쿼리를 작성

select *
from emp_test;
commit;

select *
from dept_test;

drop table dept_test;

create table dept_test as
select *
from dept;

select *
from dept_test;

select *
from emp;

alter table dept_test add (empcnt number);

update dept_test set empcnt = (select count(empno) 
                                    --= (SELECT COUNT(*) --행의 개수를 COUNT한다.
                                        from emp 
                                        where dept_test.deptno = emp.deptno  );
-- 그룹함수는 안에 값이 없더라도 결과 값이 0이 나온다.



------------------------------------------------------------------



------------------------------------------------------------------

SELECT *
FROM DEPT_TEST;
INSERT INTO DEPT_TEST VALUES (98, 'IT', 'DAEJEON','0');
INSERT INTO DEPT_TEST VALUES (99, 'IT', 'DAEJEON','0');


update dept_test set empcnt = (select count(empno) 
                                    --= (SELECT COUNT(*) --행의 개수를 COUNT한다.
                                        from emp 
                                        where dept_test.deptno = emp.deptno  );

SELECT *
FROM EMP;

delete from dept_test WHERE not exists  (select 'x'
                                                        from emp
                                                        where emp.deptno = dept_test.deptno) ;

--delete dept_test
--where empcnt not in  (select count(*)
--                        from emp
--                        where emp.deptno = dept_test.deptno
--                        group by deptno);
--
--
--
--delete dept_test
--where deptno not in(select deptno from emp);
                        
                        
select *
from dept_test;


------------------------------------------------------------------



------------------------------------------------------------------
--♠실습 서브쿼리  실습 3)

--update dept_test set empcnt = (select count(empno) 
--                                    --= (SELECT COUNT(*) --행의 개수를 COUNT한다.
--                                        from emp 
--                                        where dept_test.deptno = emp.deptno  );


alter table dept_test add (empcnt number);
select *
from emp_test;

select *
from emp;


update emp_test a set sal = sal + 200
where sal<(select avg(sal) from emp_test b where b.deptno = a.deptno);




select *
from emp_test;

select *
from emp;

-- emp, emp_test empno컬럼으로 같은 값끼리 조회
-- 1번. emp.empno, emp.ename, emp.sal, emp_test.sal
-- 2번. emp.empno, emp.ename, emp.sal, emp_test.sal,
-- 해당 사원(emp테이블 기준)이 속한 부서의 급여평균


select a.ename, b.ename, a.sal, b.sal, a.deptno
from emp a join emp_test b on(a.empno = b.empno)
order by deptno;









