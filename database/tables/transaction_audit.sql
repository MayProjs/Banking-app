CREATE TABLE transaction_audit (
    audit_id NUMBER PRIMARY KEY,
    transaction_id NUMBER,
    action VARCHAR2(50),
    description VARCHAR2(200),
    created_at DATE DEFAULT SYSDATE
);