-- COMANDOS AVANÇADOS
/* tabela heap, view, função, trigger, procedure*/
create database aula_6; 
use aula_6;

										-- ***** TABELA HEAP *****
create table pessoa (
nome varchar(50),
email varchar(50)
);

-- sem chave prinmária a tabela fica ordenada por ordem de inclusão.
insert into pessoa values ('Anabel', 'anabel@email.com'),
						  ('Luiz Afonso', 'luizafonso@email.com'),
                          ('Alais', 'alais@email.com'),
                          ('João Pedro', 'joaopedro@email.com'),
                          ('Marcos', 'marcos@email.com'),
                          ('Ulisses', 'ulisses@email.com'),
                          ('Amadeu', 'amadeu@email.com'),
                          ('Vitoria', 'vitoria@email.com'),
                          ('Caludio', 'caludio@email.com'),
                          ('Marcela', 'marcela@email.com'),
                          ('Julia', 'julia@email.com'),
                          ('Roberval', 'roberval@email.com'),
                          ('Raiza', 'raiza@email.com'),
                          ('Olavo', 'olavo@email.com'),
                          ('Murilo', 'murilo@email.com'),
                          ('Helena', 'helena@email.com'),
                          ('Vitoria', 'vitoria2@email.com'),
                          ('Pedro', 'pedro@email.com'),
                          ('Gabriela', 'gabriela@email.com'),
                          ('Marilia', 'marilia@email.com'),
                          ('Kevin', 'kevin@email.com');

select * from pessoa;

select * from pessoa where nome = 'Vitoria'; -- faz um table scan na tabela até achar o dado, o q consome muita performance do banco.

-- índice é usado para otimizar a performance na consulta de um select em um grande volume de dados.
-- criar índice para as tabelas que serão mais consultadas, uma tabela pode ter vários índices.

create index idxPessoa on pessoa(nome); -- be-tree - índice em árvore, agrupa de acordo do a primeira letra criando subdivisões.

show index from pessoa; -- mostra os indices feitos para a tabela

explain select * from pessoa where nome = 'Gabriela'; -- faz a consulta com um melhor desempenho. o Explain select mostra o plano de consuta. 
-- para trazer as informações da pessoa executar selecionando do select em diante.

													-- ***** VIEW *****
use aulapratica_5;

-- veiw é uma consulta select q fica armazenada do banco de dados para simplificar a visualização dos dados.
-- e tbm é usada para habilitar a visualização de determindadas colunas colocadas nessa view, quando não se pode...
-- mostrar todos os dados de uma tabela a view possibilita dar acesso apenas a tabelas escolhidas.
create view mostraFuncionario
as 
	select nome as 'Nome funcionario', -- só irá aparecer essas colunas
    email as 'email',
    nascimento
    from funcionario;
    
select * from mostraFuncionario;
select salario from mostraFuncionario; -- testando view, não deve mostrar pq essa coluna não está na view.

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
select nome, salario, reajuste(salario, 10) from funcionario; -- a função faz o calculo de reajuste de salário

												-- ***** TRIGGER *****
-- Trigger disparada na inclusão (triggers são gatihlos, comandos que são disparados...
-- automaticamente quando um insert, update e detele são executados).
-- essa trigger criada tem o controle de quais dados estão sendo alterados e quem está auterando.
delimiter $$
create trigger funcionarioInclusao after insert -- essa trigger vai ser disparada depois do comando insert
on funcionario
for each row
begin
    insert into auditoria values 
    ('inclusão', new.matricula, null, new.salario, curdate());
end$$
delimiter ;
-- para laterar algo na trigger existente só fazer o comando alter.

-- Mostra as triggers do Banco de Dados "aula"
show triggers from aulapratica_5;

select * from funcionario;

-- USANDO O DB aulapratica_5
-- criando a tabela auditoria para usar uma procedure
use aulapratica_5;
													-- ***** PROCEDURE *****
create table auditoria (
    acao char(10),  -- Será inclusão, exclusão ou alteração
    matricula int,
    salarioAntigo decimal(10,2),
    salarioNovo decimal(10,2),
    dataOperacao date
);

select * from auditoria;
-- Inclui um funcionário
-- quando o insert desse funcionario for feito ele vai disparar a trigger que vai registrar a inserção desses dados junto com a data da operação.
insert into funcionario values (12, 'Marina Barbosa', 'F', '2000-10-11', 3500, 2, 1, 'marina.b@email.com', 5);

-- Mostra os dados das tabelas "auditoria" e "funcionario"
select * from auditoria;
select * from funcionario;

-- CRIANDO PROCEDURE (É EXECUTADA INDEPENDENREMENTE)
-- é como se fosse uma função mas é um bloco de codigo maior que desempenha várias atividades, 
-- já a função é um bloco menor e mais específico. A procedure não precisa retornar valor, 
-- pode ter paramentros de entrada ou não.

-- Exemplo de procedure
-- ESSA PROCEDURE FAZ O INSERT DO FUNCIONARIO NA TABELA, o dev chama a procedure e passa as...
-- informações através de uma linguagem de programação.

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
call incluiFuncionario (13, 'Sofia Lima', null, '1999-12-23', 9578, 4, 4, 'sofia.lima@email.com', 5);
call incluiFuncionario (15, 'José Santana', 'M', '1960-5-2', 5000, 3, 1, 'jose@email.com', 7);

show function status where db = 'aulapratica_5';

select * from funcionario;

-- ********************************************************************************************************************************************************
-- FUNÇÃO DE UMA CARTELA DE SORTEIO
-- essa função e a procedure a seguir estão no banco aula_6.
use aula_6;

delimiter $$
 create function parImpar(numero int)
 returns char(05) deterministic
 begin
	declare tipo char(05) default null;
    set tipo = 'Impar';
    if numero mod 2 = 0 then
		set tipo = 'Par';
	end if;
	return (tipo);
 end$$
delimiter $$;

select parImpar(10), parimpar(23);

use aula_6;
create table if not exists
cartela( 
concurso int, 
numero int);

delimiter $$
create procedure geraNumeros(nroInicial int, nroFinal int, nroConcurso int)
begin 
	declare nroGerado int default 0;
    declare i int default 0;
    while i < 6 do
		set nroGerado = (select floor(rand() * nroFinal) + nroInicial);
		if not exists (select * from cartela where numero = nroGerado) then
			insert into cartela values (nroConcurso, nroGerado);
            set i = i + 1;
		end if;
    end while;
end$$
delimiter $$;

-- executando a procedure
call geraNumeros(1, 60, 100);
select * from cartela;