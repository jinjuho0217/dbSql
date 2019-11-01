--����
--WHERE
--������
--�� : =, !=, <>, >=,
--BETWEEN start    AND    end
-- IN (set)
--LIKE 'S%; (% : �ټ��� ���ڿ��� ��Ī, _ : ��Ȯ�� �ѱ��� ��Ī)
-- IS NULL�� (!=NULL => X )
--AND, OR, NOT

--emp ���̺��� �Ի����ڰ� 1981�� 6�� 1�� ���� 1986�� 12�� 31�� ���� ���� ���� ��������
SELECT *
FROM emp
--WHERE  hiredate BETWEEN TO_DATE('1981/06/01') AND TO_DATE('1986/12/31');
WHERE hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD') AND hiredate <=TO_DATE('1986/12/31', 'YYYY/MM/DD');

--emp ���̺��� ������ (mgr)�� �ִ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IS NOT null;

--���ǽ� AND OR WHERE12)
SELECT *
FROM emp
WHERE job IN('SALESMAN') OR empno LIKE('78%');


--���ǽ� AND OR WHERE13)
-- LIKE�Ⱦ���
--empno : 78, 780, 789,.,,,,,,,
SELECT *
FROM emp
WHERE job IN('SALESMAN') OR empno BETWEEN(7800) AND(7899) OR empno BETWEEN(780) AND(789) OR empno IN(78);

--���ǽ� AND OR WHERE14) �������� �켱������ �����ؼ� ( )�� �����ش�.
SELECT *
FROM emp
WHERE job IN('SALESMAN') OR ( empno LIKE('78%') AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD') );

--order by �÷��� | ��Ī | �÷��ε��� [ASC |DESC]
-- ASC : ��������(�⺻) / DESC : ��������
-- order by ������ WHERE�� ������ ���
-- WHERE���� ���� ��� FROM�� ������ ���
--emp ���̺��� ename �������� �������� ����

SELECT *
FROM emp
ORDER BY ename ASC; 
-- ASC : default
--ASC�� �Ⱥٿ��� �� ������ ������ ����� ����

--�̸�(ename)�� �������� ��������
SELECT *
FROM emp
ORDER BY ename DESC;

--job�� �������� ������������ ����, ���� job�� ���� ��� ���(empno)���� �ø����� ����
SELECT *
FROM emp
ORDER BY job DESC, empno ASC;

--��Ī���� �����ϱ�
--��� ��ȣ(empno), �����(ename), ����(sal *12) as year_sal
-- year_sal ��Ī���� �������� ����
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT�� �÷� ���� �ε����� ����
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY 4; -- �÷������� ���� �ʰ� �ε��� ��ȣ�� �Է��ص� ���� ����� ����

--���ǽ� ORDER BY orderby1)
SELECT *
FROM dept
ORDER BY dname ASC;

SELECT *
FROM dept
ORDER BY loc DESC;

--���ǽ� ORDER BY orderby2)
SELECT *
FROM emp
WHERE comm IS NOT NULL
ORDER BY comm DESC, empno ASC;

--���ǽ� ORDER BY orderby3)
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job ASC, empno DESC;

--���ǽ� ORDER BY orderby4)
SELECT *
FROM emp
WHERE (deptno = 10  OR deptno = 30 )AND sal  > 1500
ORDER BY ename DESC;

desc emp;

SELECT  ROWNUM, empno, ename
FROM emp
--WHERE ROWNUM =2;-- 1�� ���� ����
--WHERE ROWNUM >10;-- �ȵ�(1~10���� ���� ����) �̹� ���� �����Ϳ� ������ �ο���
WHERE ROWNUM <=10;


--emp���̺��� ���(empno), �̸�(ename)�� �޿� �������� ������������ �����ϰ� ���ĵ� ��� ������ ROWNUM
SELECT empno, ename, sal , ROWNUM
FROM emp
ORDER BY sal;


-- a��� ��Ī�� �ְ� �ڿ� . �� ������� ���� ���� ����ȴ�.
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal 
FROM emp 
ORDER BY sal)a;

-- ���ǽ� ROWNUM row1)
SELECT ROWNUM, a.*
FROM
    (SELECT empno, ename , sal
    FROM emp
    ORDER BY sal)a
WHERE ROWNUM BETWEEN 1 AND 10;

-- ���ǽ� ROWNUM row2)
-- ROWNUM ������ �� ��Ī�� �༭ ����Ѵ�.
SELECT *
FROM
    (SELECT ROWNUM AA, a.*
        FROM
        (SELECT empno, ename , sal
        FROM emp
        ORDER BY sal)a
    WHERE ROWNUM BETWEEN 1 AND 20)b
WHERE AA BETWEEN 11 AND 14;

-- FUNCTION
--DUAL ���̺� ��ȸ
SELECT 'HELLO WORLD' AS msg
FROM DUAL;

SELECT 'HELLO WORLD' AS msg
FROM emp;

--���ڿ� ��ҹ��� ���� �Լ�
--LOWER, UPPER, INITCAP

SELECT LOWER('HELLO, WORLD'), UPPER('hello, world'), INITCAP('hello, world')
FROM emp
WHERE job = 'SALESMAN';

--FUNCTION�� WHERE�������� ��밡��
SELECT *
FROM emp
WHERE ename = UPPER('smith');


SELECT *
FROM emp
WHERE LOWER (ename) = ('smith');

--������ SQLĥ������
-- 1. �º��� �������� ���ƶ�
--�º� (TABLE�� �÷�)�� �����ϰ� �Ǹ� INDEX�� ���������� ������� ����
-- Function Based Index -> FBI

--CONCAT : ���ڿ� ���� - �� ���� ���ڿ��� �����ϴ� �Լ�
--SUBSTR : ���ڿ��� �κ� ���ڿ�(java : String. substring)
--LENGTH : ���ڿ��� ����
--INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù��° �ε���
--LPAD : ���ڿ��� Ư�� ���ڿ��� ����
SELECT CONCAT(CONCAT('HELLO', ', ') ,' WORLD') CONCAT,
            SUBSTR ('HELLO, WORLD', 0, 5)substr,
            SUBSTR ('HELLO, WORLD', 1, 5)substr1,
            LENGTH('HELLO, WORLD')  length,
            INSTR('HELLO, WORLD', 'O')instr,
            
            --INSTR(���ڿ�, ã�� ���ڿ�, ���ڿ��� Ư�� ��ġ ���� ǥ��)
            INSTR('HELLO, WORLD', 'O', 6)instr1, -- ���ڿ��� �ε���
            
            --LAPD(���ڿ�, ��ü���ڿ��� ����, ���ڿ��� ��ü���ڿ� ���̿� ��ġ�� ���Ұ�� �߰��� ����)
            LPAD('HELLO, WORLD', 15, '*'),
            LPAD('HELLO, WORLD', 15), -- ���ڶ� �κ��� ä������ Ư�����ڸ� ���� ������ �������� ǥ�ð� �ȴ�.
            RPAD('HELLO, WORLD', 15, '*' )
            
            
FROM DUAL;



