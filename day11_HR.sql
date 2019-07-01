
-- HR계정 활성화

ALTER SESSION 
  SET "_ORACLE_SCRIPT"=true
;

@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_main_new.sql;

-- 1번 입력 : HR
-- 2번 입력 : HR
-- 3번 입력 : HR
-- 4번 입력 : $ORACLE_HOME/demo/schema/log/
-- 1 ~ 4 입력 후 HR 계정 테이블 생성됨.

--HR 로 작업
-- 2.DISTINCT 
-- 1)EMPLOYEES테이블에서 JOB_ID의 중복 값을 제하여 JOB_ID 컬럼을 조회하시오.
SELECT DISTINCT e.JOB_ID
  FROM EMPLOYEES e
;
-- 2)

-- 3.ORDER BY
-- 1)EMPLOYEES테이블에서 수당이 큰 순서대로 사번, 이름, 수당 컬럼을 조회
SELECT e.employee_id
     , e.last_name
     , e.commission_pct
  FROM employees e
 ORDER BY e.commission_pct DESC
;
-- 2) EMPLOYEES테이블에서 사번, 이름, 직무, 입사일를 조회하고 입사일이 빠른사람부터 조회하시오.
SELECT e.employee_id
     , e.last_name
     , e.job_id
     , e.hire_date
  FROM employees e
 ORDER BY e.hire_date
;
-- 3) EMPLOYEES테이블에서 사번, 이름, 직무, 급여를 조회하고 급여가 낮은 사람부터 조회하시오.
SELECT e.employee_id
     , e.last_name
     , e.job_id
     , e.salary
  FROM employees e
 ORDER BY e.salary
;

-- 4.ALIAS
-- 1) LOCATIONS테이블에 별칭을 주고 조회하시오
SELECT *
  FROM LOCATIONS l
;
-- 2) DEPARTMENTS 테이블에 별칭을주고 department_id, department_name을 조회하시오.
SELECT d.department_id
     , d.department_name
  FROM DEPARTMENTS d
;
-- 3) COUNTRIES 테이블에 별칭을 주고, COUNTRY_ID는 약자로 별칭을 주고, COUNTRY_NAME는 나라 이름으로 별칭을 주어 조회하시오
SELECT c.country_id 약자
     , c.country_name "나라 이름"
  FROM COUNTRIES c
;


-- 5.WHERE 절
-- 1) EMPLOYEES테이블에서 부서번호가 100인 사람의 사번를 조회하시오
SELECT e.employee_id
  FROM employees e
 WHERE e.department_id = 100
;
-- 2) LOCATIONS테이블에서 LOCATION_ID가 2000이상인 도시를 조회하시오.
SELECT l.city
  FROM locations l
 WHERE l.location_id > 2000
;
-- 3) EMPLOYEES테이블에서 부서번호가 50이며 급여가 5000이상인 사람의 사번, 이름, 급여를 조회하시오
SELECT e.employee_id
     , e.last_name
     , e.salary
  FROM employees e
 WHERE e.department_id = 50
   AND e.salary > 5000
;


-- 6.연산자
-- 1)employees 테이블에서 사번, 이름, 급여를 조회하고 급여의 3.3%에 해당하는 세금을 계산하여 조회하시오.
SELECT e.employee_id
     , e.last_name
     , e.salary
     , e.salary *0.033
  FROM employees e
;
-- 2) 급여가 2000이상 5000미만인 사람의 사번과, 이름, 급여를 조회하시오
SELECT e.employee_id
     , e.last_name
     , e.salary
  FROM employees e
 WHERE e.salary BETWEEN 2000 AND 5000
;
-- 3) '이름' 씨의 급여는 '급여'입니다 라는 형식을 만드시오
SELECT e.last_name || '씨의 급여는' || e.salary || '입니다' AS 급여
  FROM employees e
;

-- 7.단일행 함수
-- 1)EMPLOYEES에서 사번과 이름, 부서번호를 조회하고 DEPARTMENT_ID가 NULL인 값을 0으로 바꾸시오.
SELECT e.employee_id
     , e.last_name
     , NVL(e.department_id, 0)
  FROM employees e
;
-- 2)EMPLOYEES테이블에서 성은 대문자로 이름은 소문자로 조회하시오
SELECT UPPER(e.first_name)
     , LOWER(e.last_name)
  FROM employees e
;
-- 3)EMPLOYEES테이블에서 사번, 이름, 직무,급여를 조회하고 급여를 화폐단위로 바꾸고 세자리씩 끊어서 표현하시오.
SELECT e.employee_id
     , e.last_name
     , e.job_id
     , TO_CHAR(e.salary, '$99,999')
  FROM employees e
;

-- 8.DECODE
--1)
SELECT DISTINCT e.job_id
  FROM employees e
;


--파일명 : day11_HR 한글이름





