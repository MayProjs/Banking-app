/*
Create dummy schema with system user.
👉 Switch from SID → Service Name

Fill this:

Service Name: XEPDB1

So your connection becomes:

Hostname: localhost
Port: 1521
Service Name: XEPDB1
Username: system
Password: <your password>
*/

-- create a user then create a schema
/*
 with the credentials 
        Username: BANK_ADMIN
        Password: bank123
*/
CREATE USER BANK_ADMIN IDENTIFIED BY bank123;

GRANT CONNECT, RESOURCE TO BANK_ADMIN;

ALTER USER BANK_ADMIN QUOTA UNLIMITED ON USERS;

/*
create a schema with 
Username: BANK_ADMIN
Password: bank123
Service Name: XEPDB1
Role: default
*/


SELECT username, account_status 
FROM dba_users 
WHERE username = 'BANK_ADMIN';

SHOW CON_NAME;

-- you can drop the user 
DROP USER BANK_ADMIN CASCADE;

