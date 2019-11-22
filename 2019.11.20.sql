--GROUPING (cube, rollup ���� ���� �÷�)
-- �ش礻�з��� �Ұ� ��꿡 ���� ��� 1
-- ������ ���� ��� 0

--job�÷�
--case1.  grouping(deptno)=1 and grouping(job) =1
--              job --> '�Ѱ�'
--case esle
--              job-->job
select case when grouping(job)=1 and
                            grouping(deptno) =1 then '�Ѱ�'
                else job
            end job, deptno,
         grouping(deptno),grouping(job), sum(sal) sal
from emp
group by rollup(job ,deptno);


--���ǽ� group function  �ǽ� 2)
SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

select case when grouping(job) = 1 and grouping(deptno) =1 then '�Ѱ�' 
    
            else job
            end job, 
            case when grouping(job) =0 and grouping(deptno) =1 then job || '�Ұ�'
            else to_char(deptno)
            end deptno
            ,deptno, sum(sal) sal
 from emp
group by rollup(job ,deptno);

------------------------------------------------------------------




------------------------------------------------------------------
--���ǽ� group function  �ǽ� 3)
select deptno,job,
         sum(sal) sal
from emp
group by rollup( deptno,job)
order by deptno;

------------------------------------------------------------------



------------------------------------------------------------------
--cube (col1,col2...)
-- cube ���� ������ �÷��� ������ ��� ���տ� ���� ���� �׷����� ����
-- cube�� ������ �÷��� ���� ���⼺�� ����(rollup���� ����)
--group by cube(job, deptno)
-- oo : group by job, deptno
-- ox : group by job
-- xo : deptno
-- xx : group by -- ��� ������

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

--emp���̺��� �����͸� �����ؼ� ��� �÷��� �̿��ϼ� emp_test���̺�� ����

create table emp_test as 
select *
from emp;


--emp_test���̺� dept���̺��� ������ �ִ� dname( VARCHAR2(14) )�÷��� �߰�
desc dept;

--�÷��߰�
alter table emp_test add (dname varchar2(14));

select *
from emp_test;

--emp_test���̺���  dname�÷��� dept���̺��� dname �÷� ������ ������Ʈ�ϴ� ����  �ۼ�
update emp_test set dname = (select dname from dept where dept.deptno = emp_test.deptno  );

------------------------------------------------------------------



------------------------------------------------------------------




--���ǽ� ��������  �ǽ� 3)
-- dept_test���̺� ����
--empcnt(number) �÷��߰�
-- ���������� �̿��Ͽ� dept_test���̺��� empcnt�÷��� �ش� �μ��� ���� update������ �ۼ�

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
                                    --= (SELECT COUNT(*) --���� ������ COUNT�Ѵ�.
                                        from emp 
                                        where dept_test.deptno = emp.deptno  );
-- �׷��Լ��� �ȿ� ���� ������ ��� ���� 0�� ���´�.



------------------------------------------------------------------



------------------------------------------------------------------

SELECT *
FROM DEPT_TEST;
INSERT INTO DEPT_TEST VALUES (98, 'IT', 'DAEJEON','0');
INSERT INTO DEPT_TEST VALUES (99, 'IT', 'DAEJEON','0');


update dept_test set empcnt = (select count(empno) 
                                    --= (SELECT COUNT(*) --���� ������ COUNT�Ѵ�.
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
--���ǽ� ��������  �ǽ� 3)

--update dept_test set empcnt = (select count(empno) 
--                                    --= (SELECT COUNT(*) --���� ������ COUNT�Ѵ�.
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

-- emp, emp_test empno�÷����� ���� ������ ��ȸ
-- 1��. emp.empno, emp.ename, emp.sal, emp_test.sal
-- 2��. emp.empno, emp.ename, emp.sal, emp_test.sal,
-- �ش� ���(emp���̺� ����)�� ���� �μ��� �޿����


select a.ename, b.ename, a.sal, b.sal, a.deptno
from emp a join emp_test b on(a.empno = b.empno)
order by deptno;









