--unique table level constraint

drop table dept_test;

create table dept_test(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13),

-- constraint �������� �� constraint type[(�÷�....)]
    constraint uk_dept_test_dname unique (dname, loc)

);

insert into dept_test values (1,'ddit', 'daejeon');
-- ù��° ������ ���� danme, loc���� �ߺ��ǹǷ� �ι�° ������ ������� ���Ѵ�.
insert into dept_test values (2,'ddit', 'daejeon');

--foreign key(��������)
drop table dept_test;

create table dept_test(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13)
);
insert into dept_test values(1,'ddit','daejeon');
commit;

--emp_test(empno, ename, deptno)
desc emp;
    create table emp_test(
    empno number(4) primary key,
    ename varchar2(10),
    deptno number(2) REFERENCES dept_test(deptno)
);

--dept_test ���̺� 1�� �μ���ȣ�� �����ϰ�
--fk������ dept_test.deptno �÷��� �����ϵ��� �����Ͽ�
--1�� �̿��� �μ���ȣ�� emp_test���̺� �Է� �� �� ����.


--emp_test fk�׽�Ʈ insert
insert into emp_test values(9999, 'brown', 1);


--2�� �μ��� dept_test ���̺� �������� �ʴ� ������ �̱� ������
-- fk���࿡ ���� insert�� ���������� �������� ���Ѵ�.
insert into emp_test values(9998, 'sally', 2);

-- ���Ἲ ���࿡�� �߻��� �� �ؾߵɱ�?
-- �Է��Ϸ��� �ϴ� ���� �´°ǰ�?(2������ 1������)
-- , �θ����̺� ���� �� �Է¾ȵƴ��� Ȯ��(dept_test Ȯ��)

select *
from dept_test;
insert into dept_test values(1,'ddit','deajeon');

select *
from emp_test;
drop table emp_test;

-- fk���� table level constraint
    create table emp_test(
    empno number(4) primary key,
    ename varchar2(10),
    deptno number(2),
    constraint fk_emp_test_to_dept_test foreign key
    (deptno) REFERENCES dept_test(deptno)
);

select *
from emp_test;

-- fk������ �����Ϸ��� �����Ϸ��� �÷��� �ε����� �����Ǿ��־�� �Ѵ�.

drop table emp_test;
drop table dept_test;
-- drop�� �� ��� �ڽ����̺��� ������ �ڽ����̺���� ������ �ȴ�.


create table dept_test(
    deptno number(4), /*primary key -> uniqte ����X -> �ε��� ����X*/
    dname varchar2(10),
    loc varchar2(13) 
);

create table emp_test(
    empno number(4),
    ename varchar2(10),
    deptno number(2) REFERENCES dept_test(deptno)
);


create table dept_test(
    deptno number(4) primary key ,
    dname varchar2(10),
    loc varchar2(13) 
);

create table emp_test(
    empno number(4),
    ename varchar2(10),
    deptno number(2) REFERENCES dept_test(deptno)
);


insert into dept_test values (1,'ddit','daejean');
insert into emp_test values(9999, 'brown',1);
commit;

delete dept_test
where deptno=1;
-- ���Ἲ ���࿡ ���ؼ� ������ ���� �ʴ´�.

delete emp_test where empno=9999;

delete dept_test where deptno=1;
-- dept_test���̺��� deptno ���� �����ϴ� �����Ͱ� ���� ��� ������ �Ұ����ϴ�.
-- �� �ڽ����̺��� �����ϴ� �����Ͱ� ����� �θ����̺��� �����Ͱ� ������ �����ϴ�.

--fk����ɼ�
-- defualut : ������ �Է�/ ���� �� ���������� ó������� fk������ �������� �ʴ´�.
-- on delete cascade : �θ� ������ ������ �����ϴ� �ڽ� ���̺� ���� ����
-- on delete null : �θ� ������ ���� �� �����ϴ� �ڽ����̺� �� null
drop table emp_test;

  create table emp_test(
    empno number(4) primary key,
    ename varchar2(10),
    deptno number(2),
    constraint fk_emp_test_to_dept_test foreign key
    (deptno) REFERENCES dept_test(deptno) on delete cascade
);
select *
from dept_test;
insert into emp_test values (9999, 'brown', 1);

select *
from emp_test;
commit;

--fk ���� default �ɼǽÿ��� �θ� ���̺��� �����͸� �����ϱ� ���� �ڽ����̺��� �����ϴ� �����Ͱ� ����� ���������� ������ ��������
-- on delete cascade�� ��� ���� ���̺� ������ �����ϴ� �ڽ� ���̺��� �����͸� ���� �����Ѵ�.


--1. ���� ������ ���������� ����Ǵ���>
--2. �ڽ� ���̺� �����Ͱ� ���� �Ǿ�����?
delete dept_test -- ���� ������ ���������� ����Ǵ���?
where deptno=1;

select *
from emp_test;





------------------------------------------------------------------------------------------------------

--fk���� on delete set null
drop table emp_test;

  create table emp_test(
    empno number(4) primary key,
    ename varchar2(10),
    deptno number(2),
    constraint fk_emp_test_to_dept_test foreign key
    (deptno) REFERENCES dept_test(deptno) on delete set null
);
select *
from dept_test;

insert into dept_test values (1,'ddit','daejean');
insert into emp_test values (9999, 'brown', 1);

select *
from emp_test;
commit;

--fk ���� default �ɼǽÿ��� �θ� ���̺��� �����͸� �����ϱ� ���� �ڽ����̺��� �����ϴ� �����Ͱ� ����� ���������� ������ ��������
-- on delete cascade�� ��� ���� ���̺� ������ �����ϴ� �ڽ� ���̺��� �����͸� ���� �����Ѵ�.
--���� �÷��� null�� �����Ѵ�.

--1. ���� ������ ���������� ����Ǵ���>
--2. �ڽ� ���̺� �����Ͱ� null �Ǿ�����?
delete dept_test -- ���� ������ ���������� ����Ǵ���?
where deptno=1;

select *
from emp_test;

--check���� : �÷��� ���� ������ ����, Ȥ�� ���� �����Բ� ����

create table emp_test(
    empno number(4),
    ename varchar2(10),
    sal number check(sal>=0)
    );
--sal  �÷��� check���� ���ǿ� ���� 0�̰ų�, 0���� ū ���� �Է��� �����ϴ�.
insert into emp_test values(9999, 'brown', 10000);
insert into emp_test values(9999, 'sally', -10000);

drop table emp_test;

create table emp_test(
    empno number(4),
    ename varchar2(10),
    -- emp_gb : 01 ������, 02 ����
    emp_gb varchar2(2) check(emp_gb in('01','02'))
    );
    
    insert into emp_test values(9999, 'brown', '01');
    -- emp_gb�÷� üũ���࿡ ���� 01, 02, �� �ƴ� ���� �Էµ� ������.
    insert into emp_test values(9999, 'sally', '03');
    
    select *
    from emp_test;
    
    --select ����� �̿��� table����
    --create table ���̺�� as 
    -- select ����
    -- ctas (create table as)
    
    drop table emp_test;
    drop table dept_test;
    
    --customer ���̺��� ����Ͽ� customer_test ���̺�� ����
    -- customer ���̺��� �����͵� ���� ����
create table customer_test as
select *
from customer;

select *
from customer;

create table test as
select sysdate dt
from dual;

select *
from test;

drop table test;

--�����ʹ� �������� �ʰ� Ư�� ���̺��� �÷� ���Ĥ��� ������ �� ����
drop table customer_test;
create table customer_test as
select *
from customer
where cid=99;

drop table customer_test;
create table customer_test as
select *
from customer
where 1 != 1;

create table test(
    c1 varchar2(2) check (c1 in ('01', '02'))
);

create table test2 as 
select *
from test;

drop table test2;












-----------------------------------------------------------
--���̺� ����
--���ο� �÷� �߰�

drop table emp_test;
create table emp_test(
empno number(4),
ename varchar2(10)
);

-- �ű� �÷� �߰�
alter table emp_test add (deptno number(2));
desc emp_test;

-- ���� �÷� ����
alter table emp_test modify (ename varchar2(200));
desc emp_test;

--���� �÷� ����(���̺� �����Ͱ� ���� ��Ȳ)
alter table emp_test modify (ename varchar2(200));
desc emp_test
alter table emp_test modify (ename number);

-- �����Ͱ� �ִ� ��Ȳ���� �÷� ���� : �������̴�.
insert into emp_test values(999,1000,10);
commit;
alter table emp_test modify(ename varchar2(10));

select *
from emp_test;
desc emp_test;

-- ������ Ÿ���� �����ϱ� ���ؼ��� �÷� ���� ��� �־�� �Ѵ�.
alter table emp_test modify(ename varchar2(10));
-----------------------------------------------------------







-----------------------------------------------------------
--default ����
desc emp_test;
alter table emp_test modify(deptno default 10);

drop table emp_test;
-----------------------------------------------------------






-----------------------------------------------------------
-- �÷��� ����
alter table emp_test rename column deptno to dno;

desc emp_test;
select dno
from emp_test;

-- �÷� ����(drop)
alter table emp_test drop column dno;
--alter table emp_test drop (dno); ���� ó�� column�� �Ⱦ��� ()�ȿ� �־��൵ ���� ����� ���´�.
    
desc emp_test;
-----------------------------------------------------------







-----------------------------------------------------------
-- ���̺� ���� : �������� �߰�
-- primary key
alter table emp_test add constraint pk_emp_test primary key(empno);

--�������� ����
alter table emp_test drop constraint pk_emp_test;

-- unique ���� -> empno
alter table emp_test add constraint uk_emp_test unique(empno);

-- unique ����  ����-> empno
alter table emp_test drop constraint uk_emp_test;
-----------------------------------------------------------






-----------------------------------------------------------
--FOREIGN KEY �߰�
-- �ǽ�
-- dept ���̺��� deptno�÷����� primary key ������ ���̺� ����
-- ddl�� ��ֻ���

-- emp ���̺��� deptno�÷����� primary key������ ���̺� ����
-- ddl�� ���� ����

-- emp���̺��� deptno�÷����� dept���̺��� deptno�÷��� 
-- �����ϴ� fk������ ���̺� ���� ddl�� ���� ����
DESC dept_test;
drop table dept_test;

create table dept_test(
    deptno number(4),
    dname varchar2(10),
    loc varchar2(13) 
);

-- dept ���̺��� deptno�÷����� primary key ������ ���̺� ����
alter table dept add constraint uk_dept_test primary key(deptno);
alter table dept_test add constraint pk_dept_test primary key(deptno);

desc emp_test;

alter table emp_test add (deptno number(2)); -- �÷��߰�

alter table emp_test add constraint pk_emp_test primary key(deptno);

-------------------------------------------------------------------------------
--3.emp ���̺��� deptno �÷����� dept���̺��� deptno�÷��� �����ϴ� fk������ ���̺� ���� DDL�� ���� ����

alter table emp add constraint fk_emp_dept foreign key(deptno)
references dept(deptno); -- �����ϴ� �ٸ� ���̺� ���� ���� ��

-------------------------------------------------------------------------------
-- emp_test-> dept.deptno fk ���� ���� (alter table)
drop table emp_test;
create table emp_test(
    empno number(4),
    ename varchar2(10),
    deptno number(2) 
);

desc emp_test;
alter table emp_test add constraint fk_emp_test_dept foreign key(deptno) REFERENCES dept(deptno);
             /* �� ���̺��� �÷� �̸��� ���Ƶ� ������ Ÿ���� �ٸ��� FK ���������� ������ �� ����.
              ������ VARCHAR2 Ÿ���̰�, ������ NUMBER Ÿ���̶� ������ų�� ����.*/

-------------------------------------------------------------------------------
desc emp_test;
desc dept;

select *
from dept;

select *
from emp_test;




-------------------------------------------------------------------------------
--check ���� �߰�(ename ���� üũ, ���̰� 3���� �̻�)
alter table emp_test add constraint check_ename_len CHECK (length(ename) > 3);

insert into emp_test values (9999, 'brown',10);
insert into emp_test values (9998, 'br',10);
-- check���� ����
alter table emp_test drop constraint check_ename_len;

-------------------------------------------------------------------------------





-------------------------------------------------------------------------------
-- not null ���� �߰�
alter table emp_test modify (ename not null);

-- not null ���� ������ ����(null ���)
alter table emp_test modify (ename null);
-------------------------------------------------------------------------------