/*faça uma função UDF que retorne o faturamento total de todas as notas fiscais de um bairro.
Exemplo: Se eu seleciono como parâmetro da função o bairro jardins, o retorno da função será o total 
de faturamento de todas as notas fiscais, para todos os períodos, para este bairro.
*/
-- campo bairro está tb - CLIENTES
-- campo faturamento tb - ITENS NOTAS FISCAIS.
--select * from [TABELA DE CLIENTES]
--select * from [ITENS NOTAS FISCAIS]
--select * from [NOTAS FISCAIS]

--SELECT SUM(INF.QUANTIDADE * INF.[PREÇO]) AS FATURAMENTO
--FROM [ITENS NOTAS FISCAIS] INF
--INNER JOIN [NOTAS FISCAIS] NF
--ON INF.NUMERO = NF.NUMERO
--INNER JOIN [TABELA DE CLIENTES] TC
--ON TC.CPF = NF.CPF
--WHERE TC.BAIRRO = 'Jardins'

CREATE FUNCTION FaturamentoBairro (@BAIRRO VARCHAR(50))
RETURNS FLOAT
AS
BEGIN
   DECLARE @FATURAMENTO FLOAT
   SELECT @FATURAMENTO = SUM(INF.QUANTIDADE * INF.[PREÇO])
   -- ALIAS
   FROM [ITENS NOTAS FISCAIS] INF
   INNER JOIN [NOTAS FISCAIS] NF
   ON INF.NUMERO = NF.NUMERO
   INNER JOIN [TABELA DE CLIENTES] TC
   ON TC.CPF = NF.CPF
   WHERE TC.BAIRRO = @BAIRRO
   RETURN @FATURAMENTO
END;

--USANDO A FUNÇÃO

-- CHAMANDO DIRETAMENTE
SELECT dbo.FaturamentoBairro('Jardins') AS FaturamentoCentro;

--Atribuiindo o resultado a uma variável
DECLARE @Faturamento FLOAT;
SET @Faturamento = dbo.FaturamentoBairro('Jardins');
PRINT @Faturamento;

