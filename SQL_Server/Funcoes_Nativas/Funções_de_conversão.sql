-- Funções de conversão
-- EXIBE DT DE ATUAL CONVERTIDA PARA VARCHAR
SELECT CONVERT(VARCHAR (25), GETDATE(), 121) -- MÁSCARA 121 COVERTE DT PARA aaa-mm-dd hh:mi:ss.mmm (formato 24h)

SELECT * FROM TABELA_DE_CLIENTES
-- CONVERTA AS DTS DE NASC MAS NÃO MOSTRA HORA MIN E SEG PQ O TIPO DA COL DATA NÃO É DATE NÃO DATE TIME
SELECT DATA_DE_NASCIMENTO, CONVERT(VARCHAR(25), DATA_DE_NASCIMENTO,121) 
FROM TABELA_DE_CLIENTES

-- MASCARA 106 DD + (NOME DO MES ABREVIADO) + AAAA
SELECT DATA_DE_NASCIMENTO, CONVERT(VARCHAR(25), DATA_DE_NASCIMENTO,106) 
FROM TABELA_DE_CLIENTES

-- CONCATENANDO UM CAMPO COM UM TEXTO REALISA UMA CONVERÇÃO IMPLICITA DO CAMPO FLOAT PARA VARCHAR
SELECT NOME_DO_PRODUTO, CONCAT('O PREÇO DE LISTA É: ', PRECO_DE_LISTA) AS PRECO
FROM TABELA_DE_PRODUTOS;

-- CONVERÇÃO EXPLICITA
SELECT NOME_DO_PRODUTO, CONCAT('O PREÇO DE LISTA É - ', CAST(PRECO_DE_LISTA AS VARCHAR(10))) AS PRECO
FROM TABELA_DE_PRODUTOS;

/*
Queremos construir um SQL cujo resultado seja para cada cliente:

"O cliente João da Silva comprou R$ 121222,12 no ano de 2016".
Faça isso somente para o ano de 2016.
*/ 

-- INNER JOIN LIGAR NOTA FISCAIS COM ITENS NOTAS FISCAIS PELO CAMPO NUMERO
-- E NOTA FISCAIS UNE COM TABELA_DE_CLIENTES PELO CAMPO CPF
SELECT * FROM TABELA_DE_CLIENTES
SELECT * FROM ITENS_NOTAS_FISCAIS
SELECT * FROM NOTAS_FISCAIS

SELECT TC.NOME, CONCAT('O CLIENTE', TC.NOME, ' COMPROU R$ ',
TRIM(STR(SUM(IT.QUANTIDADE * IT.PRECO) ,10,2)), ' NO ANO DE ', YEAR(NF.DATA_VENDA), '.') AS VALOR
/*
Calcula o total gasto por cada cliente somando o valor de todos os produtos comprados, 
que é a multiplicação da quantidade pelo preço de cada item.

STR(SUM(...), 10, 2): Converte o total gasto para uma string com no máximo 
10 caracteres e 2 casas decimais. 

TRIM: Remove espaços extras gerados pela função STR
YEAR(NF.DATA_VENDA): Extrai o ano da data de venda
*/

FROM NOTAS_FISCAIS AS NF
INNER JOIN ITENS_NOTAS_FISCAIS AS IT -- junta as notas fiscais com seus respectivos itens
			ON NF.NUMERO = IT.NUMERO

INNER JOIN TABELA_DE_CLIENTES AS TC -- Junta as notas fiscais com os clientes que fizeram as compras
			ON NF.CPF = TC.CPF

WHERE YEAR(NF.DATA_VENDA) = '2015'
GROUP BY TC.NOME, YEAR(NF.DATA_VENDA);
/*
Agrupamento por cliente (TC.NOME) e ano da venda (YEAR(NF.DATA_VENDA)
garante que o cálculo do total de compras seja feito separadamente 
para cada cliente no ano de 2015

uma das linhas de saída:
  | NOME	   | VALOR
1 | Abel Silva | O CLIENTE Abel Silva COMPROU R$ 34898.78 NO ANO DE 2015.
*/