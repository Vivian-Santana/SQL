/*
Temos uma função que irá buscar o preço de um produto da tabela de produtos do esquema SUCOS_VENDAS. 
O parâmetro principal desta função é o código do produto. Acrescente mais um parâmetro que será a 
taxa de desconto sobre o preço de lista. Este valor é um número percentual.
*/
SELECT * FROM [TABELA DE PRODUTOS]


CREATE FUNCTION CalculaDesconto (@CODIGO_PRODUTO VARCHAR(10), @DescontoPercentual INT)
RETURNS FLOAT

AS
BEGIN
   DECLARE @Desconto FLOAT
   DECLARE @PrecoComDesconto FLOAT
   DECLARE @Preco FLOAT

   SELECT @CODIGO_PRODUTO = [CODIGO DO PRODUTO] FROM [TABELA DE PRODUTOS];

   -- Obtenho o preço de lista do produto com a consulta na tabela de produtos e gravando este preço de lista na variável @Preco.
   SELECT @Preco = [PREÇO DE LISTA] FROM [TABELA DE PRODUTOS] WHERE [CODIGO DO PRODUTO] = @CODIGO_PRODUTO
   
   -- O cálculo do desconto atribuido a variável @Desconto
   SET @Desconto = (@Preco * @DescontoPercentual) / 100

   -- Calculo do preço do desconto atribuido a variável @PrecoComDesconto
   SET @PrecoComDesconto = @Preco - @Desconto

   RETURN @PrecoComDesconto --  retorna o valor de um produto com o desconto aplicado
END

--USANDO A FUNC
-- SAÍDA: NOME DOS PRODUTOS COM O CODIGO PASSADO COMO PARAMENTRO E O DESCONTO DADO TBM COMO SEGUNDO PARAMETRO NA COLUNA QUE FOI NOMEADA COM O ALIAS "PREÇO COM DESCONTO"
SELECT [NOME DO PRODUTO], dbo.CalculaDesconto ('773912', 10) AS [PREÇO COM DESCONTO]
FROM [TABELA DE PRODUTOS]
