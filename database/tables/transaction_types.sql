CREATE TABLE transaction_types (
    type_code VARCHAR2(30) PRIMARY KEY
);

INSERT INTO transaction_types VALUES ('TRANSFER');
INSERT INTO transaction_types VALUES ('DEPOSIT');
INSERT INTO transaction_types VALUES ('WITHDRAW');
INSERT INTO transaction_types VALUES ('UPI');
INSERT INTO transaction_types VALUES ('UNKNOWN');