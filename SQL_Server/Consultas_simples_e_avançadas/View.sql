/*
Uma view, ou visão, é uma tabela virtual no banco de dados que resulta de uma consulta SQL. 
Ela permite que você salve uma consulta complexa com um nome, podendo ser utilizada posteriormente 
como se fosse uma tabela real. As views são úteis para simplificar consultas, reutilizar lógicas 
de seleção e organizar dados de forma mais acessível. No entanto, é importante lembrar que as views 
têm uma performance inferior em comparação com consultas diretas em tabelas, pois não armazenam 
dados fisicamente, apenas representam uma relação lógica.
*/
-- SELECT * FROM MEDIA_EMBALAGENS


CREATE VIEW MEDIA_EMBALAGENS AS
SELECT EMBALAGEM, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO 
FROM TABELA_DE_PRODUTOS 
GROUP BY EMBALAGEM;

-- consulta usando a view
SELECT EMBALAGEM, PRECO_MEDIO FROM MEDIA_EMBALAGENS -- a visão pode ser usada em outras subquerys e consultas
WHERE PRECO_MEDIO <= 10;

-- a view MEDIA_EMBALAGENS traz o mesmo resultado desse select
SELECT MEDIA_EMBALAGENS.EMBALAGEM, MEDIA_EMBALAGENS.PRECO_MEDIO FROM (
    SELECT EMBALAGEM, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO 
    FROM TABELA_DE_PRODUTOS 
    GROUP BY EMBALAGEM
) MEDIA_EMBALAGENS 
WHERE MEDIA_EMBALAGENS.PRECO_MEDIO <= 10;

----------------------------------------------------------------------------------------
/* 
Veja a consulta abaixo que foi resposta de um exercício anterior.

SELECT INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO, SUM(INF.QUANTIDADE) AS QUANTIDADE FROM ITENS_NOTAS_FISCAIS  INF
INNER JOIN TABELA_DE_PRODUTOS TP 
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
GROUP BY INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO HAVING SUM(INF.QUANTIDADE) > 394000 -- (SUBSTITUI POR 1000)
ORDER BY SUM(INF.QUANTIDADE) DESC;

Redesenhe esta consulta criando uma visão para a lista de quantidades totais 
por produto e aplicando a condição e ordenação sobre esta mesma visão.
*/

CREATE VIEW VW_QUANTIDADE_PRODUTOS AS

SELECT INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO,

SUM(INF.QUANTIDADE) AS QUANTIDADE_TOTAL FROM ITENS_NOTAS_FISCAIS  INF
INNER JOIN TABELA_DE_PRODUTOS TP 

ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
GROUP BY INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO;

-- consulta usando a view
SELECT * FROM VW_QUANTIDADE_PRODUTOS
WHERE QUANTIDADE_TOTAL > 1000 
ORDER BY QUANTIDADE_TOTAL DESC;
