CREATE OR REPLACE PROCEDURE CALCULATE_TOTAL_PRICE(
  p_Id IN Produto.Id%TYPE,
  p_TotalPrice OUT NUMBER
)
IS
  v_TotalPrice NUMBER := 0;
  v_ExceptionCode NUMBER;
  v_ExceptionMessage VARCHAR2(200);
  
  -- Cursor para realizar o INNER JOIN entre Produto e ProdutoPreco
  CURSOR c_products IS
    SELECT p.Preco
    FROM Produto p
    INNER JOIN ProdutoPreco pp ON p.Id = pp.IdProduto
    WHERE p.Id = p_Id;
  
  product_price Produto.Preco%TYPE;
BEGIN
  OPEN c_products;
  
  -- Loop para somar os preços dos produtos
  LOOP
    FETCH c_products INTO product_price;
    EXIT WHEN c_products%NOTFOUND;
    
    v_TotalPrice := v_TotalPrice + product_price;
  END LOOP;
  
  CLOSE c_products;
  
  IF v_TotalPrice = 0 THEN
    v_ExceptionCode := 20001;
    v_ExceptionMessage := 'Dados não encontrados.';
    RAISE_APPLICATION_ERROR(v_ExceptionCode, v_ExceptionMessage);
  ELSE
    -- Atribuir o valor total à variável OUT
    p_TotalPrice := v_TotalPrice;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Imprimir informações sobre a exceção
    DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
/
