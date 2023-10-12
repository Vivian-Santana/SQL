-- Implementação
create database faculdade;
use faculdade;

create table Aluno(
idAluno int not null,
matricula varchar(10) not null,
nome varchar(50) not null,
primary key(idAluno) 
);

create table Curso(
idCurso int not null,
nome varchar(50) not null,
primary key(idCurso) 
);

create table Disciplina(
idDisciplina int not null,
nome varchar(50) not null,
cargaHoraria int not null,
primary key(idDisciplina) 
);

-- Entidade associativa
create table AlunoCurso(
idAlunoCurso int ,
anoEntrada int not null,
idAluno int, foreign key (idAluno) references Aluno(idAluno),
idCurso int, foreign key (idCurso) references Curso(idCurso)
);

-- Entidade associativa
create table Historico (
nota float not null,
dataHistorico date not null,
idAluno int, foreign key (idAluno) references Aluno (idAluno),
idDisciplina int, foreign key (idDisciplina) references Disciplina (idDisciplina)
);

create table Grade (
idGrade int not null,
ano int not null,
cargaHorariaTotal int not null,
primary key(idGrade),
idCurso int, foreign key (idCurso) references Curso (idCurso)
);

-- Entidade associativa
create table GradeDisciplina (
idGrade int, foreign key (idGrade) references Grade (idGrade),
idDisciplina int, foreign key (idDisciplina) references Disciplina (idDisciplina)
);
