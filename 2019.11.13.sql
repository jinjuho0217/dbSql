--unique table level constraint

drop table dept_test;

create table dept_test(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13),

-- constraint 제약조건 명 constraint type[(컬럼....)]
    constraint uk_dept_test_dname unique (dname, loc)

);

insert into dept_test values (1,'ddit', 'daejeon');
-- 첫번째 쿼리에 의해 danme, loc값이 중복되므로 두번째 쿼리는 시행되지 못한다.
insert into dept_test values (2,'ddit', 'daejeon');

--foreign key(참조제약)
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

--dept_test 테이블에 1번 부서번호만 존재하고
--fk제약을 dept_test.deptno 컬럼을 참조하도록 생성하여
--1번 이외의 부서번호는 emp_test테이블에 입력 될 수 없다.


--emp_test fk테스트 insert
insert into emp_test values(9999, 'brown', 1);


--2번 부서는 dept_test 테이블에 존재하지 않는 데이터 이기 때문에
-- fk제약에 의해 insert가 정상적으로 동작하지 못한다.
insert into emp_test values(9998, 'sally', 2);

-- 무결성 제약에서 발생시 뭘 해야될까?
-- 입력하려고 하는 값이 맞는건가?(2번인지 1번인지)
-- , 부모테이블에 값이 왜 입력안됐는지 확인(dept_test 확인)

select *
from dept_test;
insert into dept_test values(1,'ddit','deajeon');

select *
from emp_test;
drop table emp_test;

-- fk제약 table level constraint
    create table emp_test(
    empno number(4) primary key,
    ename varchar2(10),
    deptno number(2),
    constraint fk_emp_test_to_dept_test foreign key
    (deptno) REFERENCES dept_test(deptno)
);

select *
from emp_test;

-- fk제약을 생성하려면 참조하려는 컬럼에 인덱스가 생성되어있어야 한다.

drop table emp_test;
drop table dept_test;
-- drop을 할 경우 자식테이블이 있으면 자식테이블부터 지워야 된다.


create table dept_test(
    deptno number(4), /*primary key -> uniqte 제약X -> 인덱스 생성X*/
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
-- 무결성 제약에 의해서 삭제가 되지 않는다.

delete emp_test where empno=9999;

delete dept_test where deptno=1;
-- dept_test테이블의 deptno 값을 참조하는 데이터가 있을 경우 삭제가 불가능하다.
-- 즉 자식테이블에서 참조하는 데이터가 없어야 부모테이블의 데이터가 삭제가 가능하다.

--fk제약옵션
-- defualut : 데이터 입력/ 삭제 시 순차적으로 처리해줘야 fk제약을 위해하지 않는다.
-- on delete cascade : 부모 데이터 삭제시 참조하는 자식 테이블 같이 삭제
-- on delete null : 부모 데이터 삭제 시 참조하는 자식테이블 값 null
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

--fk 제약 default 옵션시에는 부모 테이블의 데이터를 삭제하기 전에 자식테이블에서 참조하는 데이터가 없어야 정상적으로 삭제가 가능했음
-- on delete cascade의 경우 보모 테이블 삭제시 참조하는 자식 테이블의 데이터를 같이 삭제한다.


--1. 삭제 쿼리가 정상적으로 실행되는지>
--2. 자식 테이블에 데이터가 삭제 되었는지?
delete dept_test -- 삭제 쿼리가 정상적으로 실행되는지?
where deptno=1;

select *
from emp_test;





------------------------------------------------------------------------------------------------------

--fk제약 on delete set null
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

--fk 제약 default 옵션시에는 부모 테이블의 데이터를 삭제하기 전에 자식테이블에서 참조하는 데이터가 없어야 정상적으로 삭제가 가능했음
-- on delete cascade의 경우 보모 테이블 삭제시 참조하는 자식 테이블의 데이터를 같이 삭제한다.
--참조 컬럼을 null로 수정한다.

--1. 삭제 쿼리가 정상적으로 실행되는지>
--2. 자식 테이블에 데이터가 null 되었는지?
delete dept_test -- 삭제 쿼리가 정상적으로 실행되는지?
where deptno=1;

select *
from emp_test;

--check제약 : 컬럼의 값을 정해진 범위, 혹은 값만 들어오게끔 제약

create table emp_test(
    empno number(4),
    ename varchar2(10),
    sal number check(sal>=0)
    );
--sal  컬럼은 check제약 조건에 의해 0이거나, 0보다 큰 값만 입력이 가능하다.
insert into emp_test values(9999, 'brown', 10000);
insert into emp_test values(9999, 'sally', -10000);

drop table emp_test;

create table emp_test(
    empno number(4),
    ename varchar2(10),
    -- emp_gb : 01 정직원, 02 인턴
    emp_gb varchar2(2) check(emp_gb in('01','02'))
    );
    
    insert into emp_test values(9999, 'brown', '01');
    -- emp_gb컬럼 체크제약에 의해 01, 02, 가 아닌 값은 입력될 수없다.
    insert into emp_test values(9999, 'sally', '03');
    
    select *
    from emp_test;
    
    --select 결과를 이용한 table생성
    --create table 테이블명 as 
    -- select 쿼리
    -- ctas (create table as)
    
    drop table emp_test;
    drop table dept_test;
    
    --customer 테이블을 사용하여 customer_test 테이블로 생성
    -- customer 테이블의 데이터도 같이 복제
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

--데이터는 복제하지 않고 특정 테이블의 컬럼 형식ㅁ나 가져올 수 없음
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
--테이블 변경
--새로운 컬럼 추가

drop table emp_test;
create table emp_test(
empno number(4),
ename varchar2(10)
);

-- 신규 컬럼 추가
alter table emp_test add (deptno number(2));
desc emp_test;

-- 기존 컬럼 변경
alter table emp_test modify (ename varchar2(200));
desc emp_test;

--기존 컬럼 변경(테이블에 데이터가 없는 상황)
alter table emp_test modify (ename varchar2(200));
desc emp_test
alter table emp_test modify (ename number);

-- 데이터가 있는 상황에서 컬럼 변경 : 제한적이다.
insert into emp_test values(999,1000,10);
commit;
alter table emp_test modify(ename varchar2(10));

select *
from emp_test;
desc emp_test;

-- 데이터 타입을 변경하기 위해서는 컬럼 값이 비어 있어야 한다.
alter table emp_test modify(ename varchar2(10));
-----------------------------------------------------------







-----------------------------------------------------------
--default 설정
desc emp_test;
alter table emp_test modify(deptno default 10);

drop table emp_test;
-----------------------------------------------------------






-----------------------------------------------------------
-- 컬럼명 변경
alter table emp_test rename column deptno to dno;

desc emp_test;
select dno
from emp_test;

-- 컬럼 제거(drop)
alter table emp_test drop column dno;
--alter table emp_test drop (dno); 위에 처럼 column을 안쓰고 ()안에 넣어줘도 같은 결과가 나온다.
    
desc emp_test;
-----------------------------------------------------------







-----------------------------------------------------------
-- 테이블 변경 : 제약조건 추가
-- primary key
alter table emp_test add constraint pk_emp_test primary key(empno);

--제약조건 삭제
alter table emp_test drop constraint pk_emp_test;

-- unique 제약 -> empno
alter table emp_test add constraint uk_emp_test unique(empno);

-- unique 제약  삭제-> empno
alter table emp_test drop constraint uk_emp_test;
-----------------------------------------------------------






-----------------------------------------------------------
--FOREIGN KEY 추가
-- 실습
-- dept 테이블의 deptno컬럼으로 primary key 제약을 테이블 변경
-- ddl을 통애생성

-- emp 테이블의 deptno컬럼으로 primary key제약을 테이블 변경
-- ddl을 통해 생성

-- emp테이블의 deptno컬럼으로 dept테이블의 deptno컬럼을 
-- 참조하는 fk제약을 테이블 변경 ddl을 통해 생성
DESC dept_test;
drop table dept_test;

create table dept_test(
    deptno number(4),
    dname varchar2(10),
    loc varchar2(13) 
);

-- dept 테이블의 deptno컬럼으로 primary key 제약을 테이블 변경
alter table dept add constraint uk_dept_test primary key(deptno);
alter table dept_test add constraint pk_dept_test primary key(deptno);

desc emp_test;

alter table emp_test add (deptno number(2)); -- 컬럼추가

alter table emp_test add constraint pk_emp_test primary key(deptno);

-------------------------------------------------------------------------------
--3.emp 테이블의 deptno 컬럼으로 dept테이블의 deptno컬럼을 참조하는 fk제약을 테이블 변경 DDL을 통해 생성

alter table emp add constraint fk_emp_dept foreign key(deptno)
references dept(deptno); -- 참조하는 다른 테이블도 같이 들어가야 함

-------------------------------------------------------------------------------
-- emp_test-> dept.deptno fk 제약 생성 (alter table)
drop table emp_test;
create table emp_test(
    empno number(4),
    ename varchar2(10),
    deptno number(2) 
);

desc emp_test;
alter table emp_test add constraint fk_emp_test_dept foreign key(deptno) REFERENCES dept(deptno);
             /* 두 테이블간의 컬럼 이름이 같아도 데이터 타입이 다르면 FK 제약조건을 설정할 수 없다.
              한쪽은 VARCHAR2 타입이고, 한쪽은 NUMBER 타입이라 참조시킬수 없다.*/

-------------------------------------------------------------------------------
desc emp_test;
desc dept;

select *
from dept;

select *
from emp_test;




-------------------------------------------------------------------------------
--check 제약 추가(ename 길이 체크, 길이가 3글자 이상)
alter table emp_test add constraint check_ename_len CHECK (length(ename) > 3);

insert into emp_test values (9999, 'brown',10);
insert into emp_test values (9998, 'br',10);
-- check제약 제거
alter table emp_test drop constraint check_ename_len;

-------------------------------------------------------------------------------





-------------------------------------------------------------------------------
-- not null 제약 추가
alter table emp_test modify (ename not null);

-- not null 제약 조건을 제거(null 허용)
alter table emp_test modify (ename null);
-------------------------------------------------------------------------------