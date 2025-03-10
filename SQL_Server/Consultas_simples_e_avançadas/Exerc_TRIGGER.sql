--O SQL abaixo calcula a idade em anos baseado na data atual:
-- BASE [SUCOS_FRUTAS]

SELECT [CPF], [IDADE], [DATA_DE_NASCIMENTO], 
    DATEDIFF(YEAR, [DATA_DE_NASCIMENTO], GETDATE()) 
FROM TABELA_DE_CLIENTES

--Levando em consideração a situação posta acima: construa uma TRIGGER, de nome TG_CLIENTES_IDADE, 
--que atualize as idades dos clientes, na tabela de clientes, toda vez que a tabela sofrer uma inclusão, alteração ou exclusão.

CREATE TRIGGER TG_CLIENTES_IDADE
ON TABELA_DE_CLIENTES -- TB Q TEM Q SER VIGIADA PARA EXEC A TRIGGER
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

UPDATE TABELA_DE_CLIENTES 
SET IDADE = DATEDIFF(YEAR, [DATA_DE_NASCIMENTO], GETDATE()) 

END;

--TESTE
SELECT * FROM TABELA_DE_CLIENTES

UPDATE TABELA_DE_CLIENTES SET ENDERECO_1 = 'Avenida Atlântica' WHERE CPF = '95939180787' -- JÁ DISPAROU A TRIGGER ATUALIZANDO A IDADE DE TODOS OS CLIENTES

SELECT [CPF], [IDADE], [DATA_DE_NASCIMENTO] FROM TABELA_DE_CLIENTES
