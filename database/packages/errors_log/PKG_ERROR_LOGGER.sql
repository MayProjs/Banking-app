CREATE OR REPLACE PACKAGE PKG_ERROR_LOGGER AS 

  PROCEDURE log_error(
    p_procedure_name IN VARCHAR2,
    p_error_message IN VARCHAR2
  );

END PKG_ERROR_LOGGER;
/


CREATE OR REPLACE PACKAGE BODY PKG_ERROR_LOGGER AS 

  PROCEDURE log_error(
    p_procedure_name IN VARCHAR2,
    p_error_message IN VARCHAR2
  )
  IS
    PRAGMA AUTONOMOUS_TRANSACTION;  -- important for commiting rollbacked logs from transfer package 
  BEGIN
        INSERT INTO error_logs(
            error_id,
            procedure_name,
            error_message,
            error_stack,
            created_at
        )
        VALUES(
            seq_error.NEXTVAL,
            p_procedure_name,
            p_error_message,
            DBMS_UTILITY.FORMAT_ERROR_BACKTRACE(),  -- backtrace of the error logs
            SYSDATE
        );
        COMMIT; 
  END log_error;

END PKG_ERROR_LOGGER;
/
