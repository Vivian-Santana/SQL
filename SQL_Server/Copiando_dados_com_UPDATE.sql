-- COPIANDO DADOS DE UMA TABELA PARA OUTRA DE BASES DIFERENTES USANDO UPDATE

-- BASE VENDAS SUCOS 2
SELECT * FROM PRODUTOS ORDER BY CODIGO

SELECT * FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS ORDER BY CODIGO_DO_PRODUTO

-- ALTERANDO TDS OS PREÇOS, AUMENTANDO 20% PARA DEIXAR OS PREÇOS DAS TBS <>
UPDATE SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS SET 
PRECO_DE_LISTA = PRECO_DE_LISTA * 1.20;

SELECT 
A.CODIGO AS CODIGO_MINHA_TABELA, A.PRECO_LISTA AS PRECO_MINHA_TABELA,
B.CODIGO_DO_PRODUTO AS CODIGO_TABELA_APOIO, B.PRECO_DE_LISTA AS PRECO_TABELA_APOIO
FROM PRODUTOS A 
INNER JOIN SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS B 
ON A.CODIGO = B.CODIGO_DO_PRODUTO;

-- UPDATE USANDO INNER JOIN PARA IGUALAR CAMPOS DE TABELAS DIFERENTES
UPDATE A SET A.PRECO_LISTA = B.PRECO_DE_LISTA
FROM PRODUTOS A 
INNER JOIN SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS B 
ON A.CODIGO = B.CODIGO_DO_PRODUTO;

-------------------------------------------------------------------------
/*
Podemos observar que os vendedores possuem bairros associados a eles. 
Vamos aumentar em 30% o volume de compra dos clientes que possuem, 
em seus endereços, bairros onde os vendedores possuam escritórios.
*/

--SELECT PARA BUSCAR OS BAIRROS EM COMUM ENTRE VENDEDORES E CLIENTES
SELECT C.[BAIRRO] AS BAIRRO_CLIENTE, 
	   V.[BAIRRO] AS BAIRRO_VENDEDOR, 
	   VOLUME_DE_COMPRA AS VOL_COMPRA  
FROM SUCOS_FRUTAS.DBO.TABELA_DE_CLIENTES C 
INNER JOIN SUCOS_FRUTAS.DBO.TABELA_DE_VENDEDORES V
ON V.[BAIRRO] = C.[BAIRRO]

UPDATE C SET C.VOLUME_DE_COMPRA = C.VOLUME_DE_COMPRA * 1.30
FROM SUCOS_FRUTAS.DBO.TABELA_DE_CLIENTES C 
INNER JOIN SUCOS_FRUTAS.DBO.TABELA_DE_VENDEDORES V
ON C.[BAIRRO] = V.[BAIRRO]
