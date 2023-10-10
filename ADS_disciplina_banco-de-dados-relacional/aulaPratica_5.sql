create database aulapratica_5;

use aulapratica_5;

create table cidade (
    id int,
    nomeCidade varchar(100),
    uf char(02),
    primary key (id)
);

create table cliente (
    id int auto_increment,
    nome varchar(100),
    genero char(01),
    dataNascimento date,
    salario decimal(10,2),
    email varchar(120) unique,
    cidadeId int not null,
    constraint pkCliente primary key (id),
    constraint fkClienteCidade foreign key (cidadeId) references cidade (id)
    on delete no action on update no action
);

create table vendas (
    numeroVenda int,
    data date,
    clienteId int,
    valorCompras decimal(10,2),
    primary key (numeroVenda) 
);

create table funcionario (
    matricula int not null,
    nome varchar(100),
    genero char(01),
    nascimento date,
    salario decimal(10,4),
    departamento int,
    cargo int,
    email varchar(120),
    cidadeId int not null,
    constraint pkFuncionario primary key (matricula)
);

-- Inserindo os registros nas tabelas
insert into cidade values (1, 'Curitiba', 'PR');
insert into cidade values (2, 'Bagé', 'RS');
insert into cidade values (3, 'Parnaíba', 'PI');
insert into cidade values (4, 'Videira', 'SC');
insert into cidade values (5, 'Imperatriz', 'MA');
insert into cidade values (6, 'Belo Horizonte', 'MG');
insert into cidade values (7, 'São Paulo', 'SP');

insert into cliente values (1, 'Helena Magalhães', 'F', '2000-01-01', 12500.99, 'helena#email.com', 2),
                           (2, 'Nicolas', 'M', '2002-12-10', 8500, 'nicolas#email.com', 3),
                           (3, 'Ana Rosa Silva', 'F', '1996-12-31', 8500, 'ana.rosa@email.com', 1),
                           (4, 'Tales Heitor Souza', 'M', '2000-10-01', 7689, 'tales.heitor@email.com', 1),
                           (5, 'Bia Meireles', 'F', '2002-03-14', 9450, 'bia.meireles@email.com', 2),
                           (6, 'Pedro Filho', 'M', '1998-05-22', 6800, 'pedro.filho@email.com', 5),
                           (7, 'Helena Magalhães', 'F', '1994-08-10', 8600, 'helena.magalhaes@email.com', 4);

insert into vendas values (1, '2022-02-10', 4, 1000.00),
                          (2, '2022-02-10', 2, 500.00),
                          (3, '2022-03-11', 3, 100.00),
                          (4, '2022-03-11', 2, 400.00),
                          (5, '2022-03-11', 3, 200.00);

insert into funcionario values (1, 'Ana Rosa Silva', 'F', '1996-12-31', 8500.4321, 1, 1, 'ana.rosa@email.com', 1),
                               (2, 'Tales Heitor Souza', 'M', '2000-10-01', 7689.9880, 1, 2, 'tales.heitor@email.com', 1),
                               (3, 'Bia Meireles', 'F', '2002-03-14', 9450.9880, 1, 2, 'bia.meireles@email.com', 2),
                               (4, 'Pedro Filho', 'M', '1998-05-22', 12340.1670, 3, 3, 'pedro.filho@email.com', 2),
                               (5, 'Camila Fialho', 'F', '1989-03-15', 10450.1000, 2, 3, 'camila.fialho@email.com', 4),
                               (6, 'Ulisses Frota', 'M', '1997-06-30', 12340.9590, 1, 4, 'ulisses.frota@email.com', 7),
                               (7, 'Leonardo Timbo', null, '2001-07-02', 7850.1280, 2, 3, 'leonardo.timbo@email.com', 2),
                               (8, 'Lucas Goes', 'M', '2002-03-02', 8834.9880, 3, 4, 'lucas.goes@email.com', 5),
                               (9, 'Sofia Lima', null, '1999-12-23', 9578.549, 4, 4, 'sofia.lima@email.com', 5),
                               (10, 'Nicolas Figueira', 'M', '1997-06-01', 12340.1209, 3, 2, 'nicolas.figueira@email.com', 3),
                               (11, 'Helena Arcanjo', 'F', '1998-11-20', 6320.9876, 2, 2, 'helena.arcanjo@email.com', 7);

-- Mod e div
select mod(4,2) as 'Resto divisão',
    mod(5,2) as 'Resto divisão', 
    4 div 2 as 'Quociente',
    5 div 2 as 'Quociente';

-- Round, truncate, mod e div
-- obs.: salário e dados bancários não se usa round nem truncate, nesses casos deve-se trabalhar com dados precisos.
select salario,
    round(salario),
    round(salario,2),
    round(salario, 1),
    truncate(salario, 0),
    truncate(salario, 1),
    truncate(salario, 2)
    from funcionario;

-- Formatação de texto
select nome,
    upper(nome),
    lower(nome), 
    length(nome),
    ltrim(nome),
    rtrim(nome), 
    substring(nome, 5), -- extrai uma parte da string
    substring(nome, 1, 3),
    dataNascimento,
    length(dataNascimento), 
    email,
    replace(email, '#', '@') -- substitui caracteres
    from cliente;
    
select * from cliente;

-- Funções de agregação totalizam um valor baseado na coluna pasada no parâmetro.
-- Count(*) e count null
select count(*),
    count(genero) -- funcionários sem o genero cadastrado (cpm null no campo genero) não serão contados pelo count.
    from funcionario;

-- Conversão de valoes
-- o cast converte qualquer valor, é uma função de conveção de dados.
select cast('2000-01-01' as date), 
    cast('1000.00' as decimal),
    cast('20:15' as time);
    
-- FUNÇÕES QUE TRAZEM DATA E HORA
select curdate(),
    curtime(),
    now(), 
    date(curdate()), -- A FUNÇÃO DATE CONVERTE UM VALOR PARA DATA
    date(now());

-- Funções referentes ao dia
select curdate(), curtime(), now(), date(curdate()), date(now());
select curdate(), day(curdate()), dayname(curdate()), dayofweek(curdate()), dayofyear(curdate()), last_day(curdate()); -- dayofyear - mostra o número do dia do ano q estamos
select month(curdate()), monthname(curdate()), year(curdate()); -- mostra num do mes, nome do mes e num do ano.
select curdate(), now(), week(curdate()), weekday(now()), weekday(curdate()); -- now da data, hora min e segundo.
select curdate(), adddate(curdate(), interval 31 day), adddate(curdate(), interval 1 month); -- conta um intervalo de 31 dias.
-- A função DATEDIFF é usada para calcular a diferença entre duas datas. Ela retorna o número de intervalos (dias, semanas, meses, etc.) entre duas datas especificadas. 
-- DATEDIFF sintaxe (intervalo, data_inicial, data_final)
select curdate(), datediff('2022-01-01', curdate()), datediff(curdate(), '2022-01-01'); 
select curdate(), date_format(curdate(), '%w %m %y'), date_format('2022-01-01 20:15:00', '%h:%i:%s');

-- Funções de hora
select curtime(), time(curtime()), hour(curtime()), minute(curtime()), second(curtime()), microsecond(curtime()); -- trás a hora até o microsegundo.
select addtime('01:00:00.999999', '02:00:00.999998');
select timestamp('2003-12-31'), timestamp('2003-12-31 12:00:00', '12:00:00'); -- o timestamp é um número inteiro q representa uma data, traz a hora em segundos desde 1 de janeiro de 1970. Leva em consideração o servidor onde está o banco de dados.
select curdate(), curtime(), timestampadd(minute, 30, curdate());
select timediff('2021-12-31 23:59:59.000001', '2021-12-31 01:01:01.000002');
select time_format('20:30:00', '%h %m');

-- Contando com filtro
select count(*) from funcionario
    where genero = 'M';

-- Sum salário
select sum(salario) from funcionario;

-- Min
select min(salario), min(nascimento) from funcionario; -- a menor data de nasc vai trazer o funcionario mais velho.
select nascimento from funcionario;

-- Max
select max(salario), max(nascimento) from funcionario; -- a maior data de nasc vai trazer o funcionario mais novo.

-- Média
select avg(salario) from funcionario;

-- Group by: Contando funcionários do departamento
select departamento, count(*) from funcionario 
group by departamento -- o count conta agrupando por departamento
order by departamento; -- ordenando por departamento.

-- having
select departamento, count(*) from funcionario 
    group by departamento 
    having count(departamento) > 2; -- só aparece os departamentos que tem mais de um funcionario.

select departamento, genero, count(*) from funcionario -- tras a quantidade de funcionarios de cada genero em cada departamento.
group by departamento, genero;

-- Group by por gênero
-- regra: usar a função de agregação AVG, colocar a coluna do lado.
select genero, avg(salario) from funcionario 
    group by genero;

-- Subconsultas (um select dentro de outro)o q está entre parenteses é excecutado primeiro.
select nome, salario from funcionario
    where salario = (select max(salario) from funcionario);

select salario, nome from funcionario
order by salario;

select nome, cidadeId from cliente 
    where cidadeId = (select id from cidade where nomeCidade = 'Bagé');

-- Usando o in
select nome, cidadeId  from cliente 
    where cidadeId in (select id from cidade where nomeCidade = 'Curitiba' or nomeCidade = 'Imperatriz');

-- Não Curitiba e não Imperatriz NOT IN
select nome, cidadeId  from cliente 
    where cidadeId not in (select id from cidade where nomeCidade = 'Curitiba' or nomeCidade = 'Imperatriz');

-- Exists é uma consulta que sempre vai usar * pq não importa o resultado, mas se o resultado é verdadeiro ou falso.
-- < 7000 > 11000
select nome, genero, salario from cliente 
    where salario < 7000
    and exists (select * from cliente where salario > 11000); -- poderia colocar o not existe no lugar do exists par obter a consulta contrária.

-- Any é qualquer valor
-- id cliente > id cliente venda
select id, nome, genero from cliente  -- traz o id do cliente q seja maior do q qualquer cliente q já tenha feito compras.
    where id > any (select distinct clienteId from vendas);

-- All tds os valores
select id, nome, genero from cliente
    where id > all (select distinct clienteId from vendas); -- traz tds os ids dos clientes q sejam maiores q os ids trazidos pelo select entre parenteses.

-- Subconsulta correlacionada
-- salario > any salario do mesmo gênero
-- traz os clientes q recebem mais em relação a clientes do mesmo genero.
select id, nome, genero, salario 
	from cliente c
    where salario > any 
    (select salario from cliente where genero = c.genero); -- para cada linha da consulta essa sub consulta em parenteses é executada.

-- Controle de acesso
-- Criando o usuário "aluno"
create user 'aluno'@'localhost' identified by '123';

-- Atualizando os privilégios
-- flush privileges;

-- Mostrando os usuários existentes
select user, host from mysql.user;

-- Mostrando os privilégios do usuário "aluno"
 show grants for aluno@localhost;

-- revoke all, grant option from aluno@localhost;
-- flush privileges;
-- show grants for aluno@localhost;

-- Atribuindo algumas permissões
grant select, insert, delete on aulapratica_5. * to aluno@localhost;
flush privileges;
show grants for aluno@localhost; -- mostra as permissões dada ao usuário aluno
show grants for aluno;

revoke delete on aulapratica_5.* from aluno@localhost; -- revogando a permissão de deletar

-- Alterando os privilégios do usuário "aluno"
grant all privileges on *.* to aluno@localhost; -- dá pra colocar outros usuários com as mesmas permissões separando por , 
-- flush privileges;

-- Testando as permissões
-- use aula;
-- update funcionario set genero = 'M' where matricula = 7;
-- select * from funcionario where matricula = 7;

-- Retirando a permissão de update
-- revoke update on aula.* from aluno@localhost;
-- flush privileges;
-- show grants for aluno@localhost;

-- Tentando alterar a tabela "funcionario"
-- use aula;
-- update funcionario set genero = 'F' where matricula = 9;

-- Excluindo o usuário "aluno"
drop user aluno@localhost;
