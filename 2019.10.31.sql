--���ں� ����
-- �μ���ȣ�� 30�� ���� ũ�ų� ���� �μ��� ���� ���� ��ȸ

SELECT *
FROM emp
WHERE deptno >=30;

SELECT *
FROM dept;

--�μ���ȣ�� 30������ ���� �μ��� ���� ���� ��ȸ

SELECT *
FROM emp
WHERE deptno < 30;

--�Ի����ڰ� 1982�� 1�� 1�� ������ ���� ��ȸ
SELECT *
FROM emp
--WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD'); --3��
--WHERE hiredate < TO_DATE('1982/01/01', 'YYYY/MM/DD'); --11��
--WHERE hiredate >= TO_DATE('01011982', 'MMDDYYYY'); --3��
WHERE hiredate < '82/01/01';--11��, hiredate�Ⱦ��� ���ڿ��ε� ��¥�� �����Ǵ� �� ������ �ٸ� ���� ����

--BETWEEN  X AND Y ����
--�÷��� ���� X���� ũ�ų� ����, Y���� �۰ų� ���� ������
--�޿�(sal)�� 1000���� ũ�ų� ����, y���� �۰ų� ���� �����͸� ��ȸ
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000; -- BETWEEN�� AND�� �� ���� ������

--���� BETWEEN AND �����ڴ� �Ʒ��� <=, >= ���հ� ����

SELECT *
FROM emp
WHERE sal >=1000 --1000�� �������� �������� BETWEEN���ٴ� �̷��� �ϴ°� ����.
AND  sal <= 2000
AND deptno = 30;
 
 --���ǽ� where1)
SELECT ename,hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01') AND TO_DATE('1983/01/01');
--WHERE hiredate BETWEEN '1982/01/01' AND '1983/01/01';

--���ǽ� where2)
SELECT ename, hiredate
FROM emp
WHERE hiredate > TO_DATE('1982/01/01', 'YYYY/MM/DD') AND hiredate < TO_DATE('1983/01/01', 'YYYY/MM/DD');


-- IN ������
-- COL IN (values...)
-- �μ���ȣ�� 10 Ȥ�� 20�� ���� ��ȸ

SELECT *
FROM emp
WHERE deptno In (10,20);

--IN �����ڴ� OR�����ڷ� ǥ���� �� �ִ�.
SELECT *
FROM emp
WHERE deptno =10 OR deptno =20;

--���ǽ� in1)
SELECT userid ���̵�, usernm �̸�
FROM users
--WHERE userid = 'brown' or userid = 'cony' or userid = 'sally';
WHERE userid IN('brown', 'cony','sally');

-- COL LIKE 'S%'
-- COL�� ���� �빮�� S�� �����ϴ� ��� ��
-- COL LIKE 'S____'(_4������)
--COL�� ���� �빮�� S�� �����ϰ� �̾ 4���� ���ڿ�(_)�� �����ϴ� ��

-- emp ���̺��� �����̸���s�� �����ϴ� ��� ���� ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';
--WHERE ename = 'SMITH';
--WHERE ename = 'smith';�� �ٸ�

SELECT *
FROM emp
WHERE ename LIKE 'S____';

--���ǽ� WHERE4)
SELECT  mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%'; --'��'���� �����ϴ� ��繮��

--���ǽ� WHERE5)
SELECT  mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%'; --'��'�� ���� ��� ����

-- NULL ��
-- COL IS NULL
-- EMP ���̺��� MGR������ ���� ���(NULL) ��ȸ
-- �ڹٿ��� ���� !=�� �ȵǰ� IS��� ����.

--���ǽ� IS NULL WHERE)
SELECT *
FROM emp
WHERE MGR IS NULL;

--���ǽ� IS NOT NULL WHERE6)
SELECT *
FROM emp
WHERE comm IS NOT NULL; -- NULL�� �ƴϴ� IS NOT NULL

--AND / OR
--������(mgr) ����� 7698�̰� �޿��� 1000�̻��� ���
SELECT *
FROM emp
WHERE mgr = 7698 AND sal >= 1000;

--emp ���̺��� ������(mgr) ����� 7698�̰ų� �޿���(sal)�� 1000 �̻��� ���� ��ȸ
SELECT *
FROM emp
WHERE mgr = 7698 OR sal >= 1000;


--emp���̺��� ������ (mgr) ����� 7698�� �ƴϰ�, 7839�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr NOT IN(7698,7839); -->  IN = OR

--���� ������ AND/OR �����ڷ� ��ȯ
SELECT *
FROM emp
WHERE mgr != 7698 AND mgr != 7839;

--IN , NOT IN�������� NULL ó��
-- emp ���̺��� ������(mgr) ����� 7698, 7839 �Ǵ� null�� �ƴ� ������ ��ȸ

SELECT *
FROM emp
WHERE mgr NOT IN(7698,7839) AND  mgr IS NOT NULL;


--���ǽ� AND OR WHERE7)
--DESC EMP; -- �������� Ÿ���� �� ������
SELECT *
FROM emp
WHERE job IN('SALESMAN') AND hiredate > TO_DATE('1981/06/01', 'YYYY/MM/DD');


--���ǽ� AND OR WHERE8)
SELECT *
FROM emp
WHERE deptno != 10 AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


--���ǽ� AND OR WHERE9)
SELECT *
FROM emp
WHERE deptno NOT IN (10) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--���ǽ� AND OR WHERE10)
SELECT *
FROM emp
WHERE deptno IN (20,30) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
--WHERE deptno IN (20,30) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD') AND deptno NOT IN(10);

--���ǽ� AND OR WHERE11)
SELECT *
FROM emp
WHERE job IN('SALESMAN') OR hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--���ǽ� AND OR WHERE12)
SELECT *
FROM emp
WHERE job IN('SALESMAN') OR empno LIKE('78%');



select user_id, usernm, reg_dt, reg_dt + 5
from users;
