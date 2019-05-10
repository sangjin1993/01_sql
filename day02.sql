--DAY 2
--SCOTT 계정 EMP 테이블 조회

SELECT *
  FROM emp
;
  
  --SCOTT 계정 DEPT 테이블 조회
SELECT *
  FROM dept
;
-- 2. DQL : SELECT
-- 1) emp 테이블에서 job 컬럼을 조회
SELECT job
  FROM emp
  ;

-- 2) emp 테이블에서 중복을 제거하여
--    job 컬럼을 조회
SELECT DISTINCT job
  FROM emp
  ;
/* => 각 jpb이 한번씩 만 조회된 결과  
      를 얻을 수 있다.
    이 결과로 회사에는 다섯 종류의
    JOB 이 있음을 확인할 수 있다.
job
---------
CLERK
SALESMAN
ANALYST
MANAGER
PRESIDENT
/*
