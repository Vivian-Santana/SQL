-- fazendo consultas no banco

select * from employee;

-- Gerente e seu departamento
select Ssn, Fname, Dname from employee e, department d where (e.Ssn = d.Mgr_ssn);

-- dependentes e parentesco de funcionário
select Fname, Dependent_name , Relationship from employee, dependent where Essn = Ssn;

-- data de nasc e endereço do John
select Bdate, Address from employee
	where Fname = 'John' and Minit ='B' and Lname = 'Smith';
    
-- encontrar um departamento especifico
select * from department where Dname = 'Research';

-- funcionários que trabalham no departamento Research
select Fname, Lname, Address from employee, department
	where Dname = 'Research' and Dnumber = Dno;
    
-- 
select * from project;
-- horas trabalhadas num determinado projeto 
select Pname, Essn, Hours from project, works_on 
	where Pnumber = Pno;
    
-- filtrando mais informações
select Pname, Essn, Fname, Hours from project, works_on, employee 
	where  Pnumber = Pno and Essn = Ssn; -- pegando atributos: nome do projeto Essn, nome do funcionário e horas trabalhadas das três tabelas: Pname, Essn e Fname

-- Dnumber: department
desc department;
desc dept_locations;

-- Evitando erro de ambiguidade: quando realizo uma consulta com duas tabelas ou mais com o mesmo nome de atributo
 select * from department;
 select * from dept_locations;
 
 select * from department, dept_locations where Dnumber = Dnumber; -- dá erro de ambiguidade -> "Error Code: 1052. Column 'Dnumber' in where clause is ambiguous"
 -- retira a ambiguidade através do alias ou AS Statement
 select Dname, l.Dlocation as Department_name
		from department as d, dept_locations as l -- estou "apelidando" department de d e dept_locations de l
        where d.Dnumber = l.Dnumber; -- estou especificando de onde vem cada atributo. Isso é o Alias.
        
-- concatenação
select concat (Fname, '', Lname) as Employee from employee;	