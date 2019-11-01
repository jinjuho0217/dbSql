--복습
--WHERE
--연산자
--비교 : =, !=, <>, >=,
--BETWEEN start    AND    end
-- IN (set)
--LIKE 'S%; (% : 다수의 문자열과 매칭, _ : 정확히 한글자 매칭)
-- IS NULL비교 (!=NULL => X )
--AND, OR, NOT

--emp 테이블에서 입사일자가 1981년 6월 1일 부터 1986년 12월 31일 사의 직원 정보 가져오기
SELECT *
FROM emp
--WHERE  hiredate BETWEEN TO_DATE('1981/06/01') AND TO_DATE('1986/12/31');
WHERE hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD') AND hiredate <=TO_DATE('1986/12/31', 'YYYY/MM/DD');

--emp 테이블에서 관리자 (mgr)이 있는 직원만 조회
SELECT *
FROM emp
WHERE mgr IS NOT null;

--♠실습 AND OR WHERE12)
SELECT *
FROM emp
WHERE job IN('SALESMAN') OR empno LIKE('78%');


--♠실습 AND OR WHERE13)
-- LIKE안쓰고
--empno : 78, 780, 789,.,,,,,,,
SELECT *
FROM emp
WHERE job IN('SALESMAN') OR empno BETWEEN(7800) AND(7899) OR empno BETWEEN(780) AND(789) OR empno IN(78);

--♠실습 AND OR WHERE14) 연산자의 우선순위를 생각해서 ( )를 묶어준다.
SELECT *
FROM emp
WHERE job IN('SALESMAN') OR ( empno LIKE('78%') AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD') );

--order by 컬럼명 | 별칭 | 컬럼인덱스 [ASC |DESC]
-- ASC : 오름차순(기본) / DESC : 내림차순
-- order by 구문은 WHERE절 다음에 기술
-- WHERE절이 없을 경우 FROM절 다음에 기술
--emp 테이블을 ename 기준으로 오름차순 정렬

SELECT *
FROM emp
ORDER BY ename ASC; 
-- ASC : default
--ASC를 안붙여도 위 쿼리와 동일한 결과가 나옴

--이름(ename)을 기준으로 내림차순
SELECT *
FROM emp
ORDER BY ename DESC;

--job을 기준으로 내림차순으로 정렬, 만약 job이 같을 경우 사번(empno)으로 올림차순 정렬
SELECT *
FROM emp
ORDER BY job DESC, empno ASC;

--별칭으로 정렬하기
--사원 번호(empno), 사원명(ename), 연봉(sal *12) as year_sal
-- year_sal 별칭으로 오름차순 정렬
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT절 컬럼 순서 인덱스로 정렬
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY 4; -- 컬럼명으로 하지 않고 인덱스 번호를 입력해도 같은 결과가 나옴

--♠실습 ORDER BY orderby1)
SELECT *
FROM dept
ORDER BY dname ASC;

SELECT *
FROM dept
ORDER BY loc DESC;

--♠실습 ORDER BY orderby2)
SELECT *
FROM emp
WHERE comm IS NOT NULL
ORDER BY comm DESC, empno ASC;

--♠실습 ORDER BY orderby3)
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job ASC, empno DESC;

--♠실습 ORDER BY orderby4)
SELECT *
FROM emp
WHERE (deptno = 10  OR deptno = 30 )AND sal  > 1500
ORDER BY ename DESC;

desc emp;

SELECT  ROWNUM, empno, ename
FROM emp
--WHERE ROWNUM =2;-- 1을 읽지 않음
--WHERE ROWNUM >10;-- 안됨(1~10까지 읽지 않음) 이미 읽은 데이터에 순서를 부여함
WHERE ROWNUM <=10;


--emp테이블에서 사번(empno), 이름(ename)을 급여 기준으로 오름차순으로 정렬하고 정렬된 결과 순으로 ROWNUM
SELECT empno, ename, sal , ROWNUM
FROM emp
ORDER BY sal;


-- a라는 별칭을 주고 뒤에 . 을 적어줘야 오류 없이 실행된다.
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal 
FROM emp 
ORDER BY sal)a;

-- ♠실습 ROWNUM row1)
SELECT ROWNUM, a.*
FROM
    (SELECT empno, ename , sal
    FROM emp
    ORDER BY sal)a
WHERE ROWNUM BETWEEN 1 AND 10;

-- ♠실습 ROWNUM row2)
-- ROWNUM 정렬할 때 별칭을 줘서 사용한다.
SELECT *
FROM
    (SELECT ROWNUM AA, a.*
        FROM
        (SELECT empno, ename , sal
        FROM emp
        ORDER BY sal)a
    WHERE ROWNUM BETWEEN 1 AND 20)b
WHERE AA BETWEEN 11 AND 14;

-- FUNCTION
--DUAL 테이블 조회
SELECT 'HELLO WORLD' AS msg
FROM DUAL;

SELECT 'HELLO WORLD' AS msg
FROM emp;

--문자열 대소문자 관련 함수
--LOWER, UPPER, INITCAP

SELECT LOWER('HELLO, WORLD'), UPPER('hello, world'), INITCAP('hello, world')
FROM emp
WHERE job = 'SALESMAN';

--FUNCTION은 WHERE절에서도 사용가능
SELECT *
FROM emp
WHERE ename = UPPER('smith');


SELECT *
FROM emp
WHERE LOWER (ename) = ('smith');

--개발자 SQL칠거지악
-- 1. 좌변을 가공하지 말아라
--좌변 (TABLE의 컬럼)을 가공하게 되면 INDEX를 정상적으로 사용하지 못함
-- Function Based Index -> FBI

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
            RPAD('HELLO, WORLD', 15, '*' )
            
            
FROM DUAL;



