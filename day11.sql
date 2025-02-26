--day 11
---- 7. 조인과 서브쿼리
-- (2) 서브쿼리 : Sub-Query

--      SELECT, FROM, WHERE 절에 사용될 수 있다.

-- 문제) BLAKE와 직무(job)가 동일한 직원의 정보를 조회
-- 1. BLAKE의 직무를 조회
SELECT e.job
  FROM emp e
 WHERE e.ename = 'BLAKE'
;
/*
MANAGER
*/
-- 2. 1의 결과를 적용(매인쿼리)
-- ==> 직무(job)가 MANAGER 인 사람을 조회하여라.
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.job = 'MANAGER'
;
-- 메인 쿼리는 WHERE 절의 조건 중 
-- MANAGER 값 자리에 1의 쿼리가 통으로 들어간다.
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.job = (SELECT e.job
                  FROM emp e
                 WHERE e.ename = 'BLAKE')
;

-- ==> 메인쿼리의 WHERE절 () 괄호 안에 전달되는 값은
--     1번 쿼리의 결과인 MANAGER 라는 값이다.

-----------------------------
-- 서브쿼리 수업중 실습
-- 1. 이 회사의 평균 급여보다 급여를 많이 받는 직원을 모두 조회하여라.
--    사번, 이름, 급여

-- a) 회사의 급여 평균값을 구하는 쿼리
SELECT avg(e.sal)
  FROM emp e
;

-- b) 그 평균 값을 직접 적용하여 그 값보다 급여가 높은 직원을 구하는 쿼리
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > 1933.92
;

-- c) b의 쿼리에서 평균 값 자리에 (a)의 쿼리를 대체
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > (SELECT avg(e.sal)
                 FROM emp e)
;
-- 2.급여가 평균 급여보다 크면서
--   사번이 7700번 보다 높은 직원을 조회하시오.
--   사번, 이름, 급여를 조회
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > (SELECT avg(e.sal)
                 FROM emp e)
   AND e.empno > 7700
;

-- 3. 각 직무별로 최대 급여를 받는 직원 목록을 조회하여라.
--   사번, 이름, 직무, 급여를 조회

-- a) 직무별로 최대 급여를 구하는 쿼리 : 그룹함수(MAX), 그룹화기준컬럼(job)
SELECT max(e.sal)
  FROM emp e
 GROUP BY e.job
;
-- b) (a)에서 구해진 최대 급여와 job 이 일치하는지 적용하는 쿼리.
SELECT e.job
     , max(e.sal)
  FROM emp e
 GROUP BY e.job
;
-- c) b에서 사용된 값을 a의 쿼리로 대체
SELECT e.empno
     , e.ename
     , e.job
     , e.sal
  FROM emp e
 WHERE (e.job, e.sal) IN (SELECT e.job
                               , max(e.sal)
                           FROM emp e
                          GROUP BY e.job)
;
/*
-- 비교하는 값의 컬럼의 샛수가 일치하지 않을 때 발생하는 오류 구문

*/
-- 4. 각 월별 입사인원을 세로로 출력하시오.
--    출력형태 : 1월 ~ 12월까지 정렬하여 출력
--    "입사월", "인원(명)"
-------------------------------
--    1월    3
--    2월    2
--    ...
--    12월   2
-------------------
-- a) 직원들의 입사월만 추출

SELECT TO_CHAR(e.hiredate,'FMMM') "입사월"
  FROM emp e
;
--  b) 입사 월별 인원을 카운트
SELECT TO_CHAR(e.hiredate,'FMMM') "입사월"
     , COUNT(*) "인원(명)"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'FMMM')
 ORDER BY "입사월"
;
-- c) 입사 월을 숫자값으로 변경해야 정렬이 맞습니다.


-- d) (c)의 결과를 FROM 절에 통으로 들어간 후 '월'을 붙여야 함.
SELECT a.month || '월' "입사월"
     , a.cnt           "인원(명)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) month
            , COUNT(*) cnt
          FROM emp e
        GROUP BY TO_CHAR(e.hiredate, 'FMMM')
        ORDER BY month)a
;  







