--복습 WHERE 11
--job이 SALESMAN이거나 입사일자가 1981년6월 01이후인 직원정보 조회
--이거나 -> OR
--1981년 06월 01일 이후 --> 1981 06 01 포함해서

SELECT *
FROM emp
WHERE job ='SALESMAN' OR hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

DESC emp;


--ROWNUM
SELECT ROWNUM, E.*
FROM emp E;

--ROWNUM과 정렬 문제
--ORDER BY절은 SELECT 절 이후에 동작
--ROWNUM 가상컬럼이 적용되고 나서 정렬되기 때문에 우리가 원하는대로 첫번째 데이터부터 순차적인 번호 부여가되지 않는다.
SELECT ROWNUM, E.*
FROM emp E
ORDER BY ename;


--ORDER BY절을 포함한 인라인 뷰를 구성
SELECT ROWNUM, AA.*
FROM 
    (SELECT e.*
    FROM emp e
    ORDER BY ename)AA;

--ROWNUM : 1번부터 읽어야 된다.
-- WHERE절에 ROWNUM값을 중간만 읽는 것은 불가능

-- 안되는 케이스
-- WHERE ROWNUM =2
-- WHRER ROWNUM >=2

--되는 케이스
--WHERE ROWNUM =1 , =을 사용해서 되는 건 1번 밖에 없다.
--WHERE ROWNUM <= 10

--페이징 처리를 위한 꼼수 ROWNUM에 별칭을 부여, 해당 SQL을 INLINE VIWE로 감싸고
-- 별칭을 통해 페이징 처리



SELECT *
FROM
(SELECT ROWNUM rn, AA.*
FROM 
    (SELECT e.*
    FROM emp e
    ORDER BY ename)AA)
    WHERE rn BETWEEN 10 AND 14;


--19년 11월 1일~4일    
    --CONCAT : 문자열 결합 - 두 개의 문자열을 결합하는 함수
--SUBSTR : 문자열의 부분 문자열(java : String. substring)
--LENGTH : 문자열의 길이
--INSTR : 문자열에 특정 문자열이 등장하는 첫번째 인덱스
--LPAD : 문자열에 특정 문자열을 삽입
SELECT CONCAT(CONCAT('HELLO', ', ') ,' WORLD') CONCAT,
            SUBSTR ('HELLO, WORLD', 0, 5)substr,
            SUBSTR ('HELLO, WORLD', 1, 5)substr1,
            LENGTH('HELLO, WORLD')  length,
            INSTR('HELLO, WORLD', 'O')instr,
            
            --INSTR(문자열, 찾을 문자열, 문자열의 특정 위치 이후 표시)
            INSTR('HELLO, WORLD', 'O', 6)instr1, -- 문자열의 인덱스
            
            --LAPD(문자열, 전체문자열의 길이, 문자열이 전체문자열 길이에 미치지 못할경우 추가할 문자)
            LPAD('HELLO, WORLD', 15, '*'),
            LPAD('HELLO, WORLD', 15), -- 모자란 부분을 채워넣을 특수문자를 넣지 않으면 공백으로 표시가 된다.
            RPAD('HELLO, WORLD', 15, '*' ),
            --replace(원본문자열, 원본 문자열에서 변경하고자 하는 대상 문자열, 변경 문자열)
          REPLACE (REPLACE('HELLO, WORLD', 'HELLO','hello'), 'WORLD', 'world')replace,
          -- trim 앞뒤 여백을 지워줌
          TRIM(' HELLO,  WORLD ') trim,
          -- H문자열을 지움
          TRIM('H' FROM 'HELLO,  WORLD')trim2
           
           
          
            
FROM DUAL;

--ROUND(대상숫자, 반올림 결과 자리수)
SELECT ROUND(105.54 , 1)r1,-- 소수점 둘째자리에서 반올림
            ROUND(105.55, 1)r2, -- 소수점 둘째자리에서 반올림
            ROUND(105.55, 0)r3, -- 소수점 첫째자리에서 반올림
            ROUND(105.55, -1)r4 -- 정수 첫째 자리에서 반올림            
            
FROM dual;

SELECT TRUNC(105.54 , 1)t1,-- 소수점 둘째자리에서 절삭
            TRUNC(105.55, 1)t2, -- 소수점 둘째자리에서 절삭
            TRUNC(105.55, 0)t3, -- 소수점 첫째자리에서 절삭
            TRUNC(105.55, -1)t4 -- 정수 첫째 자리에서 절삭            
            
FROM dual;
desc emp;
SELECT empno, ename, sal,sal/1000, ROUND (sal/1000)Quotient, 
    MOD(sal,1000) reminder--0~999 강제로 범위를 줄일 때 사용함
    --MOD : 나눗셈의 나머지 값
FROM emp;

--SYSDATE : 오라클이 설치된 서버의 현재 날짜 시간정보를 리턴
-- 별도의 인자가 없는 함수

--TO_CHAR : DATE 타입을 문자열로 변환
-- 날짜를 문자열로 변환시에 포맷을 지정

--SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
--SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH12:MI:SS')
SELECT TO_CHAR(SYSDATE + (1/24/60)*30, 'YYYY-MM-DD HH24:MI:SS'),
            TO_CHAR(SYSDATE, 'YYYY-MM-DD HH12:MI:SS')
FROM dual;

--♠실습 FUNCTION DATE 1)
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
--년도 : YYYY, YY, RR(2 자리일때랑 4자리일 때랑 다름)
-- YYYY, RRRR은 동일
-- RR, YY
--가급적이면 명시적으로 표현
SELECT TO_CHAR(TO_DATE('35/03/01', 'RR/MM/DD'), 'YYYY/MM/DD') r1,
            TO_CHAR(TO_DATE('55/03/01', 'RR/MM/DD'), 'YYYY/MM/DD') r2,
            TO_CHAR( TO_DATE('55/03/01', 'YY/MM/DD'), 'YYYY/MM/DD') y1,
            TO_CHAR(SYSDATE, 'D') d, --오늘은 월요일-2
            TO_CHAR(SYSDATE, 'IW') IW, --몇주차 표기
            TO_CHAR(TO_DATE('20191229','YYYYMMDD'), 'IW') THIS_YEAR
FROM dual;


--♠실습 FUNCTION DATE 2)
SELECT TO_CHAR(TO_DATE('2019-11-04','YYYY-MM-DD'),'YYYY-MM-DD'),
             TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
            TO_CHAR(TO_DATE('04-11-2019','DD-MM-YYYY'),'DD-MM-YYYY')
FROM dual;


--날짜의 반올림(ROUND), 절삭(TRUNC)
--ROUND(DATE, '포맷') YYYY-MM-DD
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
    TO_CHAR( TRUNC(hiredate, 'YYYY'), 'YYYY-MM-DD HH24:MI:SS') AS trunc_yyyy,-- 월에서절삭
    TO_CHAR( TRUNC(hiredate, 'MM'), 'YYYY-MM-DD HH24:MI:SS') AS trunc_MM,-- 날짜에서 절삭
    TO_CHAR( TRUNC(hiredate, 'DD'), 'YYYY-MM-DD HH24:MI:SS') AS trunc_DD,
    TO_CHAR( TRUNC(hiredate-1, 'MM'), 'YYYY-MM-DD HH24:MI:SS') AS trunc_MM,
    TO_CHAR( TRUNC(hiredate-2, 'MM'), 'YYYY-MM-DD HH24:MI:SS') AS trunc_MM
FROM emp
WHERE ename = 'SMITH';

--날짜 연산함수
-- MONTHS_BETWEEN(DATE, DATE) : 구 날짜 사이의 개월 수
-- 1980,12.17~2019,11.04 => 2019.11.17
SELECT  ename, TO_CHAR(hiredate,'YYYY-MM-DD') hiredate,           
            MONTHS_BETWEEN(SYSDATE, hiredate) months_between,
            MONTHS_BETWEEN(TO_DATE('20191117','YYYY-MM-DD'), hiredate) months_between
FROM emp
WHERE ename ='SMITH';

SELECT MOD(467,12)
FROM dual;

--ADD_MONTHS(DATE, 개월수) : DATE에 개월수가 지난 날짜
-- 개월수가 양수일 경우 미래, 음수일 경우 과거
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

--NEXT_DAY(DATE, 요일) : DATE이후 첫번째 요일의 날짜
SELECT SYSDATE,
            NEXT_DAY(SYSDATE, 7) first_sat,-- 오늘 날짜 이후 첫 토요일 일자
            NEXT_DAY(SYSDATE, '토요일') first_sat-- 오늘 날짜 이후 첫 토요일 일자
FROM dual;

-- LAST_DAY(DATE) 해당 날짜가 속한 월의 마지막 일자
SELECT SYSDATE, LAST_DAY(SYSDATE) LAST_DAY,
          LAST_DAY( ADD_MONTHS (SYSDATE, 1)) LAST_DAT_12
FROM dual;

-- DATE + 정수 = DATE(DATE에서 정수만큼 이후의 DATE)
--D1 + 정수 = D2
-- 양변에서 D2를 차감
-- D1 + 정수 -D2 = D2-D2
-- D1 + 정수 - D2 = 0
--날짜에서 날짜를 빼면 일자가 나온다.

SELECT TO_DATE('20191104','YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') d_1,
            TO_DATE('20191201','YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') d_2,
            --201908 : 2019년 8월의 일수 : 31
           ADD_MONTHS( TO_DATE('201908', 'YYYYMM'), 1) - TO_DATE('201908', 'YYYYMM')d_3
FROM dual;