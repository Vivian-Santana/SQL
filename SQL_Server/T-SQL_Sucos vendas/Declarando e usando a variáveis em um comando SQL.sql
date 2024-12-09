USE SUCOS_VENDAS
--DECLARANDO VARIÁVEIS
DECLARE @MATRICULA VARCHAR(5);
DECLARE @NOME VARCHAR(100);
DECLARE @PERCENTUAL FLOAT;
DECLARE @DATA DATE;
DECLARE @FERIAS BIT;
DECLARE @BAIRRO VARCHAR(50);
DECLARE @CLIENTE VARCHAR(10);
DECLARE @IDADE INT;
DECLARE @DataNascimento DATE;
DECLARE @CUSTO FLOAT;

--ATRIBUINDO VALORES A ELAS
SET @MATRICULA = '00240';
SET @NOME = 'Claudia Rodrigues';
SET @PERCENTUAL = 0.10;
SET @DATA = '2012-03-12';
SET @FERIAS = 1;
SET @BAIRRO = 'Jardins';
SET @CLIENTE = 'João Sivla';
SET @IDADE = 17;
SET @DataNascimento = '2007-01-10'
SET @CUSTO = 10.23

--EXIBIR OS VALORES DAS VARIÁVEIS
PRINT @MATRICULA;
PRINT @NOME;
PRINT @PERCENTUAL;
PRINT @DATA;
PRINT @FERIAS;
PRINT @BAIRRO

PRINT @CLIENTE;
PRINT @IDADE;
PRINT @DataNascimento
PRINT @CUSTO

SET @MATRICULA = '00244';
SET @NOME = 'Roberto Araújo';
select * from [TABELA DE VENDEDORES]

 --inserir um novo vendedor usando os valres das variáveis
INSERT INTO [TABELA DE VENDEDORES]
(MATRICULA, NOME, [PERCENTUAL COMISSÃO], [DATA ADMISSÃO], [DE FERIAS], [BAIRRO])
VALUES
(@MATRICULA, @NOME, @PERCENTUAL, @DATA, @FERIAS, @BAIRRO)

PRINT 'UM VENDEDOR INCLUIDO.'
