CREATE TABLE transactions (
    transaction_id NUMBER PRIMARY KEY,
    
    from_account NUMBER,
    to_account NUMBER,
    
    amount NUMBER(12,2) NOT NULL CHECK (amount > 0),
    
    transaction_type VARCHAR2(30)
        CHECK (transaction_type IN (
            'DEPOSIT',
            'WITHDRAW',
            'TRANSFER',
            'UPI',
            'CARD',
            'EMI'
        )),
    
    transaction_channel VARCHAR2(30)
        CHECK (transaction_channel IN (
            'ATM',
            'UPI',
            'NET_BANKING',
            'CARD',
            'BRANCH'
        )),
    
    status VARCHAR2(20) DEFAULT 'SUCCESS'
        CHECK (status IN ('SUCCESS','FAILED','PENDING')),
    
    transaction_date DATE DEFAULT SYSDATE,
    
    remarks VARCHAR2(200),
    
    CONSTRAINT fk_from_account
        FOREIGN KEY (from_account)
        REFERENCES accounts(account_id),
        
    CONSTRAINT fk_to_account
        FOREIGN KEY (to_account)
        REFERENCES accounts(account_id)
);


//if you want to alter the check constrain
--Oracle does not support direct modification of CHECK constraints, 
--so we drop and recreate the constraint with updated values.

SELECT constraint_name
FROM user_constraints
WHERE table_name = 'TRANSACTIONS'
AND constraint_type = 'C';

SELECT uc.constraint_name, ucc.column_name
FROM user_constraints uc
JOIN user_cons_columns ucc
ON uc.constraint_name = ucc.constraint_name
WHERE uc.table_name = 'TRANSACTIONS'
AND uc.constraint_type = 'C';

ALTER TABLE transactions
DROP CONSTRAINT SYS_C008242;

ALTER TABLE transactions
ADD CONSTRAINT chk_transaction_type
CHECK (transaction_type IN (
    'DEPOSIT',
    'WITHDRAW',
    'TRANSFER',
    'UPI',
    'CARD',
    'EMI',
    'REFUND'   -- new value
));








CREATE TABLE transactions (
    transaction_id NUMBER PRIMARY KEY,
    
    from_account NUMBER,
    to_account NUMBER,
    
    amount NUMBER(12,2) NOT NULL CHECK (amount > 0),
    
    transaction_type VARCHAR2(30)
        CHECK (transaction_type IN (
            'DEPOSIT',
            'WITHDRAW',
            'TRANSFER',
            'UPI',
            'CARD',
            'EMI',
            'REFUND',
            'UNKNOWN'   -- ✅ added
        )),
    
    transaction_channel VARCHAR2(30)
        CHECK (transaction_channel IN (
            'ATM',
            'UPI',
            'NET_BANKING',
            'CARD',
            'BRANCH',
            'WEB',
            'UNKNOWN'   -- ✅ added
        )),
    
    status VARCHAR2(20) DEFAULT 'SUCCESS'
        CHECK (status IN ('SUCCESS','FAILED','PENDING')),
    
    transaction_date DATE DEFAULT SYSDATE,
    
    remarks VARCHAR2(200),
    
    CONSTRAINT fk_from_account
        FOREIGN KEY (from_account)
        REFERENCES accounts(account_id),
        
    CONSTRAINT fk_to_account
        FOREIGN KEY (to_account)
        REFERENCES accounts(account_id)
);