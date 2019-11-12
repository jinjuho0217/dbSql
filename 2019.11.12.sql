--♠실습 서브 쿼리 실습 7)
-- join으로 먼저 cycle.pid와 product.pid를 묶고, 나머지 customer.cid랑 조인을 함

select a.cid,cnm,a.pid, pnm, day, cnt 
from 
(select cycle.pid, day, cnt, cycle.cid, pnm
from cycle join product on (cycle.pid = product.pid))a join customer on(a.cid = customer.cid)
where a.pid in (select a.pid
                  from cycle
                  where a.pid =100) and a.cid =1;


--♠실습 서브 쿼리 실습 9)

select pid, pnm
from product
where not exists (select 'x'
                    from cycle
                    where pid = product.pid and cid =1);

delete dept where deptno=99;
-- 여기 까지만 하면 반영되지 않는다 commit을 해야 확실시 된다.
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



-- 오늘 날짜 조회
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
where table_name = 'EMP'  -- 찾은 테이블을 대문자로 작성을 해야 나온다.
order by column_id;

insert into emp
values (9999, 'OLIVE', 'ranger', null, sysdate, 2500, null, 40);
rollback;

select *
from emp;
insert into emp
values (9999, 'OLIVE', 'ranger', null, sysdate, 2500, null, 40);

-- select결과(여러건)


insert into emp (empno, ename)
select deptno, dname
from dept;

select *
from emp;
commit;


--DML(update)
-- UPDATE 테이블 SET컬럼-값, 컬럼-값......
-- WHERE condition

select*
from dept;

update dept set dname ='대덕IT', loc ='ym'
where deptno =99; -- where절을 안쓰면 모든 dept안에 있는 데이터가 update하기로 한 데이터로 바뀐다.


--DML(delete)
-- 행 자체를 지움

select *
from emp;
--delete 테이블명
--where condition

--사원번호가 9999인 직원의 emp테이블 삭제
DELETE emp
WHERE empno=9999;

-- 부서테이블을 이용해서 emp테이블에 입력한 5건 의 데이터 삭제
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

--truncate : 로그를 남기지 않아 속도가 빠름, 로그를 남기지 않아 복구가 안됨


--LV1 -> LV3, 다른 DBMS에서는 임의로 수정하는 것은 위험하다.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


--DML문장을 통해 트랜잭션 시작
Insert into dept
values(99, 'DDIT', 'daehjeon');

SELECT *
FROM dept;

--DDL(CREAT) : COMMIT, ROLLBACK이 안됨
-- 테이블생성

    CREATE TABLE ranger_new (
    ranger_no NUMBER, -- 숫자타입 
    ranger_name VARCHAR2(50), -- 문자타입: [VARCHAR2(지정한 사이즈로 나옴)], CHAR(지정한 사이즈로 나오지 않음)
    reg_dt DATE DEFAULT SYSDATE -- DEFAULT : SYSDATE
    );
desc ranger_new;

insert into ranger_new (ranger_no, ranger_name)
values(1000,'brown');

select *
from ranger_new;

commit;

--날짜 타입에서 특정 필드 가져오기
--ex : sysdate에서 년도만 가져오기
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


-- 제약조선
--DEPT 모방해서 DEPT_TEST생성

CREATE TABLE dept_test(
    deptno number(2) PRIMARY KEY ,-- DEPTNO컬럼을 식별자로 지정
    dname varchar2(14),                 -- 식별자로 지정이 되면 값이 중복이 될 수 없으며, NULL일 수 없다.
    loc varchar2(13)
);

DESC dept_test;

--primary key제약 조건 확인
-- 1.deptno 컬럼에  null이 들어갈 수 없다.
--2. deptno컬럼에 중복된 값이 들어갈 수 없다.

-- 1.deptno 컬럼에  null이 들어갈 수 없다.
insert into dept_test( deptno, dname, loc)
values (null, 'ddit', 'deajeon');

-- 2. deptno컬럼에 중복된 값이 들어갈 수 없다.
insert into dept_test values (1, 'ddit1', 'deajeon');
insert into dept_test values (1, 'ddit2', 'deajeon');

rollback;

-- 사용자 지정 제약조건명을 부여한 primary key
drop table dept_test;

create table dept_test(
    deptno number(2) constraint pk_dept_test primary key, -- constraint 뒤에오는 pk_dept_test는 테이블의 제약조건에 대한 이름
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
 -- 제약 조건으로 not null을 걸어서 null값이 못 들어감
 insert into dept_test values(1, 'ddit1', 'deajeon');
 insert into dept_test values(1, null, 'deajeon');
 
 
 --unique
 DROP TABLE dept_test;

create table dept_test(
     deptno number(2) primary key,
     dname varchar(14) unique,
     loc varchar(13)
 );
 -- 제약조건을 unique로 걸어놔서 동일한 값이 들어올 수가 없다.
 insert into dept_test values(1, 'ddit', 'deajeon');
 insert into dept_test values(1, 'ddit', 'deajeon');
 
 
 rollback;
 
 
 
 