--전체 직원의 급여평균(2073.21)

select round(avg(sal),2)
from emp;
-------실행결과
2073.21
-------

-- 부서별 직원의 평균급어
select round(avg(sal),2), deptno
from emp
group by deptno;
------------실행결과
1566.67 	30
2175	    20
2916.67	10
-------------
-- 전체 직원평균보다 높은 급여

select *
from
    (select round(avg(sal),2) d_avgsal, deptno
    from emp
    group by deptno)
where d_avgsal > (select round(avg(sal),2)
                        from emp) ;

-- 쿼리블럭을 with절에 선언하여 쿼리를 간단하게 표현

with dept_avg_sal as (select round(avg(sal),2) d_avgsal, deptno
                            from emp
                            group by deptno)
select *
from dept_avg_sal
where d_avgsal > (select round(avg(sal),2)
                        from emp);

------------------------------------------------------------------



------------------------------------------------------------------

--달력만들기
-- step1, 해당 년월의 일자 만들기
-- CONNECT BY LEVEL
--DATE + 정수 = 일자 더하기 연산

--201911
SELECT  TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), LEVEL
FROM DUAL a
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD');

-- 몇주차인지 
-- 같은 주차끼리 GROUPBY해서 묶으려고
SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'IW')
FROM DUAL a
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD');


-- 무슨요일인지 알아보는거
SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'IW') IW, -- 주차
            TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) DT, -- 날짜
            TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'D') D -- 요일
FROM DUAL a
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD');


-- 달력만들기 , 계단식으로 만들어짐, 주차별로 GROUPBY로한다
SELECT A.*, SYSDATE, 'TEST', DECODE(D,1,DT) SUN, 
                                     DECODE(D,2,DT) MON,
                                     DECODE(D,3,DT) TUE,
                                     DECODE(D,4,DT) WEN,
                                     DECODE(D,5,DT) THU,
                                     DECODE(D,6,DT) FRI,
                                     DECODE(D,7,DT) SAT
FROM
    (SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'IW') IW, -- 주차
                TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) DT, -- 날짜
                TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'D') D -- 요일
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
    (SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL), 'IW') IW, -- 주차
                TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) DT, -- 날짜
                
                TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'D') D -- 요일
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
    (SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'W') W, -- 주차
                TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) DT, -- 날짜
                
                TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'D') D -- 요일
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
    (SELECT TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL), 'iW') iW, -- 주차
                TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) DT, -- 날짜
                TO_CHAR( TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1), 'D') D -- 요일
    FROM DUAL a
    CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD'))A 
    GROUP BY a.iW
    order by a.iw;
            


select next_day((last_day(SYSDATE)-7),'월') from dual ; --마지막 주 월요일

SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD')) - TO_DATE('19871217') FROM DUAL; -- 두 날짜 사이 일수 계산

SELECT LAST_DAY(SYSDATE) FROM DUAL; -- 그 월의 마지막날

SELECT TO_DATE(TO_CHAR(SELECT LAST_DAY(SYSDATE) FROM DUAL)) - TO_DATE(select next_day((last_day(:YYYYMM)-7),'월') from dual) FROM DUAL; 

------------------------------------------------------------------



------------------------------------------------------------------
--♠실습 달력쿼리  실습 1)



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

-----------------------------------실행결과
1200	    1300    	0	    1200	    250	2700
-------------------------------------



select *
from emp_test;

--nvl(max(decode(to_char(dt,'MM'),'06', sum(sales))),0)f

-- 부서별 직원의 평균급어
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

--계층쿼리
-- START WITH : 계층의 시작 부분을 정의
-- CONNECT BY : 계층간 연결 조건을 정의


SELECT *
FROM EMP;



create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XX회사', '');
insert into dept_h values ('dept0_00', '디자인부', 'dept0');
insert into dept_h values ('dept0_01', '정보기획부', 'dept0');
insert into dept_h values ('dept0_02', '정보시스템부', 'dept0');
insert into dept_h values ('dept0_00_0', '디자인팀', 'dept0_00');
insert into dept_h values ('dept0_01_0', '기획팀', 'dept0_01');
insert into dept_h values ('dept0_02_0', '개발1팀', 'dept0_02');
insert into dept_h values ('dept0_02_1', '개발2팀', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '기획파트', 'dept0_01_0');
commit;

SELECT *
FROM DEPT_H;
-- 하향식 계층쿼리 (가장 최상위 조적에서부터 모든 조직을 탐색)


SELECT *
FROM DEPT_H
START WITH deptcd = 'dept0' -- start with p_deptcd IS NULL
CONNECT BY PRIOR DEPTCD = P_DEPTCD; -- PRIOR 현재 읽은 데이터 (XX회사)


/* LEVEL은 계층구조의 깊이를 알수 있음*/--,  LPAD(' ',(LEVEL-1)*4, ' ') || DEPT_H.DEPTNM 는 계층의 깊이를 시각화 한것이다.
SELECT DEPT_H.*, LEVEL, LPAD(' ',(LEVEL-1)*4, ' ') || DEPT_H.DEPTNM 
FROM DEPT_H
START WITH deptcd = 'dept0' -- start with p_deptcd IS NULL
CONNECT BY PRIOR DEPTCD = P_DEPTCD; -- PRIOR 현재 읽은 데이터 (XX회사)


------------------------------------------------------------------



------------------------------------------------------------------
--♠실습 계층쿼리  실습 2)
--LPAD(' ',(LEVEL-1)*4, ' ') : 앞에 공백을 주기위해서 사용함 
-- lpad는 공백을 주기위해서 사용함, 앞에 공백 ' '을 넣었을 때 공간이 남으면 뒤에 level에서 나온 수만큼 ' '을 추가한다는 의미

SELECT deptcd, LPAD(' ',(LEVEL-1)*4, ' ') || DEPT_H.DEPTNM deptnm, p_deptcd
FROM DEPT_H
START WITH deptcd = 'dept0_02'-- 문자열 안에 있는게 기준이 된다.
CONNECT BY PRIOR deptcd = p_deptcd;