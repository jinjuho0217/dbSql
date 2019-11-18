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
where lprod_nm = '축산품';

-------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------
create table mymember(
    mem_id varchar2(8) not null,  -- 회원ID
    mem_name varchar2(100) not null, -- 이름
    mem_tel varchar2(50) not null, -- 전화번호
    mem_addr varchar2(128)    -- 주소
);

select *
from mymember;

delete from mymember 
where mem_id in('A123');

commit;