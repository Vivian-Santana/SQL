--faturamnento da nota fiscal num 100
--SELECT SUM(QUANTIDADE * [PREÇO])
--FROM [dbo].[ITENS NOTAS FISCAIS]
--WHERE NUMERO = 100

CREATE FUNCTION FaturamentoNota (@NUMERO AS INT) -- entre parênteses o parâmetro de entrada
RETURNS FLOAT -- tipo do dado que a função retornará (saída da func)
AS
BEGIN
	DECLARE @FATURAMENTO FLOAT -- variável que guarda o faturamento da nota fiscal

	SELECT @FATURAMENTO = SUM(QUANTIDADE * [PREÇO]) -- atribuição do faturamento a variável @FATURAMENTO
	FROM [dbo].[ITENS NOTAS FISCAIS]
	WHERE NUMERO = @NUMERO -- atribui a col NUMERO a var de parametro de entrada.
	RETURN @FATURAMENTO

END;

SELECT NUMERO FROM [dbo].[NOTAS FISCAIS] -- TDS AS NOTAS FISCAIS

-- usando a func para ver faturamento de cada nota fiscal do banco sucos_vendas
SELECT NUMERO, dbo.FaturamentoNota(NUMERO) AS FATURAMENTO 
FROM [dbo].[NOTAS FISCAIS];