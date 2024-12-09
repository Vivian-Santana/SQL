--como podemos criar uma variável chamada NUMNOTAS e atribuir a ela o número de notas fiscais do dia 01/01/2017?
--Para verificarmos o resultado, mostre na saída do script o valor da variável.

DECLARE @NUMNOTAS INT

SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS] 
    WHERE DATA = '20170101'
PRINT @NUMNOTAS

DECLARE @CPF VARCHAR(15);
DECLARE @DATA_NASCIMENTO DATE;
DECLARE @IDADE INT;

-- Exibe o resultado usando a variável @IDADE

--SET @CPF = '1471156710';
--SELECT @DATA_NASCIMENTO = [DATA DE NASCIMENTO] FROM [TABELA DE CLIENTES] WHERE CPF = @CPF;
--SET @IDADE = DATEDIFF(YEAR, @DATA_NASCIMENTO, GETDATE());
--PRINT @IDADE;


/* Para exibirmos um resultado diretamente de uma função, sem utilizar uma variável 
para armazenar esse resultado, podemos utilizar o comando PRINT seguido do valor 
a ser exibido contendo a função desejada. Nesse caso, iremos exibir o resultado 
da função DATEDIFF() */

SET @CPF = '1471156710';
SELECT @DATA_NASCIMENTO = [DATA DE NASCIMENTO] FROM [TABELA DE CLIENTES] WHERE CPF = @CPF;
PRINT DATEDIFF(YEAR, @DATA_NASCIMENTO, GETDATE());