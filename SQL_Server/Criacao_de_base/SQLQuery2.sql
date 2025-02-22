--CRIANDO NOVA BASE - ESPECIFICAÇÕES
CREATE DATABASE [VENDAS SUCOS 2]
ON (
	NAME='VENDAS_SUCOS_2_DAT',
	FILENAME='C:\BASES_DE_DADOS\VENDAS_SUCOS_02.MDF',
	SIZE=10, -- TAMANHO INICIAL
	MAXSIZE=50, -- TAM MAXIMO
	FILEGROWTH=5 -- POLÍTICA DE CRESCIMENTO (VAI CRESCER DE 5 EM MEGA)
)

--  ARQUIVO DE LOG DE TRANSAÇÕES
LOG ON (
	NAME='VENDAS_SUCOS_2_LOG',
	FILENAME='C:\BASES_DE_DADOS\VENDAS_SUCOS_02.LDF',
	SIZE=10,
	MAXSIZE=50,
	FILEGROWTH=5
);

CREATE TABLE PRODUTOS
(
	CODIGO VARCHAR(10)NOT NULL,
	DESCRITOR VARCHAR(100)NULL,
	SABOR VARCHAR(50)NULL,
	TAMANHO VARCHAR(50)NULL,
	EMBALAGEM VARCHAR(50)NULL,
	PRECO_LISTA FLOAT NULL,
	PRIMARY KEY (CODIGO)
);

CREATE TABLE VENDEDORES
(
	MATRICULA VARCHAR(5)NOT NULL,
	NOME VARCHAR(100)NULL,
	BAIRRO VARCHAR(50)NULL,
	COMISSAO FLOAT NULL,
	DATA_ADMISSAO DATE NULL,
	FERIAS BIT NULL,
	PRIMARY KEY (MATRICULA)
);

CREATE TABLE CLIENTES
(
	CPF VARCHAR(11)NOT NULL,
	NOME VARCHAR (150),
	RUA VARCHAR (150),
	NUMERO SMALLINT,
	COMPLEMENTO VARCHAR (150),
	BAIRRO VARCHAR (150),
	CIDADE VARCHAR (150),
	ESTADO CHAR (2),
	CEP CHAR(8),
	[DATA DE NASCIMENTO] DATE,
	IDADE SMALLINT,
	SEXO CHAR,
	[LIMITE DE CREDITO] MONEY,
	[VOLUME MINIMO] FLOAT,
	[PRIMEIRA COMPRA] BIT
	PRIMARY KEY (CPF)
);

CREATE TABLE TABELA_DE_VENDAS
(
	NUMERO VARCHAR(5)NOT NULL,
	DATA_VENDA DATE NULL,
	CPF VARCHAR(11)NOT NULL,
	MATRICULA VARCHAR(5)NOT NULL,
	IMPOSTO FLOAT NULL,
	PRIMARY KEY (NUMERO),
	FOREIGN KEY (CPF) REFERENCES CLIENTES (CPF), -- CHAVE ESTRANGEIRA COM A TB CLIENTES	
	FOREIGN KEY (MATRICULA)REFERENCES VENDEDORES (MATRICULA) -- CHAVE ESTRANGEIRA COM A TB de VENDEDORES
);

/*
IMPORTANDO DADOS DE UMA TABELA DE OUTRA BASE (SUCOS_VENDAS)
APONTANDO PARA A BASE RECEM CRIADA: VENDAS SUCOS 2
*/

-- PRIMEIRO FAÇO UM SELECT (NA TB DE ORIGEM) MOSTRANDO OS CAMPOS ORDENADOS DA MESMA FORMA QUE ESTÃO NA TB DE DESTINO.
SELECT [CODIGO DO PRODUTO], 
		[NOME DO PRODUTO], 
		SABOR, 
		TAMANHO, 
		EMBALAGEM, 
		[PREÇO DE LISTA]
FROM [SUCOS_VENDAS].DBO.[TABELA DE PRODUTOS]

SELECT * FROM [dbo].[PRODUTOS] -- TB DESTINO (VAZIA)
 
-- PROXIMO PASSO: FAZER COM Q O NOME DAS COLUNAS COINCIDAM COM O NOME DOS CAMPOS DA TB DE DESTINO, USANDO ASLIAS
-- CADA NOME DE COL DA TB DE ORIGEM (Q FOR <> DA TB DE DESTINO) VAI RECEBER UM ALIAS COM O NOME DE CADA COL CORRESPONDENTE DA TB DE DESTINO

SELECT [CODIGO DO PRODUTO] AS CODIGO, 
		[NOME DO PRODUTO] AS DESCRITOR, 
		SABOR, 
		TAMANHO, 
		EMBALAGEM, 
		[PREÇO DE LISTA] AS PRECO_LISTA
FROM [SUCOS_VENDAS].DBO.[TABELA DE PRODUTOS] -- TB DE ORIGEM

-- COM ESSA SELEÇÃO PRONTA USO PARA FAZER UM INSERT NA TB DE DESTINO
INSERT INTO PRODUTOS
SELECT [CODIGO DO PRODUTO] AS CODIGO, 
		[NOME DO PRODUTO] AS DESCRITOR, 
		SABOR, 
		TAMANHO, 
		EMBALAGEM, 
		[PREÇO DE LISTA] AS PRECO_LISTA
FROM [SUCOS_VENDAS].DBO.[TABELA DE PRODUTOS]

-- AGORA AMBAS AS TBS DE BASES <> TEM OS MESMOS DADOS
SELECT * FROM PRODUTOS
SELECT * FROM [SUCOS_VENDAS].DBO.[TABELA DE PRODUTOS]