DECLARE @CPF VARCHAR(50);
DECLARE @NOME VARCHAR(100);
DECLARE @DATA_NASCIMENTO DATE;
DECLARE @IDADE INT;

SET @CPF = '492472718' --se o valor da variável for substituido por outro CPF o print de nome dt nasc e idade será do cliente desse CPF

SELECT * FROM [TABELA DE CLIENTES] 
WHERE CPF = @CPF;

--atribuindo valores de campos a variáveis, cada variável recebe o valor do seu respectivo campo na tabela.
SELECT @NOME = NOME, @DATA_NASCIMENTO = [DATA DE NASCIMENTO],@IDADE = IDADE 
FROM [TABELA DE CLIENTES] WHERE CPF = @CPF;

PRINT 'O primeiro nome do cliente ' + @NOME + ' , cujo CPF é ' + @CPF + ' , corresponde a ' + SUBSTRING (@NOME, 1, CHARINDEX (' ', @NOME) -1)
/*Uma alternativa a esse print é declarar uma variável com o nome SAIDA do tipo varchar, atribuir essa interpolação a ela e printar a variável */

PRINT @DATA_NASCIMENTO;
PRINT @IDADE;

--Mostra na coluna ao lado do nome o index onde se está o espaço no varchar nome
SELECT NOME, CHARINDEX (' ',NOME) FROM [TABELA DE CLIENTES]

--usa a func substring e charindex para colocar o primeiro nome sem espaço em outra coluna
SELECT NOME, CHARINDEX (' ',NOME), SUBSTRING (NOME, 1, CHARINDEX (' ', NOME) -1)  FROM [TABELA DE CLIENTES]