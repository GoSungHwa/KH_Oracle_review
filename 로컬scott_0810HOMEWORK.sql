--9.���� ��¥�� ���� ���� ��ȸ -- 9
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:mi:ss') FROM dual;

--10. EMP ���̺��� ���, �����, �޿� ��ȸ 
--�� �޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ���� (�ȵǳ׿�)
SELECT empno,ename,TRUNC(sal,-1) FROM emp
ORDER BY sal DESC;

--11.EMP ���̺��� �����ȣ�� Ȧ���� ������� ��ȸ
SELECT empno,ename FROM emp
WHERE MOD(empno,2)<>0;

--12.EMP���̺��� �����, �Ի��� ��ȸ
--��, �Ի����� �⵵�� ���� �и� �����ؼ� ��� 

--13.EMP���̺��� 9���� �Ի��� ������ ���� ��ȸ
SELECT * FROM emp
WHERE 