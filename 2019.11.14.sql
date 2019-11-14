--제약조건 활성화/ 비활성화
--언떤 제약조건을 활성화 (비활성화) 시킬 대상?

--emp fk제약(dept테이블의 deptno컬럼 참조)

----------------------------------------------------------------------------

-- FK_EMP_TEST_DEPT 비활성화
alter table emp_test DISABLE constraint FK_EMP_TEST_DEPT;

-----------------------------------------------------------------------------





------------------------------------------------------------------------------
--제약조건에 위배되는 데이터가 들어갈 수 있지않을까?

insert into emp_test(empno, ename, deptno)
values(9999,'brown','80');


--FK_EMP_TEST_DEPT
alter table emp_test enable constraint FK_EMP_TEST_DEPT;

--제약조건에 위배되는 데이터(소속 부서번호가 80번인 데이터)가 존재하여 제약조건 활성화 불가
delete emp
where empno = 9999;

--FK_EMP_TEST_DEPT
alter table emp_test enable constraint FK_EMP_TEST_DEPT;
commit;

select *
from emp_test;
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--현재 계정에 존재하는 데이블 목록 view 
-- 현재 계정에 존재하는 제약조건 view : USER_CONSTRAINTS
-- 현재 계정에 존재하는 제약조건의 컬럼VIEW : USER_CONS_COLUMNS

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CYCLE';



SELECT *
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME ='PK_CYCLE';

--테이블에 설정된 제약 조건(VIEW 조인)
--테이블명 / 제약조건 명 / 컬럼명 / 포지션
SELECT a.table_name, a.constraint_name, b.column_name, b.position
FROM user_constraints a, user_cons_columns b
WHERE a.constraint_name = b.constraint_name
AND a.constraint_type = 'P'
ORDER BY a.table_name, b.position;

-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--emp테이블과 8가지 컬럼 주석달기
--empno ename job mgr hiredate sal comm deptno


-- 테이블 주석 view : user_tab_comments

select *
from user_tab_comments
WHERE table_name = 'EMP';

-- emp테이블 주석
COMMENT ON TABLE emp IS '사원';

-- EMP테이블의 컬럼 주석 확인
SELECT *
FROM user_col_comments
where table_name = 'EMP';

COMMENT ON COLUMN  emp.empno  IS '사원번호';
COMMENT ON COLUMN  emp.ename  IS '이름';
COMMENT ON COLUMN emp.job  IS '담당업무';
COMMENT ON COLUMN  emp.mgr  IS '관리자사번';
COMMENT ON COLUMN  emp.hiredate  IS '입사일자';
COMMENT ON COLUMN  emp.sal  IS '급여';
COMMENT ON COLUMN  emp.comm  IS '상여';
COMMENT ON COLUMN  emp.deptno  IS '소속부서번호';
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--♠실습 테이블 comments 실습 1)
--user_tab_comments, user_col_comments view를 이용하여 customer, product, cycle, daily 테이블과
-- 컬럼의 주석 정보를 조회하는 쿼리를 작성하라
select *
from user_tab_comments;

select *
from user_col_comments;

select a.table_name, table_type, a.comments tab_comments, column_name,b.comments col_comments
from user_col_comments a join user_tab_comments b on(a.table_name = b.table_name)
where a.table_name in('CUSTOMER','CYCLE','DAILY','PRODUCT');

-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--view 생성(emp테이블에서 sal, comm 두 개 컬럼을 제외한다.)

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename,job, mgr, hiredate, deptno
FROM emp;

--VIEW(위 인라인뷰와 동일하다)
SELECT *
FROM v_emp;


--INLINE VIEW
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
            FROM emp
            );
            
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--조인된 쿼리 결과를 view로 생성 : v_emp_dept
-- emp, dept : 부서명, 사원번호, 사원명, 담당업무, 입사일자

CREATE OR REPLACE VIEW v_emp_dept AS -- VIEW만드는 법
SELECT a.dname, b.empno, b.ename, b.job, b.hiredate
FROM dept a , emp b
where a.deptno = b.deptno;

SELECT *
FROM v_emp_dept;
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--VIEW 제거

DROP VIEW v_emp;

-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--VIEW를 구성하는 테이블의 데이터를 변경하면 VIEW에도 영향이 간다.
--dept 30 = sales
SELECT *
FROM v_emp_dept;

--dept테이블의 sales --> MARKET SALES

UPDATE dept SET dname = 'MARKET SALES'
WHERE deptno =30;
rollback;
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--HR계정에게 v_emp_dept VIEW 조회권한을 준다.
GRANT SELECT ON v_emp_dept TO hr;
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--SEQUENCE 생성(게시글에 부여하는 시퀀스) 

CREATE SEQUENCE seq_post
INCREMENT BY 1
START WITH 1;

-- 게시글
SELECT seq_post.nextval
FROM dual;
-- 값이 증가한다.

-- 게시글 첨부파일
SELECT seq_post.currval
FROM dual;
-- 마직막 최종으로 시행된 sequence값을 불러온다.

select *
from post
where reg_id = 'brown'
and title = '하하하 재미있다.'
and reg_dt = TO_DATE('2019/11/14/ 15:40:15', 'YYYY/MM/DD HH24:MI:SS');

SELECT *
FROM POST
WHERE post_id =1;
-- SEQUENCE는 가주어라고 생각하면 됨
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--INDEX
--ROWID : 테이블 행의 물리적 주소, 해당 주소를 알면
-- 빠르게 테이블에 접근하는 것이 가능하다.
-- 값이 겹치지 않는다.
SELECT product. * , rowid
FROM PRODUCT
where rowid = 'AAAFL4AAFAAAAFOAAB'; 
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
--시퀀스 복습
-- sequence : 중복되지 않는 정수 값을 리턴 해주는 객체
-- 1,2,3,4,5,.....

--유일한 값을 만드는 방법
-- key table , UUID, sequence



desc emp_test;

drop table emp_test;

create table emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(15)
);

create sequence seq_emp_test; -- sequence객체 만들기

INSERT INTO emp_test 
VALUES(/*중복되지 않는 값 ->*/seq_emp_test.nextval , 'BROWN'); -- 실행하면 계속 1행씩 증가함

SELECT *
FROM emp_test;

-- sequence는 rollback이 안됨 rollback을 실행하고 다시 실행하면 전에 실행되던 부분부터 이어서 실행함

-------------------------------------------------------------------------------






-------------------------------------------------------------------------------

--실행계획을 통한 인덱스 사용확인
--EMP테이블에 EMPNO컬럼을 기준으로 인덱스가 없을 때

ALTER TABLE emp DROP CONSTRAINT pk_emp;

EXPLAIN PLAN FOR         -- 실행계획 보는법
SELECT *
FROM emp
WHERE EMPNO = 7369;

-- 인덱스가 없기 때문에 EMPNO가 7369인 데이터를 찾기 위해서 EMP테이블을 전체를 찾아봐야 한다. -> TABLE FULL SCAN

SELECT *
FROM TABLE(dbms_xplan.display); 
-- 오라클이 어떻게 실행 되었는지 보여줌
-- 실행계획은 위에서 아래순으로 읽고 
-- 자식에서 부모 순으로 읽는다 위의 실행계획을 예로 들면 1에서 0번 순으로 읽는다.
-- 즉, 라벨의 길이가 같으면 위에어 아래 순으로 읽고, 라벨의 길이가 다르면 깊이가 안쪽인 라벨 부터 읽는다.


--------------------------------------------------------------------실행결과
Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    37 |     3   (0)| 00:00:01 |         --> 라벨의 깊이가 다른경우 깊이가 더 깊은 라벨부터 읽는다.
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    37 |     3   (0)| 00:00:01 |      --> 라벨의 깊이가 같은 경우는 위에서 아래 순으로 읽는다.
 --  * 표시는
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369) --> index가 없어서 테이블 전체를 읽음 // index가 없는 경우(primary key, unique값이 없는 경우)에는 filter이고 index가 있으면(primary key, unique값이 있는 경우) access로 표시됨
------------------------------------------------------------------------------