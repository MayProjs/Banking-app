DECLARE
    v_txn_id NUMBER;
BEGIN
    pkg_transaction_service.transfer_money(
        1001,
        1001,
        5000,
        'NET_BANKING',
        v_txn_id
    );
    
    DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_txn_id);
END;
/

BEGIN
    pkg_transaction_service.deposit_money(1000, 2000, 'ATMs');
END;
/

BEGIN
    pkg_transaction_service.withdraw_money(1000, 50000000, 'ATMs');
END;
/


SELECT * FROM error_logs ORDER BY created_at DESC;