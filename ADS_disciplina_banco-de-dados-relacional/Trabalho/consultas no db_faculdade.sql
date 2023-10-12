-- consultas ao banco faculdade

use faculdade;

-- 2.	Implemente uma consulta para listar o quantitativo de cursos existentes.
select count(nome) from Curso; 

-- 3.	Implemente uma consulta para listar o nome das disciplinas existentes.
select nome from disciplina;

/*4.	Implemente uma consulta para listar o nome de todos os cursos e o nome de seus respectivos alunos. 
        A listagem deve ser mostrada em ordem decrescente pelo nome dos cursos.*/

select c.nome as NomeDoCurso, a.nome as NomeDoAluno
from Curso c
left join AlunoCurso ac on c.idCurso = ac.idCurso
left join Aluno a on ac.idAluno = a.idAluno
order by c.nome desc, a.nome;

/* 5. Implemente uma consulta para listar o nome das disciplinas e a média das notas
das disciplinas em todos os cursos. Para isso, utilize o comando group by.*/

select d.nome as NomeDaDisciplina, avg(h.nota) as MediaDasNotas
from Disciplina d
join Historico h on d.idDisciplina = h.idDisciplina
group by d.nome;

/* 6. Implemente uma consulta para listar o nome de todos os cursos e a quantidade de
alunos em cada curso. Para isso, utilize os comandos join e group by.*/

select c.nome as NomeDoCurso, COUNT(ac.idAluno) as QuantidadeDeAlunos
from Curso c
left join AlunoCurso ac on c.idCurso = ac.idCurso
group by c.nome;
