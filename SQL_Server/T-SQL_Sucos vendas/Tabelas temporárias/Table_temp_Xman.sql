-- tabelas temporárias
/*
São criadas em memória e ficam armazenadas enquanto o servidor do banco estiver ativo, são excluídas quando ele é derrubado

# apenas para a instancia q estou (CONEXÃO | QUERY)

## aparece em tds as coneções

@ só vale durante um conjunto de comandos T-SQL q estiverem sendo executados
*/
-- só essa conexão
CREATE TABLE #X_MAN (ID VARCHAR(10), NOME VARCHAR(30));
INSERT INTO #X_MAN VALUES ('1','Wolverine');
INSERT INTO #X_MAN VALUES ('2','Mística');
SELECT * FROM #X_MAN;

SELECT * FROM ##AVENGERS;

INSERT INTO ##AVENGERS VALUES ('3','Natasha Romanoff');