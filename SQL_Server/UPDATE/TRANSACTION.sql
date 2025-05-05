USE SUCOS_FRUTAS
-- UPDATE COM COMMIT E ROLLBACK
-- SELECT * FROM NOTAS_FISCAIS WHERE CPF = '94387575700'

-- Exec comando completo
GO 
BEGIN TRANSACTION;
BEGIN

    -- Atualiza o campo desejado na tabela de Notas fiscais
    UPDATE TOP (1) NOTAS_FISCAIS -- COM O TOP (1) altera só o primeiro registro MESMO QUE TENHA VÁRIAS DTS DE VENDA NESSE CPF, ou a qtd de registros passada no parâmetro do TOP.
    SET DATA_VENDA = '2024-05-10'
	-- Exibe as alterações realizadas
	OUTPUT DELETED.DATA_VENDA AS DATA_ANTERIOR,-- traz só a linha atualizada no output
	      INSERTED.DATA_VENDA AS DATA_MODIFICADA
    WHERE CPF = '94387575700'

	IF @@TRANCOUNT > 0
	COMMIT TRANSACTION;  -- Se a transação ainda estiver ativa, ele a confirma (commit).

END
/* Se o COMMIT foi executado dentro do BEGIN...END, a transação já foi encerrada.
Isso significa que @@TRANCOUNT será 0, e o ROLLBACK nunca será executado. */
IF @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;
GO


-- SEM TOP (1)
SELECT * FROM NOTAS_FISCAIS WHERE CPF = '94387575700' AND MATRICULA = 00236 AND IMPOSTO = 0.12

USE SUCOS_FRUTAS

GO
BEGIN TRY

	BEGIN TRANSACTION
    -- Atualiza o campo desejado na tabela de Notas fiscais
    UPDATE NOTAS_FISCAIS -- SEM O TOP (1) altera todas as datas atreladas a esse CPF e q tbm estão dentro das outras condições do filtro WHERE
      SET DATA_VENDA = '2020-02-11'
	-- Exibe as alterações realizadas
	OUTPUT DELETED.DATA_VENDA AS DATA_ANTERIOR,
	      INSERTED.DATA_VENDA AS DATA_MODIFICADA
    WHERE CPF = '94387575700' AND MATRICULA = 00236 AND IMPOSTO = 0.12;

	    COMMIT TRANSACTION;
END TRY -- Finaliza a transação se tudo der certo
BEGIN CATCH
    -- Se algo falhar, garante o rollback
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    -- Relança o erro para mostrar a msg original
    THROW;
END CATCH;

-- *** com IF ELSE ***
USE SUCOS_FRUTAS

GO

BEGIN TRANSACTION;

UPDATE NOTAS_FISCAIS
  SET DATA_VENDA = '2020-02-11'
OUTPUT
  DELETED.DATA_VENDA AS DATA_ANTERIOR,
  INSERTED.DATA_VENDA AS DATA_MODIFICADA
WHERE CPF = '94387575700' AND MATRICULA = 00236 AND IMPOSTO = 0.1 AND NUMERO = 105; -- MODIFICA UM REGISTRO (1 LINHA)

-- Se não houve erro, commita; senão, faz rollback
IF @@ERROR = 0
    COMMIT TRANSACTION;
ELSE
    ROLLBACK TRANSACTION;
