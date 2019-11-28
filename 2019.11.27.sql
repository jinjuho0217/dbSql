select *
from no_emp;

-- 1,leaf node찾기


select  lpad(' ', (level-1)*4, ' ')  || org_cd org_cd, no_emp
from no_emp
start with org_cd = 'XX회사'
connect by prior org_cd=parent_org_cd;

--pl/sql
-- 할당연산:=
-- system.out.println(" ") --> dbms_out.put_line(" ");
-- Log4j
-- set serveroutpu on; --> 출력기능을 활성화

set serveroutput on;

--PL./SQL
--declear : 변수, 상수 선언
-- begin : 로직 실행
-- exception : 예외처리

set serveroutput on;
declare
-- 변수선언
    deptno number(2);
    dname varchar2(14);
begin
    select deptno, dname into deptno, dname -- into는 하나만 가능
    from dept
    where deptno = 10;
    
    --select 질의 결과를 변수에 잘 할당 했는지 확인
    dbms_output.put_line('dname : ' || dname || '(' || deptno || ')');
    
end;
/



set serveroutput on;
declare
-- 참조변수선언(테이블 컬럼타입이 변경되고 pl/sql 구문을 수정할 필요가 없다.)
    deptno dept.deptno%type;
    dname dept.dname%type;
begin
    select deptno, dname into deptno, dname -- into는 하나만 가능
    from dept
    where deptno = 10;
    
    --select 질의 결과를 변수에 잘 할당 했는지 확인
    dbms_output.put_line('dname : ' || dname || '(' || deptno || ')');
    
end;
/


-- 10번부서의 부서이름과 loc정보를 화면출력하는 프로시저
-- 프로시저 이름 printdept
-- create or replace view
create or replace procedure printdept 
is
        -- 변수 선언
        dname dept.dname%type;
        loc dept.loc%type;
begin
         select dname, loc
         into dname, loc
         from dept
         where deptno = 20;

    dbms_output.put_line('dname, loc =' || dname || ',' || loc);
end;
/



exec printdept;




create or replace procedure printdept_p(p_deptno in dept.deptno%type)
is
        -- 변수 선언
        dname dept.dname%type;
        loc dept.loc%type;
begin
         select dname, loc
         into dname, loc
         from dept
         where deptno = p_deptno;

    dbms_output.put_line('dname, loc =' || dname || ',' || loc);
end;
/



exec printdept_p(30);
----------------------------------------실행결과
--dname, loc =SALES,CHICAGO
--
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
----------------------------------------
------------------------------------------------------






------------------------------------------------------


create or replace procedure printemp_p(p_emp in emp.deptno%type)
is
        -- 변수 선언
        ename emp.ename%type;
        dname dept.dname%type;
begin
         select emp.ename, dept.dname
        into ename, dname -- into -> 넣기로 한 변수
         from emp join dept 
         on emp.deptno = dept.deptno
         where empno=p_emp;

    dbms_output.put_line('ename, dname =' || ename || ',' || dname);
end;
/

exec printemp_p(7369);

----------------------------------------실행결과
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
--
--ename, dname =SMITH,RESEARCH
----------------------------------------
------------------------------------------------------






------------------------------------------------------
 select emp.ename, dept.dname
        into ename, dname -- into -> 넣기로 한 변수
         from emp join dept 
         on emp.deptno = dept.deptno and empno in(7369) ;
         
         
         
         
select *
from dept_test;

drop table dept_test;

create table dept_test as
select *
from dept;

select *
from dept_test;


create or replace procedure printemp_p(p_emp in emp.deptno%type)
is
        -- 변수 선언
        ename emp.ename%type;
        dname dept.dname%type;
begin
         select emp.ename, dept.dname
        into ename, dname -- into -> 넣기로 한 변수
         from emp join dept 
         on emp.deptno = dept.deptno
         where empno=p_emp;

    dbms_output.put_line('ename, dname =' || ename || ',' || dname);
end;
/

create or replace procedure registdept_p(p_deptno in dept.deptno%type,
                                                      p_dname in dept.dname%type,
                                                      p_loc in dept.loc%type)
is
    
begin
    insert into dept_test
    values(p_deptno, p_dname, p_loc);
    
    commit;

end;
/
exec registdept_p('99','ddit','daejeon');

select *
from dept_test;
------------------------------------------------------






------------------------------------------------------


--procedure 생성 실습3)
create or replace procedure updatedept_test(p_deptno in dept.deptno%type,
                                                            p_dname in dept.dname%type,
                                                            p_loc in dept.loc%type)
is
    
begin
    update dept_test set deptno =p_deptno, dname = p_dname , loc = p_loc
    where deptno =p_deptno;

end;
/
exec updatedept_test(99, 'ddit_m', 'daejeon');
select *
from dept_test;

------------------------------------------------------






------------------------------------------------------

--ROWTYPE : 테이블의 한 행의 데이터를 담을 수 있는 참조타입

set serveroutput on;
DECLARE
    dept_row dept%ROWTYPE;
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line(dept_row.deptno || ',' || dept_row.dname);
    
END;
/
-------------------------------------실행결과
--10,ACCOUNTING
--
--
--PL/SQL 프로시저가 성공적으로 완료되었습니다.

-------------------------------------
------------------------------------------------------






------------------------------------------------------

--복합변수 : record
declare
    -- Uservo uservo;
    type dept_row is record(
    deptno NUMBER(2), 
    dname dept.dname%type);
    
    
    v_dname dept.dname%type;
    v_row dept_row;
    
begin
    select deptno, dname
    into v_row
    from dept
    where deptno =10;

    dbms_output.put_line(v_row.deptno || ' , '||v_row.dname);
end;
/
--------------------------------실행결과
--
--10,ACCOUNTING
--
--
--PL/SQL 프로시저가 성공적으로 완료되었습니다.

-------------------------------------------------------------------------------






----------------------------------------------------------------

--tabletype
declare
    type dept_tab is table of dept%rowtype index by binary_integer;
    --java : 타입명 변수;
    --pl/sql : 변수명 타입;
    v_dept dept_tab; -- 변수 선언
    
begin
    select *
    bulk collect into v_dept
    from dept;

dbms_output.put_line(v_dept(1).dname);
dbms_output.put_line(v_dept(2).dname);
dbms_output.put_line(v_dept(3).dname);
dbms_output.put_line(v_dept(4).dname);
end;
/



select *
from dept;
------------------------------------------------------






------------------------------------------------------

--IF
--JAVA : ELSE IF --> SQL : ELSIF
-- END IF

DECLARE
    ind BINARY_INTEGER;
BEGIN
    ind :=2;
    
    IF ind = 1 then
    dbms_output.put_line(ind);
    ELSIF ind =2 THEN
    dbms_output.put_line('ELSIF ' || ind);
    else
        dbms_output.put_line('else');
        end if;
    
    
END;
/


-- FOR LOOP
-- FOR 인덱스 변수 IN 시작값..종료값 LOOP
-- END LOOP;
DECLARE

BEGIN
    FOR i IN 0..5 LOOP
    dbms_output.put_line('i : ' || i);
    END LOOP;

END;
/


declare
    type dept_tab is table of dept%rowtype index by binary_integer;
    --java : 타입명 변수;
    --pl/sql : 변수명 타입;
    v_dept dept_tab; -- 변수 선언
    
begin

    select *
    bulk collect into v_dept
    from dept;
for i in 1..v_dept.count loop
    dbms_output.put_line(v_dept(i).dname);
end loop;
end;
/
--------------------------------------실행결과
--ACCOUNTING
--RESEARCH
--SALES
--OPERATIONS
--
--
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
---------------------------------------
------------------------------------------------------






------------------------------------------------------
-- while

DECLARE

BEGIN

END;
/

-- LOOP : 계속 실행 판단 로직을 LOOP안에서 제어
-- JAVA : WHILE(TRUE)

DECLARE
    I NUMBER;
BEGIN
    I := 0;
    
    LOOP
        dbms_output.put_line(i);
        i :=i+1;
        -- loop 계속 진행여부 판단
        EXIT WHEN I>=5;
        END LOOP;
END;
/

---------------------------실행결과
--0
--1
--2
--3
--4
--
--
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
-----------------------------


 CREATE TABLE DT
(	DT DATE);

insert into dt
select trunc(sysdate + 10) from dual union all
select trunc(sysdate + 5) from dual union all
select trunc(sysdate) from dual union all
select trunc(sysdate - 5) from dual union all
select trunc(sysdate - 10) from dual union all
select trunc(sysdate - 15) from dual union all
select trunc(sysdate - 20) from dual union all
select trunc(sysdate - 25) from dual;

commit;

-- 결과 간격평균 : 5

SELECT *
FROM DT;

declare
 type dt is table of dt%rowtype index by binary_integer;
    sumdt := 0;
    m_dt :=0;
    v_dt number;
    i := 0;
 begin
    
    m_dt := to_date(v_dt(i).dt) - to_date(v_dt(i-1).dt);    
 end;
 /
---------------------------------------------------------미완
------------------------------------------------------






------------------------------------------------------

-- lead, lag 현재행의 이전, 이후 데이터를 가지고 올 수 있다.

select *
from dt
order by dt desc;

select dt, dt-lead_dt
from
(select dt, 
            lag(dt) over (order by dt) lag_dt,
            lead(dt) over (order by dt) lead_dt,            
from dt)
;
------------------------------------------------------






------------------------------------------------------
select sum(df_sum) / count(df_sum)
from(
select a.dt, a.rn, b.rn, b.dt, b.dt-a.dt df_sum

from 
(select rownum rn, dt
from
( select dt
    from dt
    order by dt desc)a) a join
(select rownum+1 rn, dt
from
( select dt
    from dt
    order by dt desc)b) b on(a.rn = b.rn))
    group by df_sum;
------------------------------------------------------






------------------------------------------------------
-- 위와 같은 결과

select 
    (max(dt)-min(dt)) /  (count(*)-1)
from dt;


------------------------------------------------------






------------------------------------------------------

declare
    cursor dept_cursor is
    select deptno, dname from dept;
    
    v_deptno dept.deptno%type;
    v_dname dept.dname%type;

begin
    -- 커서 열기
    open dept_cursor;
    loop
        fetch dept_cursor into v_deptno, v_dname;
        dbms_output.put_line(v_deptno || ', ' || v_dname);
    exit when dept_cursor%notfound; -- 더이상 읽을 데이터가 없을때 종료
    end loop;
end;
/

declare
    cursor dept_cursor is
    select deptno, dname
    from dept;
    v_dept dept.deptno%type;
    v_dname dept.dname%type;
begin
    for rec in dept_cursor loop
    dbms_output.put_line( rec.deptno ||', '|| rec.dname); 
    end loop;
end;
/


-- 파라미터가 있는 명시적 커서
declare
cursor emp_cursor(p_job emp.job%type) is
    select empno, ename, job
    from emp
    where job = p_job;
   
begin
    for emp in emp_cursor('SALESMAN') LOOP
        dbms_output.put_line(emp.empno || ', ' || emp.ename || ', ' || emp.job);
        end loop;
end;
/