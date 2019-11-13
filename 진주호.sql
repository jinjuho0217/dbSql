SELECT *
FROM REGIONS;

SELECT *
FROM COUNTRIES;

--♠실습 J0IN 8)
SELECT REGIONS.REGION_ID ,REGION_NAME, COUNTRY_NAME
FROM REGIONS JOIN COUNTRIES ON(REGIONS.REGION_ID = COUNTRIES.REGION_ID) AND REGION_NAME ='Europe';
--------------------실행결과
1	Europe	Netherlands
1	Europe	France
1	Europe	United Kingdom
1	Europe	Denmark
1	Europe	Belgium
1	Europe	Switzerland
1	Europe	Italy
1	Europe	Germany
--------------------

--♠실습 J0IN 9)
SELECT REGIONS.REGION_ID , REGION_NAME, COUNTRY_NAME, CITY
FROM
 REGIONS  JOIN COUNTRIES ON(REGIONS.REGION_ID = COUNTRIES.REGION_ID) JOIN LOCATIONS ON(COUNTRIES.COUNTRY_ID = LOCATIONS.COUNTRY_ID) AND REGION_NAME ='Europe';
 -------------------------------실행결과
 1	Europe	United Kingdom	Stretford
1	Europe	United Kingdom	Oxford
1	Europe	United Kingdom	London
1	Europe	Netherlands	    Utrecht
1	Europe	Italy	            Venice
1	Europe	Italy               	Roma
1	Europe	Germany	        Munich
1	Europe	Switzerland	    Bern
1	Europe	Switzerland	    Geneva
-------------------------------
--♠실습 J0IN 10)
SELECT REGIONS.REGION_ID , REGION_NAME, COUNTRY_NAME, CITY, DEPARTMENT_NAME
FROM 
 REGIONS  JOIN COUNTRIES ON(REGIONS.REGION_ID = COUNTRIES.REGION_ID) JOIN LOCATIONS ON(COUNTRIES.COUNTRY_ID = LOCATIONS.COUNTRY_ID) 
 JOIN DEPARTMENTS ON( LOCATIONS.LOCATION_ID = DEPARTMENTS.LOCATION_ID) AND REGION_NAME ='Europe';
 
 select *
 from locations;
 
 select *
 from countries;

--♠실습 J0IN 11)

 SELECT REGIONS.REGION_ID , REGION_NAME, COUNTRY_NAME, CITY, DEPARTMENT_NAME, first_name || last_name
FROM 
REGIONS  JOIN COUNTRIES ON(REGIONS.REGION_ID = COUNTRIES.REGION_ID) JOIN LOCATIONS ON(COUNTRIES.COUNTRY_ID = LOCATIONS.COUNTRY_ID) 
JOIN DEPARTMENTS ON( LOCATIONS.LOCATION_ID = DEPARTMENTS.LOCATION_ID) JOIN EMPLOYEES ON(DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID) AND REGION_NAME ='Europe';

--♠실습 J0IN 12)
SELECT a.employee_id, first_name || last_name, a.job_id, job_title
FROM EMPLOYEES a JOIN JOBS b ON(a.JOB_ID = b.JOB_ID);


--♠실습 J0IN 13)
SELECT a.employee_id, first_name || last_name name, a.job_id, job_title
FROM EMPLOYEES a JOIN JOBS b ON(a.JOB_ID = b.JOB_ID);

SELECT MANAGER_ID,a.employee_id, first_name || last_name name, a.job_id, job_title
FROM EMPLOYEES a JOIN JOBS b ON(a.JOB_ID = b.JOB_ID)
where JOB_TITLE ='Stock Manager';

select MANAGER_ID
FROM EMPLOYEES;

SELECT a.employee_id, a.first_name || a.last_name name, a.job_id, job_title, b.MANAGER_ID, b.first_name || b.last_name mgr_name
FROM EMPLOYEES a JOIN JOBS b ON(a.JOB_ID = b.JOB_ID) JOIN EMPLOYEES b ON(a.MANAGER_ID  = b.EMPLOYEE_ID);
 

