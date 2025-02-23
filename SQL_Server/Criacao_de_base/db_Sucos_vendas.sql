--SQL SERVER
CREATE DATABASE Sucos_vendas;

--DDL (Data Definition Language)

CREATE TABLE [tabela_clientes](
CPF CHAR(11),
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
);

CREATE TABLE [Tabela_produtos](
[CODIGO DO PRODUTO] VARCHAR (20) NOT NULL PRIMARY KEY,
[NOME DO PROUDUTO] VARCHAR (50),
EMBALAGEM VARCHAR (50),
TAMANHO VARCHAR (50),
SABOR VARCHAR (50),
[PRECO DE LISTA] SMALLMONEY
);

ALTER TABLE [tabela_clientes] ALTER COLUMN [CPF] CHAR (11) NOT NULL;

ALTER TABLE [tabela_clientes] ADD CONSTRAINT PK_TABELA_CLIENTE
PRIMARY KEY CLUSTERED ([CPF]); --TIPO DA RESTRIÇÃO

USE Sucos_vendas;

CREATE TABLE [Tabela_vendedores](
MATRICULA VARCHAR (5) NOT NULL PRIMARY KEY,
NOME VARCHAR (100),
[PERCENTUAL COMISSAO] FLOAT,
);

--inserção dos dados  com comandos DML (Data Manipulation Language)
INSERT INTO [Tabela_produtos] VALUES (
'12345', 'Light', 'lata','350 ml', 'melancia', 4.50
);

--inserção em lote
INSERT INTO [Tabela_produtos] VALUES 
('6789', 'Clean', 'PET','2 litros', 'laranja', 16.10),
('1011', 'Catafesta', 'vidro','1,5 litros', 'uva', 20.00),
('1213', 'Aurora', 'vidro','1,5 litros', 'uva verde', 19.90),
('1415', 'Linha Citros', 'PET','1 litro', 'limão', 7.80);

INSERT INTO [tabela_clientes] VALUES
('12345678910','João da Silva','Rua das Camélias', 123,'', 'Pari','São Paulo', 'SP', '20000000', '1965-03-21', 59, 'M', 2.0000, 3000.30, 1),
('11121314151','Maria Nascimento','Rua Opala', 100,'','Minas Gerais', 'Belo Horizonte', 'MG', '10000000', '1975-03-21', 49, 'F', 20000, 3000.30, 0),
('19290992743','Fernando Cavalcante','Rua Dois de Fevereiro', 90,'C', 'Agua Santa', 'Rio de Janeiro','RJ','22000000', '2000-02-12', 24, 'M', 1.000, 2000, 1),
('14711567102','Erica Carvalho','Rua Iriquitia', 230, 'A', 'Jardins','São Paulo', 'SP', '80012212', '1990-09-01', 34, 'F', 3.700, 24500, 0),
('26005867098','Mariana Teixeira','Rua Conde de Bonfim', 1530, '', 'Tijuca','Rio de Janeiro','RJ','22020001','2001-10-10',23, 'F',1.20000, 22.000, 0),
('49247271822','Eduardo Jorge','Rua Volta Grande', 55,'B', 'Tijuca','Rio de Janeiro','RJ','22012002','1994-07-19', 30, 'M', 1.000, 9500, 1),
('55762287581','Petra Oliveira','Rua Benicio de Abreu', 310,'', 'Lapa','Sao Paulo','SP','88192029','1995-11-14',29, 'F',3.000, 16.000, 1);

SELECT * FROM tabela_clientes;

-- declarando com ordem de inserção diferente (Se os campos forem inseridos em ordens diferentes das colunas da tabela, 
-- basta declarar qual é a ordem das informações com o nome dos campos antes do comando VALUES.)
INSERT INTO [Tabela_produtos] 
([CODIGO DO PRODUTO], [NOME DO PROUDUTO], EMBALAGEM, TAMANHO, [PRECO DE LISTA], SABOR)
VALUES
('5449', 'Del valle', 'caixa', '1 litro', 8.30, 'manga'),
('3965', 'Del valle', 'lata', '290 ml', 4.10, 'macacujá');

 --DQL (Data Query Language)
SELECT * FROM Tabela_produtos;

--ALTERANDO DADO COLOCADO NO CAMPO ERRADO
UPDATE [tabela_clientes]
SET BAIRRO = 'Cruzeiro'
WHERE BAIRRO = 'Minas Gerais';

INSERT INTO Tabela_vendedores VALUES
('550','Isabel Santos', null),
('123','Alexandre Amaral', 0.09),
('304','Marcia Sousa', 0.1),
('145','Bruno Dos Santos', null),
('170','Vilma Farias', 0.08),
('324','André Merieles', null),
('957','Fabio Carvalho', 0.07);

SELECT * FROM Tabela_vendedores;

--Consultas com DQL (Data Query Language)
SELECT [NOME], [ESTADO] FROM tabela_clientes
ORDER BY [NOME];

SELECT [ESTADO], [NOME] FROM tabela_clientes;

--USANDO ALIAS
SELECT [NOME] AS 'NOME DO CLIENTE',[CPF], [ESTADO] AS 'UF' FROM tabela_clientes;

SELECT [MATRICULA] AS IDENTIFICADOR,
       [NOME] AS [NOME DO VENDEDOR]
FROM Tabela_vendedores;

SELECT [SABOR] FROM Tabela_produtos;

SELECT DISTINCT [SABOR] FROM Tabela_produtos; --TRAZ VALORES UNICOS

SELECT [NOME],[CIDADE], [ESTADO], [PRIMEIRA COMPRA] FROM tabela_clientes 
WHERE [PRIMEIRA COMPRA] = 1; -- TRAZ OS CLIENTES NOVOS (1 = TRUE)

SELECT * FROM Tabela_produtos
WHERE [PRECO DE LISTA] = 7.80;

SELECT * FROM Tabela_produtos
WHERE [PRECO DE LISTA] > 10.00;

SELECT * FROM Tabela_produtos
WHERE [PRECO DE LISTA] < 7.00;

SELECT * FROM Tabela_produtos
WHERE [EMBALAGEM] = 'lata';

SELECT * FROM tabela_clientes

SELECT [NOME], [DATA DE NASCIMENTO]
FROM tabela_clientes
WHERE [DATA DE NASCIMENTO] > '1995-12-31';

--FUNÇÃO DE AGREGAÇÃO (YEAR, MONTH, DAY)
SELECT [NOME], [DATA DE NASCIMENTO]
FROM tabela_clientes
WHERE YEAR ([DATA DE NASCIMENTO]) > '1995';

--PERSOLANIZANDO A CONSULTA COM CONDIÇÕES (OPERADORES LÓGICOS)
SELECT [NOME], [BAIRRO] 
FROM [tabela_clientes]
WHERE [BAIRRO] = 'Tijuca' OR [BAIRRO] = 'Agua Santa';

--CLIENTES NOVOS NO ESTADO DE SÃO PAULO
SELECT [NOME],[ESTADO], [BAIRRO],[PRIMEIRA COMPRA]
FROM [tabela_clientes]
WHERE [ESTADO] = 'SP' AND [PRIMEIRA COMPRA] = 1;

--1 - Liste os vendedores que possuem comissão menor ou igual a 8%.
SELECT [NOME] AS 'VENDEDOR', [PERCENTUAL COMISSAO]
FROM Tabela_vendedores
WHERE [PERCENTUAL COMISSAO] <= 0.08;

--2 - Liste os produtos que custam menos de 6 reais e estão disponíveis em lata.
SELECT [NOME DO PROUDUTO], [EMBALAGEM],[PRECO DE LISTA]
FROM Tabela_produtos
WHERE [PRECO DE LISTA] < 6 AND [EMBALAGEM] = 'lata';

--3 - Mostre todos os clientes que não são de São Paulo nem do Rio de Janeiro.
SELECT [NOME], [ESTADO]
FROM tabela_clientes
WHERE ESTADO <> 'SP' AND ESTADO <>'RJ';

--OU
SELECT * FROM tabela_clientes
WHERE NOT ([ESTADO] = 'SP' OR [ESTADO] = 'RJ');

--AJUSTANDO ERRO NO NOME DO CAMPO DA TABELA DE PRODUTOS, USANDO O procedimento armazenado "sp_rename"
SELECT * FROM Tabela_produtos
EXEC sp_rename 'Tabela_produtos.NOME DO PROUDUTO', 'NOME DO PRODUTO', 'COLUMN';

--ALTERANDO PREÇOS DOS SUCOS EM LATA (DANDO 10% DE DESCONTO)
UPDATE Tabela_produtos
SET [PRECO DE LISTA] = [PRECO DE LISTA] * 0.9
WHERE [EMBALAGEM] = 'lata';

SELECT * FROM Tabela_produtos
WHERE [EMBALAGEM] = 'lata';

--modificando campos dois campos ao mesmo tempo, preço e embalagem
UPDATE Tabela_produtos
SET [EMBALAGEM] = 'Garrafa pet', [PRECO DE LISTA] = 8.10
WHERE [CODIGO DO PRODUTO] = '1415';

--modificando outro campo
UPDATE Tabela_produtos
SET [EMBALAGEM] = 'Garrafa vidro'
WHERE [EMBALAGEM] = 'vidro';

--APAGANDO UM DADO
DELETE FROM Tabela_produtos
WHERE [CODIGO DO PRODUTO]= '6789'