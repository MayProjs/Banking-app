CREATE OR REPLACE PROCEDURE TRANSFER_MONEY 
(
    p_from_account IN NUMBER ,
    p_to_account IN NUMBER  ,
    p_amount IN NUMBER 
) 
IS
   v_from_balance NUMBER;
   v_to_balance NUMBER;
   v_from_status VARCHAR2(20);
   v_to_status VARCHAR2(20);
   
   v_txn_id NUMBER;
   
BEGIN
    --  Prevent same account transfer
    IF p_from_account = p_to_account 
    THEN
        raise_application_error(-20001,'Cannot transfer to same account');
    END IF;
    
    -- Locking sender account with FOR UPDATE
    SELECT balance, status
    INTO v_from_balance, v_to_status
    FROM accounts
    WHERE account_id = p_from_account
    FOR UPDATE;
    
    -- Locking receivers account with FOR UPDATE
    SELECT balance, status
    INTO v_to_balance, v_to_status
    FROM accounts
    WHERE account_id = p_to_account
    FOR UPDATE;
    
    -- Validate account status
    IF v_from_status <> 'ACTIVE' OR v_to_status <> 'ACTIVE' THEN
        raise_application_error(-20002, 'Account is not active');
    END IF;
    
    --Validate sufficient balance
    IF v_from_balance < p_amount 
    THEN
        raise_application_error(-20003, 'Insufficient balance');
    END IF;
    
    -- deduct the balance from sender
    UPDATE accounts
    SET balance = balance - p_amount
    WHERE account_id = p_from_account;
    
    -- add balance to receiver
     UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_to_account;
    
    -- Generate the transaction_id
    SELECT seq_transaction.NEXTVAL INTO v_txn_id FROM dual;
    
    --Inset transaction record
    INSERT INTO transactions(
        transaction_id,
        from_account,
        to_account,
        amount,
        transaction_type,
        transaction_channel,
        status,
        remarks
    )VALUES (
        v_txn_id,
        p_from_account,
        p_to_account,
        p_amount,
        'TRANSFER',
        'NET_BANKING',
        'SUCCESS',
        'Transfer completed'
    );
    
    --commit te transaction
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transfer successful. Transaction ID: ' || v_txn_id);
    
EXCEPTION
    WHEN NO_DATA_FOUND 
    THEN
        ROLLBACK;
        raise_application_error(-20004, 'Account does not exist');
    
    WHEN OTHERS 
    THEN    
        ROLLBACK;
        raise_application_error(-20005, 'Transaction failed: ' || SQLERRM);
  
END TRANSFER_MONEY;
/