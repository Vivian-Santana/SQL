USE [VENDAS SUCOS 2]

-- FAZENDO UPDATE DE REGISTROS

SELECT * FROM PRODUTOS

-- ALTERAR O PREDÇO DE UM PRODUTO

UPDATE PRODUTOS SET PRECO_LISTA = 5
WHERE CODIGO = '1040107';

-- COM OUTPUT
UPDATE PRODUTOS SET PRECO_LISTA = 10.50 -- TOP(1) garante a modificação de apenas um registro
--EXIBE ANTES E DEPOIS DA ALTERAÇÃO
OUTPUT DELETED.PRECO_LISTA AS PRECO_ANTERIOR,
		INSERTED.PRECO_LISTA AS PRECO_MODIFICADO
WHERE CODIGO = '394479'

SELECT * FROM PRODUTOS WHERE  CODIGO = '394479'


-- AUMENTANDO EM 10% O PREÇO DE UM TIPO DE PRODUTO | USANDO COMMIT E ROLLBACK
SELECT * FROM PRODUTOS WHERE  SABOR = 'Maracujá'

BEGIN TRANSACTION

	UPDATE PRODUTOS SET PRECO_LISTA = PRECO_LISTA * 1.10
	OUTPUT DELETED.PRECO_LISTA AS PRECO_ANTERIOR,   -- OUTPUT MOSTRA APENAS AS LINHAS AFETADAS
			INSERTED.PRECO_LISTA AS PRECO_MODIFICADO
	WHERE SABOR = 'Maracujá'

 -- Finaliza a transação se tudo der certo
COMMIT;

-- Se ocorrer erro, desfaz a transação
ROLLBACK;

-- UPDATE com TOP(1)

SELECT * FROM PRODUTOS WHERE  SABOR = 'Manga'

BEGIN TRANSACTION

	UPDATE TOP(1) PRODUTOS SET PRECO_LISTA = PRECO_LISTA * 1.10 -- altera só o primeiro registro mesmo que tenha mais de um sabor Manga
	OUTPUT DELETED.PRECO_LISTA AS PRECO_ANTERIOR,
			INSERTED.PRECO_LISTA AS PRECO_MODIFICADO
	WHERE SABOR = 'Manga'

 -- Finaliza a transação se tudo der certo
--COMMIT;

-- Se ocorrer erro, desfaz a transação
--ROLLBACK;


-- Alteração de mais de um campo 
SELECT * FROM PRODUTOS WHERE TAMANHO = '350 ml'
SELECT DESCRITOR FROM PRODUTOS WHERE TAMANHO = '350 ml'

-- SUBSTITUI O VALOR 350 ml Q ESTA NO MEIO DO CAMPO DESCRITOR PARA 550 ML
-- NA CONSULTA COMO FICARIA
SELECT DESCRITOR, REPLACE (DESCRITOR, '350 ml', '550 ML') FROM PRODUTOS WHERE TAMANHO = '350 ml'

-- TBM NO CAMPO TAMANHO TDS Q TIVEREM 350 ML SERÃO ALTERADOS PARA 550 ML
UPDATE PRODUTOS SET DESCRITOR = REPLACE (DESCRITOR, '350 ml', '550 ML'), TAMANHO = '550 ML'
WHERE TAMANHO = '350 ml'
SELECT DESCRITOR, TAMANHO, EMBALAGEM  FROM PRODUTOS WHERE TAMANHO = '550 ml'


-- Modifique o endereço do cliente 19290992743 para R. Jorge Emilio 23, em Santo Amaro, São Paulo, SP, CEP 8833223.
SELECT CPF, NOME, ENDERECO_1, BAIRRO, CIDADE, ESTADO, CEP 
FROM SUCOS_FRUTAS.[dbo].[TABELA_DE_CLIENTES] 
WHERE CPF = '19290992743'

--SELECT * FROM [TABELA_DE_CLIENTES]

BEGIN TRANSACTION;

BEGIN TRY
-- Atualiza os dados do cliente
UPDATE SUCOS_FRUTAS.[dbo].[TABELA_DE_CLIENTES] 
        SET ENDERECO_1 = 'R. Jorge Emilio 23',
			BAIRRO = 'Santo Amaro',
			CIDADE = 'São Paulo',
			ESTADO = 'SP',
			CEP = '8833223'

OUTPUT DELETED.ENDERECO_1 AS ENDERECO_ANTERIOR, INSERTED.ENDERECO_1 AS ENDERECO_NOVO,
	   DELETED.BAIRRO AS BAIRRO_ANTERIOR, INSERTED.BAIRRO AS BAIRRO_NOVO,
	   DELETED.CIDADE AS CIDADE_ANTERIOR, INSERTED.CIDADE AS CIDADE_NOVA,
	   DELETED.ESTADO AS ESTADO_ANTERIROR, INSERTED.ESTADO AS ESTADO_NOVO,
	   DELETED.CEP AS CEP_ANTERIOR, INSERTED.CEP AS CEP_NOVO
WHERE CPF = '19290992743'

    -- Se tudo deu certo, confirma a transação
    COMMIT TRANSACTION;

END TRY
BEGIN CATCH
    -- Se houver erro, desfaz a transação
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    -- Exibi a mensagem do erro
    PRINT ERROR_MESSAGE();
END CATCH;

-- alterando o volume de compra em 20%, dos clientes do estado do Rio de Janeiro
SELECT VOLUME_DE_COMPRA, ESTADO 
FROM SUCOS_FRUTAS.DBO.TABELA_DE_CLIENTES 
WHERE ESTADO = 'RJ'

BEGIN TRANSACTION;

BEGIN
UPDATE SUCOS_FRUTAS.DBO.TABELA_DE_CLIENTES
    SET VOLUME_DE_COMPRA = VOLUME_DE_COMPRA * 1.2
	OUTPUT DELETED.VOLUME_DE_COMPRA AS VOL_COMP_ANTERIOR,
		   INSERTED.VOLUME_DE_COMPRA AS VOL_COMP_ATUALIZADO
WHERE ESTADO = 'RJ'

	IF @@TRANCOUNT > 0
	COMMIT TRANSACTION;

END

IF @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;
GO

