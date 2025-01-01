/*
A procedure faz uma consulta na tabela [NOTAS FISCAIS] para buscar registros associados 
a um determinado cliente (identificado pelo CPF) dentro de um intervalo de datas especificado.
*/
--SELECT * FROM [NOTAS FISCAIS]

CREATE PROCEDURE BuscaNotasCliente

-- DECLARA OS PARÂMETROS (ESCALARES) E JÁ INICIALIZA AO MESMO TEMPO
@CPF AS VARCHAR(11) = '7771579779',
@DATA_INICIAL AS DATETIME = '20150101',
@DATA_FINAL AS DATETIME = '20161231'

AS 
BEGIN
	SELECT * FROM [NOTAS FISCAIS] WHERE CPF = @CPF
	AND DATA >= @DATA_INICIAL AND DATA <= @DATA_FINAL;
END;

EXEC BuscaNotasCliente
EXEC BuscaNotasCliente '7771579779','20150101'
EXEC BuscaNotasCliente @CPF = '7771579779', @DATA_INICIAL = '20150101', @DATA_FINAL = '20160615'

