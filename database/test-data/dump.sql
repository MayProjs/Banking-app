SELECT line, position, text
FROM user_errors
WHERE name = 'PKG_TRANSACTION_SERVICE'
ORDER BY line;