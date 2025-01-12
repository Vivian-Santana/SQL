-- BASE SUCOS_FRUTAS
SELECT DISTINCT
	TC.CPF AS CPF_DO_CADASTRO
	,TC.NOME AS NOME_DO_CLIENTE
	,NF.CPF AS CPF_DA_NOTA

-- JUNÇÃO TB DE CLIETNES + TB NOTAS FISCAIS PELO CAMPO CPF
FROM TABELA_DE_CLIENTES TC
INNER JOIN
NOTAS_FISCAIS NF
ON TC.CPF = NF.CPF
ORDER BY TC.NOME

SELECT COUNT(*) FROM TABELA_DE_CLIENTES

-- INSERIR UM CLIENTE SEM VENDA
INSERT INTO TABELA_DE_CLIENTES 
(CPF, NOME, ENDERECO_1, ENDERECO_2,BAIRRO, CIDADE, ESTADO, CEP, DATA_DE_NASCIMENTO, IDADE, GENERO,
LIMITE_DE_CREDITO, VOLUME_DE_COMPRA, PRIMEIRA_COMPRA)
VALUES ('23412632331', 'Juliana Silva', 'Rua Tramandaí', ' ', 'Bangu', 'Rio de
Janeiro', 'RJ', '23400000', '1989-02-04', 33, 'F', '180000', '24500', 0);

-- TRAZ TDS OS CLIENTES E OS QUE NÃO COMPRARAM NO CAMPO CPF_DA_NOTA APARECEM SEM VALOR
SELECT DISTINCT
	TC.CPF AS CPF_DO_CADASTRO
	,TC.NOME AS NOME_DO_CLIENTE
	,NF.CPF AS CPF_DA_NOTA

FROM TABELA_DE_CLIENTES TC LEFT JOIN NOTAS_FISCAIS NF
ON TC.CPF = NF.CPF
ORDER BY TC.NOME

SELECT COUNT(*) FROM TABELA_DE_CLIENTES

-- TRAZ APENAS OS CLIENTES QUE NÃO COMPRARAM NADA
SELECT DISTINCT
	TC.CPF AS CPF_DO_CADASTRO
	,TC.NOME AS NOME_DO_CLIENTE
	,NF.CPF AS CPF_DA_NOTA
FROM TABELA_DE_CLIENTES TC LEFT JOIN NOTAS_FISCAIS NF
ON TC.CPF = NF.CPF
WHERE NF.CPF IS NULL