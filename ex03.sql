--Criar uma Procedure que imprimi todos os dados da tabela Produto utilizando o Cursor

CREATE OR REPLACE PROCEDURE PRINT_ALL_PRODUCTS
IS
  CURSOR c_products IS
    SELECT *
    FROM Produto;
  
  product_row Produto%ROWTYPE;
BEGIN
  OPEN c_products;
  
  LOOP
    FETCH c_products INTO product_row;
    EXIT WHEN c_products%NOTFOUND;
    
    -- Imprimir os dados do produto
    DBMS_OUTPUT.PUT_LINE('Id: ' || product_row.Id || ', Status: ' || product_row.Status || ', Preço: ' || product_row.Preco);
  END LOOP;
  
  CLOSE c_products;
END;
/
