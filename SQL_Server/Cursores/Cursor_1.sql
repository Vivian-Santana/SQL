-- Cursor imprime as 4 linhas da coluna nome da tabela de clientes da base SUCOS_VENDAS
-- Declaração
DECLARE @NOME VARCHAR(200)
DECLARE CURSOR1 
CURSOR FOR SELECT TOP 4 NOME 
FROM [TABELA DE CLIENTES]

OPEN CURSOR1 -- habilita a variável
FETCH NEXT FROM CURSOR1 INTO @NOME -- ponteiro que aponta para cada linha do cursor
WHILE @@FETCH_STATUS = 0 -- While percorrer todas as linhas do CURSOR, @@FETCH_STATUS controla o loop com uma condição de saída.
BEGIN
    PRINT @NOME -- imprime os dados
    FETCH NEXT FROM CURSOR1 INTO @NOME --lê os dados sequencialmente
END

CLOSE CURSOR1;
DEALLOCATE CURSOR1;
/*
Como o CURSOR retorna apenas uma coluna, a posição 1 dessa tabela ("nome de um cliente"), 
será passada para a variável @NOME, por isso ela precisou ser declarada antes como um VARCHAR de 200.
Ao fazer o primeiro FETCH, o conteúdo da variável @NOME será o nome do primeiro cliente da tabela.

O FETCH, é um comando que percorre um cursor, que é um conjunto de dados já selecionado e carregado 
na memória. Imagine que o cursor é uma lista de resultados, e o FETCH é como um ponteiro que se move 
ao longo dessa lista, apontando para cada elemento (linha) sequencialmente. A cada FETCH, 
você obtém o próximo elemento da lista.

A variável @@FETCH_STATUS é uma variável do sistema no SQL Server. Ela indica o status da última 
operação FETCH executada em um cursor.  O valor 0 significa que a operação FETCH foi bem-sucedida 
e que há mais linhas para serem processadas.  Qualquer outro valor indica que o final do cursor 
foi alcançado ou que ocorreu um erro. Nesse cursor, o WHILE @@FETCH_STATUS = 0 garante que o 
loop WHILE continue a executar enquanto houverem linhas no cursor CURSOR1 para serem lidas.  
Quando o FETCH chega ao final do cursor, @@FETCH_STATUS recebe um valor diferente de 0, 
e o loop para, evitando um loop infinito.
*/