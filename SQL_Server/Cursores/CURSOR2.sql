-- CURSOR QUE TRAZ DUAS COLUNAS: NOME E ENDERÇO COMPLETO DA TB DE CLIENTES
DECLARE @NOME VARCHAR(200)
DECLARE @ENDERECO VARCHAR(MAX)

DECLARE CURSOR2 CURSOR FOR
SELECT NOME, ([ENDERECO 1] 
				+ ', ' + BAIRRO 
				+ ' - ' + CIDADE 
				+ ' ' + ESTADO 
				+ ', CEP: ' + CEP) ENDEREÇO_COMPLETO

FROM [TABELA DE CLIENTES]
OPEN CURSOR2
FETCH NEXT FROM CURSOR2 INTO @NOME, @ENDERECO
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @NOME + ', Endereço: ' + @ENDERECO
    FETCH NEXT FROM CURSOR2 INTO @NOME, @ENDERECO
END
CLOSE CURSOR2
DEALLOCATE CURSOR2