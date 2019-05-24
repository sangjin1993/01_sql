-- SQL day 03

--  * SQL SELECT ������ �۵� ���� :
-- >> ���̺�(FROM ���� ������)�� �� ���� �⺻ ������ �����Ѵ�.
-- >> ���̺� ���� ������ŭ �ݺ� �����Ѵ�.
-- ���� ������ ���� ������ �����Ѵٸ� ����� ��� �ɱ�?
SELECT 'Hello, SQL~' -- �÷����� �ƴ� ������ ���� ��ȸ�ϸ� ��� �ɱ�?
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
      ,empno -- ���̺� �����ϴ� �÷����� ��� ���� ��� �ɱ�?
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
-- WHERE ������
-- 16) emp ���̺��� empno �� 7900�� ����� ���, �̸�, ����, �Ի���, �޿�, �μ���ȣ �� ��ȸ�Ͻÿ�.

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
 
 -- 17) emp ���̺��� empno �� 7900 �̰ų� deptno �� 20�� ������ ���, �̸�, ����, �Ի���, �޿�, �μ���ȣ �� ��ȸ�Ͻÿ�.
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

-- 18) 17���� ��ȸ ����(empno�� 7900, deptno�� 20)�� AND�� �����Ͽ� ��ȸ�غ���.
-- emp ���̺��� empno�� 7900�̰�, depto�� 20�� ������ ���, �̸�, ����, �Ի���
-- �ݿ�, �μ���ȣ�� ��ȸ�Ͻÿ�.

SELECT e.empno
    , e.ename
    , e.job
    , e.hiredate
    , e.sal
    , e.deptno
  FROM emp e
 WHERE e.job = 'CLERK' --���ڰ� �񱳽ÿ��� �ݵ�� �� ���ڸ� ''�� ���Ѵ�
   AND e.deptno = 10 --���ڰ� �񱳽ÿ��� ����ǥ ������
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
 WHERE e.job = 'Clerk' --���ڰ� �񱳽� ����ǥ ���� ��ҹ��ڸ� �����Ѵ�.
   AND e.deptno = 10 -- ���ڰ� �񱳽ÿ��� ����ǥ ������
;
-- ����� ��� �� : 0
-- >> Clerk �̶�� ���� �����Ϳ� �������� �����Ƿ�
--    CLERK ���� �����ϴ� �����Ϳ� ��ҹ��ڰ� �������� ������
--    �ٸ� ������ ó���Ѵ�.

-- (6) ������ : 1.���������
-- 21) emp ���̺���
--     ���, �̸�, �ݿ��� ��ȸ�ϰ�
--     �޿��� 3.3%�� �ش��ϴ� ��õ¡�� ������ ����Ͽ� ��ȸ�Ͻÿ�.
SELECT e.empno
     , e.ename
     , e.sal
     , e.sal * 0.033 tax
  FROM emp e
;
-- ���� ���ɾ׿� �ش��ϴ� 96.7%�� �޿��� ����Ͽ� ��ȸ
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
-- ���� ����� ���� �ٸ� ��
SELECT e.empno
     , e.ename
     , e.sal
     , e.sal * 0.033 tax
     , e.sal * (1-0.033) "REAL SAL"
  FROM emp e
;