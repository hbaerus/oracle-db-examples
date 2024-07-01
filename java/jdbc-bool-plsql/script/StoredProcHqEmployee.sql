CREATE USER JDBCSP_USER IDENTIFIED BY <JDBCSP_USER_PASSWORD>;
GRANT DB_DEVELOPER_ROLE TO JDBCSP_USER;
GRANT CREATE SESSION TO JDBCSP_USER;
GRANT UNLIMITED TABLESPACE TO JDBCSP_USER;

CREATE TABLE HQ_EMPLOYEE
(
  "EMP_ID"   NUMBER NOT NULL ENABLE,
  "NAME"    VARCHAR2(20 BYTE) DEFAULT NULL,
  "ROLE"    VARCHAR2(20 BYTE) DEFAULT NULL,
  "ACTIVE" BOOLEAN,
  PRIMARY KEY ("EMP_ID")
);
COMMIT;

CREATE OR REPLACE PROCEDURE INSERT_HQ_EMPLOYEE_PRC
(
 in_emp_id IN HQ_EMPLOYEE.EMP_ID%TYPE,
 in_name IN HQ_EMPLOYEE.NAME%TYPE,
 in_role IN HQ_EMPLOYEE.ROLE%TYPE,
 in_active IN HQ_EMPLOYEE.ACTIVE%TYPE, 
 out_result OUT VARCHAR2)
AS
BEGIN
  INSERT INTO HQ_EMPLOYEE (EMP_ID, NAME, ROLE, ACTIVE) 
  VALUES (in_emp_id, in_name, in_role, in_active);
  COMMIT;
  
  out_result := 'TRUE';
 
EXCEPTION
  WHEN OTHERS THEN 
  out_result := 'FALSE';
  ROLLBACK;
END;

GRANT EXECUTE ON INSERT_HQ_EMPLOYEE_PRC TO JDBCSP_USER;

--- SELECT * FROM HQ_EMPLOYEE;