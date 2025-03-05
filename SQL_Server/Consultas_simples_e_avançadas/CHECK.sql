-- Usando CHECKS para testar campos
-- BASE SUCOS VENDAS 2

CREATE TABLE TAB_CHECK (
    ID INT NOT NULL, 
    NOME VARCHAR(50) NULL, 
    IDADE INT NULL, 
    CIDADE VARCHAR(50) NULL, 
    CONSTRAINT CHK_IDADE CHECK (IDADE >= 18) -- CRIA RESTRIÇÃO PARA MENORES DE IDADE
);

INSERT INTO TAB_CHECK 
VALUES (1, 'JOÃO', 19, 'RIO DE JANEIRO');

INSERT INTO TAB_CHECK 
VALUES (2, 'PEDRO', 16, 'RIO DE JANEIRO');
/* A instrução INSERT conflitou com a restrição do CHECK "CHK_IDADE". O conflito ocorreu no banco 
de dados "VENDAS SUCOS 2", tabela "dbo.TAB_CHECK", column 'IDADE'.*/

-- O CHECK PODE SER ALGO MAIS COMPLEXO
CREATE TABLE TAB_CHECK_2 (
    ID INT NOT NULL, 
    NOME VARCHAR(50) NULL, 
    IDADE INT NULL, 
    CIDADE VARCHAR(50) NULL, 
    CONSTRAINT CHK_IDADE2 CHECK (
        (IDADE >= 18 AND CIDADE = 'RIO DE JANEIRO') 
        OR 
        (IDADE >= 16 AND CIDADE = 'SÃO PAULO')
    )
);

INSERT INTO TAB_CHECK_2 VALUES (
    1, 'JOÃO', 19, 'RIO DE JANEIRO'
);

INSERT INTO TAB_CHECK_2 VALUES (
    2, 'PEDRO', 17, 'RIO DE JANEIRO'
); -- A instrução INSERT conflitou com a restrição do CHECK "CHK_IDADE2". O conflito ocorreu no banco de dados "VENDAS SUCOS 2", tabela "dbo.TAB_CHECK_2".


INSERT INTO TAB_CHECK_2 VALUES (
    2, 'PEDRO', 17, 'SÃO PAULO'
);

SELECT * FROM TAB_CHECK_2

/*
Quando um registro que não satisfaz a condição de um campo com uma restrição CHECK é inserido, 
o sistema de gerenciamento de banco de dados (SGBD) impede a operação para manter a 
integridade dos dados. O SGBD retorna uma mensagem de erro indicando que a instrução conflitou 
com a restrição CHECK, especificando o banco de dados e a tabela onde a restrição está definida. 
Isso garante que os dados armazenados no banco de dados estejam sempre em conformidade com as regras definidas.
*/
