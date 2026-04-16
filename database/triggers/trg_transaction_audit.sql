CREATE OR REPLACE TRIGGER trq_transaction_audit
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO transaction_audit(
        audit_id,
        transaction_id,
        action,
        description,
        created_at
    )
    VALUES(
        seq_audit.NEXTVAL,
        :NEW.transaction_id,
        'INSERT',
        'Transaction created from account ' || :NEW.from_account || 
        ' to account ' || :NEW.to_account,
        SYSDATE
    );
END;
/