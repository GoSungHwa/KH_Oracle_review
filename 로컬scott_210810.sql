--DUAL ���̺���� DUAL 
--SCOTT�� ���̺��� �ƴ����� SYSTEM�� ������ �� �� �ְ� ������ �� ���̺�
--�ӽ� ����� ���̺� �ʿ��� �� ���
SELECT 35*12 FROM dual;
--5 % 4 ,������ �Լ�MOD()
SELECT MOD(5,4) FROM dual;
--���밪
SELECT -10,ABS(-10) FROM dual;
--�ݿø��� �� ���
SELECT 12.3456, ROUND(12.3456),ROUND(12.3456,2),ROUND(12.3456,-1) 
FROM dual;
--������ �� ���
SELECT 12.3456,TRUNC(12.3456,2),TRUNC(12.3456,-1),TRUNC(12.3456,0) FROM dual;
--�Ǽ� ���� ���� ������ ū���� ����
SELECT CEIL(12.3456) FROM dual;
--�Ǽ� ���� ���� ������ ���� ����
SELECT FLOOR(12.3456) FROM dual;
--����
SELECT POWER(3,4) FROM dual;
--�빮��
SELECT UPPER('sam') FROM dual;
--�ҹ���
SELECT LOWER('ORACLE') FROM dual;
--�ձ��ڸ� �빮��
SELECT INITCAP('kim mal ddong') FROM dual;
--���� ��ȯ LENGTH -���̹�ȯ(���ڴ���), LENGTHB-����Ʈ ��ȯ
SELECT LENGTH('test11'),LENGTHB('test11') FROM dual;
SELECT 'ȫ�浿', LENGTH('ȫ�浿'), LENGTHB('ȫ�浿') FROM dual;
--�˻��� ���� ��ġ ��ȯ
SELECT INSTR('ORACLE WELCOME','O',2,1) FROM dual;
--������ġ���� ���� ������ŭ ���ڸ� ��ȯ
SELECT SUBSTR('����Ŭ �����ͺ��̽�',3,5) FROM dual;
--������ġ���� ����° ������ ���ù���Ʈ����ŭ �ݺ�
SELECT SUBSTRB('����Ŭ �����ͺ��̽�',3) FROM dual;
--���� ĭ���� �����ϰ� ��ĭ��ƴ Ư�����ڷ� ä��(10ĭ)
SELECT LPAD('ORACLE',10,'+') FROM dual;
SELECT RPAD('ORACLE',10,'+') FROM dual;
--����/������ ���鹮�ڸ� ����
SELECT 'ORACLE', LTRIM('   ORACLE  '),RTRIM('   ORACLE   ') FROM dual;

--���� ��¥ �ð�(���ڵ��� �ð��� ��� �ð��� �ȶߴ°��ϻ�)
SELECT SYSDATE FROM dual;
--�ð�����
SELECT TO_CHAR(SYSDATE,'YYYY-MONTH-DD HH24:SS') FROM dual;
--����->���� ��ȯ
SELECT TO_CHAR(sal,'$9,999') FROM emp;

--����->��¥ ��ȯ
SELECT TO_DATE('2121-08-08 13:24','YYYY-MM-DD HH24:MI') FROM dual;
SELECT TO_DATE('09-08 13','MM-DD HH24') FROM dual;

--NVL2 : NULL�� ��츦 �Ǵ������� NULL���� �ƴ����� ���� ����� �ٸ���
SELECT empno,ename,NVL2(comm,sal+comm,sal) pay,sal,comm FROM emp;

--DECODE : ���ǿ� �ش��ϴ� ���� ������ �� ���,CASE~END�� ����ص���
SELECT empno,ename,deptno,DECODE(deptno,10,'ȸ����',20,'������',30,'������',40,'���')deptname FROM emp;

-- CASE WHEN THEN ELSE END
SELECT empno, ename, 
   CASE
    WHEN deptno=10 THEN 'ȸ����'
    WHEN deptno=20 THEN '������'
    WHEN deptno=30 THEN '������'
    WHEN deptno=40 THEN '���'
    ELSE '����?'
  END deptname
FROM emp;

--COUNT : �÷��� �� ����
SELECT COUNT(*) FROM emp;
SELECT COUNT(sal) FROM emp; -- �ߺ������� ���� �־ �� ������ ģ��.
SELECT COUNT(comm) FROM emp; -- NULL���� �� ������ ��ģ��.

--�μ����� ����� ������� �˷���. �μ���ȣ�� ����� ǥ������
SELECT deptno, COUNT(deptno) ||'��' ����� FROM emp
GROUP BY deptno;

--�μ����� ����� ������� �˷���. �μ���ȣ�� ����� ǥ������
--JOB�� MANAGE�� ��� �����ϰ� ��¥ ����� ���� ǥ������.
SELECT deptno, COUNT(deptno) ||'��' ����� FROM emp
WHERE job <>'MANAGER'
GROUP BY deptno
ORDER BY deptno;

--JOIN(����) �����
SELECT e.deptno,d.dname,COUNT(e.empno) FROM emp e,dept d
WHERE e.deptno=d.deptno
GROUP BY e.deptno,d.dname;

SELECT e.deptno,d.dname,COUNT(e.empno) FROM emp e JOIN dept d
ON e.deptno=d.deptno
WHERE e.deptno=d.deptno
GROUP BY e.deptno,d.dname;

SELECT e.deptno,dname,COUNT(e.empno) FROM emp e,dept d
WHERE e.deptno=d.deptno
GROUP BY e.deptno,dname
HAVING COUNT(e.empno)>5;

--�� ���� : ���� �÷��� ���� �ٸ� ������ ����Ͽ� ������ �� ���
SELECT e.ename,e.sal,s.grade FROM emp e,salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

SELECT e.ename,e.sal,s.grade FROM emp e JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal;

--SELF-JOIN :�ϳ��� ���̺��� �ڽ��� ���̺�� ������ �߻��ϴ� ��
--             �ϳ��� ���̺��� �� ���� ���̺��� ��ó�� ����
SELECT e.ename,m.ename "Manager" FROM emp e,emp m
WHERE e.empno=m.mgr;

SELECT e.ename, m.ename "Manager" 
FROM emp e JOIN emp m
ON e.mgr = m.emptno; 

--outer join
SELECT e.ename, m.ename "Manager" 
FROM emp e LEFT OUTER JOIN emp m
ON e.mgr = m.empno; 

--�����,SALGRADE ����̶� ǥ������
SELECT e.ename,s.grade FROM emp e JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal;

SELECT * FROM emp e JOIN salgrade s
ON e.sal>=s.losal AND e.sal<=s.hisal;

--GRADE �� ��ձ޿��� ��Ÿ���ּ���.GRADE ��������
select s.grade,floor(AVG(e.sal))��ձ޿� from emp e JOIN salgrade s
on e.sal between s.losal and s.hisal
group by s.grade
order by s.grade DESC;

--<select ����?>
--select [distinct] (*,�÷���1,�÷���2, ���� ��Ī,�Լ� ��Ī)
--from ���̺��1 ��Ī [INNER/LEFT/RIGHT/OUTER JOIN ���̺��2 ��Ī]
--ON/USING ��������
--where ���ǹ�-�׷��������ڵ弱��
--group by �÷���1[,�÷���2...]
--having ���ǹ�-�׷������������ڵ弱��
--order by �÷��� ����;

---�������- 
--FROM -> ON/USING -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY 








