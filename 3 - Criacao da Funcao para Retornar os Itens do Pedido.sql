USE [TopDown]
GO
CREATE FUNCTION GetOrderItems(@OrderID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT ProductName, Quantity, Price
    FROM OrderItems
    WHERE OrderID = @OrderID
);