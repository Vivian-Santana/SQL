-- 08 Funções numéricas

-- FUNC ROUND AREDONDA O NUM
SELECT ROUND(3.433, 2); 

SELECT ROUND(3.437, 2), ROUND(3.433, 2);

-- AREDONDA PARA O MENOR INTEIRO, DEPOIS DO INTEIRO DO NUM (4)
SELECT CEILING(3.433);

-- ARREDONDA PARA A PARTE INTEIRA DO NÚMERO, AMIOR INTEIRO (3)
SELECT FLOOR(3.433);

-- POTÊNCIA 12²
SELECT POWER(12, 2);

-- CALCULA O EXPONENCIAL NATURAL DE UM NÚMERO
SELECT EXP(3);

-- RAÍZ QUADRADA
SELECT SQRT(9);

-- CONVERT QUALQUER NUM NEGATIVO EM POSITIVO
SELECT ABS(10), ABS(-10);

/*
Na tabela de notas fiscais, temos o valor do imposto. Já na tabela de itens, temos a quantidade e o faturamento. 
Calcule o valor do imposto pago no ano de 2016, arredondando para o menor inteiro.
*/

SELECT * FROM NOTAS_FISCAIS
SELECT * FROM ITENS_NOTAS_FISCAIS

SELECT YEAR(DATA_VENDA) AS ANO, -- YEAR(DATA_VENDA) Extrai o ano da data de venda (DATA_VENDA) e retorna como ANO
	FLOOR(SUM(IMPOSTO * (QUANTIDADE * PRECO))) AS TOTAL_IMPOSTO -- Calcula o valor total do imposto para cada item da nota fiscal SUM Soma o total do imposto
																-- FLOOR Arredonda o valor total para baixo, eliminando casas decimais
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO -- Faz o cruzamento entre as duas tabelas com base no campo número da nota fiscal
WHERE YEAR(DATA_VENDA) = 2015 -- NÃO HA VENDAS NO ANO DE 2016
GROUP BY YEAR(DATA_VENDA); -- Agrupa os resultados pelo ano extraído de DATA_VENDA para calcular o total do imposto por ano

