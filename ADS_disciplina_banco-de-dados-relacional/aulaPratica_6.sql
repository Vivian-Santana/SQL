-- COMANDOS AVANÇADOS
/* função, stored procedure e cursor */
create database aulapratica_6;

use aulapratica_6;

create table funcionario (
    matricula int not null,
    nome varchar(100),
    genero char(01),
    nascimento date,
    salario decimal(10,2),
    departamento int,
    cargo int,
    email varchar(120),
    cidadeId int not null,
    constraint pkFuncionario primary key (matricula)
);

create table auditoria (
    acao char(10),  -- Será inclusão, exclusão ou alteração
    matricula int,
    salarioAntigo decimal(10,2),
    salarioNovo decimal(10,2),
    dataOperacao date
);

insert into funcionario values (1, 'Ana Rosa Silva', 'F', '1996-12-31', 8500, 1, 1, 'ana.rosa@email.com', 1),
                               (2, 'Tales Heitor Souza', 'M', '2000-10-01', 7689, 1, 2, 'tales.heitor@email.com', 1),
                               (3, 'Bia Meireles', 'F', '2002-03-14', 9450, 1, 2, 'bia.meireles@email.com', 2),
                               (4, 'Pedro Filho', 'M', '1998-05-22', 12340, 3, 3, 'pedro.filho@email.com', 2),
                               (5, 'Camila Fialho', 'F', '1989-03-15', 10450, 2, 3, 'camila.fialho@email.com', 4),
                               (6, 'Ulisses Frota', 'M', '1997-06-30', 12340, 1, 4, 'ulisses.frota@email.com', 7),
                               (7, 'Leonardo Timbo', null, '2001-07-02', 7850, 2, 3, 'leonardo.timbo@email.com', 2),
                               (8, 'Lucas Goes', 'M', '2002-03-02', 8834, 3, 4, 'lucas.goes@email.com', 5),
                               (9, 'Sofia Lima', null, '1999-12-23', 9578, 4, 4, 'sofia.lima@email.com', 5);

-- Tabela para armazenar a simulação do reajuste de salário
create table simulacao (
    nome varchar(100), 
    salario decimal(10,2), 
    novoSalario decimal(10,2)
);

select * from auditoria;
select * from funcionario;
select * from simulacao;

												-- ***** FUNÇÃO *****
-- USER DEFIFNED FUNCTION ou UDF - FUNÇÃO DESENVOLVIDA POR USUÁRIO.
-- Exemplo de função
delimiter $$
create function reajuste(salario decimal(10,2), percentual decimal(5,2))
returns decimal(10,2) deterministic
begin
    declare valorReajuste decimal(10,2) default 0;
    set valorReajuste = (salario * percentual) / 100;
    return (valorReajuste);
end $$
delimiter ;
											
-- Exemplo de uso de função
select nome, salario, reajuste(salario, 10) from funcionario; -- a função faz o calculo 
												-- ****** FUNÇÃO ******
                                                
												-- ***** PROCEDURE *****
-- CRIANDO PROCEDURE 
-- Uma prodedure é executada de forma independente,
-- é como se fosse uma função mas é um bloco de codigo maior que desempenha várias atividades, 
-- já a função é um bloco menor e mais específico. A procedure não precisa retornar valor, 
-- pode ter paramentros de entrada ou não.

-- Exemplo de procedure
-- ESSA PROCEDURE FAZ O INSERT DO FUNCIONARIO NA TABELA, o dev chama a procedure 
-- e passa as informações através de uma linguagem de programação.

delimiter $$
create procedure incluiFuncionario(
    pmatricula int,
    pnome varchar(100),
    pgenero char(01),
    pnascimento date,
    psalario decimal(10,2),
    pdepartamento int,
    pcargo int,
    pemail varchar(120),
    pcidadeId int
)
-- validações que devem ser feitas antes do insert
begin
    declare mensagem varchar(100);
    set mensagem = 'OK';
    if exists (select * from funcionario where matricula = pmatricula) then
        set mensagem = 'Matrícula já existe';
    end if;
    if psalario < 0 then
        set mensagem = mensagem + ', salário inválido';
    end if;
    if length(trim(pnome)) = 0 then
        set mensagem = mensagem + ', nome está vazio';
    end if;
    if pnome is null then
        set mensagem = mensagem + ', nome está vazio';
    end if;
    if mensagem = 'OK' then
        insert into funcionario values (pmatricula, pnome, pgenero, pnascimento, psalario, pdepartamento, pcargo, pemail, pcidadeId);
    end if;
end $$

-- chamando a procedure
call incluiFuncionario (10, 'José Santana', 'M', '1960-5-2', 5000, 3, 1, 'jose@email.com', 7);

show function status where db = 'aulapratica_5';

select * from funcionario;

											-- ***** CURSOR *****
-- usado para manipular o resultado de um select, permite navegar no resultado de um select
-- manipulando cada linha do select para encontrar uma informação. O cursor é usado dentro de uma procedure.
use aulapratica_5;

-- Tabela para armazenar a simulação do reajuste de salário
create table simulacao (
    nome varchar(100), 
    salario decimal(10,2), 
    novoSalario decimal(10,2)
);

select * from simulacao;

-- drop table simulacao;
-- drop procedure simulaReajuste;

delimiter $$
create procedure simulaReajuste()
begin
declare done boolean default false; -- variavel para identificar o final do cursor
declare vnome varchar(100);
declare vsalario decimal(10,2);
declare vnovoSalario decimal(10,2);
declare vdepartamento int;
    
declare cursorFuncionario cursor -- declaração do cursor que armazena o select, o cursor fica armazenado na memória da máquina.
for select nome, departamento, salario -- então um cursor com um select mt grande afeta o desempenho.
	from funcionario;
	
declare continue handler
for not found set done = true;
        
open cursorFuncionario;
        
leCursor: loop -- loop: comando de repetição do mysql que estou identificando como leCursor
	fetch cursorFuncionario -- pega cada linha da tabela
	into vnome, vdepartamento, vsalario;
    if done then -- testa se o cursor chegou ao final
		leave leCursor; -- sai do loop ao chegar no final
	end if;
    
    if vdepartamento = 1 then
		set vnovoSalario = vsalario + reajuste(vsalario, 10);
	elseif vdepartamento = 2 then
		set vnovoSalario = vsalario + reajuste(vsalario, 12);
	else 
		set vnovoSalario = vsalario  + reajuste(vsalario, 8);
	end if;
    insert into simulacao
		values (vnome, vsalario, vnovoSalario);
end loop;
close cursorFuncionario;
end $$
delimiter ;

-- Executa a procedure
call simulaReajuste();

select * from simulacao;

select nome, salario from funcionario
