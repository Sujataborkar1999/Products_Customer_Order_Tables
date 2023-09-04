create database project_capstone
CREATE TABLE Customers
(CustomerID INT PRIMARY KEY,
  Name VARCHAR(50),
  Email VARCHAR(100)
);
 INSERT INTO Customers (CustomerID, Name, Email)
VALUES
  (1, 'John Doe', 'johndoe@example.com'),
  (2, 'Jane Smith', 'janesmith@example.com'),
  (3, 'Robert Johnson', 'robertjohnson@example.com'),
  (4, 'Emily Brown', 'emilybrown@example.com'),
  (5, 'Michael Davis', 'michaeldavis@example.com'),
  (6, 'Sarah Wilson', 'sarahwilson@example.com'),
  (7, 'David Thompson', 'davidthompson@example.com'),
  (8, 'Jessica Lee', 'jessicalee@example.com'),
  (9, 'William Turner', 'williamturner@example.com'),
  (10, 'Olivia Martinez', 'oliviamartinez@example.com');

  CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductName VARCHAR(50),
  OrderDate DATE,
  Quantity INT
);

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1);


 
CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99);


SELECT * FROM Customers SELECT * FROM Products SELECT * FROM Orders

--1
SELECT  * FROM Customers

--2
SELECT  * FROM Customers
WHERE [Name] LIKE 'j%' AND Email LIKE 'j%' ;

--3
SELECT OrderID , ProductName, Quantity FROM Orders

--4
SELECT SUM(Quantity) AS Total_Quantity
FROM Orders

---5 retrieve the names of customers who have placed an order.
SELECT [Name] FROM Customers

---6 
SELECT * FROM Products
WHERE Price > '10' ;

---7
SELECT [Name], OrderDate   
FROM Customers A INNER JOIN
Orders B
ON A.CustomerID=B.CustomerID 
WHERE OrderDate > '2023-07-05';  

--8
SELECT AVG(Price) AS Average_Price
FROM Products;

--9 customer names along with the total quantity of products they have ordered.
SELECT [Name] FROM Customers
SELECT SUM(Quantity)  AS Total_Quantity FROM Orders

--10
SELECT P.ProductName FROM 
Products AS P
LEFT JOIN 
Orders AS O
ON P.ProductName=O.ProductName
WHERE O.ProductName IS NULL

--TASK2
---1
SELECT TOP 5 Quantity  
FROM Orders
ORDER BY (Quantity) DESC;  

--2
SELECT ProductName,
AVG(Price) AS [Average_price]
FROM Products
GROUP BY ProductName

--3
select * from Orders
WHERE Quantity = 0

--4
SELECT OrderID ,ProductName , Quantity ,[Name]
FROM Orders A
INNER JOIN Customers B
ON A.OrderID=B.CustomerID
WHERE [Name] LIKE 'M%'

--5 calculate the total revenue generated from all orders
SELECT SUM(O.Quantity*P.Price) AS Total_Revenue
FROM Orders AS O
INNER JOIN Products AS P 
ON P.ProductName = O.ProductName
 

--6 customer names along with the total revenue generated from their orders.
SELECT C.Name, SUM(O.Quantity*P.Price) AS Total_Revenue
FROM Customers AS C 
INNER JOIN Orders AS O
ON C.CustomerID=O.CustomerID
INNER JOIN Products AS P
ON P.ProductName = O.ProductName
GROUP BY C.Name

---7 
SELECT CustomerID , Quantity
FROM Orders
WHERE Quantity >=1

--8 retrieve the customers who have placed orders on consecutive days.
SELECT C.Name,O1.OrderDate FROM Customers AS C
INNER JOIN Orders AS O1 
ON C.CustomerID = O1.CustomerID
INNER JOIN Orders AS O2
ON C.CustomerID = O2.CustomerID
WHERE DATEDIFF(DAY,O1.OrderDate,O2.OrderDate)=1;
 

---9
SELECT TOP 3 ProductName,
COUNT(*) AS Number_of_products,
AVG(Quantity) AS AverageQuantity FROM Orders  
GROUP BY ProductName 
ORDER BY AVG(Quantity) DESC;

--10 calculate the percentage of orders that have a quantity greater than the average quantity doubt10

SELECT 
    (COUNT(CASE WHEN Quantity > 2 THEN 1 END) / COUNT(*)) * 100 AS percentage
FROM  Orders
CROSS JOIN (
    SELECT AVG(Quantity) AS Avg_quantity
    FROM orders
) AS subquery;
 






--TASK3  
--1 retrieve the customers who have placed orders for all products.
SELECT o.CustomerID
FROM Orders o
GROUP BY o.CustomerID
HAVING COUNT(DISTINCT o.CustomerID) = (SELECT COUNT(*) FROM products);

---2 retrieve the products that have been ordered by all customers
SELECT DISTINCT P.ProductName FROM 
Products AS P
LEFT JOIN 
Orders AS O 
ON P.ProductName=O.ProductName
WHERE O.ProductName IS NOT NULL
 



---3 retrieve the customers who have not placed any orders.
SELECT Name,CustomerID as Customers from Customers
where CustomerID not in
( select CustomerID from Orders);

--4 retrieve the products that have been ordered by more than 50% of the customers.
SELECT ProductName FROM Products
 

---5 retrieve the customers who have placed orders for all products in a specific category.
SELECT DISTINCT Name,ProductName  FROM Orders O
LEFT JOIN Customers C
ON O.CustomerID=C.CustomerID

--6retrieve the top 5 customers who have spent the highest amount of money on orders.
SELECT P.ProductName ,P.Price,P.ProductID,O.Quantity FROM Products P
LEFT JOIN Orders O 
ON P.ProductID=O.OrderID
GROUP BY (Quantity)*(price) AS Totalamount
ORDER BY COUNT(O.CustomerID) DESC
LIMIT 
amount=(price * quantity)
SELECT * FROM Products

---7 calculate the running total of order quantities for each customer
SELECT CustomerID, OrderDate, Quantity,
    (
        SELECT SUM(Quantity)
        FROM Orders O
        WHERE O.CustomerID = O.CustomerID AND O.OrderDate <= O.OrderDate
    ) AS running_total
FROM Orders O
ORDER BY CustomerID,OrderDate;

--8.	Write a query to retrieve the top 3 most recent orders for each customer
SELECT CustomerID,OrderDate,Quantity
FROM (
    SELECT CustomerID,OrderDate,Quantity,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS RN
    FROM orders
) AS Ranked_orders
WHERE RN <= 3;

-- 9.Write a query to calculate the total revenue generated by each customer in the last 30 days.
 


 ---10.retrieve the customers who have placed orders for at least two different product categories.
 
  
--11.Write a query to calculate the average revenue per order for each customer.
SELECT o.CustomerID,
    AVG(o.Quantity* p.Price) AS Average_revenue_per_order
FROM Orders o
JOIN Products p ON o.CustomerID = p.ProductID
GROUP BY o.CustomerID;


---12.query to retrieve the products that have been ordered by customers from a specific country.
select * from orders

--13.query to retrieve the customers who have placed orders for every month of a specific year.
SELECT o.CustomerID
FROM Orders o
WHERE YEAR(o.OrderDate) = 2023
GROUP BY o.CustomerID
HAVING COUNT(DISTINCT MONTH(o.OrderDate)) = 12;


---14.retrieve the customers who have placed orders for a specific product in consecutive months.
SELECT DISTINCT o1.CustomerID
FROM Orders o1
JOIN Orders o2 ON o1.CustomerID = o2.CustomerID
              AND YEAR(o1.OrderDate) = YEAR(o2.OrderDate)
              AND MONTH(o1.OrderDate) = MONTH(o2.OrderDate) + 1
WHERE o1.CustomerID IS NOT NULL;

---15.retrieve the products that have been ordered by a specific customer at least twice.
SELECT p.ProductID, p.ProductName
FROM Products p
JOIN Orders o ON p.ProductID = o.CustomerID
GROUP BY p.ProductID, p.ProductName
HAVING COUNT(o.CustomerID) >= 2;

    ---END---
 






















