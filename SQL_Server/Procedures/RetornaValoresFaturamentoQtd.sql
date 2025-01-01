-- CONSULTA QUE PEGA A QUANTIDADE DE NOTAS E O TOTAL DO FATURAMENTO DE UM CPF INICIALIZADO NA VAR @CPF DURANTE O ANO PASSADO NA VAR @ANO
--DECLARE @CPF AS VARCHAR(12) = '19290992743',
--		@ANO AS INT = 2017,
--		@NUM_NOTAS AS INT,
--		@FATURAMENTO AS FLOAT

--SELECT @NUM_NOTAS = COUNT(*) FROM [NOTAS FISCAIS]
--WHERE CPF = @CPF AND YEAR([DATA]) = @ANO

--SELECT @FATURAMENTO = SUM(INF.QUANTIDADE * INF.[PREÇO])
--FROM [ITENS NOTAS FISCAIS] INF
--INNER JOIN [NOTAS FISCAIS] NF
--ON INF.NUMERO = NF.NUMERO
--WHERE NF.CPF = @CPF AND YEAR(NF.[DATA]) = @ANO
--AS [TOTAL FATURAMENTO]
--SELECT @NUM_NOTAS AS [TOTAL NOTAS], @FATURAMENTO 

-- TRANSFORMANDO EM UMA PROC
CREATE OR ALTER PROCEDURE RetornaValoresFaturamentoQtd

@CPF AS VARCHAR(12),
@ANO AS INT,
@NUM_NOTAS AS INT OUTPUT, -- VAR PASSADAS COMO REFERENCIA
@FATURAMENTO AS FLOAT OUTPUT -- VAR PASSADAS COMO REFERENCIA (As variáveis marcadas como OUTPUT permitem 
							-- que os valores atribuídos dentro da procedure sejam retornados para quem a executa).
AS
BEGIN

SELECT @NUM_NOTAS = COUNT(*) FROM [NOTAS FISCAIS] -- Atribui a var @NUM_NOTAS o valor total das notas da tb Notas fiscais relacionadas ao CPF e ao ano passado
WHERE CPF = @CPF AND YEAR([DATA]) = @ANO

SELECT @FATURAMENTO = SUM(INF.QUANTIDADE * INF.[PREÇO])-- Calcula e atribui à variável @FATURAMENTO o valor total (quantidade * preço) dos itens nas notas fiscais do cliente (@CPF) para o ano especificado (@ANO).
FROM [ITENS NOTAS FISCAIS] INF
INNER JOIN [NOTAS FISCAIS] NF -- Faz um INNER JOIN entre as tabelas [ITENS NOTAS FISCAIS] e [NOTAS FISCAIS] com base na coluna NUMERO.
ON INF.NUMERO = NF.NUMERO
WHERE NF.CPF = @CPF AND YEAR(NF.[DATA]) = @ANO

END

-- CHAMADA
DECLARE @NUM_NOTAS INT,
		@FATURAMENTO AS FLOAT

SELECT @NUM_NOTAS = 0, -- nessa chamada o retorno vai ser 0 pq elas estão sendo passadas como valor não como referencia.
	   @FATURAMENTO = 0

SELECT @NUM_NOTAS AS [Total Notas], @FATURAMENTO AS [Total Faturamento]

-----------------------------------------------------------------------------------------------
-- nessa chamada o retorno vão ser os valores de "total notas' e de "total faturamento" relacionados ao CPF passado como valor, esses valores saem da proc pq são passados como referencia

EXEC RetornaValoresFaturamentoQtd @CPF = '19290992743', -- var passada como valor
								 @ANO = 2017, -- var passada como valor
								 @NUM_NOTAS = @NUM_NOTAS OUTPUT, -- var passada como referencia
								 @FATURAMENTO = @FATURAMENTO OUTPUT -- var passada como referencia

SELECT @NUM_NOTAS AS [Total Notas], @FATURAMENTO AS [Total Faturamento]

