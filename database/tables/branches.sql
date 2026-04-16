CREATE TABLE branches (
    branch_id NUMBER PRIMARY KEY,
    
    branch_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(50) NOT NULL,
    state VARCHAR2(50),
    
    ifsc_code VARCHAR2(20) UNIQUE NOT NULL,
    
    created_at DATE DEFAULT SYSDATE
);