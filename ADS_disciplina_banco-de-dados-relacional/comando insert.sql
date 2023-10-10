create database aula_quatro;
use aula_quatro;

create table cidade (
id int,
nome varchar(100) not null,
uf char(02),
constraint pkCidade primary key (id)
)
select * from cidade;

insert into cidade (id, nome, uf) values (1, 'Bagé', 'RS'); --  insert sintaxe completa
insert into cidade values (2, 'Parnaíba', 'PI'); -- reduzido
insert into cidade (id, nome) values (3, 'Imperatriz'); -- insert de algumas colunas

create table cliente (
id int auto_increment,
nome varchar(100),
cidadeId int not null,
constraint pkcliente primary key (id),
constraint fkClienteCidade foreign key (cidadeId) references cidade(id)
);
insert into cliente values (1, 'Pedro', 1);
insert into cliente (nome, cidadeid) values ('Nicolas', 2),('Helena', 1), ('Beatriz', 3);
select * from cliente;

create table funcionario (
id int,
nome varchar(100),
cidadeId int not null,
constraint fkFuncCidade foreign key (cidadeId) references cidade(id)
);
insert into funcionario (id, nome, cidadeid) -- executar essas duas linhas juntas migra os dados de 
		select id, nome, cidadeid from cliente; -- cliente para funcionario.
select * from funcionario;

-- EXCLUSÃO E MODIFICAÇÃO DE REGISTROS
insert into cidade values (4, 'Videira', 'SC'), (5, 'Curitiba', 'PR'), (6, 'Belo Horizonte', 'MG'), (7, 'São Paulo', 'SP');

update cidade   -- fazendo alteração na cidade de id 2
set nome = 'Gramado'
where id = 2;

update cidade 
set uf = 'RS'
where id = 2;

update cidade -- fazendo mais de uma lateração de uma vez
set nome = 'Londrina',
uf = 'PR'
where id = 3;

delete from cidade where id=7;

-- RESTRIÇÃO DE CONSULTAS
-- o select é mais uado com clausulas para pegar colunas específicas ao invés da tabela inteira
select * from cliente
where cidadeId = 1
or cidadeId = 3;

select nome from cliente 
where cidadeId in (1,3,4);

select nome from cliente  -- seleção por ordem alfabética
order by nome asc;  -- acendente é o padrão então quando usar order by ele já ordena em ordem alfabética.

select nome from cliente  -- seleção por ordem ascendente de cima pa baixo
order by nome desc; 

create table estado (
id int,
nome varchar(100) not null,
constraint pkEstado primary key (id)
);

ALTER TABLE cidade
ADD CONSTRAINT fkEstCidade FOREIGN KEY (id)
REFERENCES estado (id);

select * from estado;


insert into estado values (1, 'Santa Catarina'), (2, 'Paraná'), (3, 'Minas Gerais'), (4, 'Bahia'), (5, 'Rio Grande do Sul'), (6, 'Santa Catarina');
select noemCidade, nomeEstado

-- Junção de Tabelas (Joins
from cidade
inner join estado
on cidade.Estadoid = estado.id;
-- 20:37:11	from cidade inner join estado on cidade.Estadoid = estado.id	Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from cidade inner join estado on cidade.Estadoid = estado.id' at line 1	0.000 sec
