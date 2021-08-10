--DUAL 테이블명이 DUAL 
--SCOTT의 테이블이 아니지만 SYSTEM이 누구라도 쓸 수 있게 공개해 둔 테이블
--임시 사용할 테이블 필요할 때 사용
SELECT 35*12 FROM dual;
--5 % 4 ,나누기 함수MOD()
SELECT MOD(5,4) FROM dual;
--절대값
SELECT -10,ABS(-10) FROM dual;
--반올림을 한 결과
SELECT 12.3456, ROUND(12.3456),ROUND(12.3456,2),ROUND(12.3456,-1) 
FROM dual;
--버림을 한 결과
SELECT 12.3456,TRUNC(12.3456,2),TRUNC(12.3456,-1),TRUNC(12.3456,0) FROM dual;
--실수 기준 가장 근접한 큰값의 정수
SELECT CEIL(12.3456) FROM dual;
--실수 기준 가장 근접한 작은 정수
SELECT FLOOR(12.3456) FROM dual;
--제곱
SELECT POWER(3,4) FROM dual;
--대문자
SELECT UPPER('sam') FROM dual;
--소문자
SELECT LOWER('ORACLE') FROM dual;
--앞글자만 대문자
SELECT INITCAP('kim mal ddong') FROM dual;
--길이 반환 LENGTH -길이반환(문자단위), LENGTHB-바이트 반환
SELECT LENGTH('test11'),LENGTHB('test11') FROM dual;
SELECT '홍길동', LENGTH('홍길동'), LENGTHB('홍길동') FROM dual;
--검색된 값의 위치 반환
SELECT INSTR('ORACLE WELCOME','O',2,1) FROM dual;
--시작위치부터 선택 개수만큼 문자를 반환
SELECT SUBSTR('오라클 데이터베이스',3,5) FROM dual;
--시작위치부터 세번째 인자인 선택바이트수만큼 반복
SELECT SUBSTRB('오라클 데이터베이스',3) FROM dual;
--공간 칸수를 지정하고 빈칸만틈 특정문자로 채움(10칸)
SELECT LPAD('ORACLE',10,'+') FROM dual;
SELECT RPAD('ORACLE',10,'+') FROM dual;
--왼쪽/오른쪽 공백문자를 제거
SELECT 'ORACLE', LTRIM('   ORACLE  '),RTRIM('   ORACLE   ') FROM dual;

--현재 날짜 시간(인코딩에 시간이 없어서 시간이 안뜨는것일뿐)
SELECT SYSDATE FROM dual;
--시간까지
SELECT TO_CHAR(SYSDATE,'YYYY-MONTH-DD HH24:SS') FROM dual;
--숫자->문자 변환
SELECT TO_CHAR(sal,'$9,999') FROM emp;

--문자->날짜 변환
SELECT TO_DATE('2121-08-08 13:24','YYYY-MM-DD HH24:MI') FROM dual;
SELECT TO_DATE('09-08 13','MM-DD HH24') FROM dual;

--NVL2 : NULL인 경우를 판단하지만 NULL인지 아닌지에 따른 결과가 다르다
SELECT empno,ename,NVL2(comm,sal+comm,sal) pay,sal,comm FROM emp;

--DECODE : 조건에 해당하는 값을 추출할 때 사용,CASE~END로 사용해도됨
SELECT empno,ename,deptno,DECODE(deptno,10,'회게팀',20,'개발팀',30,'영업팀',40,'운영팀')deptname FROM emp;

-- CASE WHEN THEN ELSE END
SELECT empno, ename, 
   CASE
    WHEN deptno=10 THEN '회계팀'
    WHEN deptno=20 THEN '개발팀'
    WHEN deptno=30 THEN '영업팀'
    WHEN deptno=40 THEN '운영팀'
    ELSE '뭔팀?'
  END deptname
FROM emp;

--COUNT : 컬럼의 행 개수
SELECT COUNT(*) FROM emp;
SELECT COUNT(sal) FROM emp; -- 중복데이터 값이 있어도 행 개수로 친다.
SELECT COUNT(comm) FROM emp; -- NULL값은 행 개수로 안친다.

--부서별로 사원이 몇명인지 알려줘. 부서번호랑 사원수 표시해줘
SELECT deptno, COUNT(deptno) ||'명' 사원수 FROM emp
GROUP BY deptno;

--부서별로 사원이 몇명인지 알려줘. 부서번호랑 사원수 표시해줘
--JOB이 MANAGE인 사람 제외하고 진짜 사원들 수만 표시해줘.
SELECT deptno, COUNT(deptno) ||'명' 사원수 FROM emp
WHERE job <>'MANAGER'
GROUP BY deptno
ORDER BY deptno;

--JOIN(조인) 등가조인
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

--비등가 조인 : 동일 컬럼이 없이 다른 조건을 사용하여 조인할 때 사용
SELECT e.ename,e.sal,s.grade FROM emp e,salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

SELECT e.ename,e.sal,s.grade FROM emp e JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal;

--SELF-JOIN :하나의 테이블에서 자신의 테이블과 조인이 발생하는 것
--             하나의 테이블에서 두 개의 테이블인 것처럼 조인
SELECT e.ename,m.ename "Manager" FROM emp e,emp m
WHERE e.empno=m.mgr;

SELECT e.ename, m.ename "Manager" 
FROM emp e JOIN emp m
ON e.mgr = m.emptno; 

--outer join
SELECT e.ename, m.ename "Manager" 
FROM emp e LEFT OUTER JOIN emp m
ON e.mgr = m.empno; 

--사원명,SALGRADE 등급이랑 표시해줘
SELECT e.ename,s.grade FROM emp e JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal;

SELECT * FROM emp e JOIN salgrade s
ON e.sal>=s.losal AND e.sal<=s.hisal;

--GRADE 별 평균급여를 나타내주세요.GRADE 역순서로
select s.grade,floor(AVG(e.sal))평균급여 from emp e JOIN salgrade s
on e.sal between s.losal and s.hisal
group by s.grade
order by s.grade DESC;

--<select 문법?>
--select [distinct] (*,컬럼명1,컬럼명2, 계산식 별칭,함수 별칭)
--from 테이블명1 별칭 [INNER/LEFT/RIGHT/OUTER JOIN 테이블명2 별칭]
--ON/USING 조인조건
--where 조건문-그룹핑전레코드선별
--group by 컬럼명1[,컬럼명2...]
--having 조건문-그룹핑후최종레코드선별
--order by 컬럼명 정렬;

---수행순서- 
--FROM -> ON/USING -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY 








