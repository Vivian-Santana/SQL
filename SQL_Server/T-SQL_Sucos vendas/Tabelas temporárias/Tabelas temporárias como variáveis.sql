/*
O script realiza um processo de iteração entre dois números definidos pelo usuário 
(@NUMERO_INICIAL_SEQUENCIA e @NUMERO_FINAL_SEQUENCIA) e verifica se esses números estão presentes 
em uma tabela chamada [NOTAS FISCAIS].
Com base na presença ou ausência de cada número, ele classifica como "É nota fiscal" ou 
"Não é nota fiscal" e armazena essas informações em duas tabelas diferentes:
#TAB_NUM: Uma tabela temporária criada no banco de dados e acessível dentro da sessão atual.
@TABELA_DE_NUMEROS: Uma variável de tabela que existe apenas no escopo do script.
*/

DECLARE @NUMERO_INICIAL_SEQUENCIA INT; --número inicial do intervalo.
DECLARE @NUMERO_FINAL_SEQUENCIA INT; -- número final do intervalo.
DECLARE @TESTE_NOTA_FISCAL INT; --armazena o resultado da contagem de registros na tabela [NOTAS FISCAIS]
CREATE TABLE #TAB_NUM ([NUMERO] INT, [STATUS] VARCHAR(20));

-- A TABELA TEMPORÁRIA CRIADA COM @ É DECLARADA COMO UMA VARIÁVEL DENTRO DO SCRIPT E É VÁLIDA SÓ QUANDO EXECUTO O SCRIPT 1 VEZ
DECLARE @TABELA_DE_NUMEROS TABLE ([NUMERO] INT, [STATUS] VARCHAR(20));

SET @NUMERO_INICIAL_SEQUENCIA = 1;
SET @NUMERO_FINAL_SEQUENCIA = 200;

WHILE @NUMERO_INICIAL_SEQUENCIA <= @NUMERO_FINAL_SEQUENCIA
BEGIN
	SELECT @TESTE_NOTA_FISCAL = COUNT(*) FROM [NOTAS FISCAIS] 
	WHERE NUMERO = @NUMERO_INICIAL_SEQUENCIA
	
	-- O IF verifica se o numero é uma nota fiscal válida e insere o status correspondente nas duas tabelas #TAB_NUM, @TABELA_DE_NUMEROS.
	IF @TESTE_NOTA_FISCAL = 1 -- se num atual exite na tab Notas fiscais
		BEGIN
			INSERT INTO @TABELA_DE_NUMEROS ([NUMERO], [STATUS]) 
			VALUES (@NUMERO_INICIAL_SEQUENCIA, 'É nota fiscal');

			INSERT INTO #TAB_NUM ([NUMERO], [STATUS]) 
			VALUES (@NUMERO_INICIAL_SEQUENCIA, 'É nota fiscal')
		END;
	ELSE      -- se não
		BEGIN 
			INSERT INTO @TABELA_DE_NUMEROS ([NUMERO], [STATUS]) 
			VALUES (@NUMERO_INICIAL_SEQUENCIA, 'Não é nota fiscal');

			INSERT INTO #TAB_NUM ([NUMERO], [STATUS]) 
			VALUES (@NUMERO_INICIAL_SEQUENCIA, 'Não é nota fiscal');
		END;
	SET @NUMERO_INICIAL_SEQUENCIA = @NUMERO_INICIAL_SEQUENCIA + 1; -- evita um loop infinito
END;

SELECT * FROM @TABELA_DE_NUMEROS;
SELECT * FROM #TAB_NUM;