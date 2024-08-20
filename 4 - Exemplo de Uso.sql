DECLARE @OrderXML XML = '
<Order>
    <CustomerName>John Doe</CustomerName>
    <OrderDate>2024-08-19</OrderDate>
    <Items>
        <Item>
            <ProductName>Product A</ProductName>
            <Quantity>2</Quantity>
            <Price>19.99</Price>
        </Item>
        <Item>
            <ProductName>Product B</ProductName>
            <Quantity>1</Quantity>
            <Price>9.99</Price>
        </Item>
    </Items>
</Order>';

-- Processa o XML
EXEC ProcessOrderXML @OrderXML;

-- Consulta itens do pedido
SELECT * FROM GetOrderItems(1);