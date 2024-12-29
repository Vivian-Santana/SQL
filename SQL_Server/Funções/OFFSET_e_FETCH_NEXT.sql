-- A consulta abaixo lista os bairros a partir da linha 3 (OFFSET ) e apenas uma linha (FETCH NEXT).
SELECT BAIRRO
FROM [TABELA DE CLIENTES]
WHERE CIDADE = 'Rio de Janeiro'
ORDER BY BAIRRO

SELECT BAIRRO
FROM [TABELA DE CLIENTES]
WHERE CIDADE = 'Rio de Janeiro'
ORDER BY BAIRRO
OFFSET 3 ROWS
FETCH NEXT 1 ROWS ONLY;

select * from [TABELA DE CLIENTES]

/*
dapte a função criada neste tópico, porém o parâmetro inicial será uma cidade 
e iremos listar todos os bairros desta cidade, um a um, dentro do loop, gravando 
na tabela de saída o nome do bairro (Em vez do número da nota e o status se é 
nota ou não, como mostrado no vídeo da aula).
*/

DECLARE @BAIRRO VARCHAR(50), @CIDADE VARCHAR(50)

--duas variáveis: a primeira para receber o contador que vai começar no zero e percorrer até o número total de bairros, e outra com este número total de bairros
DECLARE @LINHAS_BAIRRO INT, @CONTADOR INT

--  tabela que vai receber a resposta com a lista de bairros:
DECLARE @TABELA_BAIRROS TABLE ([BAIRRO] VARCHAR(50))

-- INICIALIZAÇÃO DAS VAR
SET @CIDADE = 'Rio de Janeiro'
SET @CONTADOR = 0

-- ObteNDO o número total de bairros para a cidade
SELECT @LINHAS_BAIRRO = COUNT(*) FROM (
SELECT DISTINCT BAIRRO FROM [TABELA DE CLIENTES]
WHERE CIDADE = @CIDADE) X

-- Fazemos o Loop para percorrer todas as cidades.

WHILE @CONTADOR < @LINHAS_BAIRRO
BEGIN
	SELECT DISTINCT @BAIRRO = BAIRRO FROM [TABELA DE CLIENTES]
	WHERE CIDADE = @CIDADE
	ORDER BY BAIRRO
	OFFSET @CONTADOR ROWS
	FETCH NEXT 1 ROWS ONLY

--Inserção do bairro na tabela de saída:
	INSERT INTO @TABELA_BAIRROS (BAIRRO) VALUES (@BAIRRO)
	SET @CONTADOR = @CONTADOR + 1
END

-- EXECUÇÃO
	SELECT * FROM @TABELA_BAIRROS ORDER BY BAIRRO --listando os dados da tabela de saída


