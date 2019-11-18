select *
from user_views;

select *
from all_views
--다른 사용자로부터 권한을 받아서 볼수 있음
where owner = 'PC123';


SELECT *
FROM PC123.V_EMP_DEPT;
-- FROM 앞에 계정명을 붙여줘야 보인다.

--PC123에서 조회권한을 받은 V_EMP_DEPT view를 hr 계정에서 조회하기
-- 위해서는 계정명.view이름 형식으로 기술을 해야한다.
--매번 계정명을 기술하기 귀찮으므로 시논밍을 통해 다른 별칭으로 생성

create synonym V_EMP_DEPT FOR PC123.V_EMP_DEPT;
-- 시노님 생성
--PC123.V_EMP_DEPT ==> V_EMP_DEPT

SELECT *
FROM V_EMP_DEPT;
-- 위에서 PC123을 별칭을 주었기 때문에 계정명을 제거해야 정상적으로 나옴

--시노님 삭제
-- DROP TABLQ 테이블명
-- DROP SYNONYM 테이블명;

DROP SYNONYM V_EMP_DEPT;


--HR 계정의 비밀번호 : JAVA
--HR 계정 비밀번호 변경 : HR
ALTER USER HR IDENTIFIED BY HR;
ALTER USER PC123 IDENTIFIED BY JAVA; -- 본인 계정이 아니라 에러


--dictionary
-- 접두어 : user : 사용자 소유 객체
--              all : 사용자가 사용가능 한 객체
--              dba : 관리자 관점의 전체 객체(일반사용자는 사용불가)
--              v$ : 시스템과 관련되 view (일반사용자는 사용불가)

select *
from user_tables;

select *
from all_tables;

select *
from dba_tables 
where owner in('PC123', 'HR'); -- system계정에서 조회가능

-- 오라클에서 동일한 SQL이란?
-- 문자가 하난라고 틀리면 안됨
-- 다음SQL들은 같은결과를 만ㄷ르어 낼지 몰라도 서로 다른 DBMS에서는 
-- 서로 다른 SQL로 인식된다.

SELECT /* bind_test */*
FROM EMP;

select /* bind_test */*
from emp;

Select /* bind_test */*
from emp;
-- 문자가 서로 다르기 때문에 눈에는 같아 보여도 서로다른 sql로 인식된다.

Select /* bind_test */*
from emp
where empno=7369;

Select /* bind_test */*
from emp
where empno=7499;

Select /* bind_test */*
from emp
where empno=7521;


select *
from v$sql
where sql_text like '%emp%'; -- system에서 실행해야됨


select *
from v$sql
where sql_text like '%bind_test%'; -- system에서 실행해야됨

select *
from emp
where emp =:empno;