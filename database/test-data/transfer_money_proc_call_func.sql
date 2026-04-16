BEGIN
    transfer_money(1000, 1001, 55, );
END;
/


select * from accounts;
select * from transactions;
where TRANSACTION_ID = 6;
select * from transaction_audit;

SELECT object_name, status
FROM user_objects
WHERE object_type = 'PROCEDURE';