----���ǽ� FUNCTION NULL�ǽ� fn6)
--SELECT*
--FROM emp;
--SELECT*
--FROM dept;
--
--SELECT empno, ename, deptno, dname 
--FROM emp join dept using(deptno); -- join, using ansi���� ����ϴ� �Ű� using ���� ���ؼ� ���� �÷��� ���� �� ���
--
--select *
--from salgrade;

--select empno, ename, deptno, loc
--from emp natural join dept;-- ��� �÷��� �����

-- ���� on
--SELECT emp.ename, emp.empno, dept.deptno, dept.dname -- ansi : from���� join�� ��
--FROM emp JOIN dept ON(emp.deptno = dept.deptno);

-- emp���̺��� �μ���ȣ(deptno)�� ����
--emp ���̺��� �μ����� ��ȸ�ϱ� ���ؼ��� dept ���̺�� ������ ���� �μ��� ��ȸ

--join ���� 
    -- ansi : ���̺� join���̺� 2 on(���̺�.COL = ���̺�2.COL)
        --emp JOIN dept ON (emp.deptno = dept.deptno)

    --ORACLE : FROM ���̺�, ���̺�2 WHERE ���̺�.COL = ���̺�2.COL
--          FROM emp, dept  where emp.deptno -dept.deptno


----------------------------------------------------------

--�����ȣ, �����, �μ���ȣ, �μ���
SELECT empno, ename, deptno, dname
FROM emp natural join dept;

select empno, ename, emp.deptno, dname
from emp, dept
where emp.deptno = dept.deptno;

select *
from emp;
select *
from dept;

----���ǽ� JOIN�ǽ� 2)
SELECT empno, ename, sal, deptno, dname
FROM  emp natural join dept
where sal>2500;
---------------------------������
7566	JONES	    2975	20	RESEARCH
7698	BLAKE	2850	30	SALES
7788	SCOTT	3000	20	RESEARCH
7839	KING	    5000	10	ACCOUNTING
7902	FORD	    3000	20	RESEARCH
----------------------------



select empno, ename, sal, emp.deptno, dname
from emp, dept
where emp.deptno = dept.deptno and sal>2500;
---------------------------������
7566	JONES	    2975	20	RESEARCH
7698	BLAKE	2850	30	SALES
7788	SCOTT	3000	20	RESEARCH
7839	KING	    5000	10	ACCOUNTING
7902	FORD	    3000	20	RESEARCH
----------------------------



----���ǽ� JOIN�ǽ� 3)

SELECT empno, ename, sal, deptno, dname
FROM emp natural join dept
where sal>2500 and empno>7600;
---------------------------������
7839	KING	    5000	10	ACCOUNTING
7902	FORD	    3000	20	RESEARCH
7788	SCOTT	3000	20	RESEARCH
7698	BLAKE	2850	30	SALES
---------------------------


SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
where emp.deptno = dept.deptno AND sal>2500 AND empno>7600;
---------------------------������
7839	KING	    5000	10	ACCOUNTING
7902	FORD	    3000	20	RESEARCH
7788	SCOTT	3000	20	RESEARCH
7698	BLAKE	2850	30	SALES
----------------------------



----���ǽ� JOIN�ǽ� 4)
SELECT empno, ename, sal, deptno, dname
FROM emp natural join dept
where sal > 2500 and empno>7600 and dname = 'RESEARCH';
----------------------------������
7788	SCOTT	3000	20	RESEARCH
7902	FORD	    3000	20	RESEARCH
-----------------------------


SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
where emp.deptno = dept.deptno AND sal>2500 AND empno>7600 AND DNAME = 'RESEARCH';
----------------------------������
7788	SCOTT	3000	20	RESEARCH
7902	FORD	    3000	20	RESEARCH
-----------------------------
select *
from lprod;
select *
from prod;

select *
from lprod natural join prod;

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM LPROD join PROD ON(lprod.lprod_gu = prod.prod_lgu);

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM LPROD natural join PROD
where lprod.lprod_gu = prod.prod_lgu;

select *
from prod;
select *
from  buyer;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod join buyer on(buyer_lgu=prod_lgu);



SELECT mem_id, mem_name, prod_id, prod_name, cart_qty 
FROM member, cart, prod
where cart_prod = prod_id and mem_id = cart_member;



SELECT mem_id, mem_name, prod_id, prod_name, cart_qty 
FROM member join cart natural join  prod on(cart_prod = prod_id and mem_id = cart_member);

SELECT CUSTOMER.CID, CNM, CYCLE.PID, DAY, CNT
FROM   customer JOIN cycle ON(CUSTOMER.CID = CYCLE.CID) JOIN product ON (PRODUCT.PID = CYCLE.PID)
WHERE cnm IN('sally', 'brown');

SELECT CUSTOMER.CID, CNM, CYCLE.PID, DAY, CNT, PNM
FROM   customer JOIN cycle ON(CUSTOMER.CID = CYCLE.CID) JOIN product ON (PRODUCT.PID = CYCLE.PID)
WHERE cnm IN('sally', 'brown');


SELECT CUSTOMER.CID, CNM, CYCLE.PID, PNM
FROM   customer JOIN cycle ON(CUSTOMER.CID = CYCLE.CID) JOIN product ON (PRODUCT.PID = CYCLE.PID);

--��, ��ǰ�� �����Ǽ�(���ϰ� �������)
with cycle_groupby as(
select cid, pid, sum(cnt)
from cycle
group by cid, pid )
select customer.cid, cnm, product.pid, pnm. cnt
from customer, cycle_groupby, product
where cycle_groupby.cid = customer.cid and cycle_groupby.pid = product.pid;

select customer.cid, cnm, cycle.pid, pnm, sum(cnt) cnt
from customer, cycle, product
where customer.cid = cycle.cid
and cycle.pid = product.pid
group by customer.cid, cnm, cycle.pid, pnm;

select  cycle.pid, pnm, sum(cnt) cnt
from cycle, product
where cycle.pid = product.pid 
group by cycle.pid, pnm
order by pid;
-------------������
100	����Ʈ	    9
200	��	            6
300	���۽�	        3
400	����Ʈ400	2
----------------

select  cycle.pid, cycle.cid, sum(cnt)
from cycle join product on(cycle.pid = product.pid) join customer on(cycle.cid = customer.cid)
group by cycle.pid, cycle.cid;