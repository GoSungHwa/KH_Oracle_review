create table  dept04 as select *from dept03;  
--as select으로 기존 테이블을 가져와 생성
select * from dept04;

create table emp07 as select *from emp;
select *from emp07;

create table emp08 as select empno,ename from emp where deptno in(10,30);
select *from emp08 where 1=0; --where로 선별할게 없어 구조만 확인 가능

create table emp09 as select *from emp where 1=0;
select *from emp09;

create table emp_hire as select empno,ename,hiredate from emp where 1=0;
create table emp_sal as select empno,ename,sal from emp where 1=0;

insert all
when hiredate>'1982/01/01'   --고용일이 '2010/01/01' 이후 사원
then into emp_hire values(empno,ename,hiredate)
when sal>=2000  --급여가 2000이상인 사원
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

--merge : 조건에 따라서 삽입, 갱신, 삭제 후 갱신 작업을 한번에 할 수 있는 구문
CREATE TABLE emp_merge_ex
AS SELECT empno, ename, sal, deptno FROM emp WHERE deptno IN (10, 20);
select *from emp_merge_ex;

--emp 테이블의 부서번호가 20, 30인 사원들을 이용해 emp_merge_ex 테이블에 이미 존재하는 사
--원일 경우 급여를 10% 인상하고, 존재하지 않으면 급여가 1000보다 큰 사원들을 등록
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
 
 --DB 객체 : TALBE, INDEX, VIEW, SEQENCE,USER, ROLE, SYNONYM
 create or replace view view_emp_dept
    as select *from emp e join dept d using(deptno);
    
create or replace force view view_test01
    as select *from empa e join dept d using(deptno);

--emp_copy 테이블 생성
CREATE TABLE emp_copy AS SELECT *FROM emp;
--view 생성
create view emp_copy_view as select empno,ename,deptno from emp_copy;
--emp_copy_view에 insert문 실행
insert into emp_copy_view values(1234,'JONATHAN',30);
--EMP_COPY_VIEW 조회
select *from emp_copy_view;
select *from emp_copy;

--ROWNUM : 오라클에서 내부적으로 부여하는 컬럼, 데이터베이스에 INSERT된 순서대로 카운팅된다.
--사용을 많이함
SELECT E.*,ROWNUM FROM emp E;
    --5에서 9까지 꺼내오고싶음 어떻게 해야할까??
SELECT * FROM (SELECT E.*,ROWNUM FROM emp E) 
WHERE ROWNUM BETWEEN 5 AND 9; --나와야되는데 왜안나오누??
--진행순서 : FORM -ON/USING -WHERE -GRUOP BY -HAVING - SELECT -ORDER BY

SELECT ROWNUM,empno,ename,sal FROM emp;
SELECT ROWNUM,empno,ename,sal FROM emp
ORDER BY sal DESC;  --ROWNUM을 미리 해줬기때문에 정렬해도 ROWNUM은 바뀌지 않는다.

--뷰와 ROWNUM을 이용해 TOP-N 구하기
CREATE OR REPLACE VIEW emp_view_sal 
AS SELECT empno,ename,NVL(sal,0) SAL FROM emp
ORDER BY sal DESC;
--조회
SELECT ROWNUM,empno,ename,sal FROM emp_view_sal;

--월급이 높은 상위 5명을 구해보자
SELECT ROWNUM,empno,ename,sal FROM emp_view_sal
WHERE ROWNUM<=5;

--인라인 뷰 TOP-N : 1회성 서브쿼리
SELECT ROWNUM,empno,ename,sal 
FROM (SELECT empno,ename,NVL(sal,0) SAL FROM emp ORDER BY sal DESC)
WHERE ROWNUM<=5;

--시퀀스(Sequence) : 테이블 내의 유일한 숫자를 자동으로 생성한느 자동 번호 발생 ex)게시판
--시퀀스 생성 및 확인
CREATE SEQUENCE seq_empno 
START WITH 1000
INCREMENT BY 1
CACHE 20;  --메모리상에서 시퀀스 값 관리
SELECT seq_empno.NEXTVAL FROM dual;

--시퀀스 사용법 (오류발생함 다시해보장)
CREATE SEQUENCE seq_deptno
START WITH 50
INCREMENT BY 10;
select *from dept03;
INSERT INTO dept03 VALUES(seq_deptno.NEXTVAL,'AB','LAA','AA');

--INSERT문에서 시퀀스 사용
INSERT INTO emp(empno,ename) VALUES(seq_empno.NEXTVAL,'TEST');
SELECT empno,ename FROM emp WHERE ename='TEST';

--시퀀스 수정 : START WITH 값 제외한 다른 설정들은 수정 가능
ALTER SEQUENCE seq_empno
INCREMENT BY 10
CACHE 40;
SELECT seq_empno.NEXTVAL FROM dual;
  