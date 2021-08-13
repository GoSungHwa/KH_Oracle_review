---- PL/SQL -----
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO');
END;
/
--�� ����� ���ν���
DECLARE --���� ����
    EMP_ID  NUMBER;
    EMP_NAME    VARCHAR2(30);
BEGIN
    EMP_ID := 888; -- := ����,= ������ ��
    EMP_NAME:='���峲';
    
    DBMS_OUTPUT.PUT_LINE('���̵�:' ||EMP_ID);
    DBMS_OUTPUT.PUT_LINE(EMP_NAME);
END;
/

DECLARE
EMP_ID EMP.EMPNO%TYPE;
EMP_NAME EMP.ENAME%TYPE;
BEGIN
SELECT EMPNO, ENAME
INTO EMP_ID, EMP_NAME
FROM EMP
WHERE EMPNO = '&EMP_ID';
DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

DECLARE
    E   EMP%ROWTYPE; --����� Ÿ���� �ϳ��� ��Ƽ� ��밡��
BEGIN
SELECT *
INTO E
FROM EMP
WHERE EMPNO='&EMP_ID';
DBMS_OUTPUT.PUT_LINE('EMP NO : ' || E.EMPNO);
DBMS_OUTPUT.PUT_LINE('EMP JOB : ' || EMP.JOB);
END;
/
CREATE OR REPLACE PROCEDURE PROC_FIND_EMP_INFO
IS    -->DECLARE ��� ���ְ� �ؿ��� �����ϰ� ���.
--DECLARE  
    EMP_ID EMP.EMPNO%TYPE;
    EMP_NAME EMP.ENAME%TYPE;
    SALARY EMP.SAL%TYPE;
    BONUS EMP.COMM%TYPE;
BEGIN
    SELECT EMPNO,ENAME,SAL,NVL(COMM,0)
    INTO EMP_ID,EMP_NAME,SALARY,BONUS
    FROM EMP
    WHERE EMPNO = '&EMPNO';
    
    IF(BONUS=0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�');
    ELSIF(BONUS=300)
        THEN DBMS_OUTPUT.PUT_LINE('�Ϳ� ���ʽ� 300�޴� ����Դϴ�');
    ELSE
         DBMS_OUTPUT.PUT_LINE('���ʽ���:'||BONUS *100 || '%');
        END IF;
        FOR N IN REVERSE 10..13 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN  DBMS_OUTPUT.PUT_LINE('����� ã�� ���߾��');
END;
/

--��ü PROCEDUER, FUNCTION : �ڵ带 ã�Ƽ� �����ϴ� �������� ���δ�. ȣ���ؼ� ���.
--TRIGGER,CURSOR,PACKGAE


--�Ƹ���,,,,
CREATE OR REPLACE PROCEDURE PROC_FIND_EMP_WITH_VAR
    (VENO IN EMP.EMPNO%TYPE,      --�Ű�����
     VENAME OUT EMP.ENAME%TYPE,
     VSAL OUT EMP.SAL%TYPE,
     VCOMM OUT EMP.COMM%TYPE,
     MSG OUT VARCHAR2)
IS
BEGIN
    SELECT EMPNO,ENAME,SAL,NVL(COMM,0)
    INTO VENO,VENAME,VSAL,COMM
    FROM EMP
    WHERE EMPNO = VENO;
    
    IF(VCOMM=0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�');
         MSG:='���ʽ��� ���޹����ʴ� ����Դϴ�'; 
    ELSIF(VCOMM=300)
        THEN DBMS_OUTPUT.PUT_LINE('�Ϳ� ���ʽ� 300�޴� ����Դϴ�');
        MSG:='���ʽ��� 300 ����Դϴ�';    
    ELSE
         DBMS_OUTPUT.PUT_LINE('���ʽ���:'||BONUS *100 || '%');
         MSG:='����������������';
        END IF;
        
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN  DBMS_OUTPUT.PUT_LINE('����� ã�� ���߾��');
END;
/
SET AUTOPRINT ON;
VARIABLE VAR_ENAME VARCHAR2(10);
VARIABLE VAR_SAL NUMBER;
VARIABLE VAR_COMM NUMBER;
VARIABLE VAR_MSG VARCHAR2(150);
EXEC PROC_FIND_WITH_VAR
    (7788,
        :VAR_ENAME,
        :VAR_SAL,
        :VAR_COMM,
        :VAR_MSG    );
PRINT VAR_ENAME;
PRINT VAR_SAL;
PRINT VAR_COMM;
PRINT VAR_MSG;


