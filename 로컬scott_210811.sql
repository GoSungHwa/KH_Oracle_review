--서브쿼리 
SELECT dname FROM dept
WHERE deptno=(SELECT deptno FROM emp WHERE ename='KING');
--평균 급여보다 많은 급여를 받는 사원 조회
SELECT empno,ename,sal FROM emp
WHERE sal>=
(SELECT AVG(sal) FROM emp);
--다중 행 서브 쿼리
--부서별 급여를 제일 많이 받는 사원 조회
SELECT dname,empno,ename,sal FROM emp JOIN dept USING(deptno)
WHERE sal IN
(SELECT MAX(sal) FROM emp 
 GROUP BY deptno);
 --ANY,SOME : 메인 쿼리의 비교 조건이 서브 쿼리의 여러 검색 결과 중 하나 이상 만족되면 반환
 SELECT empno,ename,sal FROM emp
 WHERE sal>ANY(SELECT sal FROM emp WHERE job='SALESMAN');
 --SALESMAN 들의 급여와 같은 급여를 받는 사원을 조회
 SELECT empno,ename,sal FROM emp
 WHERE sal=ANY(SELECT sal FROM emp WHERE job='SALELSMAN');
 --ALL : 메인 쿼리의 비교 조건이 서브 쿼리의 여러 검색 결과와 모든 값이 일치하면 반환
 --'MANAGER' 사원들의 급여들 보다 높은 급여를 받는 사원 조회
 SELECT empno,ename,sal FROM emp
 WHERE sal>ALL(SELECT sal FROM emp WHERE job='MANAGER');
 --EXISTS : 서브쿼리의 데이터가 존재하는 지 여부를 먼저 따져 존재하는 값들만 결과로 출력
 --관리자로 등록되어 있는 사원들을 조회
 SELECT empno,ename,sal FROM emp e
 WHERE EXISTS(SELECT empno FROM emp WHERE e.empno=mgr);
 --다중 열 서브 쿼리 : 서브 쿼리의 결과가 두 개 이상의 컬럼으로 반환되어 메인 쿼리에 전달하는 쿼리
 --부서 번호가 30인 사원들의 급여와 부서번호를 묶어 메인쿼리로 전달
 SELECT empno,ename,sal,deptno FROM emp
 WHERE(deptno,sal)IN
 (SELECT deptno,sal FROM EMP
    WHERE deptno=30);
    --스칼라 서브쿼리 : SELECT 문에서 쓰이는 단일행 서브쿼리
    --EMP테이블의 매행마다 부서번호가 각행의 부서번호와 동일한 사원들의 SAL 평균을 구하라
SELECT ename,deptno,sal,
    (SELECT TRUNC(AVG(sal)) --소속 부서의 급여 평균값 1개
FROM emp
WHERE deptno=e.deptno) AS AVGDEPTSAL  FROM emp e;
--부서위치가 new york인 경우에 본사로, 그 외부서는 분점으로 리턴하는 쿼리를 case문을 통해 실행
SELECT empno,ename, 
    CASE
        WHEN deptno=(SELECT deptno
        FROM dept
        WHERE loc='NEW YORK')
        THEN '분사'
        ELSE '분점'
        END AS 소속
    FROM emp e
    ORDER BY 소속 DESC;
    
--상관쿼리(상호연관 서브쿼리) : 메인 쿼리의 특정컬럼을 조인조건으로 사용하는 서브 쿼리
    --이것은 서브쿼리만 따로 테스트해볼 수 없다.
--SELECT 컬럼에 상관쿼리를 사용해서 사원의 부서일므 구하기
SELECT ename,job,
    (SELECT dname FROM dept WHERE deptno=e.deptno) dname FROM emp e;
    
--FROM절 서브 쿼리 --많이 사용한대.
--급여가 부서번호 20인 부서의 평균보다 높고 사원을 관리하는 'MANAGER'로써 20 부서에 속하지
--않는 사원을 조회
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
    
--ORDER BY절 서브커리
SELECT empno,ename,deptno,hiredate FROM emp e
ORDER BY (
SELECT dname FROM dept
WHERE deptno=e.deptno) DESC;

--집합연산자 UNION(합집합)
SELECT *FROM emp WHERE joB='SALESMAN'
UNION 
SELECT *FROM emp WHERE job='MANAGER';
    --컬럼 '데이터타입'을 같게 해야한다!!
SELECT ename,sal FROM emp WHERE joB='SALESMAN'
UNION 
SELECT ename,deptno FROM emp WHERE job='MANAGER';
--집합연산자 INTERSECT(교집합)
SELECT empno, ename,sal FROM emp WHERE sal>100
INTERSECT
SELECT empno,ename,sal FROM emp WHERE sal<2000;
--집합연산자 MINUS(차집합)
SELECT empno,ename,sal FROM emp
MINUS
SELECT empno,ename,sal FROM emp WHERE sal>2000;
