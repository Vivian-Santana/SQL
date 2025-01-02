/*
Na base de dados SUCOS_VENDAS temos, na tabela de produtos, o campo sabor. Houve, por parte da empresa,
uma reestruturação dividindo a organização de compras de matérias primas, em dois departamentos: FRUTAS CÍTRICAS e FRUTAS NÃO CÍTRICAS.
Mas a pessoa responsável pelo banco de dados da empresa não pode, neste momento, criar uma nova tabela no banco de dados e associar 
esta nova classificação ao sistema ERP porque isso acarretaria numa mudança muito drástica na estrutura de TI.
Mas, por outro lado, a presidência quer um relatório com dados de vendas, por datas, olhando pela perspectiva destes novos departamentos.
E de tal maneira que seja simples executar este relatório sempre que necessário, passando como parâmetros a data inicial e final para 
determinar o período analisado.
Portanto, tente você mesmo usar SP (Stored Procedure) para isso e conseguir realizar essa demanda.
*/

select * from [TABELA DE PRODUTOS]

-- consulta que apresenta as vendas por sabor, tendo como filtro a data inicial e final de análise.
SELECT TP.[SABOR]
, SUM(INF.QUANTIDADE * INF.[PREÇO]) AS FATURAMENTO
FROM [TABELA DE PRODUTOS] TP
INNER JOIN [ITENS NOTAS FISCAIS] INF
ON TP.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
INNER JOIN [NOTAS FISCAIS] NF
ON NF.NUMERO = INF.NUMERO
WHERE NF.DATA >= '2015-01-01' AND NF.DATA <= '2015-12-31'
GROUP BY TP.[SABOR]

/* Para obter o faturamento é preciso buscar os dados na tabela de itens de notas fiscais. 
Já as datas na tabela de notas fiscais e o sabor da tabela de produto. 
Por isso o INNER JOIN entre estas três tabelas. */
-------------------------------------------------------------------------------------------------------------------------------------------
/*
Uma  tabela temporária cria a relação entre os sabores e os dois novos departamentos.
Uma variável do tipo tabela e inclui esta relação na base.
*/

DECLARE @DEPARTAMENTO TABLE (SABOR VARCHAR(20), DEPARTAMENTO VARCHAR(20))
INSERT INTO @DEPARTAMENTO 
SELECT DISTINCT SABOR, 'FRUTAS NÃO CÍTRICAS' as DEPARTAMENTO 
FROM [TABELA DE PRODUTOS] WHERE 
SABOR IN ('Açai','Cereja','Cereja/Maça','Maça','Manga','Maracujá','Melância')
UNION
SELECT DISTINCT SABOR, 'FRUTAS CÍTRICAS' as DEPARTAMENTO 
FROM [TABELA DE PRODUTOS] WHERE 
SABOR IN ('Laranja','Uva','Limão','Morango','Morango/Limão','Lima/Limão')

-- INNER JOIN entre ela e a primeira consulta para obter os dados de vendas agrupados por estes novos departamentos.

SELECT DP.[DEPARTAMENTO]
, SUM(INF.QUANTIDADE * INF.[PREÇO]) AS FATURAMENTO
FROM [TABELA DE PRODUTOS] TP
INNER JOIN [ITENS NOTAS FISCAIS] INF
ON TP.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
INNER JOIN [NOTAS FISCAIS] NF
ON NF.NUMERO = INF.NUMERO
INNER JOIN @DEPARTAMENTO DP
ON TP.SABOR = DP.SABOR
WHERE NF.DATA >= '2015-01-01' AND NF.DATA <= '2015-12-31'
GROUP BY DP.[DEPARTAMENTO]

-- criação da SP que faça o código T-SQL acima passando como parâmetro a data inicial e final.

CREATE OR ALTER PROCEDURE faturamentoDepartamento (@dataInicial DATE, @dataFinal DATE)
AS
BEGIN
DECLARE @DEPARTAMENTO TABLE (SABOR VARCHAR(20), DEPARTAMENTO VARCHAR(20)) -- a tabela temporária (@DEPARTAMENTO) armazena os departamentos e os sabores de frutas associados a eles.
INSERT INTO @DEPARTAMENTO 
SELECT DISTINCT SABOR, 'FRUTAS NÃO CÍTRICAS' as DEPARTAMENTO 
FROM [TABELA DE PRODUTOS] WHERE 
SABOR IN ('Açai','Cereja','Cereja/Maça','Maça','Manga','Maracujá','Melância')
UNION -- as frutas são separadas em dois departamentos: "Frutas não cítricas" e "Frutas cítricas" usando o comando UNION.

/*
consulta para retornar o departamento, a quantidade vendida e o preço total para cada item em uma 
nota fiscal para o período especificado. O resultado é agrupado por departamento e a soma do preço é calculada.
*/
SELECT DISTINCT SABOR, 'FRUTAS CÍTRICAS' as DEPARTAMENTO 
FROM [TABELA DE PRODUTOS] 
WHERE SABOR IN ('Laranja','Uva','Limão','Morango','Morango/Limão','Lima/Limão')

SELECT DP.[DEPARTAMENTO], SUM(INF.QUANTIDADE * INF.[PREÇO]) AS FATURAMENTO
FROM [TABELA DE PRODUTOS] TP

INNER JOIN [ITENS NOTAS FISCAIS] INF
ON TP.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]

INNER JOIN [NOTAS FISCAIS] NF
ON NF.NUMERO = INF.NUMERO

INNER JOIN @DEPARTAMENTO DP
ON TP.SABOR = DP.SABOR
WHERE NF.DATA >= @dataInicial AND NF.DATA <= @dataFinal
GROUP BY DP.[DEPARTAMENTO]
END

-- A PROC tem dois parâmetros de entrada: @dataInicial e @dataFinal, que especificam o período de tempo para o qual o faturamento será calculado.
EXEC faturamentoDepartamento '2016-01-01','2016-01-15';
/*
OUTPUT

DEPARTAMENTO        | FATURAMENTO	
-----------------------------------
FRUTAS CÍTRICAS		| 407040,247425
FRUTAS NÃO CÍTRICAS	| 1342329,1938
*/