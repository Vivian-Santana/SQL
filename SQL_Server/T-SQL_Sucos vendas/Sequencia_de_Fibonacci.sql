/* calculo da sequência de Fibonacci, imprimindo os valores junto com suas respectivas posições, 
e para de calcular quando atinge um limite máximo de 100 ou quando completa 20 posições na sequência. */

--Nesse caso, o valor 144 é o último número da sequência e 13 é sua posição.
DECLARE @NUMERO_ANTERIOR2 INT;
DECLARE @NUMERO_ANTERIOR1 INT;
DECLARE @NUMERO_ATUAL INT;
DECLARE @SEQUENCIA INT;
DECLARE @LIMITE_MAXIMO INT;
DECLARE @CONTADOR_SEQUENCIA INT;

SET @LIMITE_MAXIMO = 100; -- Limite máximo da sequência
SET @SEQUENCIA = 20; -- Número máximo de posições
SET @CONTADOR_SEQUENCIA = 3; -- Começa a partir da terceira posição

SET @NUMERO_ANTERIOR2 = 0; -- Primeiro número de Fibonacci
SET @NUMERO_ANTERIOR1 = 1; -- Segundo número de Fibonacci
PRINT 'POSIÇÃO 1 --> 0';
PRINT 'POSIÇÃO 2 --> 1';
WHILE @CONTADOR_SEQUENCIA <= @SEQUENCIA
BEGIN
   SET @NUMERO_ATUAL = @NUMERO_ANTERIOR2 + @NUMERO_ANTERIOR1;
   PRINT 'POSIÇÃO ' + TRIM(STR(@CONTADOR_SEQUENCIA,10,0)) + ' --> ' + TRIM(STR(@NUMERO_ATUAL, 10,0));
   -- Verifica se atingiu o limite máximo antes de imprimir o valor atual
   IF @NUMERO_ATUAL > @LIMITE_MAXIMO 
   BREAK;

   SET  @NUMERO_ANTERIOR2 = @NUMERO_ANTERIOR1;
   SET @NUMERO_ANTERIOR1 = @NUMERO_ATUAL;
   SET @CONTADOR_SEQUENCIA = @CONTADOR_SEQUENCIA + 1;
END;

-- vai até 144 posição 13