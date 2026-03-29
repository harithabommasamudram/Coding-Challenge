create database sales_db;
use sales_db;

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    product_name VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    sale_date DATE
);


INSERT INTO Sales VALUES
(1, 'Ravi', 'Bangalore', 'Laptop', 'Electronics', 1, 60000, '2023-06-01'),
(2, 'Priya', 'Chennai', 'Mobile', 'Electronics', 2, 20000, '2023-06-03'),
(3, 'Amit', 'Delhi', 'Headphones', 'Accessories', 3, 2000, '2023-06-05'),
(4, 'Neha', 'Mumbai', 'Chair', 'Furniture', 2, 5000, '2023-06-07'),
(5, 'Ravi', 'Bangalore', 'Mobile', 'Electronics', 1, 20000, '2023-06-10'),
(6, 'Priya', 'Chennai', 'Laptop', 'Electronics', 1, 60000, '2023-06-12'),
(7, 'Amit', 'Delhi', 'Chair', 'Furniture', 4, 5000, '2023-06-15'),
(8, 'Neha', 'Mumbai', 'Headphones', 'Accessories', 2, 2000, '2023-06-18');

SELECT * FROM Sales;
select customer_name,city from Sales;
select product_name,price from Sales;
select * from Sales where city='Bangalore';
select * from Sales where category='Electronics';
select * from Sales where price>10000;
select * from Sales where quantity>2;
select * from Sales order by price asc;
select * from Sales order by quantity desc;
select distinct city from Sales;
