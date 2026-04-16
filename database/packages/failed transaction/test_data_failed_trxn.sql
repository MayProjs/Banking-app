BEGIN
    pkg_failed_txn_logger.log_failed_transaction(
        p_from_account => 1009,
        p_to_account   => 1001,
        p_amount       => 500,
        p_txn_type     => 'WITHDRAW',
        p_channel      => 'ATM',
        p_error_msg    => 'Test failure'
    );
END;
/

SHOW ERRORS PACKAGE BODY PKG_FAILED_TXN_LOGGER;

SELECT object_name, status
FROM user_objects
WHERE object_name = 'PKG_FAILED_TXN_LOGGER';

SELECT * FROM user_errors 
WHERE name = 'PKG_FAILED_TXN_LOGGER';

ALTER TABLE transactions DROP CONSTRAINT SYS_C008243;

ALTER TABLE transactions ADD CONSTRAINT chk_txn_type
CHECK (transaction_type IN (
    'DEPOSIT',
    'WITHDRAW',
    'TRANSFER',
    'UPI',
    'CARD',
    'EMI',
    'UNKNOWN'  
));


DESC transactions;

ALTER TABLE transactions ADD CONSTRAINT chk_txn_chnl
CHECK (transaction_channel IN (
    'NET_BANKING',
    'UPI',
    'ATM',
    'UNKNOWN'  
));


SELECT uc.constraint_name, ucc.column_name
FROM user_constraints uc
JOIN user_cons_columns ucc
ON uc.constraint_name = ucc.constraint_name
WHERE uc.table_name = 'TRANSACTIONS'
AND uc.constraint_type = 'C';

SELECT * FROM accounts WHERE account_id = 1009;

