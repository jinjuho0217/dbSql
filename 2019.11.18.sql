select *
from user_views;

select *
from all_views
--�ٸ� ����ڷκ��� ������ �޾Ƽ� ���� ����
where owner = 'PC123';


SELECT *
FROM PC123.V_EMP_DEPT;
-- FROM �տ� �������� �ٿ���� ���δ�.

--PC123���� ��ȸ������ ���� V_EMP_DEPT view�� hr �������� ��ȸ�ϱ�
-- ���ؼ��� ������.view�̸� �������� ����� �ؾ��Ѵ�.
--�Ź� �������� ����ϱ� �������Ƿ� �ó���� ���� �ٸ� ��Ī���� ����

create synonym V_EMP_DEPT FOR PC123.V_EMP_DEPT;
-- �ó�� ����
--PC123.V_EMP_DEPT ==> V_EMP_DEPT

SELECT *
FROM V_EMP_DEPT;
-- ������ PC123�� ��Ī�� �־��� ������ �������� �����ؾ� ���������� ����

--�ó�� ����
-- DROP TABLQ ���̺��
-- DROP SYNONYM ���̺��;

DROP SYNONYM V_EMP_DEPT;


--HR ������ ��й�ȣ : JAVA
--HR ���� ��й�ȣ ���� : HR
ALTER USER HR IDENTIFIED BY HR;
ALTER USER PC123 IDENTIFIED BY JAVA; -- ���� ������ �ƴ϶� ����


--dictionary
-- ���ξ� : user : ����� ���� ��ü
--              all : ����ڰ� ��밡�� �� ��ü
--              dba : ������ ������ ��ü ��ü(�Ϲݻ���ڴ� ���Ұ�)
--              v$ : �ý��۰� ���õ� view (�Ϲݻ���ڴ� ���Ұ�)

select *
from user_tables;

select *
from all_tables;

select *
from dba_tables 
where owner in('PC123', 'HR'); -- system�������� ��ȸ����

-- ����Ŭ���� ������ SQL�̶�?
-- ���ڰ� �ϳ���� Ʋ���� �ȵ�
-- ����SQL���� ��������� �������� ���� ���� ���� �ٸ� DBMS������ 
-- ���� �ٸ� SQL�� �νĵȴ�.

SELECT /* bind_test */*
FROM EMP;

select /* bind_test */*
from emp;

Select /* bind_test */*
from emp;
-- ���ڰ� ���� �ٸ��� ������ ������ ���� ������ ���δٸ� sql�� �νĵȴ�.

Select /* bind_test */*
from emp
where empno=7369;

Select /* bind_test */*
from emp
where empno=7499;

Select /* bind_test */*
from emp
where empno=7521;


select *
from v$sql
where sql_text like '%emp%'; -- system���� �����ؾߵ�


select *
from v$sql
where sql_text like '%bind_test%'; -- system���� �����ؾߵ�

select *
from emp
where emp =:empno;