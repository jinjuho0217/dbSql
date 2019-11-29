--cursor를 명시적으로 선언하지 않고
--loop에서 inline 형태로 cursor사용

--익명블록
set SERVEROUTPUT on;
DECLARE  -- cursor선언 --> loop에서 inline선언
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
    -- 선언부
    prev_dt date; -- 이전데이터를 담을 변수
    ind number := 0; -- 인덱스
    diff number := 0; -- 간격의 합
begin
    --dt테이블 모든 데이터 조회
    for rec in (select * from dt order by dt desc)loop  
        -- rec : dt컬럼
        -- 먼저 읽은 데이터(dt) - 다음데이터(dt) : 
        if ind = 0 then --loop의 시작부분
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
-- 1번 고객은 100번 제품을 월요일날 한개를 먹는다.

 
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


    
create or replace procedure create_daily_sales(p_yyyymm varchar2) -- 바이트 수를 쓰면 에러
is
    -- 달력의 행정보를 저장할 record type
    type cla_row record is(
    dt varchar2(8), d varchar2(1));

-- 달력정보를 저장할 table type
    type calendar is table of cal_row;
    cal calendar;
    
    -- 애음주기 cursor
    -- 애음주기 loop
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
    --달력의 행정보를 저장할 RECORD TYPE
    TYPE cal_row IS RECORD (
        dt VARCHAR2(9),
        d VARCHAR2(1));
    
    --달력 정보를 저장할 table type
    TYPE calendar IS TABLE OF cal_row;
    cal calendar;
    
    --애음주기 cursor
    CURSOR cycle_cursor IS
        SELECT *
        FROM cycle;
BEGIN
    SELECT TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d
           BULK COLLECT INTO cal
    FROM dual
    CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm, 'YYYYMM')),'DD'));
    
    --생성하려고 하는 년월의 실적 데이터를 삭제한다
    DELETE daily
    WHERE dt LIKE p_yyyymm || '%';
    
    --애음주기 loop
    FOR rec IN cycle_cursor LOOP
        FOR i IN 1..cal.count LOOP    
            --애음주기의 요일이랑 일자의 요일이랑 같은지 비교
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