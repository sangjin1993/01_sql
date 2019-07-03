-- 1.sys ����
CONN sys as sysdbs;
/*
 2. SCOTT ������ VIEW ���� ���� ����
(1)���� ��
(2)sys ������ �ٸ� �����
(3)SCOTT���� ������ Ŭ��
(4)����� ����
(5)�ý��� ���� ��
(6)CREATE VIEW ������ �ο��� üũ�ڽ� ���� ->
*/
GRANT CREATE VIEM TO SCOTT;

-- 3. SCOTT ���� ���� ����
CONN SCOTT/TIGER;

---------------------------
-- 1. emp, dept ���̺� ����
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
Table NEW_EMP��(��) �����Ǿ����ϴ�.
Table NEW_DEPT��(��) �����Ǿ����ϴ�.
*/

-- 2. ���� ���̺��� PK ������ �����Ǿ� �����Ƿ� PK ������ ALTER�� �߰�
/*
 new_dept : PK_NEW_DEPT, deptno �÷��� PRIMARY KEY �� ����
 new_emp : PK_NEW_EMP , empno �÷��� PRIMART KEY �� ����
           FK_NEW_DEPTNO, deptno �÷��� FOREIGN KEY �� ����
                         new_dept ���̺��� deptno �÷��� REFERENCES �ϵ��� ����
           FK_MGE       , mgr �÷��� FOREIGN KEY �� ����
            new_emp ���̺��� empno �÷��� REFERENCES �ϵ��� ����
*/


-- 3. ���� ���̺��� �⺻ ���̺�� �ϴ� VIEW�� ����
--    : ������ �⺻ ���� + ����� �̸� + �μ��̸� + �μ���ġ ���� ��ȸ������ ��
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
--View V_EMP_DEPT��(��) �����Ǿ����ϴ�.

-- ������ �ɸ� ����� �Ϲ� ���̺� ��ȸ�ϵ� �ฦ ���� ��ȸ����
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

-- 4. VIEW �� �����Ǹ� user_views ��� �ý��� ���̺� ������ �߰��� Ȯ��
DESC user_views;
/*
�̸�                     ��?       ����             
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

-- 5. ������ �信�� DQL ��ȸ
-- 1) �μ����� SALES �� �μ� �Ҽ� ������ ��ȸ
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
-- 2) �μ����� NULL �� ������ ��ȸ
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname IS NULL
;
/*
8888	J_JAMES	BLAKE			
7777	JJ	FORD			
*/
-- 3) ���(�Ŵ���,mgr)�� NULL �� ������ ��ȸ
SELECT v.*
  FROM v_emp_dept v
 WHERE v.mgr_name IS NULL
;
/*
7839	KING		10	ACCOUNTING	NEW YORK
*/
