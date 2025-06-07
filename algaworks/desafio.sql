DROP DATABASE escola;
CREATE DATABASE escola;
USE escola;

CREATE TABLE aluno (
RA INTEGER AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100),
    email VARCHAR(100),
    idade INT,
	serie VARCHAR(3)
) ENGINE=InnoDB;

CREATE TABLE professor (
cod_professor INTEGER AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(15),
    diploma BOOLEAN
) ENGINE=InnoDB;

CREATE TABLE curso (
cod_curso INTEGER AUTO_INCREMENT PRIMARY KEY,
	disciplina VARCHAR(100),
    descr TEXT,
    carga_horaria INT,
    id_professor INTEGER,
    FOREIGN KEY (id_professor) REFERENCES professor(cod_professor)
) ENGINE=InnoDB;

CREATE TABLE matricula (
cod_matricula BIGINT AUTO_INCREMENT PRIMARY KEY,
	cod_aluno INTEGER,
    cod_curso INTEGER,
    data_matricula DATE,
    FOREIGN KEY (cod_aluno) REFERENCES aluno(RA),
    FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso)
) ENGINE=InnoDB;

INSERT INTO aluno(nome, email, idade, serie) VALUES 
("Maria Clara", "maria@maria.com", 17, "M3"),
("Lucas Barbosa", "lucas@lucas.com", 14, "F9"),
("Renata Pires", "renata@renata.com", 16, "M2"),
("Yasmim Tourinho", "yasmim@escola.com", 12, "F7"),
("Joana Souza", "joana@escola.com", 11, "F6"),
("Ana Julia", "anajulia@escola.com", 13, "F8"),
("Rejane Silva", "rejane@escola.com", 15, "M1"),
("Ana Clara", "anaclara@escola.com", 10, "F5"),
("Pedro Henrique", "pedro@escola.com", 17, "M3"),
("Lucas Martins", "lucasm@escola.com", 16, "M2"),
("Mariana Costa", "mariana@escola.com", 12, "F7"),
("Gabriel Almeida", "gabriel@escola.com", 14, "F9"),
("Rafaela Pinto", "rafaela@escola.com", 15, "M1");

INSERT INTO professor(nome, email, telefone, diploma) VALUES 
("Lucas Branquinho", "lucas.branquinho@escola.com", 40028922, TRUE),
("Ludmilla Italia", "ludmilla.italia@escola.com", 11987654321, TRUE),
("Carlos Reis", "carlos.reis@escola.com", 21912345678, TRUE),
("Thayna Coelho", "thayna.coelho@escola.com", 31998765432, FALSE),
("Lais Alves", "lais.alves@escola.com", 41911223344, TRUE);

INSERT INTO curso(disciplina, descr, carga_horaria, id_professor) VALUES 
("Matemática", "Geometria e Álgebra", 2, 1),
("Português", "Gramática e Interpretação de Texto", 3, 5),
("História", "História do Brasil e Geral", 2, 3),
("Ciências", "Biologia, Física e Química básicas", 2, 1),
("Educação Física", "Atividades físicas e esportes", 1, 2),
("Artes", "Expressão artística e cultura", 1, 4),
("Programação", "Estrutura de Dados", 1, 2);

-- Massa de dados para a tabela matricula (distribuída ao longo de 2014)
INSERT INTO matricula (cod_aluno, cod_curso, data_matricula) VALUES
(1, 1, '2014-01-15'),
(2, 2, '2014-01-20'),
(3, 3, '2014-02-05'),
(4, 4, '2014-02-18'),
(5, 5, '2014-03-02'),
(6, 6, '2014-03-15'),
(7, 1, '2014-04-01'),
(8, 2, '2014-04-16'),
(9, 3, '2014-05-03'),
(10, 4, '2014-05-19'),
(11, 5, '2014-06-07'),
(12, 6, '2014-06-22'),
(13, 1, '2014-07-01'),
(1, 2, '2014-07-18'),
(2, 3, '2014-08-04'),
(3, 4, '2014-08-20'),
(4, 5, '2014-09-05'),
(5, 6, '2014-09-21'),
(6, 1, '2014-10-09'),
(7, 2, '2014-10-25'),
(8, 3, '2014-11-10'),
(9, 4, '2014-11-24'),
(10, 5, '2014-12-08'),
(11, 6, '2014-12-20');

SELECT * FROM aluno;
SELECT * FROM professor;
SELECT * FROM curso;
SELECT * FROM matricula;

-- Liste os nomes dos alunos que fizeram matrícula em Janeiro de 2014.
SELECT DISTINCT a.nome
	 , m.data_matricula
FROM matricula m
   , aluno a
WHERE month(m.data_matricula) = 1 
AND year(m.data_matricula) = 2014
AND a.RA = m.cod_aluno;

-- Liste os nomes dos cursos de um determinado professor.
SELECT DISTINCT p.nome
	 , c.descr
 FROM professor p
	, curso c
WHERE p.cod_professor = c.id_professor
 AND p.nome = "Lucas Branquinho";

-- Liste os nomes dos alunos de um determinado curso.
SELECT a.nome
	 , c.descr
 FROM aluno a
	, curso c
    , matricula m
WHERE m.cod_aluno = a.RA
AND m.cod_curso = c.cod_curso
AND a.nome = "Maria Clara";

-- Liste os nomes dos professores que têm alunos matriculados em seus cursos.
SELECT DISTINCT p.nome
			  , c.descr
 FROM professor p
	, matricula m
    , curso c
WHERE p.cod_professor = c.id_professor
AND m.cod_curso = c.cod_curso;


