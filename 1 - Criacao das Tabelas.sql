CREATE TABLE Orders (
    OrderID INT IDENTITY PRIMARY KEY,
    CustomerName VARCHAR(50),
    OrderDate DATE
)
GO

CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY PRIMARY KEY,
    OrderID INT,
    ProductName VARCHAR(255),
    Quantity INT,
    Price DECIMAL(10, 2),
    CONSTRAINT UC_OrderProduct UNIQUE (OrderID, ProductName)
)
GO