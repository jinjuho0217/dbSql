select *
from fastfood;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='맥도날드'
group by sigungu, sido;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='버거킹'
group by sigungu, sido;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='KFC'
group by sigungu, sido;

 
select sido,SIGUNGU,count(addr)
from fastfood
where gb ='롯데리아'
group by sigungu, sido;


select a.sido, a.SIGUNGU,a.cnt, b.cnt, c.cnt, d.cnt, TRUNC((a.cnt+b.cnt+c.cnt) / d.cnt, 1)  as result
from
    (select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='맥도날드'
    group by sigungu, sido
    ) a,
    ( select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='버거킹'
    group by sigungu, sido
    )   b,
    (
    select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='KFC'
    group by sigungu, sido
    ) c, 
    (
        select sido,SIGUNGU,count(addr) cnt
    from fastfood
    where gb ='롯데리아'
    group by sigungu, sido      
    ) d 
    where
    a.sido = b.sido
    and a.sigungu = b.sigungu
    and a.sido = c.sido
    and a.sigungu = c.sigungu
    and a.sido = d.sido
    and a.sigungu = d.sigungu
    order by result desc;
--------------------------------------------------------------------------------------------------------------





