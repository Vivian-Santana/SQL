create database aulaPratica_4;
use aulaPratica_4;
-- set SQL_SAFE_UPDATES = 0 permite a exclusão ou alteração completa dos dados da tabela mesmo feita acidentalmente. obs: não usei essa clausula.

-- Tabelas que são usadas nos exemplos
create table estado (
    id int,
    nome varchar(50),
    sigla char(02),
    primary key(id)
);

create table cidade (
    id int,
    nome varchar(100),
    estadoId int,
    primary key(id)
);

create table cliente (
    id int auto_increment,
    nome varchar(100),
    genero char(01),
    nascimento date,
    salario decimal(10,2),
    email varchar(120) unique, 
    cidadeId int not null,
    constraint pkCliente primary key (id),
    constraint fkClienteCidade foreign key (cidadeId) references cidade(id)
    on delete no action on update no action
);

create table funcionario (
    matricula int not null,
    nome varchar(100),
    genero char(01),
    nascimento date,
    salario decimal(10,2),
    departamento int,
    cargo int,
    gerente int,
    email varchar(120),
    cidadeId int,
    constraint pkFuncionario primary key (matricula)
);

create table pergunta (
    id int,
    pergunta varchar(100),
    primary key(id)
);

insert into estado values (1, 'Paraná', 'PR');
insert into estado values (2, 'São Paulo', 'SP');
insert into estado values (3, 'Pernambuco', 'PE');
insert into estado values (4, 'Pará', 'PA');
insert into estado values (5, 'Rio Grande do Sul', 'RS');

insert into cidade values (1, 'Bagé', 5);
insert into cidade values (2, 'Curitiba', 1);
insert into cidade values (3, 'Recife', 3);
insert into cidade values (4, 'São Paulo', null);
insert into cidade values (5, 'Porto Alegre', null);
insert into cidade values (6, 'Olinda', 3);

insert into pergunta values (1, 'Qual a sua função?');
insert into pergunta values (2, 'Avalie a sua gerência.');

insert into cliente values (1, 'Helena Magalhães', 'F', '2000-01-01', 12500.99, 'helena@email.com', 2),
                           (2, 'Nicolas', 'M', '2002-12-10', 8500, 'nicolas@email.com', 3),
                           (3, 'Ana Rosa Silva', 'F', '1996-12-31', 8500, 'ana.rosa@email.com', 1),
                           (4, 'Tales Heitor Souza', 'M', '2000-10-01', 7689, 'tales.heitor@email.com', 1),
                           (5, 'Bia Meireles', 'F', '2002-03-14', 9450, 'bia.meireles@email.com', 2),
                           (6, 'Pedro Filho', 'M', '1998-05-22', 6800, 'pedro.filho@email.com', 5),
                           (7, 'Helena Magalhães', 'F', '1994-08-10', 8600, 'helena.magalhaes@email.com', 4);
                           
insert into cliente values (8, 'Jaqueline da Silva Amaral', 'F', '1988-09-21', 3000.00, 'jaque@email.com', 2),
						   (9, 'Silva dos Santos filho', 'M', '1950-01-01', 3000.00, 'silva@email.com', 3);

insert into funcionario values (1, 'Ana Rosa', 'F', '1996-12-31', 8500, 1, 1, null,'ana.rosa@email.com', 1),
                               (2, 'Tales Heitor', 'M', '2000-10-01', 7689, 1, 2, 1, 'tales.heitor@email.com', null),
                               (3, 'Bia Meireles', 'F', '2002-03-14', 9450, 1, 2, 1, 'bia.meireles@email.com', 2),
                               (4, 'Pedro Filho', 'M', '1998-05-22', 6800, 3, 3, 2, 'pedro.filho@email.com', 4),
                               (5, 'Helena Magalhães', 'F', '2000-01-01', 12500.99, 4, 5, 2, 'helena@email.com', 6),
                               (6, 'Nicolas Pinto', 'M', '2002-12-10', 8500, 6, 3, null, 'nicolas.pinto@email.com', 5);
                               
insert into funcionario values (7, 'Jaqueline da Silva Amaral', 'F', '1950-01-01', 5000, 1, 1, null,'jaque2@email.com', 1),
								(8, 'Jonas Duarte da Silva', 'M', '1990-12-25', 3500, 2, 3, null,'jonas@email.com', 6);
                            
select * from funcionario;
select * from cliente;
select * from cidade;
select * from estado;
select * from pergunta;

-- ALTERAÇÕES
update funcionario
    set cidadeId = (select id from cidade where nome = 'Recife') -- subconsulta
    where matricula = 2;
    
-- ATUALIZANDO
update funcionario
set nome = 'Helena Magalhaes'
where matricula = 6;

update funcionario
set genero = 'F'
where matricula = 6;
select * from funcionario;

update funcionario 
set nome = 'João da silva',
departamento = 3
where matricula = 2;

-- INSERINDO
insert into cidade (id, nome, estadoid) values (7, 'Londrina', 1);

-- DELETANDO
delete from cliente where id = 5;

delete from cliente where nome = 'Helena Magalhães' AND id = 7; -- no modo seguro ele vai exigir o id (key) para exclusão.

delete from funcionario where departamento = 1 and genero = 'M'; -- não permite no modo safe.

-- delete from cidade where id = 6;
    
delete from cliente where cidadeId in 
    (select id from cidade where nome = 'Curitiba');

truncate table cliente; -- esvazia a tabela toda

-- Filtro
-- é boas ráticas o select sempre ter um filtro
select * from cliente where genero = 'F';

-- em ambiente corporativo evitamos o *  fazendo select apenas nas colunas necessárias:
-- tem menos uso de processamento deicando a consulta mais rápida.
select nome, nascimento from cliente where genero = 'F';

-- And / or 
select * from funcionario where salario >= 5000 and salario <= 8000;

-- Null / not null
select * from cidade where nome is null; -- pegar os que são nulos
select * from cidade where nome is not null; -- pegar os que NÃO são nulos

-- Like (procurar valores específicos)
select nome from cliente where nome like '%Silva%'; -- todos os nomes q tem silva em qualuqer parte do nome
select nome from cliente where nome like '%Silva'; -- com o '%' ANTES do nome, sign q o 'Silva' tem q estar só no final.
select nome from cliente where nome like 'Silva%';  -- com o '%' DEPOIS do nome, sign q o 'Silva' tem q estar antes do nome.

-- In (procura vários valores)
select nome, cidadeid from cliente where cidadeId in (1, 2, 4);
-- Not in
select nome, cidadeid from cliente where cidadeId not in (1, 2, 4);

select * from cliente;

select nome, cidadeid from funcionario where cidadeId = 1 or cidadeId = 2 or cidadeId = 4; -- parecido com o in mas é mais verboso.

-- Between (seleciona dados entre de um intervalo)
select * from funcionario where cidadeId between 1 and 4;
-- ou 
select * from funcionario where cidadeId >= 1 and cidadeId <= 4;

-- not Between
select * from funcionario where cidadeId not between  1 and 4;

-- ORDER BY (ORDENAR POR..)
select * from funcionario order by nome desc, salario asc; -- odem descrecente se tiver 2 nomes iguais ordena os dois em ordem ascendente pelo valor do salário.
select * from funcionario order by 3 asc; -- classifica pela 3ª coluna

-- Limit (limita quantas linhas eu quero de retono do banco)
select * from funcionario LIMIT 3; -- as 3 primeiras linhas da tabela
select * from funcionario LIMIT 3, 2;

-- Comando CASE
select nome,
    case
        when genero = 'M' then 'Masculino'
        when genero = 'F' then 'Feminino'
        else 'Outros'
    end as 'Gênero'
from funcionario;

-- AS , colocar apelido nas colunas , alterando o nome das colunas na consulta.
select nome 'Nome do Funcionário',
salario as 'Salário atual',
salario * 1.10 as 'Novo salário' -- fazendo um reajuste 
from funcionario;

-- JUNÇÃO
select f.nome 'Nome do Funcionário', c.nome 'Nome da cidade'
from funcionario f
inner join cidade c
on f.cidadeId = c.id;

-- união de dois selects
-- os 2 selects tem q ser com mesmo número de colunas e os dados tem que ser respectivamente do mesmo tipo.
select nome, nascimento from cliente -- com o union valores iguais de coludas difrentes são mostrados apenas uma vez
union 
select nome, nascimento from funcionario;

select nome, nascimento, 'cliente' from cliente
union all -- com o union valores iguais de coludas difrentes são mostrados duas vezes.
select nome, nascimento, 'funcionario' from funcionario
order by 1;






-- Distinct
select nome from cliente order by nome; -- linhas com valores tds iguais não serão mostradas.
select distinct nome from funcionario;
select distinct nome, nascimento from funcionario; -- distingue pela data de nasc.

-- Distinct com mais colunas
select nome, email from cliente order by nome;
select distinct nome, email from cliente order by nome;

-- Inner join - equi-non
select estado.nome, cidade.nome, sigla 
from cidade 
inner join estado
on cidade.estadoId = estado.id;

-- Usando where
select cidade.nome, estado.nome, sigla 
from cidade, estado
where cidade.estadoId = estado.id;

select * from cidade;

-- Left join inclusive
select cidade.nome, estado.nome, sigla 
from cidade left join estado
on cidade.estadoId = estado.id;

-- Left join exclusive
select cidade.nome, estado.nome, sigla from cidade 
    left join estado
    on cidade.estadoId = estado.id
    where estado.id is null;

-- Right join inclusive
select cidade.nome, estado.nome, sigla 
from cidade 
right join estado
on cidade.estadoId = estado.id;

-- Right join exclusive
select cidade.nome, estado.nome, sigla from cidade 
    right join estado
    on cidade.estadoId = estado.id
    where cidade.estadoId is null;

-- Full join (o MySQL não suporta o full join)
select cidade.nome, estado.nome, sigla 
from cidade 
full join estado
on cidade.estadoId = estado.id;

-- Gerando o full join (também conhecido como FULL OUTER JOIN) é uma operação de junção de tabelas que combina registros de duas 
-- tabelas com base em uma condição especificada e retorna todos os registros de ambas as tabelas, incluindo aqueles que não têm 
-- correspondência na outra tabela. Em outras palavras, ele retorna uma união completa dos conjuntos de resultados das tabelas à 
-- esquerda e à direita da junção.
select cidade.nome, estado.nome, sigla from cidade 
    left join estado
    on cidade.estadoId = estado.id
    union
    select cidade.nome, estado.nome, sigla from cidade 
        right join estado
        on cidade.estadoId = estado.id
    where cidade.estadoId is null;

-- Cross join - cruza tds as linhas de uma tabela com as de outra tabela
-- usado quando é preciso pegar os dados de uma tabela e repetir para outra tabela.
select nome, pergunta 
from pergunta
cross join funcionario;

-- Self join com inner join - fazer um join dentro da própria tabela
select funcionario.nome, gerente.nome as 'gerente' 
	from funcionario 
    inner join funcionario as gerente -- mostra os funcionários e seus respectivos gerentes.
    on funcionario.gerente = gerente.matricula
    order by funcionario.nome;

-- Self join com left join
select funcionario.nome, gerente.nome  -- o mesmo q o de cima, só que tbm trás os funcionários q não tem gerente.
	from funcionario 
    left join funcionario as gerente
    on funcionario.gerente = gerente.matricula
    order by funcionario.nome;

-- Join com várias tabelas - trás os dados que forem solicitados no select de várias tabelas.
select funcionario.nome, cidade.nome, estado.nome 
	from funcionario
    inner join cidade 
    on funcionario.cidadeId = cidade.id
    inner join estado
    on cidade.estadoId = estado.id
    order by funcionario.nome;

select cidade.nome, estado.nome, sigla 
	from cidade 
    full join estado -- não funciona no mysql
    on cidade.estadoId = estado.id
    where cidade.estadoId is null
    or estado.id is null;

select nome, salario, salario * 1.10 from funcionario;

select nome as 'Nome do funcionário', 
    salario as 'Salário atual',
    salario * 1.10 as 'Novo salário'
    from funcionario;

-- select func.nome as 'Nome do funcionário', cid.nome as 'Nome da cidade' from funcionario f
    -- inner join cidade c
    -- on f.cidadeId = c.id;
    
    
