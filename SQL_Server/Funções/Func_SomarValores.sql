
-- FUNÇÃO
CREATE FUNCTION dbo.SomarValores()-- A função calcula a soma dos valores de uma coluna específica de uma tabela passada como parâmetro.

RETURNS @Resultado TABLE (
    SomaTotal FLOAT
)
AS
BEGIN
    -- Adicionar a soma total à tabela de retorno
    INSERT INTO @Resultado (SomaTotal)
    SELECT SUM(valor) AS SomaTotal
    FROM TABELA_DE_VALORES;

    RETURN;
END;
GO

CREATE TABLE TABELA_DE_VALORES (valor INT);
INSERT INTO TABELA_DE_VALORES (valor)
VALUES (10), (20), (30);

SELECT * FROM dbo.SomarValores();


--CREATE FUNCTION SomaValores (@tabela AS table (valor INT))
--RETURNS TABLE
--AS
--BEGIN
--    DECLARE @soma FLOAT
--    SET @soma = 0
--    SELECT @soma = SUM(valor)
--    FROM @tabela
--    RETURN @soma
--END

--DECLARE @tabela AS table (valor INT)

--INSERT INTO @tabela (valor)
--VALUES (10), (20), (30)

--SELECT dbo.SomaValores (@tabela)
