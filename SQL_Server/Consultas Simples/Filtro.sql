-- Base SUCOS_FRUTAS
SELECT * FROM TABELA_DE_PRODUTOS

-- filtro where
-- TRAZ DADOS DO PRODUTO FILTRANDO PELO CODIGO
SELECT * FROM TABELA_DE_PRODUTOS
WHERE CODIGO_DO_PRODUTO = '290478';

-- FILTRANDO PELA COL SABOR
SELECT * FROM TABELA_DE_PRODUTOS
WHERE SABOR = 'LARANJA'

-- FILTRANDO PELA COL EMBALAGEM
SELECT * FROM TABELA_DE_PRODUTOS
WHERE EMBALAGEM = 'PET'

-- USANDO 2 COL PARA FILTRAR
SELECT * FROM TABELA_DE_PRODUTOS
WHERE EMBALAGEM = 'PET' AND TAMANHO = '1 LITRO'

-- filtrando por embalagem e tamanho
SELECT CODIGO_DO_PRODUTO, NOME_DO_PRODUTO, EMBALAGEM, TAMANHO FROM TABELA_DE_PRODUTOS
WHERE EMBALAGEM = 'PET' AND TAMANHO = '1 LITRO'

-- filtrando por sabor embalagem e tamanho
SELECT NOME_DO_PRODUTO, PRECO_DE_LISTA
FROM TABELA_DE_PRODUTOS
WHERE SABOR = 'UVA' AND EMBALAGEM = 'Garrafa' AND TAMANHO = '700 ML'

-- **************** filtros quantitativos ****************

-- filtra tds os clientes maiores de 20a
SELECT * FROM TABELA_DE_CLIENTES 
WHERE IDADE > 20

-- filtra tds os clientes menores de 20a
SELECT * FROM TABELA_DE_CLIENTES 
WHERE IDADE < 20

-- filtra tds os clientes com idade igual ou menor que 18
SELECT * FROM TABELA_DE_CLIENTES 
WHERE IDADE <= 18

--
-- filtra tds os clientes com idade diferete de 18
SELECT NOME, IDADE FROM TABELA_DE_CLIENTES 
WHERE IDADE <> 18

-- **************** datas  formato YYYY-MM-DD ****************
-- filtrando clientes por data de nasciemento  a partir da data passada
SELECT NOME, DATA_DE_NASCIMENTO FROM TABELA_DE_CLIENTES 
WHERE DATA_DE_NASCIMENTO >= '1995-11-14'
ORDER BY DATA_DE_NASCIMENTO ASC; -- ordenando de forma crescente

-- filtrando clientes por data de nasciemento anterior a data passada
SELECT NOME, DATA_DE_NASCIMENTO FROM TABELA_DE_CLIENTES 
WHERE DATA_DE_NASCIMENTO < '1995-11-14'
ORDER BY DATA_DE_NASCIMENTO DESC; -- ordenando de forma decrescente

-- filtra os bairros que tem a letra na ordem alfabetica iniciada depois da palavra lapa (incluindo lapa)
SELECT NOME, BAIRRO FROM TABELA_DE_CLIENTES 
WHERE BAIRRO >= 'Lapa'
ORDER BY BAIRRO ASC;

-- filtra os q moram em bairros exceto lapa
SELECT NOME, BAIRRO FROM TABELA_DE_CLIENTES 
WHERE BAIRRO <> 'Lapa'
ORDER BY BAIRRO ASC;

-- filtra pelos que moram na lapa
SELECT NOME, BAIRRO FROM TABELA_DE_CLIENTES 
WHERE BAIRRO = 'Lapa'
ORDER BY BAIRRO ASC;
