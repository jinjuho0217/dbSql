--cursor�� ��������� �������� �ʰ�
--loop���� inline ���·� cursor���

--�͸���
set SERVEROUTPUT on;
DECLARE  -- cursor���� --> loop���� inline����
BEGIN
    for rec in (select deptno, dname from dept) loop
    dbms_output.put_line(rec.deptno|| ','|| rec.dname);
    end loop;
END;
/

declare
    
begin
    for dt in (select dt from dt order by dt) loop
    dbms_output.put_line(dt.dt);
       
    end loop;
end;
/


select *
from dt;


-----------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------

declare
begin
    for v_dt in (select (max(dt)-min(dt)) / (count(*)-1) a from dt) loop
    dbms_output.put_line(v_dt.a);
    end loop;
end;
/


create or replace procedure avgdt
is
    -- �����
    prev_dt date; -- ���������͸� ���� ����
    ind number := 0; -- �ε���
    diff number := 0; -- ������ ��
begin
    --dt���̺� ��� ������ ��ȸ
    for rec in (select * from dt order by dt desc)loop  
        -- rec : dt�÷�
        -- ���� ���� ������(dt) - ����������(dt) : 
        if ind = 0 then --loop�� ���ۺκ�
            prev_dt := rec.dt;
        else
            diff := diff + prev_dt - rec.dt;
            prev_dt := rec.dt;
        end if;
        ind := ind +1;
    end loop;
    dbms_output.put_line('ind : ' || ' , ' || ind);
    dbms_output.put_line('diff : ' || ' , ' || diff / (ind-1));
end;
/
exec avgdt;

select *
from dt;


select *
from cycle;

select *
from daily;
-- 1 100 2
-- 1�� ���� 100�� ��ǰ�� �����ϳ� �Ѱ��� �Դ´�.

 
--cycle
1 100 2 1

--> daily
1 100 20191104 1
1 100 20191111 1
1 100 20191118 1
1 100 20191125 1
select *
from cycle;

select *
from daily;

desc daily;


    
create or replace procedure create_daily_sales(p_yyyymm varchar2) -- ����Ʈ ���� ���� ����
is
    -- �޷��� �������� ������ record type
    type cla_row record is(
    dt varchar2(8), d varchar2(1));

-- �޷������� ������ table type
    type calendar is table of cal_row;
    cal calendar;
    
    -- �����ֱ� cursor
    -- �����ֱ� loop
    for rec in cycle_cursor loop
    end loop;
    
    
begin
    select to_char(to_date(p_yyyymm,'yyyymm')+ (level-1), 'yyyymmdd') dt,
        to_char(to_date(p_yyyymm,'yyyymm')+ (level-1), 'd') d
        bulk collect into cal
    from dual
    connect by level <= to_number(to_char(last(to_date('201911','yyyymm')),'dd');
    
    
    for i in 1..cal.cout loop
    end loop;
    dbms_output.put_line(cal(i).dt || ' , ' || cal(i).d);
end;
/
exec create_daily_sales('201911');


select to_number(to_char(last(to_date('201911','yyyymm')),'dd'))
;
select to_char(to_date('201911','yyyymm')+ (level-1), 'yyyymmdd') dt,
        to_char(to_date('201911','yyyymm')+ (level-1), 'd') d
from dual
connect by level <= to_number(to_char(last(to_date('201911','yyyymm')),'dd');

---------------------------------------------------------------------------------





----------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE create_daily_sales(p_yyyymm VARCHAR2)
IS
    --�޷��� �������� ������ RECORD TYPE
    TYPE cal_row IS RECORD (
        dt VARCHAR2(9),
        d VARCHAR2(1));
    
    --�޷� ������ ������ table type
    TYPE calendar IS TABLE OF cal_row;
    cal calendar;
    
    --�����ֱ� cursor
    CURSOR cycle_cursor IS
        SELECT *
        FROM cycle;
BEGIN
    SELECT TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d
           BULK COLLECT INTO cal
    FROM dual
    CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm, 'YYYYMM')),'DD'));
    
    --�����Ϸ��� �ϴ� ����� ���� �����͸� �����Ѵ�
    DELETE daily
    WHERE dt LIKE p_yyyymm || '%';
    
    --�����ֱ� loop
    FOR rec IN cycle_cursor LOOP
        FOR i IN 1..cal.count LOOP    
            --�����ֱ��� �����̶� ������ �����̶� ������ ��
            if REC.day = cal(i).d THEN
                INSERT INTO daily VALUES(rec.cid, rec.pid, cal(i).dt, rec.cnt);
            END IF;
        END LOOP;    
    END LOOP;
    COMMIT;    
END;
/

exec create_daily_sales('201911');

SELECT *
FROM daily;

commit;