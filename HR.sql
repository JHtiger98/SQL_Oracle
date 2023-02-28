--Q1. HR EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
--A. 
SELECT FIRST_NAME, LAST_NAME, 12*SALARY, 1.1*SALARY
FROM EMPLOYEES;

    
--Q2.  2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
--A.        
SELECT FIRST_NAME, LAST_NAME , HIRE_DATE FROM EMPLOYEES
WHERE TO_DATE('2005-01-01','YYYY-MM-DD') <= HIRE_DATE AND HIRE_DATE <= TO_DATE('2005-06-30', 'YYYY-MM-DD');

--Q3. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
--A.
SELECT FIRST_NAME, LAST_NAME, JOB_ID FROM EMPLOYEES
WHERE JOB_ID IN ('IT_PROG', 'ST_MAN');

--Q4. manager_id �� 101���� 103�� ����� ���
--A.   	
SELECT FIRST_NAME, LAST_NAME, MANAGER_ID FROM EMPLOYEES
WHERE MANAGER_ID BETWEEN 101 AND 103;


--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
--A.
SELECT LAST_NAME, HIRE_DATE, NEXT_DAY(ADD_MONTHS(HIRE_DATE, 6), '������') FROM EMPLOYEES;

--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE,
TRUNC((MONTHS_BETWEEN (SYSDATE, HIRE_DATE))) W_MONTH
FROM EMPLOYEES
ORDER BY W_MONTH DESC;

--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE,
TRUNC((SYSDATE-HIRE_DATE)/365) W_YEAR
FROM EMPLOYEES
ORDER BY W_YEAR DESC;

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
--A. 
SELECT EMPLOYEE_ID, LAST_NAME FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID,2)=1;

--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
--A
SELECT EMPLOYEE_ID, LAST_NAME, TRUNC(SALARY/12,2)
FROM EMPLOYEES;


--Q10. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰��� �Ŀ� ����ϼ���.
--2001�� 1�� 1�� â���Ͽ� ������� 20�Ⱓ ��ǿ� ȸ��� ������  �ټӳ���� ���� 30 ������� ������  ��޿� ���� 1000���� BONUS�� ����.
--�������� ����.    
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE,
TRUNC((SYSDATE-HIRE_DATE/365),0,20,30)-1) WB;--�ټӳ��


--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
--A.
SELECT COUNT(*) FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;


--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
--A.
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, NVL(TO_CHAR(DEPARTMENT_ID), '����') AS POSITION
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
--A.
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, JOB_TITLE
FROM EMPLOYEES NATURAL JOIN JOBS;


--Q14.  employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
--A. 
SELECT FIRST_NAME ||' '|| LAST_NAME AS NAME FROM EMPLOYEES;

--Q15. HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���. (�� : �μ��� ��� SALARY ����)
--A.
SELECT DEPARTMENT_NAME, ROUND(AVG(SALARY)) AS AVG_SAL FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG_SAL DESC;

--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
--A.
SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%\_A%' ESCAPE '\';

--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
--A. 
SELECT SALARY, LAST_NAME FROM EMPLOYEES
ORDER BY SALARY, LAST_NAME;


--Q18. Seo��� ����� �μ����� ����ϼ���.
--A.
SELECT DEPARTMENT_NAME FROM DEPARTMENTS NATURAL JOIN EMPLOYEES
WHERE LAST_NAME = 'Seo';

SELECT DEPARTMENT_NAME FROM DEPARTMENTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME = 'Seo');


