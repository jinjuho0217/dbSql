select ename, sal, deptno,
row_number() over(partition by deptno order by sal desc) rank
from emp;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
select *
from emp;

--RANK : ���ϰ��� ���ϼ���(1���� 2���̸� ������ 3��)
select ename, sal, deptno, RANK()OVER (PARTITION BY deptno order by sal) rank
from emp;
--DENSE_RANK :  ���ϰ��� ���ϼ���(1���� 2���̸� ������ 2��)
select ename, sal, deptno, DENSE_RANK()OVER (PARTITION BY deptno order by sal) rank
from emp;
--ROW_NUMBER : ���ϰ��̶� ������ ������ �ο�
select ename, sal, deptno, ROW_NUMBER()OVER (PARTITION BY deptno order by sal) rank
from emp;
-- PARTITION BY�� ��� ��

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--���ǽ� WINDOW�Լ�  �ǽ� 1)
SELECT *
FROM EMP;
-- ����� ���� ��� ���� ������ �ַ���(ORDER BY SAL DESC, EMPNO)�̷������� , �ڿ� ���� ������ �Ǵ� ������ ����θ� �ȴ�.
SELECT ENAME, SAL, EMPNO, ROW_NUMBER() OVER(ORDER BY SAL DESC, EMPNO) row_number,
                    RANK() OVER(ORDER BY SAL DESC, EMPNO) rank,
                    DENSE_RANK() OVER( ORDER BY SAL DESC, EMPNO) dense_rank
FROM EMP;

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--���ǽ� WINDOW�Լ�  �ǽ� 2)

select  b.empno, b.ename, b.deptno,a.cnt
from
        (select deptno, count(*) cnt  from emp  group by deptno) a 
    join
        (select empno, ename, deptno  from emp) b  on(a.deptno = b.deptno)
order by deptno;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--�м��Լ��� ���� �μ��� ������(COUNT)
select ename, empno, deptno /*,cnt*/
        , COUNT(*) OVER (partition by deptno) cnt
from emp;

--�μ��� ����� �޿� �հ�
--SUM �м��Լ�
select ename, empno, deptno,SAL
        , SUM(SAL) OVER (partition by deptno) SUM_SAL
from emp;

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--���ǽ� WINDOW�Լ�  �ǽ� 2)
-- ROUND����� �Ҽ��� ���° �ڸ��������� �Է��ϱ� round(avg(sal)over (partition by deptno),2) --> �Ҽ��� 2��° �ڸ�
-- GROUP BY�� ��쿡�� �׳� AVG������ ����ϸ�ǰ�, WINDOW�Լ����� OVER (PARTITION BY)���� ����ؾ� �Ѵ�.
select *
from emp;


select empno, ename, sal, deptno, round(avg(sal)over (partition by deptno),2) avg_sal
from emp;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--���ǽ� WINDOW�Լ�  �ǽ� 3)
select empno, ename, sal, deptno
            , max(sal) over (partition by deptno) max_sal
            , min(sal) over (partition by deptno)min_sal
from emp;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------


-- �μ��� �����ȣ�� ���� ���� ���
-- �μ��� �����ȣ�� ���� ���� ���
select empno, deptno
from emp
order by deptno;
-- ��Ȯ���ؾߵ�
select empno, ename, deptno
        ,first_value(empno) over(partition by deptno order by empno) f_emp,
        last_value(empno) over(partition by deptno ) l_emp
from emp;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--LAG(������)
-- ������
--LEAD(������)
--�޿��� ���� ������ ���� ������ �ڱ⺸�� �Ѵܰ� �޿��� ���� ����� �޿�, 
--�޿��� ���� ������ ���� ������ �ڱ⺸�� �Ѵܰ� �޿��� ���� ����� �޿�, 

SELECT empno, ename, sal, LAG(sal) OVER (ORDER BY sal) lag_sal,
                                    LEAD(sal) OVER (ORDER BY sal) lead_sal
from emp;

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--���ǽ� WINDOW�Լ�  �ǽ� 5)
select empno, ename, hiredate, sal, lead(sal) over(order by sal desc, hiredate)lead_sal
from emp;


------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--���ǽ� WINDOW�Լ�  �ǽ� 6)
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
-- UNBOUNDED PRECEDING : ���� ���� �������� �����ϴ� ��� �� - �ڱ���غ��� �޿��� ������
-- CURRENT ROW : ������
-- UNBOUNDED FOLLOWING : ���� ���� �������� �����ϴ� ��� �� - �ڱ���غ��� �޿��� ������
-- N(����) PRECEDING : ���� ���� �������� �����ϴ� N���� ��
-- N(����) FOLLOWING : ���� ���� �������� �����ϴ� N���� ��

SELECT empno, ename, sal
    ,sum(sal) over(order by sal, empno 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)sum_sal
    
     ,sum(sal) over(order by sal, empno 
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)sum_sal2

   ,sum(sal) over(order by sal, empno 
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)sum_sal3 -- �ڽ��� �����ϴ� ��� �����ϴ� ���� ���Ѱ�

FROM emp;

------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
--���ǽ� WINDOW�Լ�  �ǽ� 7)
SELECT EMPNO, ENAME, DEPTNO, SAL
            ,SUM(sal) OVER(
                PARTITION BY deptno order by sal, empno 
                ROWS BETWEEN UNBOUNDED PRECEDING AND
                CURRENT ROW)c_sal            
FROM EMP;

SELECT EMPNO, ENAME, DEPTNO, SAL
            ,SUM(sal) OVER(
                PARTITION BY deptno order by sal, empno 
                )c_sal            --ROWS BETWEEN UNBOUNDED PRECEDING AND  CURRENT ROW �� DEFUALT���̿��� ��� ����� ����
               
FROM EMP;
------------------------------------------------------------------------------------





------------------------------------------------------------------------------------

SELECT EMPNO, ENAME, DEPTNO, SAL,
    SUM(SAL) OVER (ORDER BY SAL 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) row_sum,
    
    
    SUM(SAL) OVER (ORDER BY SAL 
    ROWS UNBOUNDED PRECEDING) row_sum, -- ���� ������ ����� ���´�. between�� ���� �ʾƵ� �ڱ�������� ������ �ȴ�, rows�� ���� ���� ��� �ٸ� ������ �ν�
    
    
    SUM(SAL) OVER (ORDER BY SAL 
    range BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) row_sum, -- �ߺ����� ����� �������� ���� �޶���, range�� ���� ���� ��� ���� ������ �ν�
    
    
    SUM(SAL) OVER (ORDER BY SAL 
    range UNBOUNDED PRECEDING) row_sum 



FROM emp;




