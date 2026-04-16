CREATE OR REPLACE PACKAGE pkg_transaction_service AS 
    
    PROCEDURE transfer_money(
    p_from_account IN NUMBER,
    p_to_account   IN NUMBER,
    p_amount       IN NUMBER,
    p_channel      IN VARCHAR2,
    p_txn_id       OUT NUMBER
    );
    
     PROCEDURE deposit_money(
        p_account_id IN NUMBER,
        p_amount     IN NUMBER,
        p_channel    IN VARCHAR2,
        p_txn_id     OUT NUMBER
    );

    PROCEDURE withdraw_money(
        p_account_id IN NUMBER,
        p_amount     IN NUMBER,
        p_channel    IN VARCHAR2,
        p_txn_id     OUT NUMBER
    );
     
END pkg_transaction_service;
/


CREATE OR REPLACE PACKAGE BODY PKG_TRANSACTION_SERVICE AS 

---------------------------------------------------------
    -- TRANSFER MODULE
---------------------------------------------------------

    PROCEDURE transfer_money(
    p_from_account IN NUMBER,
    p_to_account   IN NUMBER,
    p_amount       IN NUMBER,
    p_channel      IN VARCHAR2,
    p_txn_id       OUT NUMBER
    )
    IS
        v_from_balance NUMBER;
        v_to_balance NUMBER;
        v_from_status VARCHAR2(20);
        v_to_status VARCHAR2(20);
        v_txn_channel NUMBER;
        v_txn_id NUMBER;
        
   BEGIN
        -- Prevent same account transfer
        IF p_from_account = p_to_account THEN
            raise_application_error(-20001,'Cannot transfer to same account');
        END IF;

        -- Validate transaction type
--        BEGIN
--            SELECT 1 INTO v_txn_type
--            FROM transaction_types
--            WHERE type_code = p_txn_type;
--        EXCEPTION
--            WHEN NO_DATA_FOUND THEN
--                raise_application_error(-20008, 'Invalid transaction type');
--        END;

        -- Validate channel
        BEGIN
            SELECT 1 INTO v_txn_channel
            FROM transaction_channels
            WHERE channel_code = p_channel;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20007, 'Invalid transaction channel');
        END;

        -- Lock sender account
        BEGIN
            SELECT balance, status
            INTO v_from_balance, v_from_status
            FROM accounts
            WHERE account_id = p_from_account
            FOR UPDATE;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20005, 'Sender account not found');
        END;
        
        -- Lock receiver account
        BEGIN
            SELECT balance, status
            INTO v_to_balance, v_to_status
            FROM accounts
            WHERE account_id = p_to_account
            FOR UPDATE;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20006, 'Receiver account not found');
        END;
        
         -- Validate account status
        IF v_from_status <> 'ACTIVE' OR v_to_status <> 'ACTIVE' THEN
            raise_application_error(-20002, 'Account is not active');
        END IF;

        -- Validate sufficient balance
        IF v_from_balance < p_amount THEN
            raise_application_error(-20003, 'Insufficient balance');
        END IF;

        -- Deduct from sender
        UPDATE accounts
        SET balance = balance - p_amount
        WHERE account_id = p_from_account;

        -- Add to receiver
        UPDATE accounts
        SET balance = balance + p_amount
        WHERE account_id = p_to_account;

        -- Generate transaction ID
        SELECT seq_transaction.NEXTVAL INTO v_txn_id FROM dual;
        p_txn_id := v_txn_id;
        
        -- Insert transaction
        INSERT INTO transactions (
            transaction_id,
            from_account,
            to_account,
            amount,
            transaction_type,
            transaction_channel,
            status,
            remarks
        ) VALUES (
            v_txn_id,
            p_from_account,
            p_to_account,
            p_amount,
            'TRANSFER',
            p_channel,
            'SUCCESS',
            'Transfer completed'
        );

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Transfer successful. Transaction ID: ' || v_txn_id);
        
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            ROLLBACK;
            
            pkg_error_logger.log_error(
                'transfer_money',
                'Data not found'
            );
            
            raise_application_error(-20008, 'Required data not found');

        WHEN OTHERS THEN
            --  Log FAILED transaction (business log)
            pkg_failed_txn_logger.log_failed_transaction(
                p_from_account,
                p_to_account,
                p_amount,
                'TRANSFER',
                p_channel,
                SQLERRM
            );
        
            -- Log technical error
            pkg_error_logger.log_error(
                'transfer_money',
                SQLERRM
            );
        
            ROLLBACK;
        
            raise_application_error(
                -20099,
                'Transaction failed: ' || SQLERRM
            );
    END transfer_money;
    
--------------------------------------------------
    --Deposit Money Module
--------------------------------------------------

    PROCEDURE deposit_money(
        p_account_id IN NUMBER,
        p_amount     IN NUMBER,
        p_channel    IN VARCHAR2,
        p_txn_id     OUT NUMBER
    )
    IS
        v_balance NUMBER;
        v_status  VARCHAR2(20);
        v_txn_id  NUMBER;
        v_dummy   NUMBER;
    BEGIN
        
        -- Validate channel
        BEGIN
            SELECT 1 INTO v_dummy
            FROM transaction_channels
            WHERE channel_code = p_channel;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20007, 'Invalid transaction channel');
        END;

        -- Fetch account
        BEGIN
            SELECT balance, status
            INTO v_balance, v_status
            FROM accounts
            WHERE account_id = p_account_id
            FOR UPDATE;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20004, 'Account not found');
        END;
    
        -- Validate status
        IF v_status <> 'ACTIVE' THEN
            raise_application_error(-20002, 'Account is not active');
        END IF;

        
        -- Deposit
        UPDATE accounts
        SET balance = balance + p_amount
        WHERE account_id = p_account_id;
    
        
        -- Transaction entry
        SELECT seq_transaction.NEXTVAL INTO v_txn_id FROM dual;
        p_txn_id := v_txn_id;
        
    
        INSERT INTO transactions (
            transaction_id,
            from_account,
            to_account,
            amount,
            transaction_type,
            transaction_channel,
            status,
            remarks
        ) VALUES (
            v_txn_id,
            NULL,
            p_account_id,
            p_amount,
            'DEPOSIT',
            p_channel,
            'SUCCESS',
            'Deposit completed'
        );
    
        COMMIT;
    
    EXCEPTION
         WHEN OTHERS THEN
            --  Log FAILED transaction (business log)
            pkg_failed_txn_logger.log_failed_transaction(
                NULL,              -- no sender
                p_account_id,      -- receiver
                p_amount,
                'DEPOSIT',         -- type
                p_channel,
                SQLERRM
            );
        
            -- Log technical error
            pkg_error_logger.log_error(
                'deposit_money',
                SQLERRM
            );
        
            ROLLBACK;
        
            raise_application_error(
                -20099,
                'Transaction failed: ' || SQLERRM
            );
    END;
    
--------------------------------------------------------
    -- Withdraw Money Module
--------------------------------------------------------

    PROCEDURE withdraw_money(
        p_account_id IN NUMBER,
        p_amount     IN NUMBER,
        p_channel    IN VARCHAR2,
        p_txn_id     OUT NUMBER
    )
    IS
        v_balance NUMBER;
        v_status  VARCHAR2(20);
        v_txn_id  NUMBER;
        v_dummy   NUMBER;
    BEGIN
        
        -- Validate channel
        BEGIN
            SELECT 1 INTO v_dummy
            FROM transaction_channels
            WHERE channel_code = p_channel;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20007, 'Invalid transaction channel');
        END;
    
       
        -- Fetch account
        BEGIN
            SELECT balance, status
            INTO v_balance, v_status
            FROM accounts
            WHERE account_id = p_account_id
            FOR UPDATE;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20004, 'Account not found');
        END;
    
        
        -- Validate status
        IF v_status <> 'ACTIVE' THEN
            raise_application_error(-20002, 'Account is not active');
        END IF;
    
        
        -- Validate balance
        IF v_balance < p_amount THEN
            raise_application_error(-20003, 'Insufficient balance');
        END IF;
    
        
        -- Withdraw
        UPDATE accounts
        SET balance = balance - p_amount
        WHERE account_id = p_account_id;
    
        
        -- Transaction entry
        SELECT seq_transaction.NEXTVAL INTO v_txn_id FROM dual;
        p_txn_id := v_txn_id;
    
        INSERT INTO transactions (
            transaction_id,
            from_account,
            to_account,
            amount,
            transaction_type,
            transaction_channel,
            status,
            remarks
        ) VALUES (
            v_txn_id,
            p_account_id,
            NULL,
            p_amount,
            'WITHDRAW',
            p_channel,
            'SUCCESS',
            'Withdrawal completed'
        );
    
        COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            --  Log FAILED transaction (business log)
           pkg_failed_txn_logger.log_failed_transaction(
                p_account_id,      -- sender
                NULL,              -- no receiver
                p_amount,
                'WITHDRAW',        -- type
                p_channel,
                SQLERRM
            );
        
            -- Log technical error
            pkg_error_logger.log_error(
                'withdraw_money',
                SQLERRM
            );
        
            ROLLBACK;
        
            raise_application_error(
                -20099,
                'Transaction failed: ' || SQLERRM
            );
    END;

END PKG_TRANSACTION_SERVICE;
/
