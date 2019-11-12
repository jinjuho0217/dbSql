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
                    where pid = product.pid and cid =1);

delete dept where deptno=99;
-- ���� ������ �ϸ� �ݿ����� �ʴ´� commit�� �ؾ� Ȯ�ǽ� �ȴ�.
commit;

insert into dept
values(99, 'DDIT', 'daehjeon');

rollback;

insert into customer
values(99, 'ddit');


--DML(insert)
-- 

insert into emp (empno, ename, job)
values ('brown', null);

select *
from emp
where empno = 9999;

rollback;



-- ���� ��¥ ��ȸ
select sysdate
from dual;

desc emp;
EMPNO        NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    

select *
from user_tab_columns
where table_name = 'EMP'  -- ã�� ���̺��� �빮�ڷ� �ۼ��� �ؾ� ���´�.
order by column_id;

insert into emp
values (9999, 'OLIVE', 'ranger', null, sysdate, 2500, null, 40);
rollback;

select *
from emp;
insert into emp
values (9999, 'OLIVE', 'ranger', null, sysdate, 2500, null, 40);

-- select���(������)


insert into emp (empno, ename)
select deptno, dname
from dept;

select *
from emp;
commit;


--DML(update)
-- UPDATE ���̺� SET�÷�-��, �÷�-��......
-- WHERE condition

select*
from dept;

update dept set dname ='���IT', loc ='ym'
where deptno =99; -- where���� �Ⱦ��� ��� dept�ȿ� �ִ� �����Ͱ� update�ϱ�� �� �����ͷ� �ٲ��.


--DML(delete)
-- �� ��ü�� ����

select *
from emp;
--delete ���̺��
--where condition

--�����ȣ�� 9999�� ������ emp���̺� ����
DELETE emp
WHERE empno=9999;

-- �μ����̺��� �̿��ؼ� emp���̺� �Է��� 5�� �� ������ ����
-- 10,20,30,40 => empno <100, empno between 10 and 99

delete emp
where empno < 100;
rollback;

delete emp
where empno between 10 and 99;

select *
from emp
where empno between 10 and 99;

delete emp
where empno in(select deptno from dept);

select *
from emp
where empno in(select deptno from dept);

commit;

--truncate : �α׸� ������ �ʾ� �ӵ��� ����, �α׸� ������ �ʾ� ������ �ȵ�


--LV1 -> LV3, �ٸ� DBMS������ ���Ƿ� �����ϴ� ���� �����ϴ�.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


--DML������ ���� Ʈ����� ����
Insert into dept
values(99, 'DDIT', 'daehjeon');

SELECT *
FROM dept;

--DDL(CREAT) : COMMIT, ROLLBACK�� �ȵ�
-- ���̺����

    CREATE TABLE ranger_new (
    ranger_no NUMBER, -- ����Ÿ�� 
    ranger_name VARCHAR2(50), -- ����Ÿ��: [VARCHAR2(������ ������� ����)], CHAR(������ ������� ������ ����)
    reg_dt DATE DEFAULT SYSDATE -- DEFAULT : SYSDATE
    );
desc ranger_new;

insert into ranger_new (ranger_no, ranger_name)
values(1000,'brown');

select *
from ranger_new;

commit;

--��¥ Ÿ�Կ��� Ư�� �ʵ� ��������
--ex : sysdate���� �⵵�� ��������
SELECT TO_CHAR(sysdate, 'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt, 
        TO_CHAR(reg_dt, 'MM')
FROM ranger_new;

SELECT ranger_no, ranger_name, reg_dt, 
        TO_CHAR(reg_dt, 'MM'),
        EXTRACT(MONTH FROM reg_dt) mm,
        EXTRACT(YEAR FROM reg_dt) year,
        EXTRACT(DAY FROM reg_dt)  day
FROM ranger_new;


-- ��������
--DEPT ����ؼ� DEPT_TEST����

CREATE TABLE dept_test(
    deptno number(2) PRIMARY KEY ,-- DEPTNO�÷��� �ĺ��ڷ� ����
    dname varchar2(14),                 -- �ĺ��ڷ� ������ �Ǹ� ���� �ߺ��� �� �� ������, NULL�� �� ����.
    loc varchar2(13)
);

DESC dept_test;

--primary key���� ���� Ȯ��
-- 1.deptno �÷���  null�� �� �� ����.
--2. deptno�÷��� �ߺ��� ���� �� �� ����.

-- 1.deptno �÷���  null�� �� �� ����.
insert into dept_test( deptno, dname, loc)
values (null, 'ddit', 'deajeon');

-- 2. deptno�÷��� �ߺ��� ���� �� �� ����.
insert into dept_test values (1, 'ddit1', 'deajeon');
insert into dept_test values (1, 'ddit2', 'deajeon');

rollback;

-- ����� ���� �������Ǹ��� �ο��� primary key
drop table dept_test;

create table dept_test(
    deptno number(2) constraint pk_dept_test primary key, -- constraint �ڿ����� pk_dept_test�� ���̺��� �������ǿ� ���� �̸�
    dname varchar(14),
    loc varchar(13)
    );
desc dept_test;

select *
from dept_test;



-- TABLE CONSTRAINT
 drop table dept_test;
 
 create table dept_test(
     deptno number(2),
     dname varchar(14),
     loc varchar(13),
    
     constraint pk_dept_test primary key (deptno, dname)
    );


insert into dept_test values (1, 'ddit1', 'deajeon');
insert into dept_test values (1, 'ddit2', 'deajeon');

select *
from dept_test;
ROLLBACK;

-- NOT NULL
DROP TABLE dept_test;

create table dept_test(
     deptno number(2) primary key,
     dname varchar(14) not null,
     loc varchar(13)
 );
 -- ���� �������� not null�� �ɾ null���� �� ��
 insert into dept_test values(1, 'ddit1', 'deajeon');
 insert into dept_test values(1, null, 'deajeon');
 
 
 --unique
 DROP TABLE dept_test;

create table dept_test(
     deptno number(2) primary key,
     dname varchar(14) unique,
     loc varchar(13)
 );
 -- ���������� unique�� �ɾ���� ������ ���� ���� ���� ����.
 insert into dept_test values(1, 'ddit', 'deajeon');
 insert into dept_test values(1, 'ddit', 'deajeon');
 
 
 rollback;
 
 
 
 