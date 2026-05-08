CREATE DATABASE upi_project;
USE upi_project;
CREATE TABLE transactions (
    transaction_id INT,
    user_id INT,
    amount FLOAT,
    transaction_type VARCHAR(50),
    device_type VARCHAR(50),
    location VARCHAR(50),
    time_of_transaction DATETIME,
    failed_attempts INT,
    is_night INT,
    new_device INT,
    transaction_velocity FLOAT,
    fraud_flag INT
);

SELECT * FROM transactions LIMIT 10;

SELECT * 
FROM transactions
WHERE amount IS NULL OR user_id IS NULL;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM transactions WHERE amount <= 0;

ALTER TABLE transactions ADD COLUMN risk_level VARCHAR(20);

UPDATE transactions
SET risk_level =
CASE
    WHEN failed_attempts >= 3 AND new_device = 1 THEN 'High'
    WHEN transaction_velocity > 15 THEN 'Medium'
    ELSE 'Low'
END;

SELECT fraud_flag, COUNT(*) FROM transactions GROUP BY fraud_flag;

SELECT location, COUNT(*) FROM transactions WHERE fraud_flag = 1 GROUP BY location;

SELECT risk_level, COUNT(*) FROM transactions GROUP BY risk_level;



