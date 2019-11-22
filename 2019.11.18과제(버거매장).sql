select *
from fastfood;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='맥도날드'
group by sigungu, sido;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='버거킹'
group by sigungu, sido;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='KFC'
group by sigungu, sido;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='롯데리아'
group by sigungu, sido;


select a.sido, a.SIGUNGU,a.cnt, b.cnt, c.cnt, d.cnt, TRUNC((a.cnt+b.cnt+c.cnt) / d.cnt , 1)  as result
from
    (select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='맥도날드'
    group by sigungu, sido
    ) a,
    ( select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='버거킹'
    group by sigungu, sido
    )   b,
    (
    select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='KFC'
    group by sigungu, sido
    ) c, 
    (
        select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='롯데리아'
    group by sigungu, sido      
    ) d 
    where
    a.sido = b.sido
    and a.sigungu = b.sigungu
    and a.sido = c.sido
    and a.sigungu = c.sigungu
    and a.sido = d.sido
    and a.sigungu = d.sigungu
    order by result desc;
    
    
    
    
--------------------------------------------------------------------------------------------------------------

--nvl사용
select a.sido, a.SIGUNGU,a.cnt, b.cnt, c.cnt, d.cnt, TRUNC((nvl(a.cnt,0)+nvl(b.cnt,0)+nvl(c.cnt,0)) / nvl(d.cnt,0), 1)  as result
from
    (select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='맥도날드'
    group by sigungu, sido
    ) a,
    ( select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='버거킹'
    group by sigungu, sido
    )   b,
    (
    select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='KFC'
    group by sigungu, sido
    ) c, 
    (
        select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='롯데리아'
    group by sigungu, sido      
    ) d 
    where
    a.sido = b.sido(+)
    and a.sigungu = b.sigungu(+)
    and a.sido = c.sido(+)
    and a.sigungu = c.sigungu(+)
    and a.sido = d.sido(+)
    and a.sigungu = d.sigungu
    order by result desc;

----------------------------------------------------------------------
--대전지역 한정
-- 버거킹, 맥도날드, kfc개수
select GB, SIDO, SIGUNGU
from fastfood
where sido like '%대전%'
and gb in('버거킹', '맥도날드', 'KFC')
ORDER BY GB, SIDO, SIGUNGU;

SELECT GB,SIDO, SIGUNGU, COUNT(*)
FROM FASTFOOD
WHERE SIDO LIKE '%대전%'
AND GB IN('롯데리아')
GROUP BY GB,SIDO, SIGUNGU;

    
    select a.sido, a.sigungu, a.cnt kmb, b.cnt , round(a.cnt/b.cnt, 2) point
    from
            (SELECT SIDO, SIGUNGU,  count(*) cnt
            FROM FASTFOOD
            WHERE GB IN('맥도날드', '버거킹', 'KFC')
            GROUP BY SIDO, SIGUNGU) a
            ,
            (SELECT SIDO, SIGUNGU, count(*) cnt
            FROM FASTFOOD
            WHERE GB IN('롯데리아')
            GROUP BY SIDO, SIGUNGU )b
    where a.sido = b.sido and a.sigungu = b.sigungu
    ;

select *
from tax;

select sido, sigungu,sal, round(sal/people,2) point
from tax
--order by point desc;
order by sal desc;


-- 버거지수 시도, 시군구 | 연말정산 시고 시군구
-- 서울시 중구 5.7, 경기도 수원시 
-- 시도, 시군구, 버거지수, 연말정산, 납입액
select *
from fastfood;

select *
from tax;

select sido, sigungu,sal, round(sal/people,2) point
from tax
--order by point desc;
order by sal desc;

select fast.sido, fast.sigungu, fast.point b, tax.sido, tax.sigungu, tax.point t,sal
from (select a.sido, a.sigungu, a.cnt kmb, b.cnt , round(a.cnt/b.cnt, 2) point
    from
            (SELECT SIDO, SIGUNGU,  count(*) cnt
            FROM FASTFOOD
            WHERE GB IN('맥도날드', '버거킹', 'KFC')
            GROUP BY SIDO, SIGUNGU) a
            ,
            (SELECT SIDO, SIGUNGU, count(*) cnt
            FROM FASTFOOD
            WHERE GB IN('롯데리아')
            GROUP BY SIDO, SIGUNGU )b
    where a.sido = b.sido and a.sigungu = b.sigungu) fast, 
    
   ( select sido, sigungu,sal, round(sal/people,2) point
from tax
--order by point desc;
order by sal desc) tax
where fast.sido = tax.sido and fast.sigungu = tax.sigungu
order by sal desc;


select a. *, a.rank, b.*, b.rank_2
from
(select   a. *, rownum rank
from(select a.sido, a.sigungu, a.cnt kmb, b.cnt , round(a.cnt/b.cnt, 2) point
    from
            (SELECT SIDO, SIGUNGU,  count(*) cnt
            FROM FASTFOOD
            WHERE GB IN('맥도날드', '버거킹', 'KFC')
            GROUP BY SIDO, SIGUNGU) a
            ,
            (SELECT SIDO, SIGUNGU, count(*) cnt
            FROM FASTFOOD
            WHERE GB IN('롯데리아')
            GROUP BY SIDO, SIGUNGU )b
    where a.sido = b.sido and a.sigungu = b.sigungu) a
    order by point) a ,
    
   ( select b.* ,rownum rank_2
    from
   ( select sido, sigungu,sal, round(sal/people,2) point
    from tax
    --order by point desc;
    order by sal desc) b) b

   where a.rank = b.rank_2;
   ---------------------------------------------------------------------------------------------
   
   
   
   
   
   
   
   
   
   ---------------------------------------------------------------------------------------------
select *
from emp_test;
drop table emp_test;
-- 테이블 제거

--MULTIPLE INSERT 를 위한 테스트 테이블 생성
-- EMPNO, ENAME 두개의 컬럼을 갖는 EMP_TEST, EMP_TEST2테이블을 
--EMP테이블로부터 생성한다.(CTAS를 이용)
--데이터는 복제하지 않는다.

CREATE TABLE emp_test AS ;
CREATE TABLE emp_test2 as
SELECT empno, ename
FROM emp
WHERE 1=2;

--insert all
-- 하나늬 insert sql문장으로 여러 테이블에 데이터를 입력
insert all
    INTO emp_test
    into emp_test2
    select 1, 'brown' from dual union all
    select 2, 'sally' from dual ;
    
--insert all 컬럼 정의
rollback;

insert all
    into emp_test (empno) values (empno)
    into emp_test2 values (empno, ename)
    select 1 empno, 'brown' ename from dual union all
    select 2 empno, 'sally' eanme from dual;
  
--     into emp_test (empno) values (empno)
--    into emp_test2 values (empno, ename)

insert into emp_test(empno)
select 1, empno from dual union all
select 2 empno from dual;




    
select *
from emp_test;
select *
from emp_test2;
rollback;


--multiple insert (conditional insert)
insert all
    when empno <10 then
        into emp_test (empno) values (empno)
    else -- 조건을 통과하지 못할때만 실행
        into emp_test2 values (empno, ename)
        select 20 empno, 'brown' ename from dual union all
        select 2 empno, 'sally' eanme from dual;
        
select 1 as empno, 'brown' as ename from dual
union all -- 중복제거, 속도보장
select 2 empno,'sally' as ename from dual;

rollback;

--insert first
--조건에 만족하는 첫번째 insert 구문만 실행
insert first
    when empno >10 then
        into emp_test (empno) values (empno)
    when empno > 5 then 
        into emp_test2 values (empno, ename)
        select 20 empno, 'brown' ename from dual;
        
select *
from emp_test;

select *
from emp_test2;


--merge : 조건에 만족하는 데이터가 있으면update
--          : 조건에 만족하는 데이터가 없으면 insert
rollback;



-- empno가 7369인 데이터를 emp테이블로부터 emp_test테이블에 복사(insert)
insert into emp_test 
select empno, ename
from emp
where empno=7369;

select *
from emp_test;

--emp테이블의 데이터 중 emp_test테이블의 empno와 같은 값을 갖는 데이터가 있을 경우
-- emp_test.ename =ename || '_merge' 값으로 update
-- 데이터가 없을 경우에는 emp_test테이블에 insert


alter table emp_test modify(ename varchar2(20));
merge into emp_test
using (select empno, ename
            from emp
            where emp.empno in(7369,7499) )
on(emp.empno = emp_test.empno and  emp.empno in(7369,7499) )
when matched then
 update set ename = emp.ename || '_merge'
 when not matched then
    insert values(emp.empno, emp.ename);

select *
from emp_test;


-- 다른 테이블을 통하지 않고 테이블 자체의 조재 유무로 
-- merge하는 경우

rollback;

--empno =1, ename = 'brown'
--empno가 같은 값이 있으면 ename을 'brown'으로 update
--empno가 같은 값이 없으면 신규 insert

merge into emp_test
using dual
on(emp_test.empno =1)
when matched then
    update set ename = 'brown' || '_merge'
    when not matched then insert values (1, 'brown');
    
    select *
    from emp_test;
    
-- 처음에 값이 없으면 brown이 들어가고 이미 값이 있으면 brown_merge가 된다.
update emp_test set eanme = 'brown'||'_merge'
where empno=1;

insert into emp_test values (1, 'brown');


select *
from emp;

----♠실습 group by실습 1)


select deptno, sum(sal)
from emp
group by deptno

union all

select null, sum(sal)
from emp;


--위 쿼리를 rollup형태로 변경

select deptno,sum(sal) sal
from emp
group by rollup(deptno);



--rollup
--group by의 서브그룹을 생성
-- group by rollup({col,....})
-- 컬럼을 오른쪽에서부터 제거해가면서 나온 서브그룹을  group by 하여 union한 것과 동일
-- ex :     GROUP BY ROLLUP (JOB, DEPTNO)
-- GROUP BY JOB, DEPTNO
--UNION
-- GROUP BY JOB
-- UNION
-- GROUP BY => 총계 (모든 행에 대해서 그룹함수 적용)

SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);


--GROUPING SETS (COL1, COL2....)
--GROUPTING SETS의 나열된 항목이 하나의 서브그룹으로 GROUP BY 절에 이용된다.

--GROUP BY COLL
--UNION ALL
-- GROUP BY COL2

--EMP 테이블을 이용하여 부서별 급여합과, 담당업무(JOB)별 급여합을 구하시오.

SELECT DEPTNO,NULL JOB,  SUM(SAL)
FROM EMP
GROUP BY DEPTNO

UNION ALL

SELECT NULL,JOB, SUM(SAL)
FROM EMP
GROUP BY JOB;

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB,(DEPTNO, JOB));

