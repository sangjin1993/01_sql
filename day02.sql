--DAY 2
--SCOTT ���� EMP ���̺� ��ȸ

SELECT *
  FROM emp
;
  
  --SCOTT ���� DEPT ���̺� ��ȸ
SELECT *
  FROM dept
;
-- 2. DQL : SELECT
-- 1) emp ���̺��� job �÷��� ��ȸ
SELECT job
  FROM emp
  ;

-- 2) emp ���̺��� �ߺ��� �����Ͽ�
--    job �÷��� ��ȸ
SELECT DISTINCT job
  FROM emp
  ;
/* => �� jpb�� �ѹ��� �� ��ȸ�� ���  
      �� ���� �� �ִ�.
    �� ����� ȸ�翡�� �ټ� ������
    JOB �� ������ Ȯ���� �� �ִ�.
job
---------
CLERK
SALESMAN
ANALYST
MANAGER
PRESIDENT
/*
