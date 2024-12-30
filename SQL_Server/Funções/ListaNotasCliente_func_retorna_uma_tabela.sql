-- Função retornando uma tabela | no pesquisador de objs vai estar no dir "Funções com valor de Tabela"

--SELECT * FROM [NOTAS FISCAIS] WHERE CPF = '7771579779'

-- FUNÇÃO QUE RETORNA AS NOTAS FISCAIS DE UM CPF

CREATE FUNCTION ListaNotasCliente (@CPF AS VARCHAR (11))-- CPF parâmetro de entrada da função
RETURNS TABLE
AS
RETURN SELECT * FROM [NOTAS FISCAIS] WHERE CPF = @CPF

-- usando a func
SELECT * FROM [dbo].[ListaNotasCliente]('1471156710') -- retorna a tabela com o valores relacionados ao CPF passado

SELECT COUNT (*) AS [QUANTIDADE DE NOTAS FISCAIS] FROM [dbo].[ListaNotasCliente]('1471156710')