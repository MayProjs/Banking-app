INSERT INTO customers (
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    date_of_birth,
    kyc_status
)
VALUES (
    seq_customer.NEXTVAL,
    'Mayuresh',
    'Saliyan',
    'may@email.com',
    '9876543210',
    DATE '1999-01-01',
    'VERIFIED'
);

UPDATE customers SET gender = 'MALE' WHERE first_name IN ('Mayuresh');

INSERT INTO customers (customer_id, first_name, last_name, email, phone, date_of_birth, kyc_status, gender)
VALUES (seq_customer.NEXTVAL, 'Alf', 'Dsouza', 'alf@email.com', '9876500001', DATE '1998-02-11', 'VERIFIED', 'MALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Aniket', 'Patil', 'aniket@email.com', '9876500002', DATE '2000-06-15', 'VERIFIED', SYSDATE, NULL, 'MALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Becca', 'Fernandes', 'becca@email.com', '9876500003', DATE '1990-08-22', 'VERIFIED', SYSDATE, NULL, 'FEMALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Anishka', 'Shetty', 'anishka@email.com', '9876500004', DATE '2003-01-05', 'VERIFIED', SYSDATE, NULL, 'FEMALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Anushka', 'Shetty', 'anushka@email.com', '9876500005', DATE '2003-01-05', 'VERIFIED', SYSDATE, NULL, 'FEMALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Deep', 'Mehta', 'deep@email.com', '9876500006', DATE '1996-04-19', 'VERIFIED', SYSDATE, NULL, 'MALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Sai', 'Kumar', 'sai@email.com', '9876500007', DATE '1995-09-09', 'VERIFIED', SYSDATE, NULL, 'MALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Angel', 'Sharma', 'angel@email.com', '9876500008', DATE '2001-03-17', 'VERIFIED', SYSDATE, NULL, 'FEMALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Anil', 'Kumar', 'anil@email.com', '9876500009', DATE '1994-12-25', 'VERIFIED', SYSDATE, NULL, 'MALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Ekjot', 'Singh', 'ekjot@email.com', '9876500010', DATE '1997-07-07', 'VERIFIED', SYSDATE, NULL, 'MALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Aparna', 'Iyer', 'aparna@email.com', '9876500011', DATE '1998-10-14', 'VERIFIED', SYSDATE, NULL, 'FEMALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Rohan', 'Naik', 'rohan@email.com', '9876500012', DATE '1996-05-21', 'PENDING', SYSDATE, NULL, 'OTHER');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Kavya', 'Reddy', 'kavya@email.com', '9876500013', DATE '2000-12-12', 'PENDING', SYSDATE, NULL, 'FEMALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Manav', 'Joshi', 'manav@email.com', '9876500014', DATE '1993-03-03', 'REJECTED', SYSDATE, NULL, 'MALE');

INSERT INTO customers VALUES (seq_customer.NEXTVAL, 'Tanya', 'Kapoor', 'tanya@email.com', '9876500015', DATE '1999-09-19', 'VERIFIED', SYSDATE, NULL, 'OTHER');

COMMIT;

SELECT * FROM CUSTOMERS;