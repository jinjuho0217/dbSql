--�׷��Լ�
-- multi row function : �������� ���� �Է����� �ϳ��� ��� ���� ����
-- SUM, MAX, MIN, AVG, COUNT
-- GROUP BY col | express
-- SELECT ������ GROUP BY ���� ����� COL, EXPRESSǥ�Ⱑ��

-- ���� �� ���� ���� �޿� ��ȸ
-- 14���� ���� �Է����� �� �ϳ��� ����� ����
SELECT MAX(SAL) max_sal
FROM emp;

-- �μ����� ���� ���� �޿� ��ȸ
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;

--���ǽ� FUNCTION NULL�ǽ� fn2)
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
-------------------------------------------������
ACCOUNTING	5000	    1300	    2916.67	    8750	    3  	2	3
RESEARCH	    3000	    800	    2175	        10875	5	5	5
SALES	        2850	    950	    1566.67	    9400	    6	6	6
---------------------------------------------

--���ǽ� FUNCTION NULL�ǽ� fn3)
SELECT TO_CHAR (hiredate,'YYYY/MM'), 
            count(hiredate) cnt
FROM emp
group by TO_CHAR (hiredate,'YYYY/MM');
----------������
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


--���ǽ� FUNCTION NULL�ǽ� fn4)
SELECT TO_CHAR (hiredate,'YYYY') hdate, 
            count(hiredate) cnt
FROM emp
group by TO_CHAR (hiredate,'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');
---------������
1980	    1
1981	    10
1982	    2
1983	    1
----------

--���ǽ� FUNCTION NULL�ǽ� fn5)
select count(deptno) cnt
from dept;

SELECT  distinct deptno
FROM   emp;
�̸�       ��?       ����           
-------- -------- ------------ ������
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    

--JOIN
--emp ���̺��� dname �÷��� ����. --> �μ���ȣ(deptno)�ۿ� ����
desc emp;

ALTER TABLE    emp  ADD(dname VARCHAR2(14)); --> emp ���̺� dname�÷� �߰�
�̸�       ��?       ����           
-------- -------- ------------ ������
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
----------------------------------------------������
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

ALTER TABLE   emp   DROP COLUMN DNAME; -- �ش� �÷��� �����Ѵ�.

SELECT *
FROM EMP;

--ansi natural join : �����ϴ� ���̺��� �÷����� ���� �÷��� �������� JOIN

SELECT DEPTNO, ENAME, DNAME
FROM EMP NATURAL JOIN DEPT;

--ORACLE JOIN
SELECT e.empno, e.deptno, d.dname, d.loc --���ϴ� �÷��� ������ �� �� �ִ�.
FROM emp e, dept d -- �ڿ� ��Ī�� �ָ� ��Ī���� �ҷ��� ���� �ִ�.
WHERE e.deptno = d.deptno;

SELECT emp.empno, emp.deptno, dept.dname, dept.loc 
FROM emp, dept 
WHERE emp.deptno = dept.deptno;



SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept  USING( deptno); --> ansi ����

--form���� ���� ��� ���̺� ����
-- where���� �������� ���
-- ������ ����ϴ� ���� ���൵ �������
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--job�� salesman�� ����� ������� ��ȸ  : ansi, orcle���� �� �� �˾ƾ� �ȴ�.
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE EMP.deptno = dept.deptno and emp.job = 'SALESMAN';--> orcle ����


SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.job = 'SALESMAN' and  EMP.deptno = dept.deptno; -- ������ ��� �� ���� ������ �������

--JOIN with ON (�����ڰ� ���� �÷��� ON���� ���� ���)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--self join : ���� ���̺��� �����ϴ� ��
--emp���̺��� mgr ������ �����ϱ� ���ؼ� emp ���̺�� ������ �ؾ��Ѵ�.
-- A : ���� ���� , B : ������
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
---------------------------������
7654	MARTIN	7698	7698	BLAKE
7521	WARD    	7698	7698	BLAKE
7499	ALLEN	7698	7698	BLAKE
7698	BLAKE	7839	7839	KING
7566	JONES	    7839	7839	KING
7369	SMITH	    7902	7902	FORD
------------------------------

--non-equijoing(��� ������ �ƴ� ���)
SELECT *
FROM salgrade;

--������ �޿� �����(���� �÷��� ����)?

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

SELECT emp.ename, emp.empno, dept.deptno, dept.dname -- oracle : ansi���� join�� ���� where���� ����
FROM emp,dept
WHERE emp.deptno = dept.deptno;

SELECT emp.ename, emp.empno, dept.deptno, dept.dname -- ansi : from���� join�� ��
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.empno = 7369; -- join������ ������� �ʾ� ������ ��� ����� ���� ���ͼ� 14���� ���´�.

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE b.empno = 7369; -- join������ ������� �ʾ� ������ ��� ����� ���� ���ͼ� 14���� ���´�.

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.empno = 7369 and b.empno = 7369; -- join������ ������� �ʾ� ������ ��� ����� ���� ���ͼ� 14���� ���´�.

--���ǽ� FUNCTION NULL�ǽ� fn6)
SELECT*
FROM emp;
SELECT*
FROM dept;

SELECT empno, ename, deptno, dname 
FROM emp join dept using(deptno); -- join, using ansi���� ����ϴ� �Ű� using ���� ���ؼ� ���� �÷��� ���� �� ���

select *
from salgrade;


select empno, ename, deptno, loc
from emp natural join dept;-- ��� �÷��� �����

