-- Insert Branch
INSERT INTO branches (
    branch_id, branch_name, city, state, ifsc_code
)
VALUES (
    seq_branch.NEXTVAL,
    'Mumbai Main Branch',
    'Mumbai',
    'Maharashtra',
    'MAYB0001234'
);

--INSERT INTO branches (branch_id, branch_name, city, state, ifsc_code)
--VALUES (seq_branch.NEXTVAL, 'Mumbai Main Branch', 'Mumbai', 'Maharashtra', 'MAYB0001234');

INSERT INTO branches (branch_id, branch_name, city, state, ifsc_code)
VALUES (seq_branch.NEXTVAL, 'Andheri Branch', 'Mumbai', 'Maharashtra', 'MAYB0001235');

INSERT INTO branches (branch_id, branch_name, city, state, ifsc_code)
VALUES (seq_branch.NEXTVAL, 'Pune Central Branch', 'Pune', 'Maharashtra', 'MAYB0002234');

INSERT INTO branches (branch_id, branch_name, city, state, ifsc_code)
VALUES (seq_branch.NEXTVAL, 'Bangalore Tech Branch', 'Bangalore', 'Karnataka', 'MAYB0003234');

INSERT INTO branches (branch_id, branch_name, city, state, ifsc_code)
VALUES (seq_branch.NEXTVAL, 'Delhi Main Branch', 'Delhi', 'Delhi', 'MAYB0004234');

INSERT INTO branches (branch_id, branch_name, city, state, ifsc_code)
VALUES (seq_branch.NEXTVAL, 'Chennai South Branch', 'Chennai', 'Tamil Nadu', 'MAYB0005234');

INSERT INTO branches (branch_id, branch_name, city, state, ifsc_code)
VALUES (seq_branch.NEXTVAL, 'Hyderabad Central', 'Hyderabad', 'Telangana', 'MAYB0006234');

-- Insert Account
INSERT INTO accounts (
    account_id,
    customer_id,
    branch_id,
    account_type,
    balance
)
VALUES (
    seq_account.NEXTVAL,
    1,
    1,
    'SAVINGS',
    50000
);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance)
VALUES (seq_account.NEXTVAL, 2, 1, 'CURRENT', 75000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 3, 2, 'SALARY', 30000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 4, 2, 'SAVINGS', 12000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 5, 3, 'SAVINGS', 45000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 6, 3, 'CURRENT', 150000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 7, 4, 'SAVINGS', 8000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 8, 5, 'SALARY', 25000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 9, 6, 'SAVINGS', 92000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 10, 7, 'CURRENT', 110000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 11, 8, 'SAVINGS', 6000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 12, 9, 'SAVINGS', 15000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 13, 10, 'CURRENT', 200000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 14, 11, 'SALARY', 35000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 15, 12, 'SAVINGS', 18000);

INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance) VALUES (seq_account.NEXTVAL, 1, 2, 'CURRENT', 500000); -- multiple account for same user 🔥
commit;
---------------------------------------------------
SELECT * FROM customers;
SELECT * FROM branches;
SELECT * FROM accounts;