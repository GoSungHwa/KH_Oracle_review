create table  dept04 as select *from dept03;  
--as select���� ���� ���̺��� ������ ����
select * from dept04;

create table emp07 as select *from emp;
select *from emp07;

create table emp08 as select empno,ename from emp where deptno in(10,30);
select *from emp08 where 1=0; --where�� �����Ұ� ���� ������ Ȯ�� ����

create table emp09 as select *from emp where 1=0;
select *from emp09;

create table emp_hire as select empno,ename,hiredate from emp where 1=0;
create table emp_sal as select empno,ename,sal from emp where 1=0;

insert all
when hiredate>'1982/01/01'   --������� '2010/01/01' ���� ���
then into emp_hire values(empno,ename,hiredate)
when sal>=2000  --�޿��� 2000�̻��� ���
then into emp_sal values(empno,ename,sal)
select empno,ename,hiredate,sal from emp;

select *from emp_hire;
select *from emp_sal;

select *from emp09;
insert into emp09 (empno,ename,job,sal) 
    select empno,ename,job,sal from emp where deptno in(10,20);
    
INSERT INTO emp VALUES (1001, 'ALICE', 'CLERK', 1003, '16/09/08', 800, NULL, 30);
INSERT INTO emp VALUES (1002, 'MORRIS', 'CLERK', 1003, '16/09/08', 800, NULL, 30);
INSERT INTO emp VALUES (1003, 'MATHEW', 'SALEMAN', NULL, '16/01/01', 1500, 100, 30);
INSERT INTO emp (empno, ename) VALUES (1010, 'BOB');
INSERT INTO emp (empno, ename, job) VALUES (1011, 'EDWARD', 'MANAGER');

create table emp_research as select *from emp where 1=0;

select *from emp;
update emp set ename='MATT' where ename='MATHEW';

update emp set sal=sal*1.1 where deptno in(10,30);

--merge : ���ǿ� ���� ����, ����, ���� �� ���� �۾��� �ѹ��� �� �� �ִ� ����
CREATE TABLE emp_merge_ex
AS SELECT empno, ename, sal, deptno FROM emp WHERE deptno IN (10, 20);
select *from emp_merge_ex;

--emp ���̺��� �μ���ȣ�� 20, 30�� ������� �̿��� emp_merge_ex ���̺� �̹� �����ϴ� ��
--���� ��� �޿��� 10% �λ��ϰ�, �������� ������ �޿��� 1000���� ū ������� ���
MERGE INTO emp_merge_ex m
USING (
 SELECT empno, ename, deptno, sal
 FROM emp 
 WHERE deptno IN (20,30)
) e
ON ( m.empno = e.empno )
WHEN MATCHED THEN
 UPDATE SET m.sal = ROUND(m.sal*1.1)
WHEN NOT MATCHED THEN
 INSERT (m.empno, m.ename, m.sal, m.deptno)
 VALUES (e.empno, e.ename, e.sal, e.deptno)
 WHERE e.sal > 1000;
 
 show autocommit;
 
 --DB ��ü : TALBE, INDEX, VIEW, SEQENCE,USER, ROLE, SYNONYM
 create or replace view view_emp_dept
    as select *from emp e join dept d using(deptno);
    
create or replace force view view_test01
    as select *from empa e join dept d using(deptno);

--emp_copy ���̺� ����
CREATE TABLE emp_copy AS SELECT *FROM emp;
--view ����
create view emp_copy_view as select empno,ename,deptno from emp_copy;
--emp_copy_view�� insert�� ����
insert into emp_copy_view values(1234,'JONATHAN',30);
--EMP_COPY_VIEW ��ȸ
select *from emp_copy_view;
select *from emp_copy;

--ROWNUM : ����Ŭ���� ���������� �ο��ϴ� �÷�, �����ͺ��̽��� INSERT�� ������� ī���õȴ�.
--����� ������
SELECT E.*,ROWNUM FROM emp E;
    --5���� 9���� ����������� ��� �ؾ��ұ�??
SELECT * FROM (SELECT E.*,ROWNUM FROM emp E) 
WHERE ROWNUM BETWEEN 5 AND 9; --���;ߵǴµ� �־ȳ�����??
--������� : FORM -ON/USING -WHERE -GRUOP BY -HAVING - SELECT -ORDER BY

SELECT ROWNUM,empno,ename,sal FROM emp;
SELECT ROWNUM,empno,ename,sal FROM emp
ORDER BY sal DESC;  --ROWNUM�� �̸� ����⶧���� �����ص� ROWNUM�� �ٲ��� �ʴ´�.

--��� ROWNUM�� �̿��� TOP-N ���ϱ�
CREATE OR REPLACE VIEW emp_view_sal 
AS SELECT empno,ename,NVL(sal,0) SAL FROM emp
ORDER BY sal DESC;
--��ȸ
SELECT ROWNUM,empno,ename,sal FROM emp_view_sal;

--������ ���� ���� 5���� ���غ���
SELECT ROWNUM,empno,ename,sal FROM emp_view_sal
WHERE ROWNUM<=5;

--�ζ��� �� TOP-N : 1ȸ�� ��������
SELECT ROWNUM,empno,ename,sal 
FROM (SELECT empno,ename,NVL(sal,0) SAL FROM emp ORDER BY sal DESC)
WHERE ROWNUM<=5;

--������(Sequence) : ���̺� ���� ������ ���ڸ� �ڵ����� �����Ѵ� �ڵ� ��ȣ �߻� ex)�Խ���
--������ ���� �� Ȯ��
CREATE SEQUENCE seq_empno 
START WITH 1000
INCREMENT BY 1
CACHE 20;  --�޸𸮻󿡼� ������ �� ����
SELECT seq_empno.NEXTVAL FROM dual;

--������ ���� (�����߻��� �ٽ��غ���)
CREATE SEQUENCE seq_deptno
START WITH 50
INCREMENT BY 10;
select *from dept03;
INSERT INTO dept03 VALUES(seq_deptno.NEXTVAL,'AB','LAA','AA');

--INSERT������ ������ ���
INSERT INTO emp(empno,ename) VALUES(seq_empno.NEXTVAL,'TEST');
SELECT empno,ename FROM emp WHERE ename='TEST';

--������ ���� : START WITH �� ������ �ٸ� �������� ���� ����
ALTER SEQUENCE seq_empno
INCREMENT BY 10
CACHE 40;
SELECT seq_empno.NEXTVAL FROM dual;
  