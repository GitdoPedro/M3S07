/*Crie um Cursor utilizando um loop que faça um UPDATE na tabela Produto mudando a coluna Status = 0 dos registros 1, 2 e 3;*/

DECLARE
  CURSOR c_produtos IS
    SELECT *
    FROM Produto
    WHERE ROWNUM <= 3;

BEGIN
  FOR produto IN c_produtos LOOP
    UPDATE Produto
    SET Status = 0
    WHERE CURRENT OF c_produtos; 
    
    COMMIT; 
  END LOOP;
END;

