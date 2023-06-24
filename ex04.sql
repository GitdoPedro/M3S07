--Na Procedure ExibirTodosProdutos colocar a exception NO_DATA_FOUD e imprimir a mensagem com Erro, dados não encontrados

CREATE OR REPLACE PROCEDURE PRINT_ALL_PRODUCTS
IS
  CURSOR c_products IS
    SELECT *
    FROM Produto;
  
  product_row Produto%ROWTYPE;
BEGIN
  OPEN c_products;
  
  BEGIN
    LOOP
      FETCH c_products INTO product_row;
      EXIT WHEN c_products%NOTFOUND;
      
      -- Imprimir os dados do produto
      DBMS_OUTPUT.PUT_LINE('Id: ' || product_row.Id || ', Status: ' || product_row.Status || ', Preço: ' || product_row.Preco);
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- Mensagem de erro quando nenhum dado é encontrado
      DBMS_OUTPUT.PUT_LINE('Erro: Dados não encontrados na tabela "Produto".');
  END;
  
  CLOSE c_products;
END;

