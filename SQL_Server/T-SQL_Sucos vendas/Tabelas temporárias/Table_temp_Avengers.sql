SELECT * FROM #X_MAN; --impossivel consultar fora da conexão
-- todas as conexões
CREATE TABLE ##AVENGERS (ID VARCHAR(10), NOME VARCHAR(30));
INSERT INTO ##AVENGERS VALUES ('1','Tony Stark');
INSERT INTO ##AVENGERS VALUES ('2','Steve Rogers');

INSERT INTO #X_MAN VALUES ('3','Tempestade'); -- impossivel inserir valores fora da conexão
SELECT * FROM ##AVENGERS;