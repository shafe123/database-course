DROP DATABASE IF EXISTS CompanyDB;
CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    Department VARCHAR(50),
    LastModified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Employee_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    OperationType VARCHAR(10),
    OperationTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderAmount DECIMAL(10, 2) NOT NULL,
    LastModified TIMESTAMP DEFAULT NULL
);

INSERT INTO Employees (Name, Salary, Department)
VALUES 
    ('Alice', 60000, 'HR'),
    ('Bob', 50000, 'IT'),
    ('Charlie', 45000, 'Finance');

INSERT INTO Products (ProductName, Price)
VALUES 
    ('Laptop', 1000.00),
    ('Mouse', 25.00),
    ('Keyboard', 45.00);

INSERT INTO Inventory (ProductID, Quantity)
VALUES 
    (1, 50),
    (2, 200),
    (3, 150);

INSERT INTO Orders (OrderAmount)
VALUES 
    (250.50),
    (125.75),
    (89.99);

DELIMITER $$
CREATE TRIGGER Sync_Inventory
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
    DELETE FROM Inventory WHERE ProductID = OLD.ProductID;
END $$
DELIMITER ;