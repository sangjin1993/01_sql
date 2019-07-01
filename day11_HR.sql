
-- HR���� Ȱ��ȭ

ALTER SESSION 
  SET "_ORACLE_SCRIPT"=true
;

@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_main_new.sql;

-- 1�� �Է� : HR
-- 2�� �Է� : HR
-- 3�� �Է� : HR
-- 4�� �Է� : $ORACLE_HOME/demo/schema/log/
-- 1 ~ 4 �Է� �� HR ���� ���̺� ������.

--HR �� �۾�
-- 2.DISTINCT 
-- 1)EMPLOYEES���̺��� JOB_ID�� �ߺ� ���� ���Ͽ� JOB_ID �÷��� ��ȸ�Ͻÿ�.
SELECT DISTINCT e.JOB_ID
  FROM EMPLOYEES e
;
-- 2)

-- 3.ORDER BY
-- 1)EMPLOYEES���̺��� ������ ū ������� ���, �̸�, ���� �÷��� ��ȸ
SELECT e.employee_id
     , e.last_name
     , e.commission_pct
  FROM employees e
 ORDER BY e.commission_pct DESC
;
-- 2) EMPLOYEES���̺��� ���, �̸�, ����, �Ի��ϸ� ��ȸ�ϰ� �Ի����� ����������� ��ȸ�Ͻÿ�.
SELECT e.employee_id
     , e.last_name
     , e.job_id
     , e.hire_date
  FROM employees e
 ORDER BY e.hire_date
;
-- 3) EMPLOYEES���̺��� ���, �̸�, ����, �޿��� ��ȸ�ϰ� �޿��� ���� ������� ��ȸ�Ͻÿ�.
SELECT e.employee_id
     , e.last_name
     , e.job_id
     , e.salary
  FROM employees e
 ORDER BY e.salary
;

-- 4.ALIAS
-- 1) LOCATIONS���̺� ��Ī�� �ְ� ��ȸ�Ͻÿ�
SELECT *
  FROM LOCATIONS l
;
-- 2) DEPARTMENTS ���̺� ��Ī���ְ� department_id, department_name�� ��ȸ�Ͻÿ�.
SELECT d.department_id
     , d.department_name
  FROM DEPARTMENTS d
;
-- 3) COUNTRIES ���̺� ��Ī�� �ְ�, COUNTRY_ID�� ���ڷ� ��Ī�� �ְ�, COUNTRY_NAME�� ���� �̸����� ��Ī�� �־� ��ȸ�Ͻÿ�
SELECT c.country_id ����
     , c.country_name "���� �̸�"
  FROM COUNTRIES c
;


-- 5.WHERE ��
-- 1) EMPLOYEES���̺��� �μ���ȣ�� 100�� ����� ����� ��ȸ�Ͻÿ�
SELECT e.employee_id
  FROM employees e
 WHERE e.department_id = 100
;
-- 2) LOCATIONS���̺��� LOCATION_ID�� 2000�̻��� ���ø� ��ȸ�Ͻÿ�.
SELECT l.city
  FROM locations l
 WHERE l.location_id > 2000
;
-- 3) EMPLOYEES���̺��� �μ���ȣ�� 50�̸� �޿��� 5000�̻��� ����� ���, �̸�, �޿��� ��ȸ�Ͻÿ�
SELECT e.employee_id
     , e.last_name
     , e.salary
  FROM employees e
 WHERE e.department_id = 50
   AND e.salary > 5000
;


-- 6.������
-- 1)employees ���̺��� ���, �̸�, �޿��� ��ȸ�ϰ� �޿��� 3.3%�� �ش��ϴ� ������ ����Ͽ� ��ȸ�Ͻÿ�.
SELECT e.employee_id
     , e.last_name
     , e.salary
     , e.salary *0.033
  FROM employees e
;
-- 2) �޿��� 2000�̻� 5000�̸��� ����� �����, �̸�, �޿��� ��ȸ�Ͻÿ�
SELECT e.employee_id
     , e.last_name
     , e.salary
  FROM employees e
 WHERE e.salary BETWEEN 2000 AND 5000
;
-- 3) '�̸�' ���� �޿��� '�޿�'�Դϴ� ��� ������ ����ÿ�
SELECT e.last_name || '���� �޿���' || e.salary || '�Դϴ�' AS �޿�
  FROM employees e
;

-- 7.������ �Լ�
-- 1)EMPLOYEES���� ����� �̸�, �μ���ȣ�� ��ȸ�ϰ� DEPARTMENT_ID�� NULL�� ���� 0���� �ٲٽÿ�.
SELECT e.employee_id
     , e.last_name
     , NVL(e.department_id, 0)
  FROM employees e
;
-- 2)EMPLOYEES���̺��� ���� �빮�ڷ� �̸��� �ҹ��ڷ� ��ȸ�Ͻÿ�
SELECT UPPER(e.first_name)
     , LOWER(e.last_name)
  FROM employees e
;
-- 3)EMPLOYEES���̺��� ���, �̸�, ����,�޿��� ��ȸ�ϰ� �޿��� ȭ������� �ٲٰ� ���ڸ��� ��� ǥ���Ͻÿ�.
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


--���ϸ� : day11_HR �ѱ��̸�





