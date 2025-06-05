CREATE DATABASE escola;
USE escola;

DROP DATABASE escola;

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

INSERT INTO curso(disciplina, descr, carga_horaria, id_professor) VALUES 
("Matemática", "Geometria e Álgebra", 2, 1),
("Português", "Gramática e Interpretação de Texto", 3, 5),
("História", "História do Brasil e Geral", 2, 3),
("Ciências", "Biologia, Física e Química básicas", 2, 1),
("Educação Física", "Atividades físicas e esportes", 1, 2),
("Artes", "Expressão artística e cultura", 1, 4);

TRUNCATE curso;

INSERT INTO professor(nome, email, telefone, diploma) VALUES 
("Lucas Branquinho", "lucas.branquinho@escola.com", 40028922, TRUE),
("Ludmilla Italia", "ludmilla.italia@escola.com", 11987654321, TRUE),
("Carlos Reis", "carlos.reis@escola.com", 21912345678, TRUE),
("Thayna Coelho", "thayna.coelho@escola.com", 31998765432, FALSE),
("Lais Alves", "lais.alves@escola.com", 41911223344, TRUE);

SELECT * FROM aluno;
SELECT * FROM professor;
SELECT * FROM curso