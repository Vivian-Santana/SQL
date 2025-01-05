-- BASE SUCOS_FRUTAS 
-- 09 HAVING para filtrar campos agregados
SELECT * FROM TABELA_DE_CLIENTES

-- AGREGANDO LIM DE CREDITO
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS CREDITO
FROM TABELA_DE_CLIENTES
GROUP BY ESTADO;

-- LISTAR O ESTADO CUJA SOMA DE LIM DE CREDITO É > 900.000
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS CREDITO
FROM TABELA_DE_CLIENTES
GROUP BY ESTADO
HAVING SUM(LIMITE_DE_CREDITO) >= 900000;

-- ******************* USANDO MAX E MIN *******************
-- > E < PREÇO DE TDS OS SUCOS POR TIPO DE EMBALAGEM
SELECT EMBALAGEM, MAX (PRECO_DE_LISTA) AS PRECO_MAX, 
				  MIN(PRECO_DE_LISTA) AS PRECO_MIN
FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM;

-- > E < PREÇO DE SUCOS ACIMA DE 10R$
SELECT EMBALAGEM, MAX (PRECO_DE_LISTA) AS PRECO_MAX, 
				  MIN(PRECO_DE_LISTA) AS PRECO_MIN
FROM TABELA_DE_PRODUTOS
WHERE PRECO_DE_LISTA >= 10
GROUP BY EMBALAGEM;

-- PREÇO DE SUCOS ACIMA DE 20R$
SELECT EMBALAGEM, MAX (PRECO_DE_LISTA) AS PRECO_MAX, 
				  MIN(PRECO_DE_LISTA) AS PRECO_MIN
FROM TABELA_DE_PRODUTOS
WHERE PRECO_DE_LISTA >= 10
GROUP BY EMBALAGEM
HAVING MAX(PRECO_DE_LISTA) >= 20;

/*
Vamos voltar aos itens das notas fiscais. Os dois exercícios anteriores 
olharam as vendas do produto '1101035'. Mas nossa empresa vendeu mais produtos. 
Verifique as quantidades totais de vendas de cada produto e ordene do maior para o menor.
*/

SELECT CODIGO_DO_PRODUTO, SUM(QUANTIDADE) AS QUANTIDADE_TOTAL 
FROM ITENS_NOTAS_FISCAIS
GROUP BY CODIGO_DO_PRODUTO
ORDER BY SUM(QUANTIDADE) DESC;

/*
Vimos os produtos mais vendidos no exercício anterior. 
Agora, liste somente os produtos que venderam mais que 394000 unidades.
*/
SELECT CODIGO_DO_PRODUTO, SUM(QUANTIDADE) AS QUANTIDADE FROM ITENS_NOTAS_FISCAIS 
GROUP BY CODIGO_DO_PRODUTO HAVING SUM(QUANTIDADE) > 394000 
ORDER BY SUM(QUANTIDADE) DESC;