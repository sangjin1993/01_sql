-- 1.sys 접속
CONN sys as sysdbs;
/*
 2. SCOTT 계정에 VIEW 생성 권한 설정
(1)접속 탭
(2)sys 계정의 다른 사용자
(3)SCOTT에서 오른쪽 클릭
(4)사용자 편집
(5)시스템 권한 탭
(6)CREATE VIEW 권한이 부여됨 체크박스 선택 ->
*/
GRANT CREATE VIEM TO SCOTT;

-- 3. SCOTT 으로 접속 변경
CONN SCOTT/TIGER;

---------------------------
-- 1. emp, dept 테이블 복사
DROP TABLE new_emp;
CREATE TABLE new_emp
AS
SELECT e.*
  FROM emp e
 WHERE 1=1
;

DROP TABLE new_dept;
CREATE TABLE new_dept
AS
SELECT d.*
  FROM dept d
 WHERE 1=1
;
/*
Table NEW_EMP이(가) 생성되었습니다.
Table NEW_DEPT이(가) 생성되었습니다.
*/

-- 2. 복사 테이블에는 PK 설정이 누락되어 있으므로 PK 설정을 ALTER로 추가
/*
 new_dept : PK_NEW_DEPT, deptno 컬럼을 PRIMARY KEY 로 설정
 new_emp : PK_NEW_EMP , empno 컬럼을 PRIMART KEY 로 설정
           FK_NEW_DEPTNO, deptno 컬럼을 FOREIGN KEY 로 설정
                         new_dept 테이블의 deptno 컬럼을 REFERENCES 하도록 설정
           FK_MGE       , mgr 컬럼을 FOREIGN KEY 로 설정
            new_emp 테이블의 empno 컬럼을 REFERENCES 하도록 설정
*/


-- 3. 복사 테이블을 기본 테이블로 하는 VIEW를 생성
--    : 직원의 기본 정보 + 상사의 이름 + 부서이름 + 부서위치 까지 조회가능한 뷰
CREATE OR REPLACE VIEW v_emp_dept
AS
SELECT e.empno
     , e.ename
     , e1.ename as mgr_name
     , d.deptno
     , d.dname
     , d.loc
  FROM new_emp e
     , new_dept d
     , new_emp e1
 WHERE e.deptno = d.deptno(+)
   AND e.mgr = e1.empno(+)
WITH READ ONLY
;
--View V_EMP_DEPT이(가) 생성되었습니다.

-- 조인이 걸린 결과를 일반 테이블에 조회하듯 듀를 통해 조회가능
SELECT v.*
  FROM v_emp_dept v
;
/*
EMPNO,   ENAME, MGR_NAME, DEPTNO, DNAME,    LOC
7902	FORD	JONES	    20	RESEARCH	DALLAS
7499	ALLEN	BLAKE   	30	SALES   	CHICAGO
7521	WARD	BLAKE   	30	SALES   	CHICAGO
7654	MARTIN	BLAKE   	30	SALES   	CHICAGO
7844	TURNER	BLAKE   	30	SALES   	CHICAGO
7900	JAMES	BLAKE   	30	SALES   	CHICAGO
8888	J_JAMES	BLAKE			
7934	MILLER	CLARK   	10	ACCOUNTING	NEW YORK
7782	CLARK	KING    	10	ACCOUNTING	NEW YORK
7566	JONES	KING    	20	RESEARCH	DALLAS
7698	BLAKE	KING    	30	SALES	    CHICAGO
7369	SMITH	FORD    	20	RESEARCH	DALLAS
7777	JJ	    FORD			
7839	KING	    	    10	ACCOUNTING	NEW YORK
*/

SELECT v.empno
     , v.dname
     , v.dname
     , v.loc
  FROM v_emp_dept v
;
/*
EMPNO,  DNAME,       DNAME_1,    LOC
7902	RESEARCH	RESEARCH	DALLAS
7499	SALES	    SALES	    CHICAGO
7521	SALES	    SALES	    CHICAGO
7654	SALES	    SALES	    CHICAGO
7844	SALES	    SALES   	CHICAGO
7900	SALES	    SALES	    CHICAGO
8888			
7934	ACCOUNTING	ACCOUNTING	NEW YORK
7782	ACCOUNTING	ACCOUNTING	NEW YORK
7566	RESEARCH	RESEARCH	DALLAS
7698	SALES	    SALES	    CHICAGO
7369	RESEARCH	RESEARCH	DALLAS
7777			
7839	ACCOUNTING	ACCOUNTING	NEW YORK
*/

-- 4. VIEW 가 생성되면 user_views 라는 시스템 테이블에 정보가 추가됨 확인
DESC user_views;
/*
이름                     널?       유형             
---------------------- -------- -------------- 
VIEW_NAME              NOT NULL VARCHAR2(128)  
TEXT_LENGTH                     NUMBER         
TEXT                            LONG           
TEXT_VC                         VARCHAR2(4000) 
TYPE_TEXT_LENGTH                NUMBER         
TYPE_TEXT                       VARCHAR2(4000) 
OID_TEXT_LENGTH                 NUMBER         
OID_TEXT                        VARCHAR2(4000) 
VIEW_TYPE_OWNER                 VARCHAR2(128)  
VIEW_TYPE                       VARCHAR2(128)  
SUPERVIEW_NAME                  VARCHAR2(128)  
EDITIONING_VIEW                 VARCHAR2(1)    
READ_ONLY                       VARCHAR2(1)    
CONTAINER_DATA                  VARCHAR2(1)    
BEQUEATH                        VARCHAR2(12)   
ORIGIN_CON_ID                   NUMBER         
DEFAULT_COLLATION               VARCHAR2(100)  
CONTAINERS_DEFAULT              VARCHAR2(3)    
CONTAINER_MAP                   VARCHAR2(3)    
EXTENDED_DATA_LINK              VARCHAR2(3)    
EXTENDED_DATA_LINK_MAP          VARCHAR2(3)    
HAS_SENSITIVE_COLUMN            VARCHAR2(3)    
*/

SELECT v.view_name
     , v.read_only
  FROM user_views v
;
--VIEW_NAME, READ_ONLY
--V_EMP_DEPT	Y

-- 5. 생성된 뷰에서 DQL 조회
-- 1) 부서명이 SALES 인 부서 소속 직원을 조회
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname = 'SALES'
;
/*
7499	ALLEN	BLAKE	30	SALES	CHICAGO
7521	WARD	BLAKE	30	SALES	CHICAGO
7654	MARTIN	BLAKE	30	SALES	CHICAGO
7844	TURNER	BLAKE	30	SALES	CHICAGO
7900	JAMES	BLAKE	30	SALES	CHICAGO
7698	BLAKE	KING	30	SALES	CHICAGO
*/
-- 2) 부서명이 NULL 인 직원을 조회
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname IS NULL
;
/*
8888	J_JAMES	BLAKE			
7777	JJ	FORD			
*/
-- 3) 상사(매니저,mgr)가 NULL 인 직원을 조회
SELECT v.*
  FROM v_emp_dept v
 WHERE v.mgr_name IS NULL
;
/*
7839	KING		10	ACCOUNTING	NEW YORK
*/
