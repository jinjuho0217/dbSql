--���� WHERE 11
--job�� SALESMAN�̰ų� �Ի����ڰ� 1981��6�� 01������ �������� ��ȸ
--�̰ų� -> OR
--1981�� 06�� 01�� ���� --> 1981 06 01 �����ؼ�

SELECT *
FROM emp
WHERE job ='SALESMAN' OR hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

DESC emp;


--ROWNUM
SELECT ROWNUM, E.*
FROM emp E;

--ROWNUM�� ���� ����
--ORDER BY���� SELECT �� ���Ŀ� ����
--ROWNUM �����÷��� ����ǰ� ���� ���ĵǱ� ������ �츮�� ���ϴ´�� ù��° �����ͺ��� �������� ��ȣ �ο������� �ʴ´�.
SELECT ROWNUM, E.*
FROM emp E
ORDER BY ename;


--ORDER BY���� ������ �ζ��� �並 ����
SELECT ROWNUM, AA.*
FROM 
    (SELECT e.*
    FROM emp e
    ORDER BY ename)AA;

--ROWNUM : 1������ �о�� �ȴ�.
-- WHERE���� ROWNUM���� �߰��� �д� ���� �Ұ���

-- �ȵǴ� ���̽�
-- WHERE ROWNUM =2
-- WHRER ROWNUM >=2

--�Ǵ� ���̽�
--WHERE ROWNUM =1 , =�� ����ؼ� �Ǵ� �� 1�� �ۿ� ����.
--WHERE ROWNUM <= 10

--����¡ ó���� ���� �ļ� ROWNUM�� ��Ī�� �ο�, �ش� SQL�� INLINE VIWE�� ���ΰ�
-- ��Ī�� ���� ����¡ ó��



SELECT *
FROM
(SELECT ROWNUM rn, AA.*
FROM 
    (SELECT e.*
    FROM emp e
    ORDER BY ename)AA)
    WHERE rn BETWEEN 10 AND 14;


--19�� 11�� 1��~4��    
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
            RPAD('HELLO, WORLD', 15, '*' ),
            --replace(�������ڿ�, ���� ���ڿ����� �����ϰ��� �ϴ� ��� ���ڿ�, ���� ���ڿ�)
          REPLACE (REPLACE('HELLO, WORLD', 'HELLO','hello'), 'WORLD', 'world')replace,
          -- trim �յ� ������ ������
          TRIM(' HELLO,  WORLD ') trim,
          -- H���ڿ��� ����
          TRIM('H' FROM 'HELLO,  WORLD')trim2
           
           
          
            
FROM DUAL;

--ROUND(������, �ݿø� ��� �ڸ���)
SELECT ROUND(105.54 , 1)r1,-- �Ҽ��� ��°�ڸ����� �ݿø�
            ROUND(105.55, 1)r2, -- �Ҽ��� ��°�ڸ����� �ݿø�
            ROUND(105.55, 0)r3, -- �Ҽ��� ù°�ڸ����� �ݿø�
            ROUND(105.55, -1)r4 -- ���� ù° �ڸ����� �ݿø�            
            
FROM dual;

SELECT TRUNC(105.54 , 1)t1,-- �Ҽ��� ��°�ڸ����� ����
            TRUNC(105.55, 1)t2, -- �Ҽ��� ��°�ڸ����� ����
            TRUNC(105.55, 0)t3, -- �Ҽ��� ù°�ڸ����� ����
            TRUNC(105.55, -1)t4 -- ���� ù° �ڸ����� ����            
            
FROM dual;
desc emp;
SELECT empno, ename, sal,sal/1000, ROUND (sal/1000)Quotient, 
    MOD(sal,1000) reminder--0~999 ������ ������ ���� �� �����
    --MOD : �������� ������ ��
FROM emp;

--SYSDATE : ����Ŭ�� ��ġ�� ������ ���� ��¥ �ð������� ����
-- ������ ���ڰ� ���� �Լ�

--TO_CHAR : DATE Ÿ���� ���ڿ��� ��ȯ
-- ��¥�� ���ڿ��� ��ȯ�ÿ� ������ ����

--SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
--SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH12:MI:SS')
SELECT TO_CHAR(SYSDATE + (1/24/60)*30, 'YYYY-MM-DD HH24:MI:SS'),
            TO_CHAR(SYSDATE, 'YYYY-MM-DD HH12:MI:SS')
FROM dual;

--���ǽ� FUNCTION DATE 1)
SELECT TO_CHAR(SYSDATE+57 , 'YYYY-MM-DD') AS LASTDAY,
    --TO_DATE('2019-12-31', 'YYYY-MM-DD'),
    TO_CHAR(SYSDATE+52, 'YYYY-MM-DD') AS LASTDAY_BEFORE5,
   -- TO_DATE('2019-12-31','YYYY-MM-DD' )-5,
    SYSDATE AS NOW,
    TO_CHAR(SYSDATE-3 , 'YYYY-MM-DD') AS NOW_BEFORE3
FROM dual;


SELECT LASTDAY, LASTDAY-5 AS LASTDAY_BEFORE5, NOW, NOW-3 NOT_BEFORE3
FROM
    (SELECT TO_DATE('2019-12-31','YYYY-MM-DD')LASTDAY,
        SYSDATE NOW
    FROM DUAL);
    
--date format
--�⵵ : YYYY, YY, RR(2 �ڸ��϶��� 4�ڸ��� ���� �ٸ�)
-- YYYY, RRRR�� ����
-- RR, YY
--�������̸� ��������� ǥ��
SELECT TO_CHAR(TO_DATE('35/03/01', 'RR/MM/DD'), 'YYYY/MM/DD') r1,
            TO_CHAR(TO_DATE('55/03/01', 'RR/MM/DD'), 'YYYY/MM/DD') r2,
            TO_CHAR( TO_DATE('55/03/01', 'YY/MM/DD'), 'YYYY/MM/DD') y1,
            TO_CHAR(SYSDATE, 'D') d, --������ ������-2
            TO_CHAR(SYSDATE, 'IW') IW, --������ ǥ��
            TO_CHAR(TO_DATE('20191229','YYYYMMDD'), 'IW') THIS_YEAR
FROM dual;


--���ǽ� FUNCTION DATE 2)
SELECT TO_CHAR(TO_DATE('2019-11-04','YYYY-MM-DD'),'YYYY-MM-DD'),
             TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
            TO_CHAR(TO_DATE('04-11-2019','DD-MM-YYYY'),'DD-MM-YYYY')
FROM dual;


--��¥�� �ݿø�(ROUND), ����(TRUNC)
--ROUND(DATE, '����') YYYY-MM-DD
desc emp;
SELECT ename, TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS') AS hiredate,
           TO_CHAR( ROUND(hiredate, 'YYYY'), 'YYYY-MM-DD HH24:MI:SS') AS round_yyyy,
            TO_CHAR( ROUND(hiredate, 'MM'), 'YYYY-MM-DD HH24:MI:SS') AS round_MM,
            TO_CHAR( ROUND(hiredate, 'DD'), 'YYYY-MM-DD HH24:MI:SS') AS round_DD,
            TO_CHAR( ROUND(hiredate-1, 'MM'), 'YYYY-MM-DD HH24:MI:SS') AS round_MM,
            TO_CHAR( ROUND(hiredate-2, 'MM'), 'YYYY-MM-DD HH24:MI:SS') AS round_MM
FROM emp
WHERE ename = 'SMITH';

SELECT ename, TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS') AS hiredate,
    TO_CHAR( TRUNC(hiredate, 'YYYY'), 'YYYY-MM-DD HH24:MI:SS') AS trunc_yyyy,-- ����������
    TO_CHAR( TRUNC(hiredate, 'MM'), 'YYYY-MM-DD HH24:MI:SS') AS trunc_MM,-- ��¥���� ����
    TO_CHAR( TRUNC(hiredate, 'DD'), 'YYYY-MM-DD HH24:MI:SS') AS trunc_DD,
    TO_CHAR( TRUNC(hiredate-1, 'MM'), 'YYYY-MM-DD HH24:MI:SS') AS trunc_MM,
    TO_CHAR( TRUNC(hiredate-2, 'MM'), 'YYYY-MM-DD HH24:MI:SS') AS trunc_MM
FROM emp
WHERE ename = 'SMITH';

--��¥ �����Լ�
-- MONTHS_BETWEEN(DATE, DATE) : �� ��¥ ������ ���� ��
-- 1980,12.17~2019,11.04 => 2019.11.17
SELECT  ename, TO_CHAR(hiredate,'YYYY-MM-DD') hiredate,           
            MONTHS_BETWEEN(SYSDATE, hiredate) months_between,
            MONTHS_BETWEEN(TO_DATE('20191117','YYYY-MM-DD'), hiredate) months_between
FROM emp
WHERE ename ='SMITH';

SELECT MOD(467,12)
FROM dual;

--ADD_MONTHS(DATE, ������) : DATE�� �������� ���� ��¥
-- �������� ����� ��� �̷�, ������ ��� ����
SELECT  ename, TO_CHAR(hiredate, 'YYYY-MM-DD'), hiredate,           
            ADD_MOMTHS(hiredate, 467) add_months,
            ADD_MOMTHS(hiredate, -467) add_months
FROM emp
WHERE ename = 'SMITH';

SELECT ename, TO_CHAR(hiredate, 'YYYY-MM-DD'), hiredate,
            ADD_MONTHS(hiredate, 467) add_months,
            ADD_MONTHS(hiredate, -467) add_months
    FROM emp
    where ename = 'SMITH';

--NEXT_DAY(DATE, ����) : DATE���� ù��° ������ ��¥
SELECT SYSDATE,
            NEXT_DAY(SYSDATE, 7) first_sat,-- ���� ��¥ ���� ù ����� ����
            NEXT_DAY(SYSDATE, '�����') first_sat-- ���� ��¥ ���� ù ����� ����
FROM dual;

-- LAST_DAY(DATE) �ش� ��¥�� ���� ���� ������ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) LAST_DAY,
          LAST_DAY( ADD_MONTHS (SYSDATE, 1)) LAST_DAT_12
FROM dual;

-- DATE + ���� = DATE(DATE���� ������ŭ ������ DATE)
--D1 + ���� = D2
-- �纯���� D2�� ����
-- D1 + ���� -D2 = D2-D2
-- D1 + ���� - D2 = 0
--��¥���� ��¥�� ���� ���ڰ� ���´�.

SELECT TO_DATE('20191104','YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') d_1,
            TO_DATE('20191201','YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') d_2,
            --201908 : 2019�� 8���� �ϼ� : 31
           ADD_MONTHS( TO_DATE('201908', 'YYYYMM'), 1) - TO_DATE('201908', 'YYYYMM')d_3
FROM dual;