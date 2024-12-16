SELECT MIN(NUMERO), MAX(NUMERO) FROM [NOTAS FISCAIS]--MENOR E MAIOR NOTA FISCAL

IF OBJECT_ID ('TABELA DE NUMEROS', 'U') IS NULL DROP TABLE [TABELA DE NUMEROS];
CREATE TABLE [TABELA DE NUMEROS] ([NUMERO] INT, [STATUS] VARCHAR(20))

DECLARE @NUMERO_INICIAL_SEQUENCIA INT, @NUMERO_FINAL_SEQUENCIA INT, @TESTE_NOTA_FISCAL INT;

SET @NUMERO_INICIAL_SEQUENCIA = 1;
SET @NUMERO_FINAL_SEQUENCIA = 200;

WHILE @NUMERO_INICIAL_SEQUENCIA <= @NUMERO_FINAL_SEQUENCIA
BEGIN
	SELECT @TESTE_NOTA_FISCAL = COUNT(*) FROM [NOTAS FISCAIS] 
	WHERE NUMERO = @NUMERO_INICIAL_SEQUENCIA

	IF @TESTE_NOTA_FISCAL = 1
		INSERT INTO [TABELA DE NUMEROS] ([NUMERO], [STATUS]) 
		VALUES (@NUMERO_INICIAL_SEQUENCIA, 'É nota fiscal')
	ELSE
		INSERT INTO [TABELA DE NUMEROS] ([NUMERO], [STATUS]) 
		VALUES (@NUMERO_INICIAL_SEQUENCIA, 'Não é nota fiscal')
	SET @NUMERO_INICIAL_SEQUENCIA = @NUMERO_INICIAL_SEQUENCIA + 1;
END;

SELECT * FROM [TABELA DE NUMEROS];