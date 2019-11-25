--��ü ������ �޿����(2073.21)

select round(avg(sal),2)
from emp;
-------������
2073.21
-------

-- �μ��� ������ ��ձ޾�
select round(avg(sal),2), deptno
from emp
group by deptno;
------------������
1566.67 	30
2175	    20
2916.67	10
-------------
-- ��ü ������պ��� ���� �޿�

select *
from
    (select round(avg(sal),2) d_avgsal, deptno
    from emp
    group by deptno)
where d_avgsal > (select round(avg(sal),2)
                        from emp) ;

-- �������� with���� �����Ͽ� ������ �����ϰ� ǥ��

with dept_avg_sal as (select round(avg(sal),2) d_avgsal, deptno
                            from emp
                            group by deptno)
select *
from dept_avg_sal
where d_avgsal > (select round(avg(sal),2)
                        from emp);

------------------------------------------------------------------



------------------------------------------------------------------

--�޷¸����
-- step1, �ش� ����� ���� �����
-- CONNECT BY LEVEL
--DATE + ���� = ���� ���ϱ� ����

--201911
SELECT  TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), LEVEL
FROM DUAL a
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD');

-- ���������� 
-- ���� �������� GROUPBY�ؼ� ��������
SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'IW')
FROM DUAL a
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD');


-- ������������ �˾ƺ��°�
SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'IW') IW, -- ����
            TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) DT, -- ��¥
            TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'D') D -- ����
FROM DUAL a
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD');


-- �޷¸���� , ��ܽ����� �������, �������� GROUPBY���Ѵ�
SELECT A.*, SYSDATE, 'TEST', DECODE(D,1,DT) SUN, 
                                     DECODE(D,2,DT) MON,
                                     DECODE(D,3,DT) TUE,
                                     DECODE(D,4,DT) WEN,
                                     DECODE(D,5,DT) THU,
                                     DECODE(D,6,DT) FRI,
                                     DECODE(D,7,DT) SAT
FROM
    (SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'IW') IW, -- ����
                TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) DT, -- ��¥
                TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'D') D -- ����
    FROM DUAL a
    CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD'))A ;


SELECT a.IW,                 MAX (DECODE(D,1,DT)) SUN,
                                    MAX  (DECODE(D,2,DT) )MON,
                                    MAX  (DECODE(D,3,DT)) TUE,
                                    MAX (DECODE(D,4,DT)) WEN,
                                    MAX (DECODE(D,5,DT)) THU,
                                    MAX (DECODE(D,6,DT)) FRI,
                                    MAX (DECODE(D,7,DT)) SAT
FROM
    (SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL), 'IW') IW, -- ����
                TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) DT, -- ��¥
                
                TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'D') D -- ����
    FROM DUAL a
    CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD'))A 
    GROUP BY a.IW
    order by a.iw;
    
--------------------------------------------------------------------




---------------------------------------------------------------------
SELECT a.w,                   MAX (DECODE(D,1,DT)) SUN,
                                    MAX  (DECODE(D,2,DT) )MON,
                                    MAX  (DECODE(D,3,DT)) TUE,
                                    MAX (DECODE(D,4,DT)) WEN,
                                    MAX (DECODE(D,5,DT)) THU,
                                    MAX (DECODE(D,6,DT)) FRI,
                                    MAX (DECODE(D,7,DT)) SAT
FROM
    (SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'W') W, -- ����
                TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) DT, -- ��¥
                
                TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'D') D -- ����
    FROM DUAL a
    CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD'))A 
    GROUP BY a.W
    order by a.w;
    
    
    
    
    
----------------------------------------------------------------------------




----------------------------------------------------------------------------
SELECT a.iw,                   MAX (DECODE(D,1,DT)) SUN,
                                    MAX  (DECODE(D,2,DT) )MON,
                                    MAX  (DECODE(D,3,DT)) TUE,
                                    MAX (DECODE(D,4,DT)) WEN,
                                    MAX (DECODE(D,5,DT)) THU,
                                    MAX (DECODE(D,6,DT)) FRI,
                                    MAX (DECODE(D,7,DT)) SAT
FROM
    (SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL), 'iW') iW, -- ����
                TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) DT, -- ��¥
                TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'D') D -- ����
    FROM DUAL a
    CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD'))A 
    GROUP BY a.iW
    order by a.iw;
            


select next_day((last_day(SYSDATE)-7),'��') from dual ; --������ �� ������

SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD')) - TO_DATE('19871217') FROM DUAL; -- �� ��¥ ���� �ϼ� ���

SELECT LAST_DAY(SYSDATE) FROM DUAL; -- �� ���� ��������

SELECT TO_DATE(TO_CHAR(SELECT LAST_DAY(SYSDATE) FROM DUAL)) - TO_DATE(select next_day((last_day(:YYYYMM)-7),'��') from dual) FROM DUAL; 

------------------------------------------------------------------



------------------------------------------------------------------
--���ǽ� �޷�����  �ǽ� 1)



select dt
from sales
group by dt
order by dt;

select *
from sales;

select nvl(max(decode(to_char(dt,'MM'),'01', sum(sales))),0)a, 
nvl(max(decode(to_char(dt,'MM'),'02', sum(sales))),0)b, 
nvl(max(decode(to_char(dt,'MM'),'03', sum(sales))),0)c, 
nvl(max(decode(to_char(dt,'MM'),'04', sum(sales))),0)d, 
nvl(max(decode(to_char(dt,'MM'),'05', sum(sales))),0)e, 
nvl(max(decode(to_char(dt,'MM'),'06', sum(sales))),0)f
from sales
group by to_char(dt,'MM');

-----------------------------------������
1200	    1300    	0	    1200	    250	2700
-------------------------------------



select *
from emp_test;

--nvl(max(decode(to_char(dt,'MM'),'06', sum(sales))),0)f

-- �μ��� ������ ��ձ޾�
select round(avg(sal),2)a, deptno
from emp
group by deptno;

select MIN(decode(deptno, 10,  round(avg(sal),2))) A, 
        MIN(decode(deptno, 20,  round(avg(sal),2))) B,
        MIN(decode(deptno, 30,  round(avg(sal),2))) C 
from emp
group by deptno;
------------------------------------------------------------------



------------------------------------------------------------------


create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

--sales
select *
from sales;



------------------------------------------------------------------



------------------------------------------------------------------

--��������
-- START WITH : ������ ���� �κ��� ����
-- CONNECT BY : ������ ���� ������ ����


SELECT *
FROM EMP;



create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XXȸ��', '');
insert into dept_h values ('dept0_00', '�����κ�', 'dept0');
insert into dept_h values ('dept0_01', '������ȹ��', 'dept0');
insert into dept_h values ('dept0_02', '�����ý��ۺ�', 'dept0');
insert into dept_h values ('dept0_00_0', '��������', 'dept0_00');
insert into dept_h values ('dept0_01_0', '��ȹ��', 'dept0_01');
insert into dept_h values ('dept0_02_0', '����1��', 'dept0_02');
insert into dept_h values ('dept0_02_1', '����2��', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '��ȹ��Ʈ', 'dept0_01_0');
commit;

SELECT *
FROM DEPT_H;
-- ����� �������� (���� �ֻ��� ������������ ��� ������ Ž��)


SELECT *
FROM DEPT_H
START WITH deptcd = 'dept0' -- start with p_deptcd IS NULL
CONNECT BY PRIOR DEPTCD = P_DEPTCD; -- PRIOR ���� ���� ������ (XXȸ��)


/* LEVEL�� ���������� ���̸� �˼� ����*/--,  LPAD(' ',(LEVEL-1)*4, ' ') || DEPT_H.DEPTNM �� ������ ���̸� �ð�ȭ �Ѱ��̴�.
SELECT DEPT_H.*, LEVEL, LPAD(' ',(LEVEL-1)*4, ' ') || DEPT_H.DEPTNM 
FROM DEPT_H
START WITH deptcd = 'dept0' -- start with p_deptcd IS NULL
CONNECT BY PRIOR DEPTCD = P_DEPTCD; -- PRIOR ���� ���� ������ (XXȸ��)


------------------------------------------------------------------



------------------------------------------------------------------
--���ǽ� ��������  �ǽ� 2)
--LPAD(' ',(LEVEL-1)*4, ' ') : �տ� ������ �ֱ����ؼ� ����� 
-- lpad�� ������ �ֱ����ؼ� �����, �տ� ���� ' '�� �־��� �� ������ ������ �ڿ� level���� ���� ����ŭ ' '�� �߰��Ѵٴ� �ǹ�

SELECT deptcd, LPAD(' ',(LEVEL-1)*4, ' ') || DEPT_H.DEPTNM deptnm, p_deptcd
FROM DEPT_H
START WITH deptcd = 'dept0_02'-- ���ڿ� �ȿ� �ִ°� ������ �ȴ�.
CONNECT BY PRIOR deptcd = p_deptcd;