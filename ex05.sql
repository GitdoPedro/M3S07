CREATE OR REPLACE PROCEDURE UPDATE_PRODUCT_PRICE(
  p_Id IN Produto.Id%TYPE,
  p_NewPrice IN Produto.Preco%TYPE
)
IS
  v_Status Produto.Status%TYPE;
  v_ExceptionCode NUMBER;
  v_ExceptionMessage VARCHAR2(200);
  
  -- Custom Exception
  EXCEPTION
    WHEN PRODUCT_NOT_FOUND THEN
      v_ExceptionCode := 20001;
      v_ExceptionMessage := 'Produto não existe.';
      RAISE_APPLICATION_ERROR(v_ExceptionCode, v_ExceptionMessage);
    
    WHEN PRODUCT_DISABLED THEN
      v_ExceptionCode := 20002;
      v_ExceptionMessage := 'Produto está desativado na tabela.';
      RAISE_APPLICATION_ERROR(v_ExceptionCode, v_ExceptionMessage);
BEGIN
  -- Verificar se o produto existe na base de dados
  SELECT Status INTO v_Status
  FROM Produto
  WHERE Id = p_Id;
  
  IF v_Status IS NULL THEN
    RAISE PRODUCT_NOT_FOUND;
  ELSIF v_Status = 0 THEN
    RAISE PRODUCT_DISABLED;
  ELSE
    -- Atualizar o preço do produto
    UPDATE Produto
    SET Preco = p_NewPrice
    WHERE Id = p_Id;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Preço do produto atualizado com sucesso.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Imprimir informações sobre a exceção
    DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
