-- O for não existe em T-SQL mas podemos usar o while para simular um for
/*
for (inicialização; condição; incremento)

for (int indice = 1; indice <= 100; indice++) {
            System.out.println(indice);
        }
*/
DECLARE @INDICE INT;

SET @INDICE = 1; -- inicialização

WHILE @INDICE <= 100 -- condição
BEGIN
	PRINT @INDICE;
	SET @INDICE = @INDICE +1; -- incremento
END

-------------------------------------------
-- for decrescente
DECLARE @NUM INT;

SET @NUM = 10

WHILE @NUM >= 1
	BEGIN
		PRINT @NUM;
		SET @NUM = @NUM -1;
	END