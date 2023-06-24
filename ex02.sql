/*Crie um Cursor que imprima na tela os dados Id, Status e Preco, utilizando FORALL para listar e IF e Else para verificar se o status do produto está ativo e se o preço está menor que 1000,00.*/

DECLARE
  TYPE product_cursor_type IS REF CURSOR;
  product_cursor product_cursor_type;
  
  TYPE product_record_type IS RECORD (
    Id Produto.Id%TYPE,
    Status Produto.Status%TYPE,
    Preco Produto.Preco%TYPE
  );
  
  products product_cursor;
  product_row product_record_type;
BEGIN
  OPEN products FOR
    SELECT Id, Status, Preco
    FROM Produto;
  
  FETCH products BULK COLLECT INTO product_row;
  CLOSE products;
  
  FORALL i IN product_row.FIRST..product_row.LAST
    PRINT_PRODUCT_DETAILS(product_row(i).Id, product_row(i).Status, product_row(i).Preco);
END;
/

-- Função auxiliar para imprimir os detalhes do produto
CREATE OR REPLACE PROCEDURE PRINT_PRODUCT_DETAILS(
  p_Id Produto.Id%TYPE,
  p_Status Produto.Status%TYPE,
  p_Preco Produto.Preco%TYPE
)
IS
BEGIN
  IF p_Status = 1 AND p_Preco < 1000.00 THEN
    DBMS_OUTPUT.PUT_LINE('Id: ' || p_Id || ', Status: Ativo, Preço: ' || p_Preco);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Id: ' || p_Id || ', Status: Inativo ou Preço maior que 1000,00');
  END IF;
END;
/
