/*  */

/* DELETA O SCHEMA DO BD SE EXISTIR */
DROP DATABASE IF EXISTS  biblioteca_pessoal_1s2026;

/* CRIA E SELECIONA UM SCHEMA DE BD */
CREATE DATABASE biblioteca_pessoal_1s2026;
USE biblioteca_pessoal_1s2026;

/* CRIA TABELAS, RELAÇÕES E RESTRIÇÕES */
CREATE TABLE usuario(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE categoria(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) UNIQUE,
    descricao TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE autor(
	id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL UNIQUE,
    ano_nascimento INT,
    ano_morte INT,
    apresentacao TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE editora(
	id_editora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL UNIQUE,
    cidade VARCHAR(255),
    estado VARCHAR(255),
    pais VARCHAR(255),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE livro(
	id_livro INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_autor INT,
    id_editora INT,
    id_categoria INT, 
    titulo VARCHAR(255) NOT NULL,
    sinopse TEXT,
    ano_publicacao INT,
    lido BOOLEAN DEFAULT(0),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
	CONSTRAINT fk_usuario_livro FOREIGN KEY (id_usuario) 
    REFERENCES usuario(id_usuario)
    ON DELETE CASCADE,
    
    CONSTRAINT fk_autor_livro FOREIGN KEY (id_autor) 
    REFERENCES autor(id_autor)
    ON DELETE RESTRICT,
    
    CONSTRAINT fk_editora_livro FOREIGN KEY (id_editora) 
    REFERENCES editora(id_editora)
    ON DELETE RESTRICT,
    
    CONSTRAINT fk_categoria_livro FOREIGN KEY (id_categoria) 
    REFERENCES categoria(id_categoria)
    ON DELETE RESTRICT
);
/** USUÁRIOS */
INSERT INTO usuario (nome, email, senha) VALUES
('Ana Silva', 'ana@email.com', '123'),
('Bruno Souza', 'bruno@email.com', '123'),
('Carla Mendes', 'carla@email.com', '123');

/** CATEGORIAS */
INSERT INTO categoria (nome, descricao) VALUES
('Ficção Científica', 'Livros com temas futuristas e científicos'),
('Fantasia', 'Mundos imaginários e mágicos'),
('Romance', 'Histórias centradas em relações humanas'),
('Clássicos', 'Obras consagradas da literatura'),
('Suspense', 'Narrativas de tensão e mistério'),
('Filosofia', 'Reflexões filosóficas');

/** AUTORES */
INSERT INTO autor (nome, ano_nascimento, ano_morte) VALUES
('George Orwell', 1903, 1950),
('J.R.R. Tolkien', 1892, 1973),
('Jane Austen', 1775, 1817),
('Machado de Assis', 1839, 1908),
('Agatha Christie', 1890, 1976),
('Isaac Asimov', 1920, 1992),
('Fyodor Dostoevsky', 1821, 1881),
('J.K. Rowling', 1965, NULL),
('Stephen King', 1947, NULL),
('Aldous Huxley', 1894, 1963);

/** EDITORAS */
INSERT INTO editora (nome, cidade, estado, pais) VALUES
('Penguin Books', 'Londres', NULL, 'Reino Unido'),
('HarperCollins', 'Nova York', 'NY', 'EUA'),
('Companhia das Letras', 'São Paulo', 'SP', 'Brasil'),
('Editora Record', 'Rio de Janeiro', 'RJ', 'Brasil'),
('Rocco', 'Rio de Janeiro', 'RJ', 'Brasil');

/** LIVROS (42 REGISTROS) */

/** Usuário 1 */
INSERT INTO livro (id_usuario, id_autor, id_editora, id_categoria, titulo, ano_publicacao, lido) VALUES
(1,1,1,4,'1984',1949,1),
(1,1,1,1,'Animal Farm',1945,1),
(1,2,1,2,'The Hobbit',1937,1),
(1,2,1,2,'The Lord of the Rings',1954,0),
(1,3,1,3,'Pride and Prejudice',1813,1),
(1,3,1,3,'Sense and Sensibility',1811,0),
(1,4,3,4,'Dom Casmurro',1899,1),
(1,4,3,4,'Memórias Póstumas de Brás Cubas',1881,0),
(1,5,2,5,'Murder on the Orient Express',1934,1),
(1,5,2,5,'And Then There Were None',1939,0),
(1,6,2,1,'Foundation',1951,1),
(1,6,2,1,'I, Robot',1950,0),
(1,7,1,6,'Crime and Punishment',1866,1),
(1,7,1,6,'The Brothers Karamazov',1880,0);

/** Usuário 2 */
INSERT INTO livro (id_usuario, id_autor, id_editora, id_categoria, titulo, ano_publicacao, lido) VALUES
(2,8,5,2,'Harry Potter and the Sorcerer''s Stone',1997,1),
(2,8,5,2,'Harry Potter and the Chamber of Secrets',1998,1),
(2,8,5,2,'Harry Potter and the Prisoner of Azkaban',1999,0),
(2,9,2,5,'The Shining',1977,1),
(2,9,2,5,'It',1986,0),
(2,9,2,5,'Misery',1987,1),
(2,10,1,1,'Brave New World',1932,1),
(2,10,1,1,'Island',1962,0),
(2,1,1,1,'Homage to Catalonia',1938,0),
(2,6,2,1,'The Caves of Steel',1953,1),
(2,6,2,1,'The Naked Sun',1957,0),
(2,5,2,5,'Death on the Nile',1937,1),
(2,3,1,3,'Emma',1815,0),
(2,4,3,4,'Quincas Borba',1891,1);

/** Usuário 3 */
INSERT INTO livro (id_usuario, id_autor, id_editora, id_categoria, titulo, ano_publicacao, lido) VALUES
(3,7,1,6,'Notes from Underground',1864,1),
(3,7,1,6,'The Idiot',1869,0),
(3,2,1,2,'Silmarillion',1977,0),
(3,2,1,2,'Unfinished Tales',1980,0),
(3,8,5,2,'Harry Potter and the Goblet of Fire',2000,1),
(3,8,5,2,'Harry Potter and the Order of the Phoenix',2003,0),
(3,9,2,5,'Carrie',1974,1),
(3,9,2,5,'Pet Sematary',1983,0),
(3,10,1,1,'Doors of Perception',1954,1),
(3,6,2,1,'Prelude to Foundation',1988,0),
(3,6,2,1,'Forward the Foundation',1993,0),
(3,5,2,5,'The ABC Murders',1936,1),
(3,4,3,4,'Helena',1876,0),
(3,3,1,3,'Mansfield Park',1814,1);
/* CARREGA TODOS OS LIVROS */
select * from livro;

/*
Carrega todos os livros (titulo)
e busca o nome do autor
*/
SELECT
	t2.nome as nome_autor,
	t1.titulo
FROM
	livro t1
JOIN
	autor t2 ON (t1.id_autor = t2.id_autor);
    
/*
Carrega todos os livros (titulo)
e busca o nome do autor
e busca o nome da categoria
*/
SELECT 
    t2.nome AS nome_autor, t1.titulo, t3.nome AS nome_categoria
FROM
    livro t1
        JOIN
    autor t2 ON (t1.id_autor = t2.id_autor)
        JOIN
    categoria t3 ON (t1.id_categoria = t3.id_categoria);
    
/* Busca título e 
todos os campos de nome das relações*/    
SELECT 
    t4.nome as nome_usuario,
    t2.nome AS nome_autor, 
    t1.titulo, 
    t3.nome AS nome_categoria,
    t5.nome as nome_editora
FROM
    livro t1
JOIN
    autor t2 ON (t1.id_autor = t2.id_autor)
JOIN
    categoria t3 ON (t1.id_categoria = t3.id_categoria)
JOIN
    usuario t4 ON (t1.id_usuario = t4.id_usuario)
JOIN
    editora t5 ON (t1.id_editora = t5.id_editora);
    /* Busca título e 
todos os campos de nome das relações*/  
SELECT 
    t4.nome as nome_usuario,
    t2.nome AS nome_autor, 
    t1.titulo, 
    t3.nome AS nome_categoria,
    t5.nome as nome_editora
FROM
    livro t1
JOIN
    autor t2 ON (t1.id_autor = t2.id_autor)
JOIN
    categoria t3 ON (t1.id_categoria = t3.id_categoria)
JOIN
    usuario t4 ON (t1.id_usuario = t4.id_usuario)
JOIN
    editora t5 ON (t1.id_editora = t5.id_editora);
    
    
/* Conta quantidade de livros na tabela */
SELECT
	COUNT(*)
FROM
	LIVRO;

/* Conta quantidade de livros na tabela 
	Para um usuário específico
*/
SELECT
	COUNT(*)
FROM
	LIVRO
WHERE
	ID_USUARIO=1;
    
/* DELETA O LIVRO DE ID 1*/    
DELETE FROM LIVRO WHERE ID_LIVRO = 1;    

/* Conta quantidade de livros na tabela 
	para todos os usuários
*/
SELECT
	ID_USUARIO,
	COUNT(*)
FROM
	LIVRO
GROUP BY
	ID_USUARIO;

/* Conta quantidade de livros na tabela 
	para todos os usuários POR NOME
*/
SELECT
	t1.ID_USUARIO,
    t2.NOME,
	COUNT(t1.ID_LIVRO) AS QTD_LIVRO 
FROM
	LIVRO t1
JOIN
	USUARIO t2 ON (t1.ID_USUARIO = t2.ID_USUARIO)
GROUP BY
	t1.ID_USUARIO,
    t2.NOME;
    
/* Conta quantidade de livros na tabela 
	para todos as categorias POR NOME
*/
SELECT
	t1.ID_CATEGORIA,
    t2.NOME,
	COUNT(t1.ID_LIVRO) AS QTD_LIVRO 
FROM
	LIVRO t1
JOIN
	CATEGORIA t2 ON (t1.ID_CATEGORIA = t2.ID_CATEGORIA)
GROUP BY
	t1.ID_CATEGORIA,
    t2.NOME;
    
/* Conta quantidade de livros na tabela 
	para todos os usuários POR NOME
*/
SELECT
	t1.ID_USUARIO,
    t1.ID_CATEGORIA,
    t2.NOME AS USUARIO,
    t3.NOME AS CATEGORIA,
	COUNT(t1.ID_LIVRO) AS QTD_LIVRO 
FROM
	LIVRO t1
JOIN
	USUARIO t2 ON (t1.ID_USUARIO = t2.ID_USUARIO)
JOIN
	CATEGORIA t3 ON (t1.ID_CATEGORIA = t3.ID_CATEGORIA)
GROUP BY
	t1.ID_USUARIO,
    t1.ID_CATEGORIA,
    t2.NOME,
    t3.NOME
ORDER BY
t3.NOME, QTD_LIVRO DESC;


/* Conta quantidade E PERCENTUAL de livros na tabela 
	para todos as categorias POR NOME
*/
SELECT
	t1.ID_CATEGORIA,
    t2.NOME,
	COUNT(t1.ID_LIVRO) AS QTD_LIVRO,
    (COUNT(t1.ID_LIVRO)/(SELECT COUNT(*) FROM LIVRO))*100 AS PCT
FROM
	LIVRO t1
JOIN
	CATEGORIA t2 ON (t1.ID_CATEGORIA = t2.ID_CATEGORIA)
GROUP BY
	t1.ID_CATEGORIA,
    t2.NOME
ORDER BY
	PCT DESC;
    /**/
/* Mostra todos os databases*/
show databases;

/* Seleciona um DB específico */
USE biblioteca_pessoal_1s2026;

/* Visualiza as tabelas de um DB*/
SHOW tables;

/* INSERE DADOS NO BD */
INSERT INTO usuario(nome, email, senha)
VALUES
	("João", "joao@email.com", "123"),
    ("Pedro", "pedro@email.com", "123");

INSERT INTO autor(nome)
VALUES ("Santo Agostinho"),
		("Aristóteles");

INSERT INTO editora(nome)
VALUES ("L&M"),
	("Companhia das Letras");

INSERT INTO categoria(nome) 
VALUES ("Filosofiaaa"),
	("Religião");

/* Visualiza dados cadastrados*/
SELECT * FROM usuario;
SELECT * FROM autor;
SELECT * FROM editora;
SELECT * FROM categoria;

/* Cadastra 2 livros para cada usuário*/
INSERT INTO livro (id_usuario, id_autor, id_editora,
	id_categoria, titulo, sinopse, ano_publicacao)
VALUES 
	(2, 3, 2, 2, "Ética a Nicômaco", "", 2011),
    (2, 3, 3, 2, "Política", "", 2007),
    (3, 2, 2, 3, "Confissões", "", 2015),
    (3, 2, 2, 3, "Sobre a vida feliz", "", 2001);
    
SELECT * FROM livro;

SELECT * FROM categoria;

/* REMOVE UM REGISTRO ESPECÍFICO */
DELETE FROM categoria 
WHERE id_categoria = 1;

SELECT * FROM categoria;

/* ATUALIZA UM REGISTRO ESPECÍFICO */
UPDATE categoria
SET nome = "Filosofia"
WHERE id_categoria=2;

select * from livro;
UPDATE livro
SET sinopse = "Reflexões sobre a justa medida para a felicidade."
WHERE id_livro=8;

/* CONSULTA DADOS EM MÚLTIPLAS TABELAS */
SELECT 
	t1.id_autor,
    t2.nome as autor,
	t1.titulo,
    t1.sinopse
FROM livro t1
LEFT JOIN autor t2 ON (t1.id_autor = t2.id_autor);

SELECT
	t1.ID_USUARIO,
    t2.NOME,
    count(t1.ID_LIVRO) AS QTD_LIVRO,
    sum(t1.LIDO) AS QTD_LIVRO_LIDO,
    round((sum(t1.LIDO) / count(t1.ID_LIVRO))*100, 2) AS PCT_LIDO,
    max(t1.ANO_PUBLICAÇAO) AS ANO_MAIS_RECENTE,
    min(t1.ANO_PUBLICAÇAO) AS ANO_MAIS_ANTIGO
FROM
	LIVRO t1
JOIN
	USUARIO t2 on (t1.ID_USUARIO = t2.ID_USUARIO)
GROUP BY
	t1.ID_USUARIO,
    t2.NOME
;

/*
	CALCULA A IDADE DOS AULTORES
*/
SELECT

AVG(IF(ANO_MORTE > 0, ANO_MORTE, YEAR(CURRENT_DATE())) - ANO_NASCIMENTO) AS IDADE_MEDIA_AUTOR

FROM
	AUTOR;
