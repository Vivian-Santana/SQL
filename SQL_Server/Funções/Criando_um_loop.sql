/*
Pegue uma sequencia de números inteiros desde um limite mínimo
até um limite máximo, percorra e varifique se esses números 
correspondem ou não a uma nota fiscal da base de dados SUCOS_VENDAS
*/

DECLARE @LIMITE_MIN INT, @LIMITE_MAX INT
DECLARE @TABELA_NUM TABLE ([NUMERO] INT, [STATUS] VARCHAR (200), [FATURAMENTO] FLOAT)
DECLARE @CONTADOR_NOTA INT

SET @LIMITE_MIN = 1
SET @LIMITE_MAX = 1000000

SET NOCOUNT ON
WHILE @LIMITE_MIN <= @LIMITE_MAX
BEGIN
	SELECT @CONTADOR_NOTA = COUNT (*) FROM [dbo].[NOTAS FISCAIS]
	WHERE NUMERO = @LIMITE_MIN
	IF @CONTADOR_NOTA > 0
		BEGIN
			INSERT INTO @TABELA_NUM (NUMERO, [STATUS], FATURAMENTO) 
			VALUES (@LIMITE_MIN, 'É NOTA FISCAL',[dbo].[FaturamentoNota](@LIMITE_MIN)) -- usando a func FaturamentoNota detro do loop para mostrar o faturamento de cada nota.
		END
	ELSE
		BEGIN
			INSERT INTO @TABELA_NUM (NUMERO, [STATUS], FATURAMENTO) 
			VALUES (@LIMITE_MIN, 'NÃO É NOTA FISCAL', 0)-- se o valor do limite min não corresponder a uma nota fiscal o faturamento não exite (é 0) pq não é nota fiscal
		END
	SET @LIMITE_MIN = @LIMITE_MIN +1
END

SELECT * FROM @TABELA_NUM ORDER BY NUMERO

--MOSTRA O NUM DO CAMPO EM QUE PASSA A SER NOTA FISCAL E O CAMPO QUE DEIXA DE SER
--SELECT MIN(NUMERO) AS [A PARTIR DAQUI É NOTA FISCAL], MAX(NUMERO) AS [A PARTIR DAQUI NÃO É MAIS NOTA FISCAL] FROM [dbo].[NOTAS FISCAIS]

--SELECT [dbo].[FaturamentoNota](5000)-- VALOR DO FATURAMENTO PARA A NOTA O PARAMETRO