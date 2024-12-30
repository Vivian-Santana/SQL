-- Deletando uma função
CREATE FUNCTION EnderecoCompleto_2
( -- PARÂMETROS
@ENDERCO VARCHAR (100),
@BAIRRO VARCHAR (50),
@CIDADE VARCHAR (100),
@ESTADO VARCHAR (20),
@CEP VARCHAR (20)
)
RETURNS VARCHAR (250)
AS

BEGIN
	DECLARE @ENDERECO_COMPLETO VARCHAR(250)
	SET @ENDERECO_COMPLETO = @ENDERCO + ' - ' + @BAIRRO + ' - ' + @CIDADE + ' - ' + @ESTADO + ' - ' + @CEP
	RETURN @ENDERECO_COMPLETO
END

-- DROP FUNCTION [dbo].[EnderecoCompleto_2] -- apaga a func

-- Cria uma condição para apagar se a func existir
IF OBJECT_ID('EnderecoCompleto_2', 'FN') IS NOT NULL
DROP FUNCTION [dbo].[EnderecoCompleto_2]