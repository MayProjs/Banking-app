CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    
    customer_id NUMBER NOT NULL,
    branch_id NUMBER NOT NULL,
    
    account_type VARCHAR2(20)
    CHECK (account_type IN ('SAVINGS','CURRENT','SALARY')),
    
    balance NUMBER(12,2) DEFAULT 0 CHECK (balance >= 0),
    
    currency VARCHAR2(10) DEFAULT 'INR',
    
    status VARCHAR2(20) DEFAULT 'ACTIVE'
    CHECK (status IN ('ACTIVE','INACTIVE','CLOSED')),
    
    created_at DATE DEFAULT SYSDATE,
    
    CONSTRAINT fk_account_customer
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id),
    
    CONSTRAINT fk_account_branch
    FOREIGN KEY (branch_id)
    REFERENCES branches(branch_id)
);
    
    
    
 