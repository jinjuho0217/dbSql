-- SELECT : 조회할 컬럼 명시
--          - 전체 컬럼 조회 : *
--          - 일부 컬럼 : 해당 컬럼명 나열(, 구분)
-- FROM : 조회할 테이블 명시
-- 쿼리를 여러줄에 나누어서 작성해도 상관없다.
-- 단 keyword풀어서 작성


SELECT *
FROM prod;

-- SELECT 컬럼 | express(문자열 상수) [as] 별칭
-- FROM 데이터를 조회할 테이블(VIEW)

SELECT  'TEST'
FROM emp;

DESC users_tables;
SELECT table_name
FROM user_tables;


