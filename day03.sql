-- SQL day 03

--  * SQL SELECT 구문의 작동 원리 :
-- >> 테이블(FROM 절에 나열된)의 한 행을 기본 단위로 실행한다.
-- >> 테이블 행의 개수만큼 반복 실행한다.
-- 만약 다음과 같은 구문을 실행한다면 결과는 어떻게 될까?
SELECT 'Hello, SQL~' -- 컬럼명이 아닌 고정된 값을 조회하면 어떻게 될까?
  FROM emp
  ;
/*
'HELLO,SQL~'
------------
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
*/

SELECT 'Hello, SQL~' AS greeting
      ,empno -- 테이블에 존재하는 컬럼명을 섞어서 쓰면 어떻게 될까?
      ,ename
 FROM emp
 ;
 /*
'HELLO,SQL~ EMPNO   ENAME
 --------------------------
Hello, SQL~	7369	SMITH
Hello, SQL~	7499	ALLEN
Hello, SQL~	7521	WARD
Hello, SQL~	7566	JONES
Hello, SQL~	7654	MARTIN
Hello, SQL~	7698	BLAKE
Hello, SQL~	7782	CLARK
Hello, SQL~	7839	KING
Hello, SQL~	7844	TURNER
Hello, SQL~	7900	JAMES
Hello, SQL~	7902	FORD
Hello, SQL~	7934	MILLER
*/
-- WHERE 조건절
-- 16) emp 테이블에서 empno 가 7900인 사원의 사번, 이름, 직무, 입사일, 급여, 부서번호 를 조회하시오.

SELECT e.empno
     , e.ename
     , e.job
     , e.hiredate
     , e.sal
     , e.deptno
 FROM emp e
WHERE e.empno = 7900
 ;
 /*
 EMPNO  ENAME   JOB     HIREDATE    SAL  DEPTNO
 7900	JAMES	CLERK	81/12/03	950	 30
 */
 
 -- 17) emp 테이블에서 empno 가 7900 이거나 deptno 가 20인 직원의 사번, 이름, 직무, 입사일, 급여, 부서번호 를 조회하시오.
SELECT e.empno
     , e.ename
     , e.job
     , e.hiredate
     , e.sal
     , e.deptno
  FROM emp e
 WHERE e.empno = 7900
    OR e.deptno = 20
;

/*
EMPNO  ENAME    JOB     HIREDATE    SAL    DEPTNO
-----------------------------------------------------
7369	SMITH	CLERK	80/12/17	800	    20
7566	JONES	MANAGER	81/04/02	2975	20
7900	JAMES	CLERK	81/12/03	950	    30
7902	FORD	ANALYST	81/12/03	3000	20
*/

-- 18) 17번의 조회 조건(empno가 7900, deptno가 20)을 AND로 결합하여 조회해보자.
-- emp 테이블에서 empno가 7900이고, depto가 20인 직원의 사번, 이름, 직무, 입사일
-- 금여, 부서번호를 조회하시오.

SELECT e.empno
    , e.ename
    , e.job
    , e.hiredate
    , e.sal
    , e.deptno
  FROM emp e
 WHERE e.job = 'CLERK' --문자값 비교시에는 반드시 비교 문자를 ''로 감싼다
   AND e.deptno = 10 --숫자값 비교시에는 따옴표 사용안함
;

/*
EMPNO   ENAME   JOB     HIREDATE    SAL     DEPTNO
--------------------------------------------------
7934	MILLER	CLERK	82/01/23	1300	10
*/

-- 20)
SELECT e.empno
     , e.ename
     , e.job
     , e.deptno
  FROM emp e
 WHERE e.job = 'Clerk' --문자값 비교시 따옴표 안의 대소문자를 구분한다.
   AND e.deptno = 10 -- 숫자값 비교시에는 따옴표 사용안함
;
-- 인출된 모든 행 : 0
-- >> Clerk 이라는 값은 데이터에 존재하지 않으므로
--    CLERK 으로 존재하는 데이터와 대소문자가 일지하지 않으면
--    다른 값으로 처리한다.

-- (6) 연산자 : 1.산술연산자
-- 21) emp 테이블에서
--     사번, 이름, 금여를 조회하고
--     급여의 3.3%에 해당하는 원천징수 세금을 계산하여 조회하시오.
SELECT e.empno
     , e.ename
     , e.sal
     , e.sal * 0.033 tax
  FROM emp e
;
-- 실제 수령액에 해당하는 96.7%의 급여도 계산하여 조회
SELECT e.empno
     , e.ename
     , e.sal * 0.033 tax
     , e.sal *0.967 "REAL SAL"
  FROM emp e
;
/*
EMPNO   ENAME   TAX     REAL SAL
7369	SMITH	26.4	773.6
7499	ALLEN	52.8	1547.2
7521	WARD	41.25	1208.75
7566	JONES	98.175	2876.825
7654	MARTIN	41.25	1208.75
7698	BLAKE	94.05	2755.95
7782	CLARK	80.85	2369.15
7839	KING	165	    4835
7844	TURNER	49.5	1450.5
7900	JAMES	31.35	918.65
7902	FORD	99	    2901
7934	MILLER	42.9	1257.1
*/
-- 같은 결과를 내는 다른 식
SELECT e.empno
     , e.ename
     , e.sal
     , e.sal * 0.033 tax
     , e.sal * (1-0.033) "REAL SAL"
  FROM emp e
;