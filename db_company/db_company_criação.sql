create schema if not exists company;
use company;

create table employee(
	Fname varchar (15) not null,
    Minit char,
    Lname varchar (15) not null,
    Ssn char (9), -- char limita o numero de caracteres que irá receber (no caso so ssn são 9 numeros)
    Bdate DATE,
    Address varchar(30),
    gender char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    constraint chk_salary_employee check (Salary > 2000.0), -- constraint de checagem 
    constraint pk_employee  primary key (Ssn)
);
desc employee;
select * from information_schema.table_constraints where constraint_schema = 'company'; -- mostra as constraints

alter table employee
	add constraint fk_employee
	foreign key (Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade; -- sempre que houver atualização nessa fk as tabelas que herdam (as filhas) tbm serão atualizadas.


create table departament( -- Department
	Dname varchar (15) not null,
    Dnumber int not null,
    Mgr_ssn char (9) not null,
    Mgr_Start_date date,-- Mgr = gerente
    Dept_creat_date date, -- Dept = departamento
    constraint chk_date_dept check (Dept_creat_date < Mgr_Start_date),  
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept unique (Dname),
    foreign key (Mgr_ssn) references employee (Ssn) -- não coloquei nome em constrian (nome automáticodepartment_ibfk_1) vamos alterar renomeando com alter table.
);

desc department;

-- alterando o nome da tabela
alter table departament rename to department;

-- modificando uma constrint: primeiro - drop, depois add
alter table department drop constraint department_ibfk_1;
alter table department
	add constraint fk_dept foreign key(Mgr_ssn) references employee (Ssn)
    on update cascade;

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation), -- um departamento pode ter mais de uma localização por isso a pk composta.
    constraint fk__dept_locations foreign key (Dnumber) references department(Dnumber) 
);
-- excluindo e adicionando uma constrain fk
alter table dept_locations drop constraint fk_dept_locations;

alter table dept_locations
	add constraint fk_dept_locations foreign key(Dnumber) references department(Dnumber)
    on delete cascade
    on update cascade;

create table project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname), -- um projeto será associado a apenas um nome (unique garante que esse nome não vai se repetir)
    constraint fk_project foreign key (Dnum) references department(Dnumber)
);

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hour decimal(3,1) not null, -- (3,1) é valor decimal ex.: 6:30.
    primary key (Essn, Pno), -- pk composta (porque um funciinário pode trabalhar em mais de um projeto então a tabela deve ser refenciada por mais de uma pk a do Essn e do num do projeto).
    constraint fk_employee_works_on foreign key (Essn) references employee (Ssn), -- duas fk uma referencia o funcionário e outra o projeto.
    constraint fk_project_works_on foreign key (Pno) references project (Pnumber)
);
desc works_on;
alter table works_on 
	rename column Hour to Hours;

drop table dependent;
create table dependent( -- tabela que possui uma existencia de dependência por que a pk também é a fk
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    gender char, -- F ou M
    Bdate date,
    Relationship varchar(8),
    primary key(Essn, Dependent_name), -- pk composta 
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
    );
    show tables;

select * from information_schema.table_constraints where constraint_schema = 'company';

select * from information_schema.referential_constraints where constraint_schema = 'company';

-- legenda:
--  employee = empregado ou funcinário/ Fname = first name/ Minit = abreviação do middle name/ Lname = last name /ssn = social security number (equivalente a RG nos USA)/ Bdate= birth date/ Address = endereço/ gender= genero/ 
-- departmant = departamento/ Dname = nome do departamento/ Dnumber = num do departamento/ Mgr = manager - gerente/ dept location = localização do departamento.
-- works on = trabalha em (tem a finalidade de mapear as horas gastas em cada projeto que o funcináro trabalha)/ Pno = numero do projeto/ hours = horas
-- dependent = dependente/ Relationship = tipo de parentesco entre  funcionário e o dependente/  
