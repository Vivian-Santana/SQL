-- Aula teórica 5 usando o banco da aula prática 4
use aulaPratica_4;

select * from cidade;

-- SUB QUERIES - sub consultas
select * from cliente
where cidadeid = (select id from cidade where cidade.nome = 'Bagé'); -- consulta dinâmica

select * from cliente -- mais de um resultado na sub-consulta
where cidadeid in (select id from cidade where cidade.nome = 'Bagé'or cidade.nome = 'Curitiba');
select * from cidade;

-- CONDIÇÃO DENTRO DA CONSULTA
select nome, salario
from cliente 
where salario < 7000
and exists (select * from cliente where salario > 11000);
-- NOT EXIST
select nome, salario
from cliente 
where salario < 7000
and not exists (select * from cliente where salario > 11000);

-- any / all
select *  from cliente
where id > any (select distinct clienteid from vendas); -- ainda não tem tabela vendas

-- INTERSECÇÃO - MESMA  FUNÇÃO DO INNER JOIN
select cidadeid from cliente
intersect;
select id from cidade;

-- parecido com INNER JOIN
select cidadeid from cliente
inner join cidade
on cidade.id = cliente.cidadeId;

-- FORMATAÇÃO DE DADOS TEXTUAIS
select * from cliente;
select nome, length(nome), length(nascimento) from cliente; -- mostra o dado string e a quandtidade de caracteres.

-- conversão de minusculo para maiuscula e vice versa
select upper(nome), lower(nome) from cliente;

-- remove espaço à esquerda
select ltrim(nome) from cliente;

-- remove espaço à direita
select ltrim(nome) from cliente;

-- tira os espaços em branco dos dois lados aomesmo tempo
select trim(botn from nome), nome from cliente;

-- extrai um numero de caracteres da coluna que for passada no parametro.
select substring(nome, 5), nome from cliente;
-- extrai tudo e deixa os ultimos 5 caracteres.
select substring(nome, -5), nome from cliente;

-- REPLACE -substitui os dados dentro do parametro
select email, replace(email, 'e', 'g') from cliente;

-- conversão de tipos de dados.
select cast('2029-12-31' as date), cast('1000.99' as float);

-- FORMATAÇÃO DE DADOS NUMÉRICOS E TEMPORAIS

select salario, round(salario, 2), -- faz o arredondamento dos dados
truncate(salario, 2) -- elimina os caracteres excedentes
from funcionario;

-- funções mode e div
select mod(10, 2), 10 div 2; -- 10/2 = 5 resto = 0. mod é o módulo, resto, div é o quociente da divisão.

-- traz a data atual
select curdate();

-- traz todas as datas passadas no parâmetro
select day('2023-10-20'),
month('2023-10-20'),
year('2023-10-20');

-- mostra o dia da semana da data passada no parâmetro.
select dayname('2023-10-20'),
monthname('2023-10-20'); -- nome do mes

-- SELEÇÃO DE HORA E DATA E CALCULO COM DATA E HORA
select current_time();
select hour('12:00:10'); -- separa a hora
select minute('12:00:10'); -- separa o minuto

select adddate('2023-10-20', interval 30 day); -- adiciona,soma 30 dias a partir da data colocada no parâmetro.
-- dá pra escrever tbm como 1 mês, só substituir interval 30 day por 1 month.

select datediff('2035-12-31', '2032-12-31'); -- mostra a diferença em dias entre as datas.

-- AGREGAÇÃO (sumarizar os dados da tabela)/ EXTRAÇÃO DE DADOS
select count(*) from funcionario; -- traz a quantidade de funcionarios
select count(genero) from funcionario; -- o count com um valor dentro do parametro faz a conta ignorando linhas nulas
select sum(salario) from funcionario; -- soma o sala´rio dos funcionarios.

-- soma tds os salarios dos fun. do dep. 1
select sum(salario) from funcionario
where departamento = 1;

use aulaPratica_4; -- o código de construção desse db está na query aulaPratica_4

-- ESTÁ TRAZENDO A INFORMAÇÃO ERRADA!!!
select min(salario), max(salario) from funcionario; -- min traz o menor salario e max traz o maior.
select min(salario), nome from funcionario; -- em mts SGBDs isso não dá certo mas pode ser feito com uma sub consulta como o exemplo a baixo
select max(salario), nome from funcionario;

-- sub consulta de quem recebe o menor salário
select nome, salario from funcionario
where salario = (select min(salario) from funcionario);

-- verificando o resultado das consultas
select salario, nome from funcionario
order by salario;

-- consulta de nasc com max e min
-- ESTÁ TRAZENDO A INFORMAÇÃO ERRADA!!!
select max(nascimento), nome from funcionario; -- funcionario + novo
select min(nascimento), nome from funcionario; -- funcionario + velho

-- nasc. com sub consulta
select nome, nascimento from funcionario
where nascimento = (select min(nascimento) from funcionario);

select nome, nascimento from funcionario
where nascimento = (select max(nascimento) from funcionario);

-- verificando o resultado das consultas
select nascimento, nome from funcionario
order by nascimento;

-- agrupar as informações
select departamento, sum(salario)from funcionario -- soma os salarios por departamento
group by departamento;

-- com mais de uma coluna
select departamento, cargo, sum(salario)from funcionario -- soma os salarios por departamento e cargo
group by departamento, cargo;

select departamento, sum(salario) as 'soma dos salarios' from funcionario -- soma os salarios por departamento e cargo
group by departamento
having sum(salario) > 20000 -- filtra os departamentos que somando tds os salarios o resultado é acima de 20000 
order by 2 desc; -- ordena por departamento em ordem decrescente
