--1.
SELECT  e.*,s.dname,s.loc FROM emp e JOIN dept s
ON e.deptno=s.deptno
WHERE hiredate>'80/04/02' AND hiredate<='82/01/23'
ORDER BY e.deptno;

--2.
SELECT e.*,s.grade FROM emp e JOIN salgrade s
ON  e.sal>=losal AND e.sal<=hisal
WHERE hiredate>'80/04/02' AND hiredate<='82/01/23'
ORDER BY s.grade DESC;

--3.
SELECT e.*,s.grade FROM emp e JOIN salgrade s
ON e.sal>=losal AND e.sal<=hisal
WHERE hiredate>'80/04/02' AND hiredate<='82/01/23' AND e.deptno!=10
ORDER BY s.grade DESC;

--4.
SELECT deptno,FLOOR(AVG(sal*12+NVL(comm,0))) Æò±Õ¿¬ºÀ FROM emp 
WHERE deptno IN(20,30)
GROUP BY deptno
ORDER BY Æò±Õ¿¬ºÀ DESC;

--5.
SELECT e.*,d.dname,d.loc,s.grade FROM emp e JOIN dept d 
ON e.deptno=d.deptno
JOIN salgrade s
ON  e.sal>=losal AND e.sal<=hisal
WHERE hiredate>'80/04/02' AND hiredate<='82/01/23'
ORDER BY s.grade ASC;

--6.
SELECT a.empno,a.ename,a.job,a.mgr,b.ename "MANAGER" FROM emp a LEFT OUTER JOIN emp b
ON a.mgr=b.empno;

--7.
SELECT e.ename,c.ename "MANAGER",d.dname FROM emp e JOIN emp c
    ON e.mgr=c.empno
    JOIN dept d
    ON e.deptno=d.deptno
WHERE e.deptno=20;

--8.
SELECT e.empno,e.ename,e.job,e.sal,d.dname,d.loc FROM emp e JOIN dept d
ON e.deptno=d.deptno
WHERE e.deptno=20 AND e.sal>(SELECT AVG(sal) FROM emp);

--9.
SELECT ename,sal,deptno FROM emp
WHERE sal IN(SELECT MAX(sal) FROM emp GROUP BY deptno);

--10.
SELECT job,ename,sal FROM emp
WHERE sal IN(SELECT MIN(sal) FROM emp GROUP BY job);










