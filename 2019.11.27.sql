select *
from no_emp;

-- 1,leaf nodeã��


select  lpad(' ', (level-1)*4, ' ')  || org_cd org_cd, no_emp
from no_emp
start with org_cd = 'XXȸ��'
connect by prior org_cd=parent_org_cd;

--pl/sql
-- �Ҵ翬��:=
-- system.out.println(" ") --> dbms_out.put_line(" ");
-- Log4j
-- set serveroutpu on; --> ��±���� Ȱ��ȭ

set serveroutput on;

--PL./SQL
--declear : ����, ��� ����
-- begin : ���� ����
-- exception : ����ó��

set serveroutput on;
declare
-- ��������
    deptno number(2);
    dname varchar2(14);
begin
    select deptno, dname into deptno, dname -- into�� �ϳ��� ����
    from dept
    where deptno = 10;
    
    --select ���� ����� ������ �� �Ҵ� �ߴ��� Ȯ��
    dbms_output.put_line('dname : ' || dname || '(' || deptno || ')');
    
end;
/



set serveroutput on;
declare
-- ������������(���̺� �÷�Ÿ���� ����ǰ� pl/sql ������ ������ �ʿ䰡 ����.)
    deptno dept.deptno%type;
    dname dept.dname%type;
begin
    select deptno, dname into deptno, dname -- into�� �ϳ��� ����
    from dept
    where deptno = 10;
    
    --select ���� ����� ������ �� �Ҵ� �ߴ��� Ȯ��
    dbms_output.put_line('dname : ' || dname || '(' || deptno || ')');
    
end;
/


-- 10���μ��� �μ��̸��� loc������ ȭ������ϴ� ���ν���
-- ���ν��� �̸� printdept
-- create or replace view
create or replace procedure printdept 
is
        -- ���� ����
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
        -- ���� ����
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
----------------------------------------������
--dname, loc =SALES,CHICAGO
--
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
----------------------------------------
------------------------------------------------------






------------------------------------------------------


create or replace procedure printemp_p(p_emp in emp.deptno%type)
is
        -- ���� ����
        ename emp.ename%type;
        dname dept.dname%type;
begin
         select emp.ename, dept.dname
        into ename, dname -- into -> �ֱ�� �� ����
         from emp join dept 
         on emp.deptno = dept.deptno
         where empno=p_emp;

    dbms_output.put_line('ename, dname =' || ename || ',' || dname);
end;
/

exec printemp_p(7369);

----------------------------------------������
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
--
--ename, dname =SMITH,RESEARCH
----------------------------------------
------------------------------------------------------






------------------------------------------------------
 select emp.ename, dept.dname
        into ename, dname -- into -> �ֱ�� �� ����
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
        -- ���� ����
        ename emp.ename%type;
        dname dept.dname%type;
begin
         select emp.ename, dept.dname
        into ename, dname -- into -> �ֱ�� �� ����
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


--procedure ���� �ǽ�3)
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

--ROWTYPE : ���̺��� �� ���� �����͸� ���� �� �ִ� ����Ÿ��

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
-------------------------------------������
--10,ACCOUNTING
--
--
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-------------------------------------
------------------------------------------------------






------------------------------------------------------

--���պ��� : record
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
--------------------------------������
--
--10,ACCOUNTING
--
--
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-------------------------------------------------------------------------------






----------------------------------------------------------------

--tabletype
declare
    type dept_tab is table of dept%rowtype index by binary_integer;
    --java : Ÿ�Ը� ����;
    --pl/sql : ������ Ÿ��;
    v_dept dept_tab; -- ���� ����
    
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
-- FOR �ε��� ���� IN ���۰�..���ᰪ LOOP
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
    --java : Ÿ�Ը� ����;
    --pl/sql : ������ Ÿ��;
    v_dept dept_tab; -- ���� ����
    
begin

    select *
    bulk collect into v_dept
    from dept;
for i in 1..v_dept.count loop
    dbms_output.put_line(v_dept(i).dname);
end loop;
end;
/
--------------------------------------������
--ACCOUNTING
--RESEARCH
--SALES
--OPERATIONS
--
--
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
---------------------------------------
------------------------------------------------------






------------------------------------------------------
-- while

DECLARE

BEGIN

END;
/

-- LOOP : ��� ���� �Ǵ� ������ LOOP�ȿ��� ����
-- JAVA : WHILE(TRUE)

DECLARE
    I NUMBER;
BEGIN
    I := 0;
    
    LOOP
        dbms_output.put_line(i);
        i :=i+1;
        -- loop ��� ���࿩�� �Ǵ�
        EXIT WHEN I>=5;
        END LOOP;
END;
/

---------------------------������
--0
--1
--2
--3
--4
--
--
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
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

-- ��� ������� : 5

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
---------------------------------------------------------�̿�
------------------------------------------------------






------------------------------------------------------

-- lead, lag �������� ����, ���� �����͸� ������ �� �� �ִ�.

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
-- ���� ���� ���

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
    -- Ŀ�� ����
    open dept_cursor;
    loop
        fetch dept_cursor into v_deptno, v_dname;
        dbms_output.put_line(v_deptno || ', ' || v_dname);
    exit when dept_cursor%notfound; -- ���̻� ���� �����Ͱ� ������ ����
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


-- �Ķ���Ͱ� �ִ� ����� Ŀ��
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