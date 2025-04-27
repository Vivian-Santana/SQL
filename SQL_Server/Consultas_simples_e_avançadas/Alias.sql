--Base SUCOS_FRUTAS
SELECT * FROM TABELA_DE_CLIENTES;

-- escolhendo os campos que eu quero visualizar e a ordem que quero visualizar, colocando SELECT e o nome do campo,
SELECT CPF, 
	   NOME,
	   BAIRRO,
	   CIDADE 
FROM TABELA_DE_CLIENTES;

-- dando um alias para as cols CPF e Nome | POSSO OMITIR O AS
SELECT CPF [ID CPF], 
	   NOME [NOME DO CLIENTE], 
	   BAIRRO [BAIRRO DO CLIENTE],
	   CIDADE [CIDADE DO CLIENTE] 
FROM TABELA_DE_CLIENTES;

-- dando um alias para a tabela
SELECT CPF AS IDENTIFICADOR, 
	   NOME AS [NOME DE CLIENTE], 
	   BAIRRO, 
	   CIDADE FROM TABELA_DE_CLIENTES TDC; -- o as para o alias da tb foi suprimido

-- ao criar um alias para tabela, posso colocar o alias depois o nome do campo
-- o alias de tabela é especialmente útil quando for fazer uma consulta com tabelas que tenham
-- colunas com nomes iguais nesse caso o alias faz o papel de diferenciar esses campos.
SELECT TDC.CPF, 
	   TDC.NOME,
	   TDC. BAIRRO 
FROM TABELA_DE_CLIENTES TDC;

--  ver todos os campos, usando o asterisco e o alias
SELECT TDC.* FROM TABELA_DE_CLIENTES TDC;

-- usando o o próprio nome da tabela como se fosse um alias.
SELECT TABELA_DE_CLIENTES.CPF, 
	   TABELA_DE_CLIENTES.NOME 
FROM TABELA_DE_CLIENTES;

-- usando um alias, explicitamente com a cláusula
SELECT C.CPF, 
	   C.NOME
FROM TABELA_DE_CLIENTES AS C;
