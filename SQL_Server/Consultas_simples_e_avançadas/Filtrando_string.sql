-- BASE SUCOS_FRUTAS

SELECT TOP 10 * FROM TABELA_DE_PRODUTOS 
WHERE SABOR IN ('Lima/Limao', 'Morango/Limao');

-- FILTRA TDS SUCOS Q TEM LIMAO NO FINAL
SELECT TOP 10 * FROM TABELA_DE_PRODUTOS 
WHERE SABOR LIKE '%Limao';

-- FILTRA TDS CLIENTES COM O SOBRENOME "MATTOS"
SELECT * FROM TABELA_DE_CLIENTES 
WHERE NOME LIKE '%MATTOS';

SELECT * FROM TABELA_DE_CLIENTES ORDER BY NOME

-- TDS Q TEM A MAÇÃ NO SABOR
SELECT SABOR FROM TABELA_DE_PRODUTOS 
WHERE SABOR LIKE '%MACA%';

--TRAZ TDS OS NOMES Q TENHAM "CA"
SELECT * FROM TABELA_DE_CLIENTES 
WHERE NOME LIKE '%CA%';

-- TDS Q COMEÇAM COM MORANGO
SELECT SABOR FROM TABELA_DE_PRODUTOS 
WHERE SABOR LIKE 'MORANGO%';

--TRAZ TDS OS Q NOMES INICIAM COM "ED"
SELECT * FROM TABELA_DE_CLIENTES 
WHERE NOME LIKE 'ED%';

-- TDS SUCOS DE MORANGO NO COMEÇO E EM EMBALAGEM PET
SELECT SABOR, EMBALAGEM FROM TABELA_DE_PRODUTOS 
WHERE SABOR LIKE 'MORANGO%'
AND (EMBALAGEM = 'PET');


-- Na base de dados usada pelo nosso treinamento execute uma consulta que diga quantos clientes possuem o sobrenome Silva.
SELECT NOME FROM TABELA_DE_CLIENTES
WHERE NOME LIKE '%SILVA';
