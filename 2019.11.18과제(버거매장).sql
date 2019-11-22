select *
from fastfood;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='�Ƶ�����'
group by sigungu, sido;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='����ŷ'
group by sigungu, sido;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='KFC'
group by sigungu, sido;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='�Ե�����'
group by sigungu, sido;


select a.sido, a.SIGUNGU,a.cnt, b.cnt, c.cnt, d.cnt, TRUNC((a.cnt+b.cnt+c.cnt) / d.cnt , 1)  as result
from
    (select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='�Ƶ�����'
    group by sigungu, sido
    ) a,
    ( select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='����ŷ'
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
    where gb ='�Ե�����'
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

--nvl���
select a.sido, a.SIGUNGU,a.cnt, b.cnt, c.cnt, d.cnt, TRUNC((nvl(a.cnt,0)+nvl(b.cnt,0)+nvl(c.cnt,0)) / nvl(d.cnt,0), 1)  as result
from
    (select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='�Ƶ�����'
    group by sigungu, sido
    ) a,
    ( select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='����ŷ'
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
    where gb ='�Ե�����'
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
--�������� ����
-- ����ŷ, �Ƶ�����, kfc����
select GB, SIDO, SIGUNGU
from fastfood
where sido like '%����%'
and gb in('����ŷ', '�Ƶ�����', 'KFC')
ORDER BY GB, SIDO, SIGUNGU;

SELECT GB,SIDO, SIGUNGU, COUNT(*)
FROM FASTFOOD
WHERE SIDO LIKE '%����%'
AND GB IN('�Ե�����')
GROUP BY GB,SIDO, SIGUNGU;

    
    select a.sido, a.sigungu, a.cnt kmb, b.cnt , round(a.cnt/b.cnt, 2) point
    from
            (SELECT SIDO, SIGUNGU,  count(*) cnt
            FROM FASTFOOD
            WHERE GB IN('�Ƶ�����', '����ŷ', 'KFC')
            GROUP BY SIDO, SIGUNGU) a
            ,
            (SELECT SIDO, SIGUNGU, count(*) cnt
            FROM FASTFOOD
            WHERE GB IN('�Ե�����')
            GROUP BY SIDO, SIGUNGU )b
    where a.sido = b.sido and a.sigungu = b.sigungu
    ;

select *
from tax;

select sido, sigungu,sal, round(sal/people,2) point
from tax
--order by point desc;
order by sal desc;


-- �������� �õ�, �ñ��� | �������� �ð� �ñ���
-- ����� �߱� 5.7, ��⵵ ������ 
-- �õ�, �ñ���, ��������, ��������, ���Ծ�
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
            WHERE GB IN('�Ƶ�����', '����ŷ', 'KFC')
            GROUP BY SIDO, SIGUNGU) a
            ,
            (SELECT SIDO, SIGUNGU, count(*) cnt
            FROM FASTFOOD
            WHERE GB IN('�Ե�����')
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
            WHERE GB IN('�Ƶ�����', '����ŷ', 'KFC')
            GROUP BY SIDO, SIGUNGU) a
            ,
            (SELECT SIDO, SIGUNGU, count(*) cnt
            FROM FASTFOOD
            WHERE GB IN('�Ե�����')
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
-- ���̺� ����

--MULTIPLE INSERT �� ���� �׽�Ʈ ���̺� ����
-- EMPNO, ENAME �ΰ��� �÷��� ���� EMP_TEST, EMP_TEST2���̺��� 
--EMP���̺�κ��� �����Ѵ�.(CTAS�� �̿�)
--�����ʹ� �������� �ʴ´�.

CREATE TABLE emp_test AS ;
CREATE TABLE emp_test2 as
SELECT empno, ename
FROM emp
WHERE 1=2;

--insert all
-- �ϳ��� insert sql�������� ���� ���̺� �����͸� �Է�
insert all
    INTO emp_test
    into emp_test2
    select 1, 'brown' from dual union all
    select 2, 'sally' from dual ;
    
--insert all �÷� ����
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
    else -- ������ ������� ���Ҷ��� ����
        into emp_test2 values (empno, ename)
        select 20 empno, 'brown' ename from dual union all
        select 2 empno, 'sally' eanme from dual;
        
select 1 as empno, 'brown' as ename from dual
union all -- �ߺ�����, �ӵ�����
select 2 empno,'sally' as ename from dual;

rollback;

--insert first
--���ǿ� �����ϴ� ù��° insert ������ ����
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


--merge : ���ǿ� �����ϴ� �����Ͱ� ������update
--          : ���ǿ� �����ϴ� �����Ͱ� ������ insert
rollback;



-- empno�� 7369�� �����͸� emp���̺�κ��� emp_test���̺� ����(insert)
insert into emp_test 
select empno, ename
from emp
where empno=7369;

select *
from emp_test;

--emp���̺��� ������ �� emp_test���̺��� empno�� ���� ���� ���� �����Ͱ� ���� ���
-- emp_test.ename =ename || '_merge' ������ update
-- �����Ͱ� ���� ��쿡�� emp_test���̺� insert


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


-- �ٸ� ���̺��� ������ �ʰ� ���̺� ��ü�� ���� ������ 
-- merge�ϴ� ���

rollback;

--empno =1, ename = 'brown'
--empno�� ���� ���� ������ ename�� 'brown'���� update
--empno�� ���� ���� ������ �ű� insert

merge into emp_test
using dual
on(emp_test.empno =1)
when matched then
    update set ename = 'brown' || '_merge'
    when not matched then insert values (1, 'brown');
    
    select *
    from emp_test;
    
-- ó���� ���� ������ brown�� ���� �̹� ���� ������ brown_merge�� �ȴ�.
update emp_test set eanme = 'brown'||'_merge'
where empno=1;

insert into emp_test values (1, 'brown');


select *
from emp;

----���ǽ� group by�ǽ� 1)


select deptno, sum(sal)
from emp
group by deptno

union all

select null, sum(sal)
from emp;


--�� ������ rollup���·� ����

select deptno,sum(sal) sal
from emp
group by rollup(deptno);



--rollup
--group by�� ����׷��� ����
-- group by rollup({col,....})
-- �÷��� �����ʿ������� �����ذ��鼭 ���� ����׷���  group by �Ͽ� union�� �Ͱ� ����
-- ex :     GROUP BY ROLLUP (JOB, DEPTNO)
-- GROUP BY JOB, DEPTNO
--UNION
-- GROUP BY JOB
-- UNION
-- GROUP BY => �Ѱ� (��� �࿡ ���ؼ� �׷��Լ� ����)

SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);


--GROUPING SETS (COL1, COL2....)
--GROUPTING SETS�� ������ �׸��� �ϳ��� ����׷����� GROUP BY ���� �̿�ȴ�.

--GROUP BY COLL
--UNION ALL
-- GROUP BY COL2

--EMP ���̺��� �̿��Ͽ� �μ��� �޿��հ�, ������(JOB)�� �޿����� ���Ͻÿ�.

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

