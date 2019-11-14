--�������� Ȱ��ȭ/ ��Ȱ��ȭ
--�� ���������� Ȱ��ȭ (��Ȱ��ȭ) ��ų ���?

--emp fk����(dept���̺��� deptno�÷� ����)

----------------------------------------------------------------------------

-- FK_EMP_TEST_DEPT ��Ȱ��ȭ
alter table emp_test DISABLE constraint FK_EMP_TEST_DEPT;

-----------------------------------------------------------------------------





------------------------------------------------------------------------------
--�������ǿ� ����Ǵ� �����Ͱ� �� �� ����������?

insert into emp_test(empno, ename, deptno)
values(9999,'brown','80');


--FK_EMP_TEST_DEPT
alter table emp_test enable constraint FK_EMP_TEST_DEPT;

--�������ǿ� ����Ǵ� ������(�Ҽ� �μ���ȣ�� 80���� ������)�� �����Ͽ� �������� Ȱ��ȭ �Ұ�
delete emp
where empno = 9999;

--FK_EMP_TEST_DEPT
alter table emp_test enable constraint FK_EMP_TEST_DEPT;
commit;

select *
from emp_test;
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--���� ������ �����ϴ� ���̺� ��� view 
-- ���� ������ �����ϴ� �������� view : USER_CONSTRAINTS
-- ���� ������ �����ϴ� ���������� �÷�VIEW : USER_CONS_COLUMNS

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CYCLE';



SELECT *
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME ='PK_CYCLE';

--���̺� ������ ���� ����(VIEW ����)
--���̺�� / �������� �� / �÷��� / ������
SELECT a.table_name, a.constraint_name, b.column_name, b.position
FROM user_constraints a, user_cons_columns b
WHERE a.constraint_name = b.constraint_name
AND a.constraint_type = 'P'
ORDER BY a.table_name, b.position;

-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--emp���̺�� 8���� �÷� �ּ��ޱ�
--empno ename job mgr hiredate sal comm deptno


-- ���̺� �ּ� view : user_tab_comments

select *
from user_tab_comments
WHERE table_name = 'EMP';

-- emp���̺� �ּ�
COMMENT ON TABLE emp IS '���';

-- EMP���̺��� �÷� �ּ� Ȯ��
SELECT *
FROM user_col_comments
where table_name = 'EMP';

COMMENT ON COLUMN  emp.empno  IS '�����ȣ';
COMMENT ON COLUMN  emp.ename  IS '�̸�';
COMMENT ON COLUMN emp.job  IS '������';
COMMENT ON COLUMN  emp.mgr  IS '�����ڻ��';
COMMENT ON COLUMN  emp.hiredate  IS '�Ի�����';
COMMENT ON COLUMN  emp.sal  IS '�޿�';
COMMENT ON COLUMN  emp.comm  IS '��';
COMMENT ON COLUMN  emp.deptno  IS '�ҼӺμ���ȣ';
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--���ǽ� ���̺� comments �ǽ� 1)
--user_tab_comments, user_col_comments view�� �̿��Ͽ� customer, product, cycle, daily ���̺��
-- �÷��� �ּ� ������ ��ȸ�ϴ� ������ �ۼ��϶�
select *
from user_tab_comments;

select *
from user_col_comments;

select a.table_name, table_type, a.comments tab_comments, column_name,b.comments col_comments
from user_col_comments a join user_tab_comments b on(a.table_name = b.table_name)
where a.table_name in('CUSTOMER','CYCLE','DAILY','PRODUCT');

-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--view ����(emp���̺��� sal, comm �� �� �÷��� �����Ѵ�.)

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename,job, mgr, hiredate, deptno
FROM emp;

--VIEW(�� �ζ��κ�� �����ϴ�)
SELECT *
FROM v_emp;


--INLINE VIEW
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
            FROM emp
            );
            
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--���ε� ���� ����� view�� ���� : v_emp_dept
-- emp, dept : �μ���, �����ȣ, �����, ������, �Ի�����

CREATE OR REPLACE VIEW v_emp_dept AS -- VIEW����� ��
SELECT a.dname, b.empno, b.ename, b.job, b.hiredate
FROM dept a , emp b
where a.deptno = b.deptno;

SELECT *
FROM v_emp_dept;
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--VIEW ����

DROP VIEW v_emp;

-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--VIEW�� �����ϴ� ���̺��� �����͸� �����ϸ� VIEW���� ������ ����.
--dept 30 = sales
SELECT *
FROM v_emp_dept;

--dept���̺��� sales --> MARKET SALES

UPDATE dept SET dname = 'MARKET SALES'
WHERE deptno =30;
rollback;
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--HR�������� v_emp_dept VIEW ��ȸ������ �ش�.
GRANT SELECT ON v_emp_dept TO hr;
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--SEQUENCE ����(�Խñۿ� �ο��ϴ� ������) 

CREATE SEQUENCE seq_post
INCREMENT BY 1
START WITH 1;

-- �Խñ�
SELECT seq_post.nextval
FROM dual;
-- ���� �����Ѵ�.

-- �Խñ� ÷������
SELECT seq_post.currval
FROM dual;
-- ������ �������� ����� sequence���� �ҷ��´�.

select *
from post
where reg_id = 'brown'
and title = '������ ����ִ�.'
and reg_dt = TO_DATE('2019/11/14/ 15:40:15', 'YYYY/MM/DD HH24:MI:SS');

SELECT *
FROM POST
WHERE post_id =1;
-- SEQUENCE�� ���־��� �����ϸ� ��
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--INDEX
--ROWID : ���̺� ���� ������ �ּ�, �ش� �ּҸ� �˸�
-- ������ ���̺� �����ϴ� ���� �����ϴ�.
-- ���� ��ġ�� �ʴ´�.
SELECT product. * , rowid
FROM PRODUCT
where rowid = 'AAAFL4AAFAAAAFOAAB'; 
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--������ ����
-- sequence : �ߺ����� �ʴ� ���� ���� ���� ���ִ� ��ü
-- 1,2,3,4,5,.....

--������ ���� ����� ���
-- key table , UUID, sequence



desc emp_test;

drop table emp_test;

create table emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(15)
);

create sequence seq_emp_test; -- sequence��ü �����

INSERT INTO emp_test 
VALUES(/*�ߺ����� �ʴ� �� ->*/seq_emp_test.nextval , 'BROWN'); -- �����ϸ� ��� 1�྿ ������

SELECT *
FROM emp_test;

-- sequence�� rollback�� �ȵ� rollback�� �����ϰ� �ٽ� �����ϸ� ���� ����Ǵ� �κк��� �̾ ������

-------------------------------------------------------------------------------






-------------------------------------------------------------------------------

--�����ȹ�� ���� �ε��� ���Ȯ��
--EMP���̺� EMPNO�÷��� �������� �ε����� ���� ��

ALTER TABLE emp DROP CONSTRAINT pk_emp;

EXPLAIN PLAN FOR         -- �����ȹ ���¹�
SELECT *
FROM emp
WHERE EMPNO = 7369;

-- �ε����� ���� ������ EMPNO�� 7369�� �����͸� ã�� ���ؼ� EMP���̺��� ��ü�� ã�ƺ��� �Ѵ�. -> TABLE FULL SCAN

SELECT *
FROM TABLE(dbms_xplan.display); 
-- ����Ŭ�� ��� ���� �Ǿ����� ������
-- �����ȹ�� ������ �Ʒ������� �а� 
-- �ڽĿ��� �θ� ������ �д´� ���� �����ȹ�� ���� ��� 1���� 0�� ������ �д´�.
-- ��, ���� ���̰� ������ ������ �Ʒ� ������ �а�, ���� ���̰� �ٸ��� ���̰� ������ �� ���� �д´�.


--------------------------------------------------------------------������
Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    37 |     3   (0)| 00:00:01 |         --> ���� ���̰� �ٸ���� ���̰� �� ���� �󺧺��� �д´�.
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    37 |     3   (0)| 00:00:01 |      --> ���� ���̰� ���� ���� ������ �Ʒ� ������ �д´�.
 --  * ǥ�ô�
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369) --> index�� ��� ���̺� ��ü�� ���� // index�� ���� ���(primary key, unique���� ���� ���)���� filter�̰� index�� ������(primary key, unique���� �ִ� ���) access�� ǥ�õ�
------------------------------------------------------------------------------