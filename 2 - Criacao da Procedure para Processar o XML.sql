CREATE PROCEDURE ProcessOrderXML
    @OrderXML XML
AS
BEGIN
    DECLARE @CustomerName VARCHAR(255),
            @OrderDate DATE,
            @OrderID INT;
    
    -- Extrair os dados do pedido (CustomerName e OrderDate)
    SET @CustomerName = @OrderXML.value('(/Order/CustomerName)[1]', 'VARCHAR(100)');
    SET @OrderDate = @OrderXML.value('(/Order/OrderDate)[1]', 'DATE');

    -- Inserir o pedido na tabela Orders
    INSERT INTO Orders (CustomerName, OrderDate)
    VALUES (@CustomerName, @OrderDate);
    
    -- Obter o ID do pedido inserido
    SET @OrderID = SCOPE_IDENTITY();

    -- Inserir os itens do pedido na tabela OrderItems
    INSERT INTO OrderItems (OrderID, ProductName, Quantity, Price)
    SELECT
        @OrderID,
        Item.value('(ProductName)[1]', 'VARCHAR(100)'),
        Item.value('(Quantity)[1]', 'INT'),
        Item.value('(Price)[1]', 'DECIMAL(10, 2)')
    FROM @OrderXML.nodes('/Order/Items/Item') AS T(Item)
    WHERE NOT EXISTS (
        SELECT 1 FROM OrderItems
        WHERE OrderID = @OrderID AND ProductName = Item.value('(ProductName)[1]', 'VARCHAR(255)')
    );

    -- Se houver duplicatas, retorne um erro
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('Erro: Produto duplicado no pedido.', 16, 1);
        ROLLBACK;
        RETURN;
    END;
END;