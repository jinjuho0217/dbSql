select *
from lprod
order by lprod_id;

rollback;
commit

delete from lprod 
where lprod_gu in('N230');



desc lprod;

delete from lprod
where lprod_id in(123);

delete from lprod
where lprod_nm = '���ǰ';

-------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------
create table mymember(
    mem_id varchar2(8) not null,  -- ȸ��ID
    mem_name varchar2(100) not null, -- �̸�
    mem_tel varchar2(50) not null, -- ��ȭ��ȣ
    mem_addr varchar2(128)    -- �ּ�
);

select *
from mymember;

delete from mymember 
where mem_id in('A123');

commit;