CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50),
    
    email VARCHAR2(50) UNIQUE NOT NULL,
    phone VARCHAR2(50) UNIQUE NOT NULL,
    
    date_of_birth DATE,
    
    kyc_status VARCHAR2(20) DEFAULT 'PENDING'
    CHECK ( kyc_status IN ('PENDING','VERIFIED','REJECTED')),
    
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE
);

ALTER TABLE customers
ADD gender VARCHAR2(10)
CHECK (gender IN ('MALE','FEMALE','OTHER'));