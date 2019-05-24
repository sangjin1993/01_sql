--day06
----- 2) �����Լ�
------- 1. INITCAP(str) : str �� ù ���ڸ� �빮��ȭ(����)
SELECT initcap('the watch')-- The Watch
  FROM dual
;

SELECT initcap('�ȳ��ϼ���. ������') -- �ȳ��ϼ���. ������
  FROM dual
;

------------ 2. LOWER(str) : str�� ��� ���ڸ� �ҹ���ȭ(����)
SELECT lower ('MR. SOCTT MCMILLAN') "�ҹ��ڷ� ����"
  FROM dual
;
-- mr. soctt mcmillan

-------------- 3. UPPER(str) : str�� ��� ���ڸ� �빮��ȭ(����)
SELECT upper('lee') "���� �빮�ڷ� ����"
  FROM dual
;

SELECT upper('sql is coooooooooooooooool~!!')
  FROM dual
  ;
  
-- smith �� ã�µ� �Է��� �ҹ��ڷ� �� ��쿡
-- SMITH �� �ٸ� ���ڷ� �νĵǹǷ� ã�� �� ����.
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
 ;
 -- ename�� ���ϴ� ���� �빮 �� �̹Ƿ� ������ ��ȸ ��.
 SELECT e.empno
      , e.ename
  FROM emp e
 WHERE e.ename = upper('smith')
 ;
 
 -------- 4. LENGTH(str), LENGTHB(str) : str�� ���ڱ���, ������byte �� ����Ͽ� ���ڷ� ���
 SELECT length('hello, sql') as "���� ����"
   FROM dual
;
-- ��� : 10 ==> Ư����ȣ, ���鵵 ���� ���̷� ���
SELECT 'hello, sal�� ���� ���̴� ' 
  FROM dual
;

---- oracle���� �ѱ��� 3byte �� ���
SELECT lengthb('hello, sql') "���� byte"
  FROM dual
;
-- ��� : 10 ==> �����ڴ� 1byte �Ҵ�
SELECT lengthb('����Ŭ') "���� byte"
  FROM dual
;
-- ��� : 9 ==> �ѱ��� 3byte �Ҵ�


----------- 5. CONCAT(str1, str2) : str1�� str2�� ���ڿ� ����
--                                  || �����ڿ� ������ ���
SELECT concat('�ȳ��ϼ���.', 'SQL') "�λ�"
  FROM dual
;
/*
�λ�
-------------
�ȳ��ϼ���.SQL
*/
-- concat('�ȳ��ϼ���.', 'SQL') �� ���� ����� ���� || ���� ���
SELECT '�ȳ��ϼ���,' || 'SQL!' "�λ�"
  FROM dual
;

-------- SUBSTR(str, i) :
-- str���� i��° ��ġ������ n���� ���ڸ� ����

-- ���� : SQL is cooooooooooool~~!! ���� SQL �� �����غ���
SELECT substr('SQL is coooooooooool~~!!',5,2 )
  FROM dual
;
-- ���� : SQL is coooooooooool~~!! ���� is �� �����غ���
SELECT substr('SQL is coooooooooool~~!!', )
  FROM dual
;
-- ���� : SQL is coooooooooool~~!! ���� ~~!! �� �����غ���
SELECT substr('SQL is coooooooooool~~!!', 20)
  FROM dual
;

-- ���� : emp ���̺��� ������ �̸��� �� �α��� ������ �����Ͽ� ����� �Բ� ��ȸ�Ͻÿ�.
SELECT substr(e.ename,1,2) "����� �̸�"
     , e.empno
  FROM emp e
;
/*
����� �̸�, EMPNO
-----------------
SM	7369
AL	7499
WA	7521
JO	7566
MA	7654
BL	7698
CL	7782
KI	7839
TU	7844
JA	7900
FO	7902
MI	7934
*/

------------------7. INSTR(str1,str2) : �ι�° ���ڿ��� str2�� ù��° ���ڿ��� str1�� ��� ��ġ�ϴ��� �����ϴ� ��ġ�� ����Ͽ� ���ڷ� ���
SELECT instr('SQL is cooooooool~~!!', 'is') "is�� ��ġ"
  FROM dual
;

SELECT instr('SQL is cooooooool~~!!', 'io') "io�� ��ġ"
  FROM dual
;
-- �ι�° ���ڿ��� ù��° ���ڿ��� ������ 0�� ����Ѵ�.
/*
io�� ��ġ
--------
0
*/

---------- 8. LPAD, RPAD (str, n, c) : 
--            �Էµ� str�� ���ؼ� ��ü ���ڰ� ������ �ڸ����� n���� ��� ��ü ���ڼ� ��� ����/�����ʿ� ���� �ڸ����� c�� ���ڸ� ä�� �ִ´�.
SELECT lpad('SQL is cool!',20,'*')
  FROM dual
;

SELECT rpad('SQL is cool!',20,'*')
  FROM dual
;

------------9. LTRIM, RTRIM, TRIM : �Էµ� ���ڿ��� ����, ������, ���� ������ ����

SELECT '>' || '     sql is cool     '|| '<'
  FROM dual
;

SELECT '>' || ltrim('     sql is cool     ')|| '<'
  FROM dual
;
SELECT '>' || rtrim('     sql is cool     ')|| '<'
  FROM dual
;
SELECT '>' || trim('     sql is cool     ')|| '<'
  FROM dual
;

SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = '  SMITH'
 ;
 -- ����� �� : 0 ==> '   SMITH' ������ �� ���� 'SMITH'�� �ٸ��Ƿ� SMITH ������ ��ȸ���� ����
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = trim('  SMITH')
 ;
 -- '  SIMTH' ���� trim �Լ��� �����Ͽ� ��ȸ ����
 
 -- ���� : �񱳰��� '  smith' �� �� SMITH�� ������ ��ȸ�Ͻÿ�.
SELECT *
  FROM emp e
 WHERE e.ename = upper(trim(  'smith')) -- �Լ� ��ø
;

--------- 10. NVL(expr1, xepr2)
--            NVL2)expr1, expr2, expr3)
--            NULLIF(expr1, expr2)

-- NVL(expr1, expr2) :  ù��° ���� ���� NULL �̸�
--                      �ι�° ������ ��ü�Ͽ� ���
-- �Ŵ���(mgr)�� �������� ���� ������ ���
-- �Ŵ����� ����� 0���� ��ü�Ͽ� ���
SELECT e.empno
     , e.ename
     , nvl(e.mgr, 0) "�Ŵ��� ���"
  FROM emp e
;

SELECT e.empno
     , e.ename
     , nvl(e.mgr, '�Ŵ��� ����') "�Ŵ��� ���"
  FROM emp e
;

-- ==>nvl ó�� ��� �÷��� e.mgr �� ����Ÿ���� ���������� NULL ���� ��ó�ϴ� '�Ŵ��� ����'�� ����Ÿ���� �������̹Ƿ� ��ȯ�� mgr �÷��� Ÿ�԰� ����ġ�ϱ� ������ ����� ���� ������ �߻�

-- ���� : || ������ ��� concat() �Լ��� ����Ͽ� ���� ����� ���ÿ�
SELECT e.empno
     , e.ename
     , nvl(concat(e.mgr,''), '�Ŵ��� ����') "�Ŵ��� ���"
  FROM emp e
;
-- ����Ŭ ������ �� ���ڿ�('')�� NULL �� ���
-- NVL2(expr1,expr2,expr3) : ù��° ���� ���� NOT NULL �̸� �ι�° ���� ������ ���
--                           NULL �̸� ����° ���� ������ ���

-- �Ŵ���(mgr)�� ������ ��쿡�� '�Ŵ��� ����'���� ���
-- �Ŵ����� �������� ���� ��쿡�� '�Ŵ��� ����'���� ���
SELECT e.empno
     , e.ename
     , nvl2(e.mgr, '�Ŵ��� ����', '�Ŵ��� ����') "�Ŵ�����/��"
  FROM emp e
;
-- ����Ŭ���� �� ���ڿ� ('')�� NULL �� ����ϴ� ���� Ȯ���ϱ� ���� ����
SELECT nvl2('','IS NOT NULL','IS NULL') "NULL �� ����"
  FROM dual
;

-- �Է��� ���� 1ĭ ¥�� ����
SELECT nvl2(' ','IS NOT NULL','IS NULL') "NULL �� ����"
  FROM dual
;

--NULLIF(expr1, expr2) : ù��° ��, �ι�° ���� ���� �����ϸ� NULL�� ���
--                       �� ���� �ٸ��� ù��° ���� ���� ���
SELECT nullif('AAA','bbb') -- AAA
  FROM dual
;

SELECT nullif('AA', 'AA') "NULLIF���"
  FROM dual
;
/*
NULLIF���
---------
(null)
*/

--��ȸ�� ��� ���� 1���� �����ϰ� �� ���� null �λ���
-- 1���̶� ��ȸ�� �Ȱ��� "����� ��� ��:0" �� �ٸ��ٴ� �Ϳ� ����


-- ������ �ý��� �ð��� ��� sysdate �Լ�
SELECT sysdate
  FROM dual
;
/*
SYSDATE
---------
19/05/24  ==> ����Ŭ�� ��¥ ��� ���� YY/MM/DD
*/


-- TO_CHAR(arg) : arg�� ����, ��¥ Ÿ���� �����Ͱ� �ɼ� �ִ�. �Էµ� arg�� ����Ÿ������ �������ִ� �Լ�

SELECT to_char(sysdate, 'YYYY') "�⵵"-- 2019 
  FROM dual
;
SELECT to_char(sysdate, 'YY') "�⵵"-- 19 
  FROM dual
;
SELECT to_char(sysdate, 'MM') "��"-- 05 
  FROM dual
;
SELECT to_char(sysdate, 'MONTH') "��"-- 5��
  FROM dual
;
SELECT to_char(sysdate, 'Mon') "��"-- 
  FROM dual
;

-- ������ ����
SELECT to_char(sysdate, 'YYYY-MM-DD') "���� ��¥"-- 2019-05-24
  FROM dual
;
SELECT to_char(sysdate, 'FMYYYY-MM-DD') "���� ��¥"--2019-5-24
  FROM dual
;
SELECT to_char(sysdate, 'YY-MON-DD') "���� ��¥" --19-5�� -24
  FROM dual
;
SELECT to_char(sysdate, 'YY-MON-DD DAY') "���� ��¥" --19-5�� -24 �ݿ���
  FROM dual
;
SELECT to_char(sysdate, 'YY-MON-DD DY') "���� ��¥" --19-5�� -24 ��
  FROM dual
;

/* �ð� ���� : 
  HH : �ð��� ���ڸ��� ǥ��
  MI : ���� ���ڸ��� ǥ��
  SS : �ʸ� ���ڸ��� ǥ��
  HH24 : �ð��� 24�ð� ü��� ǥ��
  AM : �������� �������� ǥ��
*/

SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') "���� ��¥ �ú���" --2019-05-24 15:30:46
 FROM dual
;

--2019-05.24 03:41:42 <== 03�ð� �������� �������� �Ǻ� �Ұ�
SELECT to_char(sysdate, 'YYYY-MM-DD AM HH:MI:SS') "���� ��¥ �ú���"
  FROM dual
;

-- 2019-05-24 ���� 03:43:29 <== AM ���Ϲ��ڸ� �����ϸ� ����/���� ������

-- ��¥ ���� ������ ���� : +,- �����ڸ� ���
-- �������κ��� 10�� ��
SELECT sysdate + 10
  FROM dual
;
-- 2019/06/03 (���� ��¥ : 19/05/24 �϶�)

-- 10�� ��
SELECT sysdate - 10
  FROM dual
;
--19/05/14

-- 10�ð� ��
SELECT sysdate + 10/24
  FROM dual
;
-- 10�ð� �ĸ� ��/��/�� ���� ���
SELECT to_char(sysdate + 10/24, 'YYYY-MM-DD HH24:MI:SS') "10�ð� ��"
  FROM dual
;
--2019-05-25 01:47:20

---------- 1. MONTHS_BETWEEN(��¥1, ��¥2) : �� ��¥ ������ ���� ����
-- �� ������ �Ի��� ���κ��� ������� ����� �ٹ� �ߴ��� ��ȸ�Ͻÿ�.
SELECT  e.empno
      , e.ename
      , MONTHS_BETWEEN(sysdate, e.hiredate) "�ټ� ���� ��"
  FROM emp e
;
-- �� ������ �ټ� ���� ���� ���ϵ� �Ҽ��� 1�� �ڸ������� ���϶�
-- �̋�, �Ҽ��� 2�� �ڸ����� �ݿø�.
SELECT  e.empno
      , e.ename
      , ROUND(MONTHS_BETWEEN(sysdate, e.hiredate), 1) "�ټ� ���� ��"
  FROM emp e
;

-------------2.ADD_MONATHS(��¥, ����) :  ��¥�� ���ڸ� ���� ���� ���� ��¥�� ����
SELECT add_months(sysdate, 3) -- ����κ��� 3���� ���� ��¥
  FROM dual
;
-- ��¥ + ���� : ���� ��ŭ�� �� ���� ���Ͽ� ��¥�� ����
-- ��¥ + ����/24 : ���� ��ŭ�� �ð��� ���Ͽ� ��¥�� ����
-- ADD_MONTHS(��¥, ����) : ���� ��ŭ�� ���� ���Ͽ� ��¥�� ����

------------- 3. NEXT_DAT, LAST_DAT
--              ���� ���Ͽ� �ش��ϴ� ��¥�� ����
--              �̴��� ������ ��¥�� ����

-- ���� ��¥���� ���ƿ��� ��(4) ������ ��¥�� ����
SELECT next_day(sysdate, 4) --"���ƿ��� ������"
  FROM dual
;
SELECT next_day(sysdate, '������') --"���ƿ��� ������"
  FROM dual
;
SELECT last_day(sysdate) "�̴��� ������ ��"
  FROM dual
;  
------ 4. ROUND, TRUNC : ��¥�� ���� �ݿø�, ���� ����
SELECT round(sysdate) "���� �ð�"
  FROM dual
;
-- ���� �ð����� �ݿø� �� ��¥�� ��/��/�� ���� ���
SELECT to_char(round(sysdate), 'YYYY-MM-DD HH24:MI:SS')
  FROM dual
;

SELECT trunc(sysdate) "���� �ð����� �ú��� ����"
  FROM dual
;
SELECT to_char(trunc(sysdate), 'YYYY-MM-DD HH24:MI:SS')
  FROM dual
;