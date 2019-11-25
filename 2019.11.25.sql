--member 테이블을 이용하여 member2 테이블을 생성
--member2 테이블에서 김은대 회원(mem_id='a001')의 직업(mem_job)을 '군인'으로 변경 후 commit하고 조회

select *
from member;
------------------------------------
CREATE table member2 as 
select *
from member;
------------------------------------
select *
from member2;
-----------------------------------
update member2 set mem_job = '군인'
where mem_id = 'a001';
commit;
-----------------------------------
select mem_id, mem_name, mem_job
from member2;


--제품별 제품 구매 수량(buy_qty) 합계, 제품 구입(buy_cost) 금액 합계
-- 제품코드,제품명 ,수량합계, 금액합계
select *
from buyprod;

select buy_prod, buy_qty,  buy_cost, prod_name
from 
(select buy_prod, sum(buy_qty) buy_qty, sum(buy_cost) buy_cost
from buyprod
group by buy_prod)a, prod b
where a.buy_prod = b.prod_id;




select *
from prod
where prod_id ='P302000015';

select *
from prod;

--vw_prod_buy(view생성)
create  or replace view vw_prod_buy as
select buy_prod, buy_qty,  buy_cost, prod_name
from 
(select buy_prod, sum(buy_qty) buy_qty, sum(buy_cost) buy_cost
from buyprod
group by buy_prod)a, prod b
where a.buy_prod = b.prod_id;



select *
from vw_prod_buy;

select *
from user_views;

select *
from emp;

select ename,sal, deptno
from emp
order by deptno;


select ename, sal, deptno, rownum rn
from 
(select ename, sal, deptno
from emp
where deptno = 10
order by sal desc);

select ename, sal, deptno, rownum rn
from 
(select ename, sal, deptno
from emp
where deptno = 20
order by sal desc);

select ename, sal, deptno, rownum rn
from 
(select ename, sal, deptno
from emp
where deptno = 30
order by sal desc);


-----------------------------------------------------


select *
from emp
order by deptno;

select *
from dept;


select ename, sal, deptno, rownum sal_rank
from
(select ename, sal,a.deptno 
from emp a join dept b on(a.deptno = b.deptno)
order by a.deptno);

--부서별 랭킹

(select ename, sal, deptno
from emp
order by deptno, sal desc) ;

(select a.deptno, b.rn
from
(select deptno, count(*) cnt
from emp
group by deptno)a,
(select rownum rn
from emp) b
where a.cnt>=b.rn
order by a.deptno, b.rn;


















select a.ename, a.sal, a.deptno, b.rn
from

(select a.ename, a.sal, a.deptno, rownum j_rn
from
(select ename, sal, deptno
from emp
order by deptno, sal desc) a)a,

natural join

(select b.rn, rownum j_rn
from
(select a.deptno, b.rn
from
(select deptno, count(*) cnt
from emp
group by deptno)a,
(select rownum rn
from emp) b
where a.cnt>=b.rn
order by a.deptno, b.rn)b)b
where a.j_rn =b.j_rn;


--부서별 랭크

SELECT a.ename, a.sal, a.deptno, b.rn
FROM
    (SELECT a.ename, a.sal, a.deptno, ROWNUM j_rn
     FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC) a ) a, 
(SELECT b.rn, ROWNUM j_rn
FROM 
(SELECT a.deptno, b.rn 
 FROM
    (SELECT deptno, COUNT(*) cnt --3, 5, 6
     FROM emp
     GROUP BY deptno )a,
    (SELECT ROWNUM rn --1~14
     FROM emp) b
WHERE  a.cnt >= b.rn
ORDER BY a.deptno, b.rn ) b ) b
WHERE a.j_rn = b.j_rn;
------------------------------------------------------------------------------



------------------------------------------------------------------------------
-- 위에와 같은 결과로 나옴
select ename, sal, deptno,
row_number() over(partition by deptno order by sal desc) rank
from emp;
------------------------------------------------------------------------------



------------------------------------------------------------------------------

