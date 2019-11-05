-- LAST_DAY(DATE) �ش� ��¥�� ���� ���� ������ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) LAST_DAY,
          LAST_DAY( ADD_MONTHS (SYSDATE, 1)) LAST_DAT_12
FROM dual;

-- ��� �Ķ���Ͱ� �־����� �� �ش����� �ϼ��� ���ϴ� ����
--201911--> 30/201912--> 31
-- �Ѵ� ���� �� �������� ���� �ϼ�
-- ������ ��¥ ���� �� --> DD�� ����

--SELECT TO_CHAR(LAST_DAY(TO_DATE('201911', 'YYYYMM')), 'DD')  day_cnt
SELECT :yyyymm as param, TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') dt -- ���ϴ� ���� ������ ��¥�� �� �� �ִ�.
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

SELECT  empno, ename, sal, TO_CHAR(sal, 'L000999,999.99') sal_fmt -- ����ǥ�ø� 9�� �Ѵ�.
FROM emp;

select * from nls_session_parameters
;

alter session set NLS_CURRENCY = '\';


--function null
--nvl(coll, null�� ��� ��ü�� ��)
SELECT empno, ename, sal, comm, nvl(comm, 0) nvl_comm,     -- comm�� null�̸� ���� 0�� ����
            sal + comm,
            sal +nvl(comm, 0),
            nvl(sal + comm, 0)
FROM emp;

--nvl2(coll, coll�� null�� �ƴҰ�� ǥ���Ǵ� ��, coll null�� ��� ǥ���Ǵ� ��)
SELECT empno, ename, sal, comm, nvl2(comm, comm, 0) + sal
FROM emp;

--NULLIF(exper1, exper2)
-- exper1 == exper2 ������ null
-- else : exper1

SELECT empno, sal, ename, comm, NULLIF(sal, 1250) -- �ΰ��� ���� ������ ������ null�� �����.
FROM emp;


--COALESCE(exper1, exper2, exper3....) , �ڹ��� �������� ������
-- �Լ� ���� �� null�� �ƴ� ù��° ����
SELECT empno, ename, sal, comm, coalesce(comm, sal)
FROM emp;

--���ǽ� FUNCTION NULL�ǽ� fn1)
SELECT empno, ename, mgr, coalesce(mgr, 9999) mgr_n, 
             nvl(mgr, 9999) mgr_n1, 
             nvl2(mgr, mgr, 9999) mgr_n2 -- ù��° ���ڰ� null�� �ƴҰ�� ǥ���Ǵ� ��
FROM emp;
-------------------------------���� ���
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

--���ǽ� FUNCTION NULL�ǽ� fn2)
SELECT userid, usernm, reg_dt, nvl(reg_dt, sysdate) N_REG_DT
FROM users;
-------------------------------- ������
brown	����	19/01/28	19/01/28
cony	�ڴ�	    19/01/28	19/01/28
sally	����	    19/01/28	19/01/28
james	���ӽ�	19/01/28	19/01/28
moon	��		     (null)         19/11/05
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
------------------------------------������
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

--���ǽ� FUNCTION condition �ǽ�1)
SELECT empno, ename,
        DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS', 'DDIT') DNAME
FROM EMP;
-------------------------������
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

--���ǽ� FUNCTION condition �ǽ�2)
-- �� �ؼ��� ¦���ΰ� Ȧ���ΰ�
-- 1. ���� ���� ���ϱ�(DATE --> TO_CHAR(DATE, FORMAT))
-- 2. ���� �⵵�� ¦������ ���
-- � ���� 2�� ������ �������� �׻� 2���� �۴�
-- 2�� ���� ��� �������� 0, 1
-- MOD(���, ������)
SELECT empno, ename, hiredate,
    decode(MOD(SUBSTR(hiredate, 0,2), 2),0, '�ǰ����� ������',1, '�ǰ����� �����')�ǰ�����,
FROM emp;

SELECT MOD(TO_CHAR(SYSDATE, 'YYYY'),2)
FROM DUAL;

-- EMP ���̺��� �Ի����ڰ� Ȧ���⵵ ���� ¦���⵵ ���� Ȯ��
SELECT empno, ename, hiredate, 
    case
        WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =  MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
            then '�ǰ����� ���'
            else '�ǰ����� ����'
        end concat_to_doctor
FROM emp;
----------------------������
7369	SMITH   	80/12/17	�ǰ����� ����
7499	ALLEN	81/02/20	�ǰ����� ���
7521	WARD    	81/02/22	�ǰ����� ���
7566	JONES	81/04/02	�ǰ����� ���
7654	MARTIN	81/09/28	�ǰ����� ���
7698	BLAKE	81/05/01	�ǰ����� ���
7782	CLARK	81/06/09	�ǰ����� ���
7788	SCOTT	82/12/09	�ǰ����� ����
7839	KING	    81/11/17	�ǰ����� ���
7844	TURNER	81/09/08	�ǰ����� ���
7876	ADAMS	83/01/12	�ǰ����� ���
7900	JAMES	81/12/03	�ǰ����� ���
7902	FORD    	81/12/03	�ǰ����� ���
7934	MILLER	82/01/23	�ǰ����� ����
------------------------------


--���ǽ� FUNCTION condition �ǽ�3)
SELECT userid, usernm, alias, reg_dt,
    case
        when MOD(TO_CHAR(reg_dt, 'YYYY'), 2) = MOD(TO_CHAR (SYSDATE, 'YYYY'), 2)
            THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
            END concat_to_doctor
FROM USERS;
----------------------------������
brown	����		19/01/28	�ǰ����� �����
cony	�ڴ�		    19/01/28	�ǰ����� �����
sally	����		    19/01/28	�ǰ����� �����
james	���ӽ�		19/01/28	�ǰ����� �����
moon	��			     (NULL)      �ǰ����� ������
-----------------------------

-- �׷��Լ�(AVG, MAX, MIN, SUM, COUNT)
-- �׷��Լ��� NULL���� ����󿡼� �����Ѵ�.
--SUM(COMM), COUNT(*), COUNT(MGR)
SELECT *
FROM emp;

--���� �� ���� ���� �޿��� �޴� ���
SELECT MAX(sal) max_sal
FROM emp;
--���� �� ���� ���� �޿��� �޴� ���
SELECT MIN(sal) min_sal
FROM emp;

SELECT empno, ename, sal
FROM emp
ORDER BY sal;

-- �μ��� ���� ���� �޿��� �޴� ����� �޷�
--  GROUP BY ���� ������� ���� �÷��� SELECT���� ����� ��� ����
SELECT deptno, MIN(ename), MAX(SAL) max_sal
FROM emp
GROUP BY deptno;

-- ������ �޿����, �Ҽ��� ��° �ڸ����� �ݿø�
SELECT MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(SAL), 2), SUM(SAL) SUM_SAL
FROM emp;

--������ ���� ī��Ʈ
SELECT MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(SAL), 2), SUM(SAL) SUM_SAL,
            COUNT(*) EMP_CNT, COUNT(SAL) SAL_CNT, COUNT(MGR) MGR_CNT
            , SUM(COMM) COMM_SUM
FROM emp;

SELECT deptno, MIN(ename), MAX(SAL) max_sal,ROUND(AVG(SAL), 2), SUM(SAL) SUM_SAL,
            COUNT(*) EMP_CNT, COUNT(SAL) SAL_CNT, COUNT(MGR) MGR_CNT
            , SUM(COMM) COMM_SUM
FROM emp
GROUP BY deptno;
-------------------------------------������
30	ALLEN	2850	1566.67	9400    	6	6	6	2200
20	ADAMS	3000	2175	    10875	5	5	5	(NULL)
10	CLARK	5000	2916.67	8750	    3	3	2	(NULL)
-------------------------------------


-- �μ��� �ִ� �޿�
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY   deptno
HAVING MAX(sal) > 3000;


--���ǽ� GROUP FUNCTION grp �ǽ�1)
SELECT max(sal) max_sal, 
            min(sal) min_sal, 
            round(avg(sal), 2) avg_sal, 
            sum(sal) sum_sal,
            count(sal) count_sal, 
            count(mgr) count_mgr,
            count(*) count_all
FROM emp;
----------------------------������
5000	800	2073.21	29025	14	    13  	14
----------------------------------

--���ǽ� GROUP FUNCTION grp �ǽ�2)
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

--------------------------------------������
30	    2850	    950	    1566.67	   9400	    6	6	6
20 	3000	    800	    2175	       10875	5	5	5
10 	5000	    1300	    2916.67	   8750	    3	2	3
---------------------------------------