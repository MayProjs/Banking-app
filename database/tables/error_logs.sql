--------------------------------------------------------
--  File created - Thursday-March-19-2026   
--------------------------------------------------------

CREATE TABLE error_logs (
    error_id NUMBER PRIMARY KEY,
    procedure_name VARCHAR2(100),
    error_message VARCHAR2(4000),
    error_stack VARCHAR2(4000),
    created_at DATE DEFAULT SYSDATE
);


CREATE SEQUENCE seq_error
START WITH 1
INCREMENT BY 1;
--------------------------------------------------------
--  DDL for Table ERROR_LOGS
--------------------------------------------------------

  CREATE TABLE "BANK_ADMIN"."ERROR_LOGS" 
   (	"ERROR_ID" NUMBER, 
	"PROCEDURE_NAME" VARCHAR2(100 BYTE), 
	"ERROR_MESSAGE" VARCHAR2(4000 BYTE), 
	"ERROR_STACK" VARCHAR2(4000 BYTE), 
	"CREATED_AT" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index ERROR_LOGS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BANK_ADMIN"."ERROR_LOGS_PK" ON "BANK_ADMIN"."ERROR_LOGS" ("ERROR_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table ERROR_LOGS
--------------------------------------------------------

  ALTER TABLE "BANK_ADMIN"."ERROR_LOGS" MODIFY ("ERROR_ID" NOT NULL ENABLE);
  ALTER TABLE "BANK_ADMIN"."ERROR_LOGS" ADD CONSTRAINT "ERROR_LOGS_PK" PRIMARY KEY ("ERROR_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE;
