-- day04 : 실습 4일차

-- (6) 연산자 2. 비교연산자
--     비교연산자는 SELECT 절에 사용할 수 없음
--     WHERE, HAVING 절에만 사용할 수 있음.

-- 22) 급여가 2000이 넘는 직원의 사번, 이름, 급여를 조회
SELECT e.empno 사번
     , e.ename 이름
     , e.sal 급여
  FROM emp e
 WHERE e.sal > 2000
 ;
