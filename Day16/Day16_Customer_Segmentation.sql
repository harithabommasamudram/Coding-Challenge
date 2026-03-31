create database customer_db;
use customer_db;
CREATE TABLE customers ( 
    customer_id INT, 
    customer_name VARCHAR(50), 
    city VARCHAR(50), 
    age INT, 
    total_spent DECIMAL(10,2), 
    number_of_orders INT 
);

INSERT INTO customers VALUES 
(1, 'Amit', 'Bangalore', 25, 12000, 5), 
(2, 'Neha', 'Mumbai', 30, 45000, 12), 
(3, 'Raj', 'Delhi', 22, 8000, 3), 
(4, 'Sneha', 'Bangalore', 28, 60000, 15), 
(5, 'Karan', 'Mumbai', 35, 20000, 7), 
(6, 'Pooja', 'Delhi', 27, 15000, 6), 
(7, 'Arjun', 'Bangalore', 40, 70000, 20), 
(8, 'Meera', 'Mumbai', 23, 5000, 2);

Select * from customers where city ='Bangalore';
select * from customers where total_spent>20000;
select * from customers where age between 25 and 35;
select * from customers order by total_spent desc;
select sum(total_spent) as Total_Revenue from customers;
select avg(total_spent) as Avg_Spending from customers;
select city,sum(total_spent) as total_spending from customers group by city;
select city,count(*) as total_customers from customers group by city;
select sum(total_spent) as Total_Revenue from customers;
SELECT 
    CASE 
        WHEN total_spent > 50000 THEN 'High Value'
        WHEN total_spent BETWEEN 20000 AND 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_segment
ORDER BY total_customers DESC;

SELECT city, SUM(total_spent) AS total_spending
FROM customers
GROUP BY city
HAVING SUM(total_spent) > 50000;



