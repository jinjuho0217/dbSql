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

-- ANY : SET �߿� �����ϴ°� �ϳ���� ������ ������ (ũ���)
-- SMITH, WARD �� ����� �޿����� ���� �޿��� �޴� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE sal < any (
        SELECT sal 
        FROM emp
        WHERE ename IN ('SMITH', 'WARD'));


-- SMITH�� WARD���� �޿��� ���� ���� ��ȸ
-- SMITH���ٵ� �޿��� ���� WARD���ٵ� �޿��� �������(AND)
SELECT *
FROM emp --> 1250���� �޿��� ���� ��� ��ȸ
WHERE sal > ALL (
        SELECT sal 
        FROM emp
        WHERE ename IN ('SMITH', 'WARD'));

-- NOT IN
SELECT mgr
FROM emp;

select *
from emp;

--�������� ��������
-- 1. �������� ����� ��ȸ
--  .mgr �÷��� ���� ������ ����
-- DISTINCT -> �ߺ�����
select DISTINCT mgr
from emp
order by mgr;

-- � ������ ������ ������ �ϴ� �������� ��ȸ
SELECT *
FROM emp
WHERE empno in(7566,7698,7782,7788,7839,7902);
-------------------------------------------������
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
-------------------------------------------������
7566	JONES	    MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7782	CLARK	MANAGER	7839	81/06/09	2450		10
7788	SCOTT	ANALYST	    7566	82/12/09	3000		20
7839	KING	    PRESIDENT		    81/11/17	5000		10
7902	FORD	    ANALYST	    7566	81/12/03	3000		20
---------------------------------------------

--�����ڰ� �ƴ� ����� ��ȸ
-- NULL ������ �ƹ����� ������ ����
SELECT *
FROM emp
 WHERE empno NOT IN(
 
    SELECT mgr
    FROM emp );


-- ������ ������ ���� �ʴ� ���� ���� ��ȸ
-- �� NOT IN ������ ���� NULL�� ���Ե� ��� ���������� �������� �ʴ´�.
-- NULL ó�� �Լ��� WHERE ���� ���� NULL���� ó���� �� ���
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
-- ��� 7499, 7782 �� ������ ������, �μ���ȣ ��ȸ
SELECT mgr, deptno
FROM emp
WHERE empno in(7499,7782);
----------������
7698	30
7839	10
---------
-- �����ڿ� �μ���ȣ��(7698,30) �̰ų� (7839,10)�� ��� mgr, deptno�÷��� <����>�� ������Ű�� �������� ��ȸ
-- (7839,10),(7698,30) 2������ ��츸
SELECT *
FROM emp
WHERE(mgr, deptno) in(
                                SELECT mgr, deptno
                                FROM emp
                                WHERE empno in(7499,7782));
                                

-- mgr���� deptno����
-- (7698,30), (7698,10), (6839,30), (7839,10) 4������ ���
SELECT *
FROM emp
WHERE mgr in(SELECT mgr
                             FROM emp
                               WHERE empno in(7499,7782))
and deptno in(SELECT deptno
                             FROM emp
                               WHERE empno in(7499,7782));

--SCALAR SUBQUERY : SELECT ���� �����ϴ� ���� ����(�� ���� �ϳ��� ��, �ϳ��� �÷�)
--������ �Ҽ� �μ����� JOIN�� ������� �ʰ� ��ȸ
SELECT empno, ename, deptno, (SELECT dname
                                          FROM dept
                                          WHERE deptno =emp.deptno) dname -- join�� ����� �� ���� �� ��� / emp.deptno ������ ���������� ��ȸ�� �Ұ����ϴ�. emp.deptno�� ������������ ���������
FROM emp;


SELECT dname
FROM dept
WHERE deptno =20;

--����4 ������ ����

INSERT INTO dept VALUES(99, 'ddit', 'daejeon');
COMMIT;

--���ǽ� ���� ���� �ǽ� 4)
SELECT *
FROM emp
order by deptno;

SELECT deptno, dname, loc
FROM dept
where deptno not in(10,20,30);      --emp���̺��� �����Ǹ� �Է��� ���� �����ؾߵǼ�
-----------------------������
99	    ddit	                    daejeon
40	    OPERATIONS	            BOSTON
---------------------------


SELECT deptno, dname, loc
FROM dept
where deptno not in(
                            select deptno
                            from emp);

-----------------------������
99	    ddit	                    daejeon
40	    OPERATIONS	            BOSTON
---------------------------


--���ǽ� ���� ���� �ǽ� 5)
select *
from cycle;

select *
from product;

select *
from customer;


-- not in �ȿ� �ִ� �� �ȿ� �ִ� �����̶� �ٸ��� / in �� �ȿ��ִ� �����̶� ��ġ�� ��(������ 2�� ���� ���� �ϳ��� ������ ������ ��µ�)
select pid, pnm
from product
where pid not in(select pid 
                        from cycle 
                        where cid = 1); 
                        
--���ǽ� ���� ���� �ǽ� 6)
select cid,pid
from cycle
where pid =100;


select *
from cycle
where pid in (select pid
                  from cycle
                  where pid =100) and cid =1;
------------������
1	100	6	1
1	100	4	1
1	100	2	1
------------                    

--���ǽ� ���� ���� �ǽ� 7)
select cycle.pid, day, cnt, cycle.cid, pnm, cnm
from cycle join product on(cycle.pid = product.pid) and join customer on(cycle.cid = customer.cid)
where pid in (select pid
                  from cycle
                  where pid =100) and cid =1;
                  
                  
--EXISTS MAIN������ �÷��� ����ؼ� SUBQUERY�� �����ϴ� ������ �ִ��� üũ
-- �����ϴ� ���� �ϳ��� �����ϸ� ���̻� �������� �ʰ� ���߱� ������ ���ɸ鿡�� ����

-- MGR�� �����ϴ� ���� ��ȸ
SELECT *
FROM emp a
WHERE EXISTS (SELECT 'X' 
                    FROM emp
                    WHERE empno = a.mgr);
                    
                    
                    
-- MGR�� �������� �ʴ� ���� ��ȸ
SELECT *
FROM emp a
WHERE NOT EXISTS (SELECT 'X' 
                    FROM emp
                    WHERE empno = a.mgr);
                    
                    
--���ǽ� ���� ���� �ǽ� 7)
-- �Ŵ����� �����ϴ� ���� ��ȸ
SELECT *
FROM emp
WHERE mgr is not null;

select *
from emp a
where exists(select 'x'
                from emp b
                where b.empno = a.mgr);
                
-- �μ��� �Ҽӵ� ������ �ִ� �μ� ���� ��ȸ
select *
from dept
where deptno in(10,20,30);

select *
from dept;

select *
from dept 
where exists(select 'x'
                    from emp
                    where deptno = dept.deptno); -- emp������ deptno�� dept���� deptno
-----------------------������
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
                    
                    
--���տ���
-- union : ������, �ߺ��� ����
--         : DBMS������ �ߺ��� �����ϱ� ���� �����͸� �����Ѵ�.
-- union all : union�� ���� ����, �ߺ��� �������� �ʰ� �� �Ʒ� ������ ���ո���
-- �� �Ʒ� �ߺ��� �����Ͱ� ���ٴ� ���� Ȯ���ϸ� ����Ѵ�.
-- union�����ں��� ���ɸ鿡�� ����



-- ����� 7566 �Ǵ� 7698�� ��� ��ȸ(����̶� �̸��� ��ȸ)
SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698;


-- ����� 7369. 7499�� ��� ��ȸ(���, �̸�)
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



--------------------�ߺ��� �����Ѵ�.
SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698
union
SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698;
-----------������
7566	JONES
7698	BLAKE
-----------

SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698
union all -- �ߺ��� �������� �ʴ´�.
SELECT empno, ename
FROM emp
WHERE empno = 7566 or empno = 7698;
----------������
7566	JONES
7698	BLAKE
7566	JONES
7698	BLAKE
----------

-- INTERSECT(������ : �� �Ʒ� ���� �� ���� ������)

SELECT empno, ename
FROM emp
WHERE empno IN( 7566 , 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN( 7566 ,7698, 7499);
------------------------------------
--MINUS(������ : �����տ��� �Ʒ������� ����)
-- ������ ����(���Ʒ� ������ ������ �ٲٸ� ����� �ٲ� �� ����)
SELECT empno, ename
FROM emp
WHERE empno IN( 7566 , 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN( 7566 ,7698, 7499);
---------������
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
---------������
7499	ALLEN
----------


SELECT *
FROM USER_CONSTRAINTS
WHERE OWNER = 'PC123'
AND TABLE_NAME IN('PROD', 'LPROD')
AND CONSTRAINT_TYPE IN ('P','R');



--���ǽ� ���� ���� �ǽ� 7)
-- join���� ���� cycle.pid�� product.pid�� ����, ������ customer.cid�� ������ ��

select a.cid,cnm,a.pid, pnm, day, cnt 
from 
(select cycle.pid, day, cnt, cycle.cid, pnm
from cycle join product on (cycle.pid = product.pid))a join customer on(a.cid = customer.cid)
where a.pid in (select a.pid
                  from cycle
                  where a.pid =100) and a.cid =1;


--���ǽ� ���� ���� �ǽ� 9)

select pid, pnm
from product
where not exists (select 'x'
                    from cycle
                    where pid = product.pid and cycle.cid =1);

                
select *
from cycle;

select *
from product;

