CREATE DATABASE Academico1
GO

USE Academico1
GO


CREATE TABLE Coordenador
(
idcoord smallint NOT NULL,
nome varchar(40) NOT NULL,
cpf varchar(14) NOT NULL,
CONSTRAINT PK_coord PRIMARY KEY (idcoord),
CONSTRAINT AK_coord_cpf UNIQUE (cpf)
);

CREATE TABLE Curso
(
idcurso smallint NOT NULL,
nome varchar(40) NOT NULL,
periodos smallint NOT NULL,
idcoord smallint NOT NULL,
CONSTRAINT PK_curso PRIMARY KEY (idcurso),
CONSTRAINT AK_curso_nome UNIQUE (nome),
/* Relacionamento curso/coordernador */
CONSTRAINT FK_curso_coordernador FOREIGN KEY (idcoord) REFERENCES Coordenador
);

CREATE TABLE Aluno
(
idaluno smallint NOT NULL,
nome varchar(40) NOT NULL,
sexo varchar(1) NOT NULL,
cpf varchar(14) NOT NULL,
dtnasc date NOT NULL,
matr varchar(11) NOT NULL,
email varchar(40) NULL,
cidade varchar(40) NOT NULL,
bairro varchar(40) NOT NULL,
cep varchar(10) NOT NULL,
rua varchar(40) NOT NULL,
numero varchar(3) NOT NULL,
idcurso smallint NOT NULL,
CONSTRAINT PK_aluno PRIMARY KEY (idaluno),
CONSTRAINT CK_aluno_sexo CHECK (sexo = 'M' or sexo = 'F'),
CONSTRAINT AK_aluno_cpf UNIQUE (cpf),
CONSTRAINT AK_aluno_matr UNIQUE (matr),
/* Relacionamento aluno/curso */
CONSTRAINT FK_aluno_curso FOREIGN KEY (idcurso) REFERENCES Curso
);

CREATE TABLE FoneAluno
(
idaluno smallint NOT NULL,
fone varchar(10)
/* Relacionamento aluno/telefone */
CONSTRAINT FK_fonealuno_aluno FOREIGN KEY (idaluno) REFERENCES Aluno
CONSTRAINT PK_fonealuno PRIMARY KEY (idaluno, fone),
);

CREATE TABLE Departamento
(
iddepar smallint NOT NULL,
nome varchar(40) NOT NULL,
CONSTRAINT PK_depar PRIMARY KEY (iddepar),
CONSTRAINT AK_depar_nome UNIQUE (nome)
);

CREATE TABLE Disciplina
(
iddisc smallint NOT NULL,
iddepar smallint NOT NULL,
nome varchar(40) NOT NULL,
cargahor smallint NOT NULL,
CONSTRAINT PK_disc PRIMARY KEY (iddisc),
CONSTRAINT AK_disc_nome UNIQUE (nome),
/* Relacionamento disciplina/departamento */
CONSTRAINT FK_disciplina_departamento FOREIGN KEY (iddepar) REFERENCES Departamento
);

/* Auto-relacionamento disciplina/pre-requisito */
CREATE TABLE PreRequisito
(
iddisc smallint NOT NULL,
CONSTRAINT FK_disciplina_prerequisito FOREIGN KEY (iddisc) REFERENCES Disciplina,
CONSTRAINT FK_disciplina_prerequisito1 FOREIGN KEY (iddisc) REFERENCES Disciplina,
CONSTRAINT PK_prerequisito PRIMARY KEY (iddisc)
);

CREATE TABLE Ppc
(
idppc smallint NOT NULL,
codigo varchar(10) NOT NULL,
periodo varchar(2) NOT NULL
CONSTRAINT PK_ppc PRIMARY KEY (idppc),
CONSTRAINT AK_codigo UNIQUE (codigo),
);

/* Relacionamento ternário curso/disciplina/ppc */
CREATE TABLE Possui
(
idcurso smallint NOT NULL,
iddisc smallint NOT NULL,
idppc smallint NOT NULL,
CONSTRAINT FK_possui_curso FOREIGN KEY (idcurso) REFERENCES Curso,
CONSTRAINT FK_possui_disciplina FOREIGN KEY (iddisc) REFERENCES Disciplina,
CONSTRAINT FK_possui_ppc FOREIGN KEY (idppc) REFERENCES Ppc,
CONSTRAINT PK_possui PRIMARY KEY (idcurso, iddisc, idppc),
);

CREATE TABLE Professor
(
idprof smallint NOT NULL,
nome varchar(40) NOT NULL,
cpf varchar(14) NOT NULL,
sexo varchar(1) NOT NULL,
dtnasc date NOT NULL,
email varchar(40) NOT NULL,
CONSTRAINT PK_prof PRIMARY KEY (idprof),
CONSTRAINT AK_professor_cpf UNIQUE (cpf),
CONSTRAINT CK_professor_sexo CHECK (sexo = 'M' or sexo = 'F')
);

CREATE TABLE Fixo
(
idprof smallint NOT NULL,
salario smallint NOT NULL,
gratificaao smallint NOT NULL,
CONSTRAINT CK_fixo_salfixo CHECK (salario > 0),
CONSTRAINT FK_fixo_professor FOREIGN KEY (idprof) REFERENCES Professor,
CONSTRAINT PK_fixo PRIMARY KEY (idprof)
);

CREATE TABLE Temporario
(
idprof smallint NOT NULL,
salario smallint NOT NULL,
contrato smallint NOT NULL,
CONSTRAINT CK_fixo_saltemp CHECK (salario > 0),
CONSTRAINT FK_temp_professor FOREIGN KEY (idprof) REFERENCES Professor,
CONSTRAINT PK_temporario PRIMARY KEY (idprof)
);


/* Relacionamento disciplina/professor */
CREATE TABLE DiscProf
(
iddisc smallint NOT NULL,    
idprof smallint NOT NULL,
periodo smallint NOT NULL,
CONSTRAINT FK_discprof_disciplina FOREIGN KEY (iddisc) REFERENCES Disciplina,
CONSTRAINT FK_discprof_professor FOREIGN KEY (idprof) REFERENCES Professor,
CONSTRAINT PK_discprof PRIMARY KEY (iddisc,idprof,periodo)
);

/* Relacionamento professor/foneprofessor */
CREATE TABLE FoneProfessor
(
idprof smallint NOT NULL,
fone varchar(10) NOT NULL,
CONSTRAINT FK_foneprofessor_professor FOREIGN KEY (idprof) REFERENCES Professor,
CONSTRAINT PK_foneprofessor PRIMARY KEY (idprof, fone)
);

CREATE TABLE Dependente
(
iddepen smallint NOT NULL,
idprof smallint NOT NULL,
nome varchar(40) NOT NULL,
cpf varchar(14) NOT NULL,
sexo varchar(1) NOT NULL,
dtnasc date NOT NULL,
CONSTRAINT AK_dependente_cpf UNIQUE (cpf),
CONSTRAINT CK_dependente_sexo CHECK (sexo = 'M' or sexo = 'F'),
/* Relacionamento identificador dependente/prof */
CONSTRAINT FK_dependente_professor FOREIGN KEY (idprof) REFERENCES Professor,
CONSTRAINT PK_dependente PRIMARY KEY (iddepen,idprof)
);

CREATE TABLE Projeto
(
idprojeto smallint NOT NULL,
nome varchar(40) NOT NULL,
CONSTRAINT PK_projeto PRIMARY KEY (idprojeto),
CONSTRAINT AK_projeto_nome UNIQUE (nome),
);

CREATE TABLE Paga
(
idaluno smallint NOT NULL,
iddisc smallint NOT NULL,
CONSTRAINT FK_paga_aluno FOREIGN KEY (idaluno) REFERENCES Aluno,
CONSTRAINT FK_paga_disc FOREIGN KEY (iddisc) REFERENCES Disciplina,
CONSTRAINT PK_paga PRIMARY KEY (idaluno, iddisc)
);

CREATE TABLE Participa
(
idaluno smallint NOT NULL,
iddisc smallint NOT NULL,
idprojeto smallint NOT NULL,
CONSTRAINT FK_participa_aluno FOREIGN KEY (idaluno) REFERENCES Aluno,
CONSTRAINT FK_participa_disc FOREIGN KEY (iddisc) REFERENCES Disciplina,
CONSTRAINT FK_participa_projeto FOREIGN KEY (idprojeto) REFERENCES Projeto,
CONSTRAINT PK_participa PRIMARY KEY (idaluno, iddisc, idprojeto)
);

INSERT INTO Coordenador VALUES (1,'João','000.000.000-00');
INSERT INTO Coordenador VALUES (2,'Maria','111.111.111-11');
INSERT INTO Coordenador VALUES (3,'Thiago','222.222.222-22');
INSERT INTO Coordenador VALUES (4,'José','333.333.333-33');
INSERT INTO Coordenador VALUES (5,'Luciana','444.444.444-44');

INSERT Curso VALUES (1,'Sistemas para Internet',8,1);
INSERT Curso VALUES (2,'Redes de Computadores',8,2);
INSERT Curso VALUES (3,'Administração',10,3);
INSERT Curso VALUES (4,'Medicina',12,4);
INSERT Curso VALUES (5,'Direito',12,5);

INSERT Aluno VALUES (1,'Guilherme','M','555.555.555-55','14/12/1999','20182000000','guilherme@gmail.com','João Pessoa','Bairro V','0000000000','Rua V','123',1);
INSERT Aluno VALUES (2,'Andréia','F','666.666.666-66','01/01/1999','20182111111','andreia@gmail.com','João Pessoa','Bairro W','1111111111','Rua W','456',1);
INSERT Aluno VALUES (3,'Hidekazu','M','777.777.777-77','02/02/1997','20182222222','hidekazu@gmail.com','Bayeux','Bairro X','2222222222','Rua X','789',2);
INSERT Aluno VALUES (4,'Vanessa','F','888.888.888-88','03/03/1995','20182333333','vanessa@gmail.com','Bayeux','Bairro Y','3333333333','Rua Y','101',3);
INSERT Aluno VALUES (5,'Adriano','M','999.999.999-99','04/04/1990','20182444444','adriano@gmail.com','João Pessoa','Bairro Z','4444444444','Rua Z','102',5);

INSERT FoneAluno VALUES (1,'8611112222');
INSERT FoneAluno VALUES (2,'8622223333');
INSERT FoneAluno VALUES (3,'8633334444');
INSERT FoneAluno VALUES (4,'8644445555');
INSERT FoneAluno VALUES (5,'8655556666');

INSERT Departamento VALUES (1,'Departamento X');
INSERT Departamento VALUES (2,'Departamento Y');
INSERT Departamento VALUES (3,'Departamento Z');
INSERT Departamento VALUES (4,'Departamento V');
INSERT Departamento VALUES (5,'Departamento W');

INSERT Disciplina VALUES (1,1,'Banco de Dados',200);
INSERT Disciplina VALUES (2,2,'Protocolos de Interconexão de Redes',250);
INSERT Disciplina VALUES (3,3,'Economia',100);
INSERT Disciplina VALUES (4,4,'Biologia',300);
INSERT Disciplina VALUES (5,5,'Direito do Trabalho',150);
INSERT Disciplina VALUES (6,1,'Fundamentos da Computação',200);
INSERT Disciplina VALUES (7,2,'Introdução a Redes',200);

INSERT PreRequisito VALUES (1);
INSERT PreRequisito VALUES (2);
INSERT PreRequisito VALUES (6);
INSERT PreRequisito VALUES (7);
INSERT PreRequisito VALUES (3);

INSERT Ppc VALUES (1,'0101010101','1');
INSERT Ppc VALUES (2,'0202020202','1');
INSERT Ppc VALUES (3,'0303030303','4');
INSERT Ppc VALUES (4,'0404040404','6');
INSERT Ppc VALUES (5,'0505050505','5');

INSERT Possui VALUES (1,6,1);
INSERT Possui VALUES (2,2,2);
INSERT Possui VALUES (3,3,3);
INSERT Possui VALUES (4,4,4);
INSERT Possui VALUES (5,5,5);

INSERT Professor VALUES (1,'Jorge','000.000.000-11','M','16/05/1970','jorge@gmail.com');
INSERT Professor VALUES (2,'André','111.111.111-22','M','05/12/1983','andre@gmail.com');
INSERT Professor VALUES (3,'Lucélia','222.222.222-33','M','22/11/1983','lucelia@gmail.com');
INSERT Professor VALUES (4,'Luíza','123.456.789-44','M','04/09/1988','luiza@gmail.com');
INSERT Professor VALUES (5,'Gustavo','789.456.123-55','M','14/12/1995','gustavo@gmail.com');

INSERT Fixo VALUES (1,'17000','1000');
INSERT Fixo VALUES (2,'17000','1000');
INSERT Fixo VALUES (3,'18000','1000');

INSERT Temporario VALUES (4,'7000',6);
INSERT Temporario VALUES (5,'7000',6);

INSERT DiscProf VALUES (1,2,2);
INSERT DiscProf VALUES (2,1,2);
INSERT DiscProf VALUES (3,4,3);
INSERT DiscProf VALUES (4,3,5);
INSERT DiscProf VALUES (5,5,6);

INSERT FoneProfessor VALUES (1,'8666667777');
INSERT FoneProfessor VALUES (2,'8677778888');
INSERT FoneProfessor VALUES (3,'8677778888');
INSERT FoneProfessor VALUES (4,'8688889999');
INSERT FoneProfessor VALUES (5,'8699991010');

INSERT Dependente VALUES (1,1,'Emanuel','xxx.xxx.xxx-xx','M','13/07/2003');
INSERT Dependente VALUES (2,3,'Julia','yyy.yyy.yyy-yy','F','26/03/2010');

INSERT Projeto VALUES (1,'Criação de Compilador');

INSERT Paga VALUES(1,1);
INSERT Paga VALUES(1,2);
INSERT Paga VALUES(2,3);
INSERT Paga VALUES(3,4);
INSERT Paga VALUES(5,5);

INSERT Participa VALUES (1,2,1);
INSERT Participa VALUES (2,2,1);



