/*Crie um Cursor que imprima na tela os dados Id, Status e Preco, utilizando FORALL para listar e IF e Else para verificar se o status do produto está ativo e se o preço está menor que 1000,00.*/

DECLARE
  CURSOR c_products IS
    SELECT Id, Status, Preco
    FROM Produto;
  
  product_row c_products%ROWTYPE;
BEGIN
  FOR product_row IN c_products LOOP
    IF product_row.Status = 1 AND product_row.Preco < 1000.00 THEN
      DBMS_OUTPUT.PUT_LINE('Id: ' || product_row.Id || ', Status: Ativo, Preço: ' || product_row.Preco);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Id: ' || product_row.Id || ', Status: Inativo ou Preço maior ou igual a 1000,00');
    END IF;
  END LOOP;
END;
/

