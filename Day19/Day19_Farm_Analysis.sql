CREATE DATABASE agri_innovate;
USE agri_innovate;

-- Farmers Table
CREATE TABLE farmers (
    farmer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE
);

-- Plots Table
CREATE TABLE plots (
    plot_id INT PRIMARY KEY,
    plot_name VARCHAR(50),
    farmer_id INT,
    crop_type VARCHAR(50),
    soil_type VARCHAR(50),
    FOREIGN KEY (farmer_id) REFERENCES farmers(farmer_id)
);

-- Yields Table
CREATE TABLE yields (
    yield_id INT PRIMARY KEY,
    plot_id INT,
    harvest_date DATE,
    yield_kg DECIMAL(10,2),
    weather_condition VARCHAR(50),
    FOREIGN KEY (plot_id) REFERENCES plots(plot_id)
);

-- Irrigation Logs
CREATE TABLE irrigation_logs (
    log_id INT PRIMARY KEY,
    plot_id INT,
    irrigation_date DATE,
    water_amount_liters DECIMAL(10,2),
    FOREIGN KEY (plot_id) REFERENCES plots(plot_id)
);

INSERT INTO farmers VALUES
(1,'Ravi','Kumar','ravi@gmail.com','2022-01-10'),
(2,'Sita','Reddy','sita@gmail.com','2021-03-15'),
(3,'Arjun','Naidu','arjun@gmail.com','2023-06-20');

INSERT INTO plots VALUES
(1,'West Field',1,'Wheat','Loam'),
(2,'North Field',2,'Corn','Clay'),
(3,'East Field',3,'Soybeans','Sand'),
(4,'South Field',1,'Wheat','Clay'),
(5,'Central Field',2,'Corn','Loam');

INSERT INTO yields VALUES
(1,1,'2025-01-10',500,'Sunny'),
(2,1,'2025-02-10',550,'Rainy'),
(3,2,'2025-01-15',400,'Sunny'),
(4,2,'2025-02-20',420,'Mild'),
(5,3,'2025-01-18',300,'Rainy'),
(6,3,'2025-02-25',320,'Sunny'),
(7,4,'2025-01-22',480,'Mild'),
(8,5,'2025-02-28',450,'Sunny');

INSERT INTO irrigation_logs VALUES
(1,1,'2025-01-05',1000),
(2,1,'2025-02-05',1200),
(3,2,'2025-01-07',900),
(4,2,'2025-02-07',950),
(5,3,'2025-01-10',800),
(6,3,'2025-02-10',850),
(7,4,'2025-01-12',1100),
(8,5,'2025-02-15',1000);

-- Task 1A- Top 3 Most Productive Plots
SELECT p.plot_name, p.crop_type,
       AVG(y.yield_kg) AS avg_yield
FROM plots p
JOIN yields y ON p.plot_id = y.plot_id
GROUP BY p.plot_id
ORDER BY avg_yield DESC
LIMIT 3;

-- Task 1B - Total Water Consumption Ranking
SELECT p.plot_name,
       SUM(i.water_amount_liters) AS total_water
FROM plots p
JOIN irrigation_logs i ON p.plot_id = i.plot_id
GROUP BY p.plot_id
ORDER BY total_water DESC;

-- Task 2A - Yeild by Weather
SELECT p.crop_type,
       y.weather_condition,
       AVG(y.yield_kg) AS avg_yield
FROM yields y
JOIN plots p ON y.plot_id = p.plot_id
GROUP BY p.crop_type, y.weather_condition;

-- Task 2B - Highest Yeild per soil
SELECT soil_type, plot_name, yield_kg
FROM (
    SELECT p.soil_type, p.plot_name, y.yield_kg,
           RANK() OVER (PARTITION BY p.soil_type ORDER BY y.yield_kg DESC) AS rnk
    FROM plots p
    JOIN yields y ON p.plot_id = y.plot_id
) t
WHERE rnk = 1;

-- Task 3A - Lowest water usage Farmer
SELECT f.first_name, f.last_name,
       AVG(i.water_amount_liters) AS avg_water
FROM farmers f
JOIN plots p ON f.farmer_id = p.farmer_id
JOIN irrigation_logs i ON p.plot_id = i.plot_id
GROUP BY f.farmer_id
ORDER BY avg_water ASC
LIMIT 1;

-- Task 3B - Harvests per month
SELECT DATE_FORMAT(harvest_date, '%Y-%m') AS month,
       COUNT(*) AS total_harvests
FROM yields
WHERE harvest_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY month;

-- Task 4 - Advanced Analysis
SELECT p.plot_name, p.crop_type,
       AVG(y.yield_kg) AS avg_yield,
       SUM(i.water_amount_liters) AS total_water
FROM plots p
JOIN yields y ON p.plot_id = y.plot_id
JOIN irrigation_logs i ON p.plot_id = i.plot_id
GROUP BY p.plot_id
HAVING avg_yield < (
    SELECT AVG(y2.yield_kg)
    FROM yields y2
    JOIN plots p2 ON y2.plot_id = p2.plot_id
    WHERE p2.crop_type = p.crop_type
)
AND total_water > (
    SELECT AVG(i2.water_amount_liters)
    FROM irrigation_logs i2
    JOIN plots p3 ON i2.plot_id = p3.plot_id
    WHERE p3.crop_type = p.crop_type
);