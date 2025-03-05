-- IDENTITY - CAMPO COM AUTO INCREMENTO

CREATE TABLE TAB_IDENTITY
(
ID INT IDENTITY(1,1) NOT NULL, 
DESCRITOR VARCHAR (20) NULL
);

SELECT * FROM TAB_IDENTITY

INSERT INTO TAB_IDENTITY (DESCRITOR) VALUES ('Tony Stark')

INSERT INTO TAB_IDENTITY (DESCRITOR) 
VALUES ('Steve Rogers'), 
	   ('Bruce Banner'), 
	   ('Natasha Romanoff'), 
	   ('Thor');

DELETE FROM TAB_IDENTITY WHERE ID = 1

-- ID VIRA 6 (NÃO SUBSTITUI O ID 1 Q FOI APAGAADO PQ O ID É SEMPRE CESCENTE)
INSERT INTO TAB_IDENTITY (DESCRITOR) VALUES ('Clint Barton')


-- MUDANDO PARÂMETROS DE NUMERO INICIAL E INCREMENTO 

CREATE TABLE TAB_IDENTITY_2
-- ID INICIA NO NUM 100 E CRESCE DE 5 EM 5
(ID INT IDENTITY(100,5) NOT NULL, DESCRITOR VARCHAR (20) NULL);

INSERT INTO TAB_IDENTITY_2 (DESCRITOR) 
VALUES ('HOMEM DE FERRO'), 
	   ('CAPITÃO AMÉRICA');

SELECT * FROM TAB_IDENTITY_2

-- O CAMPO IDENTITY NÃO PERMITE FIXAR UM VALOR PARA ELE (ESSE COMANDO VAI DAR ERRO "Não é possível inserir um valor explícito para a coluna de identidade...")
INSERT INTO TAB_IDENTITY_2 (ID,DESCRITOR) VALUES (255,'HULK')

-- DEFININDO PARDÕES PARA OS CAMPOS
CREATE TABLE TB_PADRAO
(
ID INT IDENTITY(1,1) NOT NULL, DESCRITOR VARCHAR(20) NULL, 
ENDERECO VARCHAR(20) NULL, 
CIDADE VARCHAR(20) DEFAULT 'RIO DE JANEIRO',
DATA_CRIACAO DATE DEFAULT GETDATE() -- MESMO O CAMPO TENDO DEFAULT DEFINIDO  NO INSERT POSSO COLOCAR UM VALOR <> PARA ELE
);

INSERT INTO TB_PADRAO 
    (DESCRITOR, ENDERECO, CIDADE, DATA_CRIACAO) 
VALUES
    ('CLIENTE X', 'RUA PROJETADA A', 'SÃO PAULO', '2018-04-30');

SELECT * FROM TB_PADRAO;

-- OMITINDO DADOS
-- O campo será preenchido com o valor default caso ele não seja declarado no INSERT
INSERT INTO TB_PADRAO 
    (DESCRITOR) 
VALUES
    ('CLIENTE Y');

--RESULTADO ID - 2 | DESCRITOR - CLIENTE Y| ENDERECO - NULL| CIDADE - RIO DE JANEIRO | DATA_CRIACAO - DT DE HJ

