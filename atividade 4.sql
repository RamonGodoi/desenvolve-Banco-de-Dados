CREATE DATABASE faculdade;

USE faculdade;

CREATE TABLE departamento(
    id int NOT NULL AUTO_INCREMENT,
    nome varchar(255) NOT NULL,
    local varchar(255),
    PRIMARY KEY (id)
);

CREATE TABLE aluno(
    nome varchar(255) NOT NULL,
    data_nascimento date,
    matricula varchar(10) NOT NULL,
    endereco varchar(255),
    PRIMARY KEY (matricula)
);

CREATE TABLE disciplina(
    nome varchar(100) NOT NULL,
    carga_horario int NOT NULL DEFAULT 30,
    ementa text,
    PRIMARY KEY (nome)
) CREATE TABLE professor(
    inicio_contrato date,
    nome varchar(255) NOT NULL,
    cpf varchar(11) NOT NULL,
    depto_id int,
    PRIMARY KEY (cpf),
    FOREIGN KEY (depto_id) REFERENCES departamento(id)
) CREATE TABLE professor_contato(
    prof_cpf varchar(11) NOT NULL,
    contato varchar(14) NOT NULL,
    FOREIGN KEY (prof_cpf) REFERENCES professor(cpf),
    CONSTRAINT PK_professor_contato PRIMARY KEY (prof_cpf, contato)
);

CREATE TABLE avaliacao(
    prof_cpf varchar(11) NOT NULL,
    data_hora datetime NOT NULL,
    comentario varchar(500),
    nota int,
    FOREIGN KEY (prof_cpf) REFERENCES professor(cpf),
    PRIMARY KEY (prof_cpf, data_hora)
);

ALTER TABLE
    departamento
ADD
    prof_chefe_cpf varchar(11),
ADD
    FOREIGN KEY (prof_chefe_cpf) REFERENCES professor(cpf);

ALTER TABLE
    disciplina
ADD
    disc_pre_requisito varchar(100),
ADD
    FOREIGN KEY (disc_pre_requisito) REFERENCES disciplina(nome);

CREATE TABLE aluno_disciplina(
    matricula varchar(10) NOT NULL,
    nome varchar (100) NOT NULL,
    PRIMARY KEY (matricula, nome),
    FOREIGN KEY (matricula) REFERENCES aluno (matricula),
    FOREIGN KEY (nome) REFERENCES disciplina (nome)
);

CREATE TABLE professor_disciplina(
    cpf varchar(11) NOT NULL,
    nome varchar (100) NOT NULL,
    PRIMARY KEY (cpf, nome),
    FOREIGN KEY (cpf) REFERENCES professor(cpf),
    FOREIGN KEY (nome) REFERENCES disciplina(nome)
);

INSERT INTO departamento (nome, local)
VALUES ('Ciência da Computação', 'Bloco A - Sala 101');

INSERT INTO professor (inicio_contrato, nome, cpf, depto_id)
VALUES 
('2015-03-01', 'Dr. João Silva', '12345678901', 1),
('2018-07-15', 'Dra. Maria Oliveira', '98765432100', 1);

INSERT INTO professor_contato (prof_cpf, contato)
VALUES
('12345678901', '11987654321'),
('12345678901', '11234567890'),
('98765432100', '21987654321');

INSERT INTO disciplina (nome, carga_horario, ementa)
VALUES 
('Algoritmos', 60, 'Introdução à lógica de programação e estruturas de controle.'),
('Banco de Dados', 60, 'Modelagem, SQL e administração de bancos de dados.'),
('Engenharia de Software', 45, 'Processos de desenvolvimento e gerenciamento de projetos de software.');

INSERT INTO aluno (nome, data_nascimento, matricula, endereco)
VALUES 
('Ana Souza', '2001-05-12', 'A001', 'Rua das Flores, 123'),
('Carlos Mendes', '2000-08-23', 'A002', 'Av. Brasil, 456'),
('Juliana Ferreira', '1999-12-15', 'A003', 'Rua Palmeiras, 789'),
('Rafael Lima', '2002-03-30', 'A004', 'Rua Santos Dumont, 101'),
('Beatriz Costa', '2001-07-19', 'A005', 'Av. Paulista, 202');

INSERT INTO aluno_disciplina (matricula, nome)
VALUES
('A001', 'Algoritmos'),
('A002', 'Banco de Dados'),
('A003', 'Engenharia de Software'),
('A004', 'Algoritmos'),
('A005', 'Banco de Dados');

INSERT INTO professor_disciplina (cpf, nome)
VALUES
('12345678901', 'Algoritmos'),
('98765432100', 'Banco de Dados'),
('12345678901', 'Engenharia de Software');
