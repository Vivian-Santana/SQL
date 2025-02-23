-- BASE SUCOS_FRUTAS

SELECT SABOR FROM TABELA_DE_PRODUTOS 
WHERE SABOR IN ('Lima/Limao', 'Morango/Limao');

-- FILTRA TDS SUCOS Q TEM LIMAO NO FINAL
SELECT SABOR FROM TABELA_DE_PRODUTOS 
WHERE SABOR LIKE '%Limao';

-- TDS Q TEM A MAÇA
SELECT SABOR FROM TABELA_DE_PRODUTOS 
WHERE SABOR LIKE '%MACA%';

-- TDS Q COMEÇAM COM MORANGO
SELECT SABOR FROM TABELA_DE_PRODUTOS 
WHERE SABOR LIKE 'MORANGO%';

-- TDS SUCOS DE MORANGO NO COMEÇO E EM EMBALAGEM PET
SELECT SABOR, EMBALAGEM FROM TABELA_DE_PRODUTOS 
WHERE SABOR LIKE 'MORANGO%'
AND (EMBALAGEM = 'PET');


-- Na base de dados usada pelo nosso treinamento execute uma consulta que diga quantos clientes possuem o sobrenome Silva.
SELECT NOME FROM TABELA_DE_CLIENTES
WHERE NOME LIKE '%SILVA';