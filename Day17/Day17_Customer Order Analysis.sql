create database Customers_db;
use Customers_db;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_status VARCHAR(20)
);
INSERT INTO customers VALUES
(1, 'Amit', 'Bangalore'),
(2, 'Sneha', 'Mumbai'),
(3, 'Rahul', 'Delhi'),
(4, 'Priya', 'Chennai'),
(5, 'Kiran', 'Hyderabad'),
(6, 'Neha', 'Pune'),
(7, 'Arjun', 'Kolkata');

INSERT INTO orders VALUES
(101, 1, '2024-01-10', 500),
(102, 1, '2024-02-15', 700),
(103, 2, '2024-03-01', 300),
(104, 3, '2024-03-05', 900),
(105, 5, '2024-03-10', 1200),
(106, 5, '2024-03-15', 400),
(107, 6, '2024-03-20', 650),
(108, 10, '2024-03-25', 800);  -- Invalid customer


INSERT INTO payments VALUES
(1, 101, 'Completed'),
(2, 102, 'Pending'),
(3, 103, 'Completed'),
(4, 104, 'Completed'),
(5, 105, 'Pending'),
(6, 106, 'Completed');
-- Note: Orders 107 and 108 have NO payments

select * from customers;
select * from orders;
select * from Payments;

SELECT c.customer_name, o.order_id, o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

select c.customer_name, o.order_id
from customers c
left join orders o
on c.customer_id = o.customer_id;

SELECT o.*
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT c.customer_name, o.order_id, p.payment_status
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN payments p
ON o.order_id = p.order_id;

SELECT c.*
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT o.*
FROM orders o
LEFT JOIN payments p
ON o.order_id = p.order_id
WHERE p.order_id IS NULL;


SELECT c.customer_name, SUM(o.amount) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

SELECT c.customer_name
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_name
HAVING COUNT(*) = SUM(CASE WHEN p.payment_status = 'Completed' THEN 1 ELSE 0 END);

SELECT c.customer_name, MAX(o.amount) AS highest_order
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

SELECT c.customer_name, SUM(o.amount) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 2;


