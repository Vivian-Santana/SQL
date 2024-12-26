--Relatorio: nome, CPF e valor total das vendas por cliente em um período de tempo

SELECT * FROM [TABELA DE CLIENTES]

SELECT COUNT(*) FROM [TABELA DE CLIENTES]
SELECT X.CPF, X.NOME
FROM(
-- A subconsulta cria uma tabela virtual com a numeração (RowNum) associada a cada cliente.
SELECT ROW_NUMBER() Over (Order By CPF) AS RowNum, * FROM [TABELA DE CLIENTES] -- ROW_NUMBER() Over (Order By CPF) cria uma numeração sequencial dos clientes, ordenada pelo CPF.
) X
WHERE X.RowNum = 5 -- seleciona o 5º cliente dessa sequência.

DECLARE @CPF VARCHAR(20);
DECLARE @NOME VARCHAR (100);
DECLARE @NUMERO_CLIENTES INT;
DECLARE @I INT; -- Controle de iteração do loop.
DECLARE @MES INT;
DECLARE @ANO INT;
DECLARE @TOTAL_VENDAS FLOAT;

--SALVANDO O RELATÓRIO EM UMA TABELA (VARIÁVEL) TEMPORÁRIA
DECLARE @TABELA_FINAL TABLE 
(
	  CPF VARCHAR(11)
	, NOME VARCHAR(100)
	, MES INT
	, ANO INT
	, VALOR_TOTAL FLOAT
);

-- INCIALIZAÇÃO DAS VARIÁVEIS
SELECT @NUMERO_CLIENTES = COUNT(*) FROM [TABELA DE CLIENTES] -- Recebe o total de clientes da tabela TABELA

SET @MES = 1;
SET @ANO = 2015;
SET @I = 1;

-- ITERA SOBRE CADA CLIENTE, PROCESSANDO AS VENDAS E SALVANDO OS RESUTADOS NA TABELA TEMPORÁRIA
WHILE @I <= @NUMERO_CLIENTES
BEGIN
-- Seleciona o CPF e o Nome do cliente correspondente à iteração atual (@I) usando a numeração gerada por ROW_NUMBER().
	SELECT @CPF = X.CPF, @NOME = X.NOME
	FROM(
	SELECT ROW_NUMBER() Over (Order By CPF) AS RowNum, * FROM [TABELA DE CLIENTES]
	) X
	WHERE X.RowNum = @I;

	-- CALCULO DO TOTAL DE VENDAS
	--  Calcula o total de vendas de janeiro de 2015 (@MES e @ANO) para o cliente atual (@CPF).
	SELECT
	@TOTAL_VENDAS = SUM([ITENS NOTAS FISCAIS].QUANTIDADE * [ITENS NOTAS FISCAIS].[PREÇO]) -- Calcula o valor total de vendas baseado na quantidade e preço dos itens.
	FROM [NOTAS FISCAIS]
	INNER JOIN [ITENS NOTAS FISCAIS] -- Relaciona as tabelas NOTAS FISCAIS e ITENS NOTAS FISCAIS para acessar os itens vendidos em cada nota.
	ON [NOTAS FISCAIS].NUMERO = [ITENS NOTAS FISCAIS].NUMERO
	WHERE [NOTAS FISCAIS].CPF = @CPF
	AND YEAR([NOTAS FISCAIS].DATA) = @ANO AND MONTH([NOTAS FISCAIS].DATA)= @MES;--TOTAL VENDAS 01/2015 

	-- INSERE OS RESULTADOS NA TABELA TEMPORARIA
	INSERT INTO @TABELA_FINAL VALUES (@CPF, @NOME, @MES, @ANO, @TOTAL_VENDAS);

	 -- Output com o CPF, nome, mês, ano e total de vendas do cliente processado.
	PRINT CONCAT (' Vendas para ',  @CPF, ' - ', @NOME, ' no mes ',  @MES , ' e ano ' , @ANO , ' foi de ' , TRIM(STR(@TOTAL_VENDAS, 15, 2)));
	SET @I = @I + 1; -- Incrementa o valor de @I para processar o próximo cliente
END

SELECT * FROM @TABELA_FINAL;

-----------------------------------------------------------
-- A MESMA COISA COM TABELA DE PRODUTOS
DECLARE @CODIGO VARCHAR(10);
DECLARE @NOME_PRODUTO VARCHAR(50);
DECLARE @NUMERO_PRODUTOS INT;
DECLARE @INDICE INT;

SELECT @NUMERO_PRODUTOS = COUNT(*) FROM [TABELA DE PRODUTOS];
SET @INDICE = 1;
WHILE @INDICE <= @NUMERO_PRODUTOS
BEGIN
   SELECT @CODIGO = X.[CODIGO DO PRODUTO], @NOME_PRODUTO = X.[NOME DO PRODUTO]
   FROM ( SELECT Row_Number() Over (Order By [CODIGO DO PRODUTO]) as RowNum, * from [TABELA DE PRODUTOS]) X
   WHERE X.RowNum = @INDICE;
   PRINT 'Vendas para ' + @CODIGO + ' - ' + @NOME_PRODUTO ;
   SET @INDICE = @INDICE + 1;
END;

