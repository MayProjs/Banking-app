INSERT INTO users (user_id, email, password, role)
VALUES (
    seq_user.NEXTVAL,
    'admin@bank.com',
    'admin123',
    'ADMIN'
);

SELECT email, password, role FROM users WHERE email = 'admin@bank.com';

UPDATE users
SET password = 'admin123'
WHERE email = 'admin@bank.com';