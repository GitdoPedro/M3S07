CREATE OR REPLACE PROCEDURE DELETE_PRODUCT(
  p_Id IN Produto.Id%TYPE
)
IS
  v_Status Produto.Status%TYPE;
  v_ExceptionCode NUMBER;
  v_ExceptionMessage VARCHAR2(200);
  
  CURSOR c_prod_preco IS
    SELECT 1
    FROM ProdutoPreco
    WHERE IdProduto = p_Id;
  
  l_prod_preco_exists NUMBER := 0;
BEGIN
  -- Verificar se o produto está sendo utilizado na tabela ProdutoPreco
  OPEN c_prod_preco;
  FETCH c_prod_preco INTO l_prod_preco_exists;
  CLOSE c_prod_preco;
  
  -- Verificar o status do produto
  SELECT Status INTO v_Status
  FROM Produto
  WHERE Id = p_Id;
  
  -- Verificar as regras
  IF l_prod_preco_exists = 1 THEN
    v_ExceptionCode := 20001;
    v_ExceptionMessage := 'O produto está sendo utilizado na tabela ProdutoPreco.';
    RAISE_APPLICATION_ERROR(v_ExceptionCode, v_ExceptionMessage);
  ELSIF v_Status = 0 THEN
    v_ExceptionCode := 20002;
    v_ExceptionMessage := 'O produto está desativado.';
    RAISE_APPLICATION_ERROR(v_ExceptionCode, v_ExceptionMessage);
  ELSE
    -- Deletar o registro da tabela Produto
    DELETE FROM Produto
    WHERE Id = p_Id;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Registro excluído com sucesso.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Imprimir informações sobre a exceção
    DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;

