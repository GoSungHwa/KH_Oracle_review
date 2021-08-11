--9.오늘 날짜에 대한 정보 조회 -- 9
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:mi:ss') FROM dual;

--10. EMP 테이블에서 사번, 사원명, 급여 조회 
--단 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬 (안되네요)
SELECT empno,ename,TRUNC(sal,-1) FROM emp
ORDER BY sal DESC;

--11.EMP 테이블에서 사원번호가 홀수인 사원들을 조회
SELECT empno,ename FROM emp
WHERE MOD(empno,2)<>0;

--12.EMP테이블에서 사원명, 입사일 조회
--단, 입사일은 년도와 월을 분리 추출해서 출력 

--13.EMP테이블에서 9월에 입사한 직원의 정보 조회
SELECT * FROM emp
WHERE 