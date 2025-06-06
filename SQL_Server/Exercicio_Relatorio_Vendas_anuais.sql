/*
 Mostrar as vendas anuais,  dos sucos de frutas por sabor. 
 Ordenando do que mais vendeu para o que menos vendeu.
 
 JOIN ENTRE ITENS_NOTAS_FISCAIS, NOTAS_FISCAIS E TABELA_DE_PRODUTOS
*/

-- VENDA POR QUANTIDADE NO DIA 
SELECT TP.SABOR,
	   NF.DATA_VENDA,
	   INF.QUANTIDADE

FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO

INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO


-- VENDA POR QTD NO ANO, FILTRANDO POR ANO (2015)
SELECT TP.SABOR,
	   YEAR (NF.DATA_VENDA) AS ANO,
	   SUM(INF.QUANTIDADE) AS VENDA_ANO

FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO

INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR (NF.DATA_VENDA) = '2015'
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
ORDER BY SUM(INF.QUANTIDADE) DESC -- ORDENAÇÃO DECRESCENTE

-- QUANTIDADE DA PARTICIPAÇÃO DA VENDA DE UM SABOR EM RELAÇÃO A VENDA TOTAL DO ANO
SELECT TP.SABOR,
	   YEAR (NF.DATA_VENDA) AS ANO,
	   SUM(INF.QUANTIDADE) AS VENDA_ANO

FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO

INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR (NF.DATA_VENDA) = '2015'
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
ORDER BY SUM(INF.QUANTIDADE) DESC


-- SELECT PARA USAR COMO SUBQUERY DE CALCULO TOTAL DE VENDAS POR ANO
SELECT
	YEAR(NF.DATA_VENDA) AS ANO,
	SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON  INF.NUMERO = NF.NUMERO
WHERE YEAR (NF.DATA_VENDA) = '2015'
GROUP BY YEAR(NF.DATA_VENDA)

-- CRIA UMA COL COM OS VALORES DE VENDA ANUAL POR SABOR
SELECT  VENDA_SABOR.SABOR,
		VENDA_SABOR.ANO,
		VENDA_SABOR.VENDA_ANO,
		VENDA_ANUAL.VENDA_TOTAL_ANO
FROM
(
	SELECT TP.SABOR,
		  YEAR (NF.DATA_VENDA) AS ANO,
		  SUM(INF.QUANTIDADE) AS VENDA_ANO

	FROM TABELA_DE_PRODUTOS TP
	INNER JOIN ITENS_NOTAS_FISCAIS INF
	ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO

	INNER JOIN NOTAS_FISCAIS NF
	ON INF.NUMERO = NF.NUMERO
	WHERE YEAR (NF.DATA_VENDA) = '2015'
	GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VENDA_SABOR
INNER JOIN

(
	SELECT
		  YEAR(NF.DATA_VENDA) AS ANO,
		  SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
		FROM NOTAS_FISCAIS NF
		INNER JOIN ITENS_NOTAS_FISCAIS INF
		ON  INF.NUMERO = NF.NUMERO
		WHERE YEAR (NF.DATA_VENDA) = '2015'
		GROUP BY YEAR(NF.DATA_VENDA)
) VENDA_ANUAL
ON VENDA_SABOR.ANO = VENDA_ANUAL.ANO
ORDER BY VENDA_SABOR.VENDA_ANO DESC -- OBS: ORDER BY NÃO PODE SER USADO DENTRO DE UMA SUBQUERY


-- PERCENTUAL DA PARTICIPAÇÃO DA VENDA DE UM SABOR EM RELAÇÃO A VENDA TOTAL DO ANO
-- (VENDA_ANO [DE CADA SABOR] / VENDA_TOTAL_ANO) * 100
SELECT  VENDA_SABOR.SABOR,
		VENDA_SABOR.ANO,
		VENDA_SABOR.VENDA_ANO,
		-- VENDA_ANUAL.VENDA_TOTAL_ANO,

		-- CONVERSÃO DE INT PARA FLOAT PQ SE NÃO A DIV DE INT DARÁ VALOR 0 NA COL PERCENTUAL. USANDO ROUND PARA AREDONDAR PARA 2 CS DECIMAIS
		CONCAT(ROUND ((CONVERT (FLOAT, VENDA_SABOR.VENDA_ANO) / CONVERT (FLOAT, VENDA_ANUAL.VENDA_TOTAL_ANO)) * 100, 2), '%') AS PERCENTUAL_SABOR
FROM
(
	SELECT TP.SABOR,
		  YEAR (NF.DATA_VENDA) AS ANO,
		  SUM(INF.QUANTIDADE) AS VENDA_ANO

	FROM TABELA_DE_PRODUTOS TP
	INNER JOIN ITENS_NOTAS_FISCAIS INF
	ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO

	INNER JOIN NOTAS_FISCAIS NF
	ON INF.NUMERO = NF.NUMERO
	WHERE YEAR (NF.DATA_VENDA) = '2015'
	GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VENDA_SABOR
INNER JOIN

(
	SELECT
		  YEAR(NF.DATA_VENDA) AS ANO,
		  SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
		FROM NOTAS_FISCAIS NF
		INNER JOIN ITENS_NOTAS_FISCAIS INF
		ON  INF.NUMERO = NF.NUMERO
		WHERE YEAR (NF.DATA_VENDA) = '2015'
		GROUP BY YEAR(NF.DATA_VENDA)
) VENDA_ANUAL
ON VENDA_SABOR.ANO = VENDA_ANUAL.ANO
ORDER BY VENDA_SABOR.VENDA_ANO DESC

/*
Durante a aula sobre vendas por sabor trabalhamos alguns assuntos e entre eles havia a presença de um relatório.

Agora, a ideia é focar neste relatório novamente, porém que você modifique o relatório tendo como objetivo ver o ranking das vendas por tamanho.


NA SUBQUERY NO LUGAR DE SABOR ANO COLOCAR O TAM. PEGANDO PELA TABELA_DE_PRODUTOS
*/

SELECT  VENDA_TAMANHO.TAMANHO,
		VENDA_TAMANHO.ANO,
		VENDA_TAMANHO.VENDA_ANO,

		-- CONVERSÃO DE INT PARA FLOAT PQ SE NÃO A DIV DE INT DARÁ VALOR 0 NA COL PERCENTUAL. USANDO ROUND PARA AREDONDAR PARA 2 CS DECIMAIS
		CONCAT(ROUND ((CONVERT (FLOAT, VENDA_TAMANHO.VENDA_ANO) / CONVERT (FLOAT, VENDA_ANUAL.VENDA_TOTAL_ANO)) * 100, 2), '%') AS PERCENTUAL_TAMANHO
FROM
(
	SELECT TP.TAMANHO,
		  YEAR (NF.DATA_VENDA) AS ANO,
		  SUM(INF.QUANTIDADE) AS VENDA_ANO

	FROM TABELA_DE_PRODUTOS TP
	INNER JOIN ITENS_NOTAS_FISCAIS INF
	ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO

	INNER JOIN NOTAS_FISCAIS NF
	ON INF.NUMERO = NF.NUMERO
	WHERE YEAR (NF.DATA_VENDA) = '2015'
	GROUP BY TP.TAMANHO, YEAR(NF.DATA_VENDA)
) VENDA_TAMANHO
INNER JOIN

(
	SELECT
		  YEAR(NF.DATA_VENDA) AS ANO,
		  SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
		FROM NOTAS_FISCAIS NF
		INNER JOIN ITENS_NOTAS_FISCAIS INF
		ON  INF.NUMERO = NF.NUMERO
		WHERE YEAR (NF.DATA_VENDA) = '2015'
		GROUP BY YEAR(NF.DATA_VENDA)
) VENDA_ANUAL
ON VENDA_TAMANHO.ANO = VENDA_ANUAL.ANO
ORDER BY VENDA_TAMANHO.VENDA_ANO DESC

----------------------------------------------------------------------------------------
-- TRAZ QUANTO CADA SABOR DE X TAMANHO VENDEU EM UM DETERMINADO ANO (2015)
SELECT TP.SABOR, TP.TAMANHO,
	   YEAR (NF.DATA_VENDA) AS ANO,
	   SUM(INF.QUANTIDADE) AS TOTAL_VENDA_ANO

FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO

INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR (NF.DATA_VENDA) = '2015'
GROUP BY TP.TAMANHO,TP.SABOR, YEAR(NF.DATA_VENDA)
-- ORDER BY SUM(INF.QUANTIDADE) DESC,
ORDER BY TP.SABOR, TP.TAMANHO;

----------------------------------------------------------------------------------------
-- PERCENTUAL EM CIMA DE CADA TAMANHO/SABOR DIFERENTE, ordenação crescente

SELECT  VENDA_SABOR.SABOR,
		VENDA_SABOR.TAMANHO,
		VENDA_SABOR.ANO,
		VENDA_SABOR.VENDA_ANO,
		--VENDA_ANUAL.VENDA_TOTAL_ANO,

		-- CONVERSÃO DE INT PARA FLOAT PQ SE NÃO A DIV DE INT DARÁ VALOR 0 NA COL PERCENTUAL. USANDO ROUND PARA AREDONDAR PARA 2 CS DECIMAIS
		CONCAT(ROUND ((CONVERT (FLOAT, VENDA_SABOR.VENDA_ANO) / CONVERT (FLOAT, VENDA_ANUAL.VENDA_TOTAL_ANO)) * 100, 2), '%') AS PERCENTUAL_SABOR_TAMANHO
FROM
(
	SELECT TP.SABOR, TP.TAMANHO,
		  YEAR (NF.DATA_VENDA) AS ANO,
		  SUM(INF.QUANTIDADE) AS VENDA_ANO

	FROM TABELA_DE_PRODUTOS TP
	INNER JOIN ITENS_NOTAS_FISCAIS INF
	ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO

	INNER JOIN NOTAS_FISCAIS NF
	ON INF.NUMERO = NF.NUMERO
	WHERE YEAR (NF.DATA_VENDA) = '2015'
	GROUP BY TP.SABOR, TP.TAMANHO, YEAR(NF.DATA_VENDA)
) VENDA_SABOR
INNER JOIN

(
	SELECT
		  YEAR(NF.DATA_VENDA) AS ANO,
		  SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
		FROM NOTAS_FISCAIS NF
		INNER JOIN ITENS_NOTAS_FISCAIS INF
		ON  INF.NUMERO = NF.NUMERO
		WHERE YEAR (NF.DATA_VENDA) = '2015'
		GROUP BY YEAR(NF.DATA_VENDA)
) VENDA_ANUAL
ON VENDA_SABOR.ANO = VENDA_ANUAL.ANO
ORDER BY VENDA_SABOR.SABOR, VENDA_SABOR.TAMANHO;

/*
-- Mesma consulta usando CTE (Common Table Expression)

CTE (WITH TOTAL_VENDAS_ANO):
Calcula o total geral de vendas (soma de todas as quantidades) para o ano de 2015.
Essa subquery simplifica o acesso ao valor total geral de vendas.

-- CALCULAR O PERCENTUAL DE VENDAS POR TAMANHO/SABOR EM RELAÇÃO AO TOTAL
*/

WITH TOTAL_VENDAS_ANO AS (
    SELECT SUM(INF.QUANTIDADE) AS TOTAL_GERAL_ANO
    FROM ITENS_NOTAS_FISCAIS INF
    INNER JOIN NOTAS_FISCAIS NF ON INF.NUMERO = NF.NUMERO
    WHERE YEAR(NF.DATA_VENDA) = '2015'
)
SELECT 
    TP.SABOR, 
    TP.TAMANHO,
    YEAR(NF.DATA_VENDA) AS ANO,
    SUM(INF.QUANTIDADE) AS TOTAL_VENDA_ANO,
    CONCAT(ROUND(
        (CAST(SUM(INF.QUANTIDADE) AS FLOAT) / (SELECT TOTAL_GERAL_ANO FROM TOTAL_VENDAS_ANO)) * 100, 2), '%') AS PERCENTUAL_VENDAS
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = '2015'
GROUP BY TP.TAMANHO, TP.SABOR, YEAR(NF.DATA_VENDA)
ORDER BY TP.SABOR, TP.TAMANHO;
