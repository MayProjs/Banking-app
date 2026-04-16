CREATE OR REPLACE PACKAGE pkg_failed_txn_logger AS

    PROCEDURE log_failed_transaction(
        p_from_account IN NUMBER,
        p_to_account   IN NUMBER,
        p_amount       IN NUMBER,
        p_txn_type     IN VARCHAR2,
        p_channel      IN VARCHAR2,
        p_error_msg    IN VARCHAR2
    );

END pkg_failed_txn_logger;
/


CREATE OR REPLACE PACKAGE BODY pkg_failed_txn_logger AS

    PROCEDURE log_failed_transaction(
        p_from_account IN NUMBER,
        p_to_account   IN NUMBER,
        p_amount       IN NUMBER,
        p_txn_type     IN VARCHAR2,
        p_channel      IN VARCHAR2,
        p_error_msg    IN VARCHAR2
    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;  -- Important for AUTONOMOUS TRANSACTION
        v_txn_id NUMBER;
    BEGIN
        -- Generate ID
        SELECT seq_transaction.NEXTVAL INTO v_txn_id FROM dual;

        -- Insert FAILED transaction
        INSERT INTO transactions (
            transaction_id,
            from_account,
            to_account,
            amount,
            transaction_type,
            transaction_channel,
            status,
            remarks
        )
        VALUES (
            v_txn_id,
            
            -- handling the invalidate account inputs..
            CASE 
                WHEN EXISTS (SELECT 1 FROM accounts WHERE account_id = p_from_account)
                THEN p_from_account
                ELSE NULL
            END,
            CASE 
                WHEN EXISTS (SELECT 1 FROM accounts WHERE account_id = p_to_account)
                THEN p_to_account
                ELSE NULL
            END,
            NVL(p_amount, 0),
            
            -- handling improper transaction type and channel
            CASE 
                WHEN EXISTS (
                    SELECT 1 FROM transaction_types 
                    WHERE type_code = p_txn_type
                )
                THEN p_txn_type
                ELSE 'UNKNOWN'
            END,
    
            CASE 
                WHEN EXISTS (
                    SELECT 1 FROM transaction_channels 
                    WHERE channel_code = p_channel
                )
                THEN p_channel
                ELSE 'UNKNOWN'
            END,
        
            'FAILED',
            p_error_msg
        );

        COMMIT;  --  required
    END log_failed_transaction;

END pkg_failed_txn_logger;
/
