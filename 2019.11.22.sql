select *
from sales;

--���ǽ� ��������  �ǽ� 2)
--LPAD(' ',(LEVEL-1)*4, ' ') : �տ� ������ �ֱ����ؼ� ����� 
-- lpad�� ������ �ֱ����ؼ� �����, �տ� ���� ' '�� �־��� �� ������ ������ �ڿ� level���� ���� ����ŭ ' '�� �߰��Ѵٴ� �ǹ�

SELECT deptcd, LPAD(' ',(LEVEL-1)*4, ' ') || DEPT_H.DEPTNM deptnm, p_deptcd
FROM DEPT_H
START WITH deptcd = 'dept0_02'-- ���ڿ� �ȿ� �ִ°� ������ �ȴ�.
CONNECT BY PRIOR deptcd = p_deptcd;
--------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------

--����� ��������
--Ư�� ���� ���� �ڽ��� �θ��带 Ž��(Ʈ�� ��ü Ž���� �ƴϴ�.)
-- ���������� �������� ���� �μ��� ��ȸ
--�������� dept0_00_0

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

--h_4 : ���������
select  lpad(' ', (level-1)*4, ' ')  ||  s_id s_id, value 
from h_sum
start with s_id = '0'
connect by prior s_id = ps_id;
---------------------������
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
insert into no_emp values('XXȸ��', null, 1);
insert into no_emp values('�����ý��ۺ�', 'XXȸ��', 2);
insert into no_emp values('����1��', '�����ý��ۺ�', 5);
insert into no_emp values('����2��', '�����ý��ۺ�', 10);
insert into no_emp values('������ȹ��', 'XXȸ��', 3);
insert into no_emp values('��ȹ��', '������ȹ��', 7);
insert into no_emp values('��ȹ��Ʈ', '��ȹ��', 4);
insert into no_emp values('�����κ�', 'XXȸ��', 1);
insert into no_emp values('��������', '�����κ�', 7);

commit;


select *
from no_emp;


--����� ���� : ��ü�� ��ȸ�� �� ����
select  lpad(' ', (level-1)*4, ' ')  || org_cd org_cd, no_emp
from no_emp
start with org_cd = 'XXȸ��'
connect by prior org_cd=parent_org_cd;


-- ��������� : ��ü ��ȸ���ȵ�
select  lpad(' ', (level-1)*4, ' ')  || org_cd org_cd, no_emp
from no_emp
start with org_cd = '����2��'
connect by prior parent_org_cd =org_cd;

--prunning branch (����ġ��)
--������������ WHERE���� START WITH, CONNECT BY���� ���� ����� ���Ŀ� ����ȴ�.

--dept_h���̺��� �ֻ��� ��� ���� ����� ��ȸ
select deptcd, lpad(' ', 4*(level-1), ' ') || deptnm deptnm
from dept_h
start with deptcd='dept0'
connect by prior deptcd = p_deptcd;


-- ���������� �ϼ��� ���� where���� ����ȴ�.

select deptcd, lpad(' ', 4*(level-1), ' ') || deptnm deptnm
from dept_h
where deptnm != '������ȹ��'
start with deptcd='dept0'
connect by prior deptcd = p_deptcd;


-----------------------������
dept0	XXȸ��
dept0_00	    �����κ�
dept0_00_0	        ��������
dept0_01_0	        ��ȹ��
dept0_00_0_0	            ��ȹ��Ʈ
dept0_02	    �����ý��ۺ�
dept0_02_0	        ����1��
dept0_02_1	        ����2��
-----------------------
-- ������ȹ�θ� ������� ������ȹ�� �Ʒ��ִ� ��ȹ���� �����κ��� ���� ������ ��Ÿ����.


select deptcd, lpad(' ', 4*(level-1), ' ') || deptnm deptnm
from dept_h
start with deptcd='dept0'
connect by prior deptcd = p_deptcd and deptnm != '������ȹ��';

-----------------------������
dept0	XXȸ��
dept0_00	    �����κ�
dept0_00_0	        ��������
dept0_02	    �����ý��ۺ�
dept0_02_0	        ����1��
dept0_02_1	        ����2��
-----------------------
--������ȹ�� ��ü�� �����
-- where���� �� ������ ��� �γĿ� ���� ����� �޶�����.
--------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------
select  lpad(' ', 4*(level-1), ' ') || org_cd org_cd,
            connect_by_root(org_cd) root_org_cd
from no_emp
start with org_cd = 'XXȸ��'
connect by prior org_cd = parent_org_cd;
---------------------������
XXȸ��	XXȸ��
    �����κ�	XXȸ��
        ��������	XXȸ��
    ������ȹ��	XXȸ��
        ��ȹ��	XXȸ��
            ��ȹ��Ʈ	XXȸ��
    �����ý��ۺ�	XXȸ��
        ����1��	XXȸ��
        ����2��	XXȸ��
---------------------
--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------

select  lpad(' ', 4*(level-1), ' ') || org_cd org_cd,
            connect_by_root(org_cd) root_org_cd,
           ltrim( sys_connect_by_path(org_cd, '-'),'-') path_org_cd
from no_emp
start with org_cd = 'XXȸ��'
connect by prior org_cd = parent_org_cd;

----------------------------------------������
XXȸ��	            XXȸ��	-XXȸ��
    �����κ�	        XXȸ��	-XXȸ��-�����κ�
        ��������	    XXȸ��	-XXȸ��-�����κ�-��������
    ������ȹ��	    XXȸ��	-XXȸ��-������ȹ��
        ��ȹ��	        XXȸ��	-XXȸ��-������ȹ��-��ȹ��
            ��ȹ��Ʈ	XXȸ��	-XXȸ��-������ȹ��-��ȹ��-��ȹ��Ʈ
    �����ý��ۺ�	    XXȸ��	-XXȸ��-�����ý��ۺ�
        ����1��	    XXȸ��	-XXȸ��-�����ý��ۺ�-����1��
        ����2��	    XXȸ��	-XXȸ��-�����ý��ۺ�-����2��
-----------------------------------------
--LITRIM(,'-') -> ������ �� ���δ�.

--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
--CONNECT_BY_ROOT(COL) : COL�� �ֻ��� ��� �÷� ��
--SYS_CONNECT_BY_PATH(col, ������) : col�� �������� ������ �����ڷ� ���� ���
--    , LTRIM�� ���� �ֻ��� ��� ������ �����ڸ� ���� �ִ� ���°� �Ϲ���
--CONNECT_BY_ISLEAF isleaf : �ش� row�� leaf node���� �Ǻ�(1:o, 0:x)

select  lpad(' ', 4*(level-1), ' ') || org_cd org_cd,
            connect_by_root(org_cd) root_org_cd,
           ltrim( sys_connect_by_path(org_cd, '-'),'-') path_org_cd,
           CONNECT_BY_ISLEAF isleaf
           
from no_emp
start with org_cd = 'XXȸ��'
connect by prior org_cd = parent_org_cd;
-------------------------------������
XXȸ��	            XXȸ��	XXȸ��	                                0
    �����κ�	        XXȸ��	XXȸ��-�����κ�	                        0
        ��������    	XXȸ��	XXȸ��-�����κ�-��������	            1
    ������ȹ��	    XXȸ��	XXȸ��-������ȹ��	                    0
        ��ȹ��	        XXȸ��	XXȸ��-������ȹ��-��ȹ��	            0
            ��ȹ��Ʈ	XXȸ��	XXȸ��-������ȹ��-��ȹ��-��ȹ��Ʈ	1
    �����ý��ۺ�  	XXȸ��	XXȸ��-�����ý��ۺ�	                0
        ����1��    	XXȸ��	XXȸ��-�����ý��ۺ�-����1��	        1
        ����2��    	XXȸ��	XXȸ��-�����ý��ۺ�-����2��	        1
-----------------------------------------
--  CONNECT_BY_ISLEAF isleaf -> ������ ������ 1�� ǥ��, �������� 0
--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, 'ù��° ���Դϴ�');
insert into board_test values (2, null, '�ι�° ���Դϴ�');
insert into board_test values (3, 2, '����° ���� �ι�° ���� ����Դϴ�');
insert into board_test values (4, null, '�׹�° ���Դϴ�');
insert into board_test values (5, 4, '�ټ���° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (6, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (7, 6, '�ϰ���° ���� ������° ���� ����Դϴ�');
insert into board_test values (8, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (9, 1, '��ȩ��° ���� ù��° ���� ����Դϴ�');
insert into board_test values (10, 4, '����° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (11, 10, '���ѹ�° ���� ����° ���� ����Դϴ�');
commit;
--���ǽ� ��������  �ǽ� 6)
SELECT *
FROM BOARD_TEST;

-- ����� �������� �Ʒ��� ���� ������� �ϴ°� ����
--SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE
--FROM BOARD_TEST
--START WITH SEQ = '1' OR SEQ='2' OR SEQ ='4'
--CONNECT BY PRIOR  SEQ=PARENT_SEQ;

SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE
FROM BOARD_TEST
START WITH parent_seq is null
connect by prior seq = parent_seq;
----------------------------------������
        ù��° ���Դϴ�
            ��ȩ��° ���� ù��° ���� ����Դϴ�
        �ι�° ���Դϴ�
            ����° ���� �ι�° ���� ����Դϴ�
        �׹�° ���Դϴ�
            �ټ���° ���� �׹�° ���� ����Դϴ�
                ������° ���� �ټ���° ���� ����Դϴ�
                    �ϰ���° ���� ������° ���� ����Դϴ�
                ������° ���� �ټ���° ���� ����Դϴ�
            ����° ���� �׹�° ���� ����Դϴ�
                ���ѹ�° ���� ����° ���� ����Դϴ�
----------------------------------
--  TITLE�� �ҷ��� ���̰�, ������ ���� ������ �ִ°� SEQ�̴�. 
--  SEQ�� PARENT_SEQ�� ��
-- PARENT_SEQ�� ���� �θ�(�����μ�)�� ��� NULL������ ���´�.
-- ����  NULL���� �ִ� SEQ�� �������� �Ѵ�.

--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
--���ǽ� ��������  �ǽ� 7)
-- �ֽű۷� ����
--order siblings by�� ����ϸ� ���������� ������ü�� ������ �ȴ�.
SELECT  lpad(' ', 4*(level-1), ' ') || TITLE TITLE
FROM BOARD_TEST
START WITH parent_seq is null
connect by prior seq = parent_seq
order siblings by seq desc;
--------------------------------������
�׹�° ���Դϴ�
    ����° ���� �׹�° ���� ����Դϴ�
        ���ѹ�° ���� ����° ���� ����Դϴ�
    �ټ���° ���� �׹�° ���� ����Դϴ�
        ������° ���� �ټ���° ���� ����Դϴ�
        ������° ���� �ټ���° ���� ����Դϴ�
            �ϰ���° ���� ������° ���� ����Դϴ�
�ι�° ���Դϴ�
    ����° ���� �ι�° ���� ����Դϴ�
ù��° ���Դϴ�
    ��ȩ��° ���� ù��° ���� ����Դϴ�
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
-- �� �׷��ȣ �߰�
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
    
    