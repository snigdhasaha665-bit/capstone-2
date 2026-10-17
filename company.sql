-- Create Customers table
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(30),
    Country VARCHAR(30)
);

-- Create Products table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Category VARCHAR(30),
    Price DECIMAL(10,2),
    Stock INT
);

-- Create Exports table
CREATE TABLE Exports (
    Export_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Export_Country VARCHAR(30),
    Quantity INT,
    Export_Date DATE,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Insert customer details
INSERT INTO Customers VALUES
(1, 'Arjun Mehta', 'arjun@gmail.com', '9876543210', 'Mumbai', 'India'),
(2, 'Riya Sharma', 'riya@gmail.com', '9876543211', 'Delhi', 'India'),
(3, 'Ananya Roy', 'ananya@gmail.com', '9876543212', 'Kolkata', 'India'),
(4, 'Rahul Verma', 'rahul@gmail.com', '9876543213', 'Pune', 'India'),
(5, 'Aarav Singh', 'aarav@gmail.com', '9876543214', 'Jaipur', 'India'),
(6, 'Priya Kapoor', 'priya@gmail.com', '9876543215', 'Delhi', 'India'),
(7, 'Aditya Rao', 'aditya@gmail.com', '9876543216', 'Bangalore', 'India'),
(8, 'Neha Das', 'neha@gmail.com', '9876543217', 'Kolkata', 'India');

-- Insert product details
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 75000, 20),
(102, 'Smartphone', 'Electronics', 45000, 35),
(103, 'Headphones', 'Accessories', 5000, 50),
(104, 'Tablet', 'Electronics', 30000, 25),
(105, 'Smart Watch', 'Accessories', 12000, 40);

-- Insert export details
INSERT INTO Exports VALUES
(1001, 1, 101, 'USA', 5, '2026-01-15'),
(1002, 2, 102, 'UK', 10, '2026-02-10'),
(1003, 3, 103, 'Canada', 15, '2026-02-20'),
(1004, 4, 104, 'USA', 8, '2026-03-05'),
(1005, 5, 101, 'Germany', 4, '2026-03-15'),
(1006, 6, 105, 'Australia', 12, '2026-04-01'),
(1007, 7, 102, 'USA', 7, '2026-04-10'),
(1008, 8, 103, 'UK', 20, '2026-04-20'),
(1009, 1, 104, 'France', 6, '2026-05-01'),
(1010, 3, 105, 'USA', 9, '2026-05-15');

-- 1. Customers whose names start with A
SELECT *
FROM Customers
WHERE Customer_Name LIKE 'A%';

-- 2. Customers whose names contain the letter R
SELECT *
FROM Customers
WHERE Customer_Name LIKE '%R%';

-- 3. Customers whose names start with A AND contain R
SELECT *
FROM Customers
WHERE Customer_Name LIKE 'A%'
AND Customer_Name LIKE '%R%';

-- 4. Display customer details with their exported products
SELECT 
    Customers.Customer_Name,
    Products.Product_Name,
    Products.Category,
    Products.Price,
    Exports.Export_Country,
    Exports.Quantity
FROM Customers
JOIN Exports
    ON Customers.Customer_ID = Exports.Customer_ID
JOIN Products
    ON Exports.Product_ID = Products.Product_ID;

-- 5. Show products costing more than 30000
SELECT *
FROM Products
WHERE Price > 30000;

-- 6. Show products whose price is between 10000 and 60000
SELECT *
FROM Products
WHERE Price BETWEEN 10000 AND 60000;

-- 7. Show products that belong to Electronics OR Accessories
SELECT *
FROM Products
WHERE Category = 'Electronics'
OR Category = 'Accessories';

-- 8. Show products whose names contain 'phone'
SELECT *
FROM Products
WHERE Product_Name LIKE '%phone%';

-- 9. Display all different export countries
SELECT DISTINCT Export_Country
FROM Exports;

-- 10. Count the number of customers exporting to each country
SELECT Export_Country, COUNT(DISTINCT Customer_ID) AS Number_of_Customers
FROM Exports
GROUP BY Export_Country;

-- 11. Find the total quantity exported to each country
SELECT Export_Country, SUM(Quantity) AS Total_Quantity
FROM Exports
GROUP BY Export_Country;

-- 12. Find the average quantity exported to each country
SELECT Export_Country, AVG(Quantity) AS Average_Quantity
FROM Exports
GROUP BY Export_Country;

-- 13. Show countries where more than 10 products were exported
SELECT Export_Country, SUM(Quantity) AS Total_Quantity
FROM Exports
GROUP BY Export_Country
HAVING SUM(Quantity) > 10;

-- 14. Find the total value of exports for each product
SELECT 
    Products.Product_Name,
    SUM(Exports.Quantity * Products.Price) AS Total_Export_Value
FROM Products
JOIN Exports
    ON Products.Product_ID = Exports.Product_ID
GROUP BY Products.Product_Name;

-- 15. Find the total value of products exported by each customer
SELECT
    Customers.Customer_Name,
    SUM(Exports.Quantity * Products.Price) AS Total_Value
FROM Customers
JOIN Exports
    ON Customers.Customer_ID = Exports.Customer_ID
JOIN Products
    ON Exports.Product_ID = Products.Product_ID
GROUP BY Customers.Customer_Name
ORDER BY Total_Value DESC;

-- 16. Show customers who exported more than 10 products
SELECT
    Customers.Customer_Name,
    SUM(Exports.Quantity) AS Total_Products
FROM Customers
JOIN Exports
    ON Customers.Customer_ID = Exports.Customer_ID
GROUP BY Customers.Customer_Name
HAVING SUM(Exports.Quantity) > 10;

-- 17. Show customers from India whose names start with A
SELECT *
FROM Customers
WHERE Country = 'India'
AND Customer_Name LIKE 'A%';

-- 18. Find customers who exported products to the USA
SELECT DISTINCT Customers.Customer_Name
FROM Customers
JOIN Exports
    ON Customers.Customer_ID = Exports.Customer_ID
WHERE Export_Country = 'USA';

-- 19. Find customers who exported Electronics products
SELECT DISTINCT Customers.Customer_Name
FROM Customers
JOIN Exports
    ON Customers.Customer_ID = Exports.Customer_ID
JOIN Products
    ON Exports.Product_ID = Products.Product_ID
WHERE Products.Category = 'Electronics';

-- 20. Display the complete export report
SELECT
    Customers.Customer_Name,
    Customers.Email,
    Customers.City,
    Products.Product_Name,
    Products.Category,
    Products.Price,
    Exports.Quantity,
    Exports.Export_Country,
    Exports.Export_Date
FROM Customers
JOIN Exports
    ON Customers.Customer_ID = Exports.Customer_ID
JOIN Products
    ON Exports.Product_ID = Products.Product_ID
ORDER BY Customers.Customer_Name;