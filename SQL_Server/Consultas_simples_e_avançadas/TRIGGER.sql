--TRIGGER
--BASE SUCOS_FRUTAS

-- CRIANDO TB DE FATURAMENTO
CREATE TABLE TB_FATURAMENTO
(
DT_VENDA DATE NULL,
TOTAL_VENDA FLOAT
);

-- [SUCOS_FRUTAS].[dbo].[NOTAS_FISCAIS] = TB DE VENDAS
-- [SUCOS_FRUTAS].[dbo].[ITENS_NOTAS_FISCAIS] = TB DE INTENS VENDIDOS

SELECT
TV.DATA_VENDA,
SUM (TIV.QUANTIDADE * TIV.PRECO) AS TOTAL_VENDA
FROM NOTAS_FISCAIS TV
INNER JOIN ITENS_NOTAS_FISCAIS TIV
ON TV.NUMERO = TIV.NUMERO
GROUP BY TV.DATA_VENDA


-- INSERIR NOVA VENDA

--SELECT * FROM TABELA_DE_VENDEDORES WHERE MATRICULA = '00237';
--SELECT * FROM TABELA_DE_CLIENTES WHERE CPF = '1471156710'
--SELECT * FROM NOTAS_FISCAIS ORDER BY NUMERO DESC --NUM NOTAS EXISTENTES 100 -> 610

INSERT INTO NOTAS_FISCAIS
(NUMERO, DATA_VENDA, CPF, MATRICULA, IMPOSTO)
VALUES (
    '0611', '15-05-2018', '1471156710', '00237',0.18
);

--SELECT * FROM TABELA_DE_PRODUTOS WHERE CODIGO_DO_PRODUTO = '1000889'

INSERT INTO ITENS_NOTAS_FISCAIS
(NUMERO, CODIGO_DO_PRODUTO, QUANTIDADE, PRECO )
VALUES (
    '0611', '1000889', 100, 9.08
);

--SELECT * FROM NOTAS_FISCAIS WHERE CPF = '1471156710' AND DATA_VENDA = '2018-05-15'
--SELECT * FROM ITENS_NOTAS_FISCAIS WHERE NUMERO =  '0611'


-- INSERT TB RELATORIO DE VENDAS
INSERT INTO TB_FATURAMENTO
SELECT
TV.DATA_VENDA,
SUM (TIV.QUANTIDADE * TIV.PRECO) AS TOTAL_VENDA
FROM NOTAS_FISCAIS TV
INNER JOIN ITENS_NOTAS_FISCAIS TIV
ON TV.NUMERO = TIV.NUMERO
GROUP BY TV.DATA_VENDA

SELECT * FROM TB_FATURAMENTO ORDER BY DT_VENDA DESC -- VAI APARECER A NOVA VENDA

-- ********** SEMPRE QUE ENTRAR UMA NOVA VENDA A TB_FATURAMENTO TEM QUE SER ATUALIZADA ***********

SELECT * FROM TB_FATURAMENTO ORDER BY DT_VENDA DESC

--NOVA VENDA
INSERT INTO NOTAS_FISCAIS
(NUMERO, DATA_VENDA, CPF, MATRICULA, IMPOSTO)
VALUES (
    '0614', '16-05-2018', '1471156710', '00237',0.18
);

INSERT INTO ITENS_NOTAS_FISCAIS
(NUMERO, CODIGO_DO_PRODUTO, QUANTIDADE, PRECO )
VALUES (
    '0614', '1000889', 100, 9.08
);
--NOVA VENDA

DELETE FROM TB_FATURAMENTO -- APAGAR A TB EVITA DUPLICAR OS MESMOS CAMPOS A CADA NOVO INSERT

INSERT INTO TB_FATURAMENTO
SELECT
TV.DATA_VENDA,
SUM (TIV.QUANTIDADE * TIV.PRECO) AS TOTAL_VENDA
FROM NOTAS_FISCAIS TV
INNER JOIN ITENS_NOTAS_FISCAIS TIV
ON TV.NUMERO = TIV.NUMERO
GROUP BY TV.DATA_VENDA

SELECT * FROM TB_FATURAMENTO ORDER BY DT_VENDA DESC

-- ############################ SENSIBILIZAR A TB_FATURAMENTO COM TRIGGER ############################

CREATE TRIGGER TG_ITENS_VENDIDOS
ON ITENS_NOTAS_FISCAIS -- TB Q TEM Q SER VIGIADA PARA EXEC A TRIGGER
AFTER INSERT, UPDATE, DELETE -- O MOMENTO Q A TRIGGER VAI SER RODADA
AS
BEGIN
-- COMANDOS A SEREM EXEC NA TRIGGER
DELETE FROM TB_FATURAMENTO

INSERT INTO TB_FATURAMENTO
SELECT
TV.DATA_VENDA,
SUM (TIV.QUANTIDADE * TIV.PRECO) AS TOTAL_VENDA
FROM NOTAS_FISCAIS TV
INNER JOIN ITENS_NOTAS_FISCAIS TIV
ON TV.NUMERO = TIV.NUMERO
GROUP BY TV.DATA_VENDA

END;


-- TESTANDO A TRIGGER COM UMA NOVA VENDA

INSERT INTO NOTAS_FISCAIS
(NUMERO, DATA_VENDA, CPF, MATRICULA, IMPOSTO)
VALUES (
    '0615', '16-05-2018', '1471156710', '00237',0.18
);

INSERT INTO ITENS_NOTAS_FISCAIS
(NUMERO, CODIGO_DO_PRODUTO, QUANTIDADE, PRECO )
VALUES (
    '0615', '1000889', 150, 9.08
);

-- UPDATE
UPDATE ITENS_NOTAS_FISCAIS SET QUANTIDADE = 200 WHERE NUMERO = '0615'

-- DELETE
DELETE FROM ITENS_NOTAS_FISCAIS WHERE NUMERO = '0615'

SELECT * FROM TB_FATURAMENTO ORDER BY DT_VENDA DESC

-- ESSA TRIGGER AUTOMATIZA O PROCESSO DE INCLUSAO, MODIFICAO E EXCLUSAO NA TB_FATURAMENTO

