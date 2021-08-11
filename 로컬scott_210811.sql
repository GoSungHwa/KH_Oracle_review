--�������� 
SELECT dname FROM dept
WHERE deptno=(SELECT deptno FROM emp WHERE ename='KING');
--��� �޿����� ���� �޿��� �޴� ��� ��ȸ
SELECT empno,ename,sal FROM emp
WHERE sal>=
(SELECT AVG(sal) FROM emp);
--���� �� ���� ����
--�μ��� �޿��� ���� ���� �޴� ��� ��ȸ
SELECT dname,empno,ename,sal FROM emp JOIN dept USING(deptno)
WHERE sal IN
(SELECT MAX(sal) FROM emp 
 GROUP BY deptno);
 --ANY,SOME : ���� ������ �� ������ ���� ������ ���� �˻� ��� �� �ϳ� �̻� �����Ǹ� ��ȯ
 SELECT empno,ename,sal FROM emp
 WHERE sal>ANY(SELECT sal FROM emp WHERE job='SALESMAN');
 --SALESMAN ���� �޿��� ���� �޿��� �޴� ����� ��ȸ
 SELECT empno,ename,sal FROM emp
 WHERE sal=ANY(SELECT sal FROM emp WHERE job='SALELSMAN');
 --ALL : ���� ������ �� ������ ���� ������ ���� �˻� ����� ��� ���� ��ġ�ϸ� ��ȯ
 --'MANAGER' ������� �޿��� ���� ���� �޿��� �޴� ��� ��ȸ
 SELECT empno,ename,sal FROM emp
 WHERE sal>ALL(SELECT sal FROM emp WHERE job='MANAGER');
 --EXISTS : ���������� �����Ͱ� �����ϴ� �� ���θ� ���� ���� �����ϴ� ���鸸 ����� ���
 --�����ڷ� ��ϵǾ� �ִ� ������� ��ȸ
 SELECT empno,ename,sal FROM emp e
 WHERE EXISTS(SELECT empno FROM emp WHERE e.empno=mgr);
 --���� �� ���� ���� : ���� ������ ����� �� �� �̻��� �÷����� ��ȯ�Ǿ� ���� ������ �����ϴ� ����
 --�μ� ��ȣ�� 30�� ������� �޿��� �μ���ȣ�� ���� ���������� ����
 SELECT empno,ename,sal,deptno FROM emp
 WHERE(deptno,sal)IN
 (SELECT deptno,sal FROM EMP
    WHERE deptno=30);
    --��Į�� �������� : SELECT ������ ���̴� ������ ��������
    --EMP���̺��� ���ึ�� �μ���ȣ�� ������ �μ���ȣ�� ������ ������� SAL ����� ���϶�
SELECT ename,deptno,sal,
    (SELECT TRUNC(AVG(sal)) --�Ҽ� �μ��� �޿� ��հ� 1��
FROM emp
WHERE deptno=e.deptno) AS AVGDEPTSAL  FROM emp e;
--�μ���ġ�� new york�� ��쿡 �����, �� �ܺμ��� �������� �����ϴ� ������ case���� ���� ����
SELECT empno,ename, 
    CASE
        WHEN deptno=(SELECT deptno
        FROM dept
        WHERE loc='NEW YORK')
        THEN '�л�'
        ELSE '����'
        END AS �Ҽ�
    FROM emp e
    ORDER BY �Ҽ� DESC;
    
--�������(��ȣ���� ��������) : ���� ������ Ư���÷��� ������������ ����ϴ� ���� ����
    --�̰��� ���������� ���� �׽�Ʈ�غ� �� ����.
--SELECT �÷��� ��������� ����ؼ� ����� �μ��Ϲ� ���ϱ�
SELECT ename,job,
    (SELECT dname FROM dept WHERE deptno=e.deptno) dname FROM emp e;
    
--FROM�� ���� ���� --���� ����Ѵ�.
--�޿��� �μ���ȣ 20�� �μ��� ��պ��� ���� ����� �����ϴ� 'MANAGER'�ν� 20 �μ��� ������
--�ʴ� ����� ��ȸ
SELECT b.empno,b.ename,b.job,b.sal,b.deptno
FROM(
    SELECT empno FROM emp
    WHERE sal>(
    SELECT AVG(sal) FROM emp
    WHERE deptno=20)
    )a,emp b
    WHERE a.empno=b.empno
    AND b.mgr IS NOT NULL
    AND b.deptno !=20;
    
--ORDER BY�� ����Ŀ��
SELECT empno,ename,deptno,hiredate FROM emp e
ORDER BY (
SELECT dname FROM dept
WHERE deptno=e.deptno) DESC;

--���տ����� UNION(������)
SELECT *FROM emp WHERE joB='SALESMAN'
UNION 
SELECT *FROM emp WHERE job='MANAGER';
    --�÷� '������Ÿ��'�� ���� �ؾ��Ѵ�!!
SELECT ename,sal FROM emp WHERE joB='SALESMAN'
UNION 
SELECT ename,deptno FROM emp WHERE job='MANAGER';
--���տ����� INTERSECT(������)
SELECT empno, ename,sal FROM emp WHERE sal>100
INTERSECT
SELECT empno,ename,sal FROM emp WHERE sal<2000;
--���տ����� MINUS(������)
SELECT empno,ename,sal FROM emp
MINUS
SELECT empno,ename,sal FROM emp WHERE sal>2000;
