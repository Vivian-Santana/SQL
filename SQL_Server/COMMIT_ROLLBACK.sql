-- UPDATE COM COMMIT E ROWBACK
SELECT * FROM NOTAS_FISCAIS

BEGIN TRANSACTION

    -- Atualiza o campo desejado na tabela de Notas fiscais
    UPDATE TOP (1) NOTAS_FISCAIS -- mostra só uma linha atualizada no output
    SET DATA_VENDA = '2015-08-03'
	-- Exibe as alterações realizadas
	OUTPUT DELETED.DATA_VENDA AS DATA_ANTERIOR,
	      INSERTED.DATA_VENDA AS DATA_MODIFICADA
    WHERE CPF = '94387575700'

 -- Finaliza a transação se tudo der certo
--COMMIT;

-- Se ocorrer erro, desfaz a transação
--ROLLBACK;
