select *
from sales;

--♠실습 계층쿼리  실습 2)
--LPAD(' ',(LEVEL-1)*4, ' ') : 앞에 공백을 주기위해서 사용함 
-- lpad는 공백을 주기위해서 사용함, 앞에 공백 ' '을 넣었을 때 공간이 남으면 뒤에 level에서 나온 수만큼 ' '을 추가한다는 의미

SELECT deptcd, LPAD(' ',(LEVEL-1)*4, ' ') || DEPT_H.DEPTNM deptnm, p_deptcd
FROM DEPT_H
START WITH deptcd = 'dept0_02'-- 문자열 안에 있는게 기준이 된다.
CONNECT BY PRIOR deptcd = p_deptcd;
--------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------

--상향식 계층쿼리
--특정 노드로 부터 자신의 부모노드를 탐색(트리 전체 탐색이 아니다.)
-- 디잔인팀을 시작으로 상위 부서를 조회
--디자인팀 dept0_00_0

select deptcd, lpad(' ', (level-1)*4, ' ') || dept_h.deptnm deptnm, p_deptcd
from dept_h
start with deptcd = 'dept0_00_0'
connect by prior p_deptcd=deptcd;


--------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------
create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;

select *
from h_sum;
-- deptcd = 'dept0_00_0'

--h_4 : 하향식쿼리
select  lpad(' ', (level-1)*4, ' ')  ||  s_id s_id, value 
from h_sum
start with s_id = '0'
connect by prior s_id = ps_id;
---------------------실행결과
0	
    01	
        012	
            0123	    10
            0124	    10
        015	
            0156	    20
        017	        50
        018	
            0189	    10
    11	                27
---------------------

--------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------

create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XX회사', null, 1);
insert into no_emp values('정보시스템부', 'XX회사', 2);
insert into no_emp values('개발1팀', '정보시스템부', 5);
insert into no_emp values('개발2팀', '정보시스템부', 10);
insert into no_emp values('정보기획부', 'XX회사', 3);
insert into no_emp values('기획팀', '정보기획부', 7);
insert into no_emp values('기획파트', '기획팀', 4);
insert into no_emp values('디자인부', 'XX회사', 1);
insert into no_emp values('디자인팀', '디자인부', 7);

commit;


select *
from no_emp;


--하향식 쿼리 : 전체를 조회할 수 있음
select  lpad(' ', (level-1)*4, ' ')  || org_cd org_cd, no_emp
from no_emp
start with org_cd = 'XX회사'
connect by prior org_cd=parent_org_cd;


-- 상향식쿼리 : 전체 조회가안됨
select  lpad(' ', (level-1)*4, ' ')  || org_cd org_cd, no_emp
from no_emp
start with org_cd = '개발2팀'
connect by prior parent_org_cd =org_cd;

--prunning branch (가지치기)
--계층쿼리에서 WHERE절은 START WITH, CONNECT BY절이 전부 적용된 이후에 실행된다.

--dept_h테이블을 최상위 노드 부터 하향식 조회
select deptcd, lpad(' ', 4*(level-1), ' ') || deptnm deptnm
from dept_h
start with deptcd='dept0'
connect by prior deptcd = p_deptcd;


-- 계층쿼리가 완성된 이후 where절이 적용된다.

select deptcd, lpad(' ', 4*(level-1), ' ') || deptnm deptnm
from dept_h
where deptnm != '정보기획부'
start with deptcd='dept0'
connect by prior deptcd = p_deptcd;


-----------------------실행결과
dept0	XX회사
dept0_00	    디자인부
dept0_00_0	        디자인팀
dept0_01_0	        기획팀
dept0_00_0_0	            기획파트
dept0_02	    정보시스템부
dept0_02_0	        개발1팀
dept0_02_1	        개발2팀
-----------------------
-- 정보기획부만 사라져서 정보기획부 아래있는 기획팀이 디자인부의 하위 팀같이 나타난다.


select deptcd, lpad(' ', 4*(level-1), ' ') || deptnm deptnm
from dept_h
start with deptcd='dept0'
connect by prior deptcd = p_deptcd and deptnm != '정보기획부';

-----------------------실행결과
dept0	XX회사
dept0_00	    디자인부
dept0_00_0	        디자인팀
dept0_02	    정보시스템부
dept0_02_0	        개발1팀
dept0_02_1	        개발2팀
-----------------------
--정보기획부 전체가 사라짐
-- where절에 들어간 내용을 어디에 두냐에 따라서 결과가 달라진다.
--------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------
select  lpad(' ', 4*(level-1), ' ') || org_cd org_cd,
            connect_by_root(org_cd) root_org_cd
from no_emp
start with org_cd = 'XX회사'
connect by prior org_cd = parent_org_cd;
---------------------실행결과
XX회사	XX회사
    디자인부	XX회사
        디자인팀	XX회사
    정보기획부	XX회사
        기획팀	XX회사
            기획파트	XX회사
    정보시스템부	XX회사
        개발1팀	XX회사
        개발2팀	XX회사
---------------------
--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------

select  lpad(' ', 4*(level-1), ' ') || org_cd org_cd,
            connect_by_root(org_cd) root_org_cd,
           ltrim( sys_connect_by_path(org_cd, '-'),'-') path_org_cd
from no_emp
start with org_cd = 'XX회사'
connect by prior org_cd = parent_org_cd;

----------------------------------------실행결과
XX회사	            XX회사	-XX회사
    디자인부	        XX회사	-XX회사-디자인부
        디자인팀	    XX회사	-XX회사-디자인부-디자인팀
    정보기획부	    XX회사	-XX회사-정보기획부
        기획팀	        XX회사	-XX회사-정보기획부-기획팀
            기획파트	XX회사	-XX회사-정보기획부-기획팀-기획파트
    정보시스템부	    XX회사	-XX회사-정보시스템부
        개발1팀	    XX회사	-XX회사-정보시스템부-개발1팀
        개발2팀	    XX회사	-XX회사-정보시스템부-개발2팀
-----------------------------------------
--LITRIM(,'-') -> 정렬할 때 쓰인다.

--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
--CONNECT_BY_ROOT(COL) : COL의 최상위 노드 컬럼 값
--SYS_CONNECT_BY_PATH(col, 구분자) : col의 계층구조 순서를 구분자로 이은 경로
--    , LTRIM을 통해 최상위 노드 왼쪽의 구분자를 없애 주는 형태가 일반적
--CONNECT_BY_ISLEAF isleaf : 해당 row가 leaf node인지 판별(1:o, 0:x)

select  lpad(' ', 4*(level-1), ' ') || org_cd org_cd,
            connect_by_root(org_cd) root_org_cd,
           ltrim( sys_connect_by_path(org_cd, '-'),'-') path_org_cd,
           CONNECT_BY_ISLEAF isleaf
           
from no_emp
start with org_cd = 'XX회사'
connect by prior org_cd = parent_org_cd;
-------------------------------실행결과
XX회사	            XX회사	XX회사	                                0
    디자인부	        XX회사	XX회사-디자인부	                        0
        디자인팀    	XX회사	XX회사-디자인부-디자인팀	            1
    정보기획부	    XX회사	XX회사-정보기획부	                    0
        기획팀	        XX회사	XX회사-정보기획부-기획팀	            0
            기획파트	XX회사	XX회사-정보기획부-기획팀-기획파트	1
    정보시스템부  	XX회사	XX회사-정보시스템부	                0
        개발1팀    	XX회사	XX회사-정보시스템부-개발1팀	        1
        개발2팀    	XX회사	XX회사-정보시스템부-개발2팀	        1
-----------------------------------------
--  CONNECT_BY_ISLEAF isleaf -> 최하위 계층을 1로 표현, 나머지는 0
--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, '첫번째 글입니다');
insert into board_test values (2, null, '두번째 글입니다');
insert into board_test values (3, 2, '세번째 글은 두번째 글의 답글입니다');
insert into board_test values (4, null, '네번째 글입니다');
insert into board_test values (5, 4, '다섯번째 글은 네번째 글의 답글입니다');
insert into board_test values (6, 5, '여섯번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (7, 6, '일곱번째 글은 여섯번째 글의 답글입니다');
insert into board_test values (8, 5, '여덜번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (9, 1, '아홉번째 글은 첫번째 글의 답글입니다');
insert into board_test values (10, 4, '열번째 글은 네번째 글의 답글입니다');
insert into board_test values (11, 10, '열한번째 글은 열번째 글의 답글입니다');
commit;
--♠실습 계층쿼리  실습 6)
SELECT *
FROM BOARD_TEST;

-- 결과는 나오지만 아래와 같은 방식으로 하는게 맞음
--SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE
--FROM BOARD_TEST
--START WITH SEQ = '1' OR SEQ='2' OR SEQ ='4'
--CONNECT BY PRIOR  SEQ=PARENT_SEQ;

SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE
FROM BOARD_TEST
START WITH parent_seq is null
connect by prior seq = parent_seq;
----------------------------------실행결과
        첫번째 글입니다
            아홉번째 글은 첫번째 글의 답글입니다
        두번째 글입니다
            세번째 글은 두번째 글의 답글입니다
        네번째 글입니다
            다섯번째 글은 네번째 글의 답글입니다
                여섯번째 글은 다섯번째 글의 답글입니다
                    일곱번째 글은 여섯번째 글의 답글입니다
                여덜번째 글은 다섯번째 글의 답글입니다
            열번째 글은 네번째 글의 답글입니다
                열한번째 글은 열번째 글의 답글입니다
----------------------------------
--  TITLE은 불러올 값이고, 고유의 값을 가지고 있는건 SEQ이다. 
--  SEQ와 PARENT_SEQ와 비교
-- PARENT_SEQ는 위에 부모(상위부서)가 없어서 NULL값으로 나온다.
-- 따라서  NULL값이 있는 SEQ를 시작으로 한다.

--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
--♠실습 계층쿼리  실습 7)
-- 최신글로 정렬
--order siblings by를 사용하면 계층구조가 유지된체로 정렬이 된다.
SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE
FROM BOARD_TEST
START WITH parent_seq is null
connect by prior seq = parent_seq
order siblings by seq desc;
--------------------------------실행결과
네번째 글입니다
    열번째 글은 네번째 글의 답글입니다
        열한번째 글은 열번째 글의 답글입니다
    다섯번째 글은 네번째 글의 답글입니다
        여덜번째 글은 다섯번째 글의 답글입니다
        여섯번째 글은 다섯번째 글의 답글입니다
            일곱번째 글은 여섯번째 글의 답글입니다
두번째 글입니다
    세번째 글은 두번째 글의 답글입니다
첫번째 글입니다
    아홉번째 글은 첫번째 글의 답글입니다
--------------------------------
--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
 
(SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE
FROM BOARD_TEST
START WITH parent_seq is null
connect by prior seq = parent_seq
order siblings by seq asc)a
order siblings by seq desc;


SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE
FROM BOARD_TEST
START WITH parent_seq is null
connect by prior seq = parent_seq;


SELECT *
FROM BOARD_TEST;

SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE
FROM BOARD_TEST
START WITH parent_seq is null
connect by prior seq = parent_seq;

SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE
FROM BOARD_TEST
START WITH  parent_seq is null
connect by prior seq = parent_seq;


SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE,
            case when parent_seq is null then seq else 0 end o1
FROM BOARD_TEST
START WITH parent_seq is null
connect by prior seq = parent_seq
order siblings by seq desc;

SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE,
            case when parent_seq is null then seq else 0 end o1
    --        case when parent_seq is null then seq else 0 end o2
FROM BOARD_TEST
START WITH parent_seq is null
connect by prior seq = parent_seq
order siblings by seq desc;


select *
from board_test;
-- 글 그룹번호 추가
alter table board_test add (gn Number);

select seq, lpad(' ', 4*(level-1), ' ') || TITLE TITLE
from board_test
start with parent_seq is null
connect by prior seq = parent_seq
order siblings by gn desc, seq;
--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
select a.ename, a.sal, b.sal
from
(select ename, sal
from emp
order by sal desc)a,
(select ename, sal
from
(select ename, sal
from emp
order by sal desc)) b;

select a.ename, a.sal, b.sal
from
(select ename, sal, rownum rn
from 
    (select ename, sal 
    from emp
    order by sal desc))a 
        left outer join
(select ename, sal, rownum rn
from
    (select ename, sal
    from emp
    order by sal desc))b on a.rn = b.rn -1;
    
    