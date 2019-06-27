-- day09
-- 2. ������ �Լ�(�׷��Լ�)

-- 1) COUNT(*) : FROM ���� ������ Ư�� ���̺��� ���� ����(������ ����)�� �����ִ� �Լ�
--               NULL ���� ó���ϴ� "����"�� �׷��Լ�

--    COUNT(expr) : expr ���� ������ ���� NULL �����ϰ� �����ִ� �Լ�

-- ����) dept, salgrade ���̺��� ��ü ������ ���� ��ȸ
-- 1. dept ���̺� ��ȸ
SELECT d.*
  FROM dept d
;
/*
������ �Լ��� ���� ���� :
----------------------------
10	ACCOUNTING	NEW YORK ===> SUBST(dname,1,5) => ACCOU
20	RESEARCH	DALLAS   ===> SUBST(dname,1,5) => DALLA
30	SALES	    CHICAGO  ===> SUBST(dname,1,5) => SALES
40	OPERATIONS	BOSTON   ===> SUBST(dname,1,5) => OPERA
*/
/*
�׷� �Լ�(COUNT(*))�� ���� ���� : 
---------------------------
10	ACCOUNTING	NEW YORK ===>
20	RESEARCH	DALLAS   ===> COUNT(*) ===>4
30	SALES	    CHICAGO  ===>
40	OPERATIONS	BOSTON   ===>
*/

--2. dept ���̺��� ������ ���� ��ȸ : COUNT(*)���
SELECT COUNT(*) "�μ� ����"
  FROM dept d
;
/*
�μ� ����
--------
      4
*/

-- salgrade(�޿����) ���̺��� �޿� ��� ������ ��ȸ
SELECT COUNT(*) "�޿� ��� ����"
  FROM salgrade
;
/*
�޿� ��� ����
-----------
        5
*/

SELECT s.*
  FROM salgrade s
;
/*
GRADE, LOSAL,   HISAL
1	    700	    1200
2	    1201	1400
3	    1401	2000  ===> COUNT(*) ====>5
4	    2001	3000
5	    3001	9999
*/

-- COUNT(expr) �� NULL �����͸� ó������ ���ϴ� �� Ȯ���� ���� ������ �߰�
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ')
COMMIT;

-- emp ���̺��� job �÷��� ������ ������ ī��Ʈ
SELECT COUNT(e.job) "������ ������ ������ ��"
  FROM emp e
;
/*
������ ������ ������ ��
----------------------
        12
*/
/*
7369	SMITH	CLERK   	7902	80/12/17	800		    20          ====>
7499	ALLEN	SALESMAN	7698	81/02/20	1600	    300	    30  ====>
7521	WARD	SALESMAN	7698	81/02/22	1250    	500	    30  ====> ������ ���� ���� �÷��� job��
7566	JONES	MANAGER	    7839	81/04/02	2975		20          ====> null �� ���� ó�� ������ �ʴ´�
7654	MARTIN	SALESMAN	7698	81/09/28	1250	    1400	30  ====> COUNT(e.job) === 12
7698	BLAKE	MANAGER 	7839	81/05/01	2850		30          ====>
7782	CLARK	MANAGER	    7839	81/06/09	2450		10          ====>
7839	KING	PRESIDENT	    	81/11/17	5000		10          ====>
7844	TURNER	SALESMAN	7698	81/09/08	1500	    0	    30  ====>
7900	JAMES	CLERK	    7698	81/12/03	950	    	30          ====>
7902	FORD	ANALYST 	7566	81/12/03	3000		20          ====>
7934	MILLER	CLERK	    7782	82/01/23	1300		10          ====>
7777	JJ						
*/

-- ����) ȸ�翡 �Ŵ����� ������ ������ ����ΰ�
--       ��Ī : ��簡 �ִ� ������ ��
SELECT COUNT(e.mgr) "��簡 �ִ� ������ ��"
  FROM emp e
;
/*
��簡 �ִ� ������ ��
------------------
                11
*/

-- ����) �Ŵ��� ���� �ð� �ִ� ������ ����ΰ�?
-- 1. emp ���̺��� mgr �÷��� ������ ���¸� �ľ�
-- 2. mrg �÷��� �ߺ� �����͸� ����
SELECT DISTINCT e.mgr
 FROM emp e
;
/*
MGR
----
7782
7698
7902
7566
(null)
7839
*/
-- 3. �ߺ� �����Ͱ� ���ŵ� ����� ī��Ʈ
SELECT COUNT(DISTINCT e.mgr) "�Ŵ��� ��"
  FROM emp e
;

-- ����) �μ��� ������ ������ ����̳� �ִ°�?
SELECT COUNT(e.deptno) "�μ��� ������ ����"
  FROM emp e
;
/*
�μ��� ������ ����
------------------
            12
*/

-- COUNT(*) �� �ƴ� COUNT(expr)�� ����� ��쿡��
SELECT e.deptno
  FROM emp e
 WHERE e.deptno IS NOT NULL
;
-- �� ������ ����� ī��Ʈ �� ������ ������ �� ����.

-- ����) ��ü�ο�, �μ� ���� �ο�, �μ� �̹��� �ο��� ���Ͻÿ�
SELECT COUNT(*) ��ü�ο�
       COUNT(e.deptno) "�μ� ���� �ο�"
       COUNT(*) - COUNT(e.deptno) "�μ� �̹��� �ο�"
  FROM emp e
;

-- SUM(expr) : NULL �׸� �����ϰ�
--             �ջ� ������ ���� ��� ���� ����� ���

SELECT e.comm
  FROM emp e
;
/*
(null)
300
500
(null)
1400
(null)
(null)
(null)          SUM(e.comm)==>2200:�ڵ����� NULL �÷� ����
0
(null)
(null)
(null)
(null)
*/

-- SALESMAN ���� ���� ������ ���غ���.
SELECT SUM(e.comm) "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
���� ����
-------
2200
*/

-- ���� ���� ����� ���� ��� ������ ���� $, ���ڸ� ���� �б� ����
SELECT to_char(SUM(e.comm), '$9,999') "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
���� ����
--------
 $2,200
*/

-- AVG(expr) : NULL �� �����ϰ� ���� ������ �׸��� ��� ����� ����

-- SALESMAN �� ���� ����� ���غ���
SELECT AVG(e.comm) "���� ���"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
���� ���
-------
550
*/
-- ���� ��� ����� ���� ��� ���� $, ���ڸ� ���� �б� ����
SELECT to_char(AVG(e.comm), '$9,999') "���� ���"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
���� ���
--------
   $550
*/

-- 4) MAX(expr) : expr�� ������ �� �� �ִ��� ���� 
--                expr�� ������ ���� ���ĺ��� ���ʿ� ��ġ�� ���ڸ�
--                �ִ����� ���

-- �̸��� ���� ������ ����
SELECT MAX(e.ename) "�̸��� ���� ������ ����"
  FROM emp e
;
/*
�̸��� ���� ������ ����
---------------------
WARD
*/

-- 4) MIN(expr) : expr�� ������ �� �� �ּҰ��� ���� 
--                expr�� ������ ���� ���ĺ��� ���ʿ� ��ġ�� ���ڸ�
--                �ּҰ����� ���

SELECT MIN(e.ename) "�̸��� ���� ���� ����"
  FROM emp e
;
/*
�̸��� ���� ���� ����
-------------------
ALLEN
*/

------ 3. GROUP BY ���� ���
-- ����) �� �μ����� �޿��� ����, ���, �ִ�, �ּҸ� ��ȸ

-- 1. �� �μ����� �޿��� ������ ��ȸ�Ϸ��� 
--    ���� : SUM() �� ���
--    �׷�ȭ ������ �μ���ȣ(deptno)�� ���
--    GROUP BY ���� �����ؾ� ��

-- a) ���� emp ���̺��� �޿� ������ ���ϴ� ���� �ۼ�
SELECT SUM(e.sal)
  FROM emp e
;
-- b) �μ� ��ȣ�� �������� �׷�ȭ ����
--    SUM()�� �׷��Լ���.
--    GROUP BY ���� �����ϸ� �׷�ȭ �����ϴ�.
--    �׷�ȭ�� �Ϸ��� �����÷��� GROUP BY ���� �����ؾ� ��.

SELECT e.deptno �μ���ȣ -- �׷�ȭ �����÷�
     , SUM(e.sal) -- "�μ� �޿� ����"
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;

-- GROUP BY ���� �׷�ȭ ���� �÷����� ������ �÷��� �ƴ� ����
-- SELECT ���� �����ϸ� ����, ����Ұ�
SELECT e.deptno �μ���ȣ -- �׷�ȭ �����÷�
     , e.job -- �׷�ȭ �����÷��� �ƴѵ� SELECT ���� ���� -> ������ ����
     , SUM(e.sal) -- "�μ� �޿� ����"
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*/

-- ����) �μ��� �޿��� ����, ���, �ִ�, �ּ�

SELECT e.deptno �μ���ȣ -- �׷�ȭ �����÷�
     , TO_CHAR(SUM(e.sal), '$999,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$999,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$999,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$999,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;

-- �μ���ȣ�� ������ ����
SELECT TO_CHAR(SUM(e.sal), '$999,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$999,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$999,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$999,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;

/*
���� ������ ��������� ��Ȯ�ϰ� ��� �μ��� ������� �� �� ���ٴ� ������ ����
�׷���, GROUP BY ���� �����ϴ� �����÷��� SELECT ���� �Ȱ��� �����ϴ� ����
��� �ؼ��� ���ϴ�.

SELECT ���� ������ �÷� �߿��� �׷��Լ��� ������ �ʴ� �÷��� ���� ������
���� ������ ����Ǵ� ���̴�.
*/

-- ����) �μ���, ������ �޿��� ����, ���, �ִ�, �ּ�
SELECT e.deptno �μ���ȣ -- �׷�ȭ �����÷�
     , e.job
     , TO_CHAR(SUM(e.sal), '$999,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$999,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$999,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$999,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;
/*
�μ���ȣ, JOB,    �μ� �޿� ����, �μ� �޿� ���, �μ� �޿� �ִ�, �μ� �޿� �ּ�
    10	CLERK	       $1,300	   $1,300.00	   $1,300	   $1,300
    10	MANAGER	       $2,450	   $2,450.00	   $2,450	   $2,450   
    10	PRESIDENT	   $5,000	   $5,000.00	   $5,000	   $5,000
    20	ANALYST	       $3,000	   $3,000.00	   $3,000	   $3,000
    20	CLERK	       $800	         $800.00	     $800	     $800
    20	MANAGER	       $2,975	   $2,975.00	   $2,975	   $2,975
    30	CLERK	       $950	        $950.00	         $950	     $950
    30	MANAGER	       $2,850	   $2,850.00	   $2,850	   $2,850
    30	SALESMAN	   $5,600	   $1,400.00	   $1,600	   $1,250
*/					


-- ������Ȳ
-- a) GROUP BY���� �׷�ȭ ������ ������ ���
SELECT --e.deptno �μ���ȣ
     , SUM(e.sal)
     , AVG(e.sal)
     , MAX(e.sal)
     , MIN(e.sal)
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
-- b) SELECT ���� �׷��Լ��� �Ϲ� �÷��� ���� ����
--    GROUP BY �� ��ü�� ������ ���
SELECT e.deptno �μ���ȣ
     , SUM(e.sal)
     , AVG(e.sal)
     , MAX(e.sal)
     , MIN(e.sal)
  FROM emp e
-- GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
00937. 00000 -  "not a single-group group function"
*/

-- ����) ����(job) �� �޿��� ����, ���, �ִ�, �ּҸ� ���غ���
--      ��Ī : ����, �޿�����, �޿����, �ִ�޿�, �ּұ޿�
SELECT e.job ����
     , SUM(e.sal) �޿�����
     , AVG(e.sal) �޿����
     , MAX(e.sal) �ִ�޿�
     , MIN(e.sal) �ּұ޿�
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;
-- ������ null�� ������� ������ ��� '���� �̹���'���� ���
SELECT NVL(e.job, '����������') ����
     , SUM(e.sal) �޿�����
     , AVG(e.sal) �޿����
     , MAX(e.sal) �ִ�޿�
     , MIN(e.sal) �ּұ޿�
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;
-- �μ��� ����, ���, �ִ�, �ּ�
-- �μ���ȣ�� null �� ���, '�μ� �̹���' ���� �з��ǵ��� ��ȸ
SELECT NVL(e.deptno, '�μ� �̹���') �μ���ȣ -- �׷�ȭ �����÷�
     , TO_CHAR(SUM(e.sal), '$999,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$999,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$999,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$999,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;
/* deptno �� ����, '�μ� �̹���'�� ���� �������̹Ƿ� Ÿ�� ����ġ��
   NVL()�� �۵����� ���Ѵ�.
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
*/
-- �ذ��� : deptno �� ���� ����ȭ
SELECT NVL(to_char(e.deptno), '�μ� �̹���') �μ���ȣ -- �׷�ȭ �����÷�
     , TO_CHAR(SUM(e.sal), '$999,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$999,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$999,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$999,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;
-- ���ڸ� ���ڷ� ���� : ���տ�����(||)�� ���
SELECT NVL(e.deptno|| '', '�μ� �̹���') �μ���ȣ -- �׷�ȭ �����÷�
     , TO_CHAR(SUM(e.sal), '$999,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$999,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$999,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$999,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;

-- NVL, DECODE TO_CHAR �������� �ذ�
SELECT DECODE(NVL(e.deptno, 0), e.deptno, TO_CHAR(e.deptno)
                              , 0       , '�μ� �̹���') "�μ���ȣ"
     , TO_CHAR(SUM(e.sal), '$999,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$999,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$999,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$999,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;

----- 4. HAVING ���� ���
-- GROUP BY ����� ������ �ɾ
-- �� ����� ������ �������� ���Ǵ� ��.
-- HAVING���� WHERE ���� ��������� SELECT ������ ���� ����������
-- GROUP BY �� ���� ���� ����Ǵ� WHERE ���δ�
-- GROUP BY ����� ������ �� ����.

-- ���� GROUP BY ���� ��������� ������
-- HAVING ���� �����Ѵ�.

-- ����) �μ��� �޿� ����� 2000 �̻��� �μ��� ��ȸ�Ͽ���.
 
-- a) �켱 �μ��� �޿� ����� ���Ѵ�.
SELECT e.deptno
     , AVG(e.sal)
  FROM emp e
 GROUP BY e.deptno;


-- b) a�� ������� �޿������ 2000�̻��� ���� �����.
--    HAVING ���� ��� ����
SELECT e.deptno �μ���ȣ
     , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;
-- ����� ���� ����
SELECT e.deptno �μ���ȣ
     , TO_CHAR(AVG(e.sal), '$9,999.99') �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

-- ���� : HAVING ���� ��Ī�� ����� �� ����.
SELECT e.deptno �μ���ȣ
     , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING �޿���� >= 2000 -- HAVING�� ��Ī�� ����� �� ����
;
/*
ORA-00904: "�޿����": �������� �ĺ���
00904. 00000 -  "%s: invalid identifier"
*/

-- HAVING ���� �����ϴ� ��� SELCET ������ ���� ���� ����
/*  
 1. FROM          ���� ���̺� �� �� ��θ� �������
 2. WHERE         ���� ���ǿ� �´� �ุ �����ϰ�
 3. GROUP BY      ���� ���� �÷�, ��(�Լ� ��) ���� �׷�ȭ ����
 4. HAVING        ���� ������ ������Ű�� �׷��ุ ����
 5.               4���� ���õ� �׷� ������ ���� �࿡ ���ؼ�
 6. SELECT        ���� ��õ� Į��, ��(�Լ� ��)�� ���
 7. ORDER BY      �� �ִٸ� ���� ���ǿ� ���߾� ���� �����Ͽ� ��� ���
*/

-- ������ �ǽ�

-- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ����
--   : mgr �÷��� �׷�ȭ ���� �÷�
SELECT e.mgr �Ŵ���
     , COUNT(e.mgr) "���������� ��"
  FROM emp e
 GROUP BY e.mgr
 ORDER BY COUNT(e.mgr) DESC
;

-- 2.1 �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
--    : deptno �÷��� �׷�ȭ ���� �÷�
SELECT e.deptno
     , COUNT(e.deptno)
  FROM emp e
 GROUP BY e.deptno
 ORDER BY COUNT(e.deptno) DESC
;

-- 2.2 �μ� ��ġ �̹��� �ο� ó��
SELECT NVL(e.deptno||'','�μ� �̹���')
     , COUNT(e.deptno)
  FROM emp e
 GROUP BY e.deptno
 ORDER BY COUNT(e.deptno) DESC
;

-- 3.1 ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job ����
     , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.job
 ORDER BY �޿���� DESC
;

-- 3.2 job �� null �� ������ ó��
SELECT NVL(e.job||'', '���� �̹���') ����
     , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.job
 ORDER BY �޿���� DESC
;

-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job ����
     , SUM(e.sal) "�޿� ����"
  FROM emp e
 GROUP BY e.job
 ORDER BY "�޿� ����" DESC
;

-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ�
--    �޿� ���� ������������ ����
SELECT CASE WHEN e.sal < 1000                   THEN 1
            WHEN e.sal >= 1000 AND e.sal < 2000 THEN 1000
            WHEN e.sal >= 2000 AND e.sal < 3000 THEN 2000
            WHEN e.sal >= 3000 AND e.sal < 5000 THEN 3000
            WHEN e.sal >= 5000                  THEN 5000
            ELSE 0
       END AS "�޿� ����"
    , COUNT(CASE WHEN e.sal < 1000                   THEN 1
                 WHEN e.sal >= 1000 AND e.sal < 2000 THEN 1000
                 WHEN e.sal >= 2000 AND e.sal < 3000 THEN 2000
                 WHEN e.sal >= 3000 AND e.sal < 5000 THEN 3000
                 WHEN e.sal >= 5000                  THEN 5000
                ELSE 0
       END) �ο���
  FROM emp e
 GROUP BY CASE WHEN e.sal < 1000                   THEN 1
               WHEN e.sal >= 1000 AND e.sal < 2000 THEN 1000
               WHEN e.sal >= 2000 AND e.sal < 3000 THEN 2000
               WHEN e.sal >= 3000 AND e.sal < 5000 THEN 3000
               WHEN e.sal >= 5000                  THEN 5000
               ELSE 0
          END
 ORDER BY "�޿� ����" DESC
;
-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����
SELECT e.job ����
     , SUM(e.sal) "�޿� ��"
  FROM emp e
 GROUP BY e.job
 ORDER BY "�޿� ��" DESC
;


-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ����
SELECT e.job
     , AVG(e.sal) "�޿� ���"
  FROM emp e
 GROUP BY e.job
 HAVING AVG(e.sal) <= 2000
 ORDER BY "�޿� ���" DESC
;


-- 8. �⵵�� �Ի� �ο��� ���Ͻÿ�
SELECT SUBSTR(e.hiredate, 1,2)
     , COUNT(SUBSTR(e.hiredate, 1,2))
  FROM emp e
 WHERE e.hiredate IS NOT NULL
 GROUP BY SUBSTR(e.hiredate, 1,2)
;








