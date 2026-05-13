/* DELETA O SCHEMA DO BD SE EXISTIR */
DROP DATABASE IF EXISTS biblioteca_pessoal_1s2026;

/* CRIA E SELECIONA O BANCO */
CREATE DATABASE biblioteca_pessoal_1s2026;
USE biblioteca_pessoal_1s2026;

/* =========================
   TABELAS
========================= */

CREATE TABLE usuario(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE categoria(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL UNIQUE,
    descricao TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE autor(
	id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL UNIQUE,
    ano_nascimento INT,
    ano_morte INT,
    apresentacao TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE editora(
	id_editora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL UNIQUE,
    cidade VARCHAR(255),
    estado VARCHAR(255),
    pais VARCHAR(255),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE livro(
	id_livro INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_autor INT NOT NULL,
    id_editora INT NOT NULL,
    id_categoria INT NOT NULL,
    
    titulo VARCHAR(255) NOT NULL,
    sinopse TEXT,
    ano_publicacao INT,
    lido BOOLEAN DEFAULT 0,
    
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_usuario_livro 
    FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON DELETE CASCADE,
    
    CONSTRAINT fk_autor_livro
    FOREIGN KEY (id_autor)
    REFERENCES autor(id_autor)
    ON DELETE RESTRICT,
    
    CONSTRAINT fk_editora_livro
    FOREIGN KEY (id_editora)
    REFERENCES editora(id_editora)
    ON DELETE RESTRICT,
    
    CONSTRAINT fk_categoria_livro
    FOREIGN KEY (id_categoria)
    REFERENCES categoria(id_categoria)
    ON DELETE RESTRICT
);

/* =========================
   USUÁRIOS
========================= */

INSERT INTO usuario(nome, email, senha)
VALUES
('Ana Silva', 'ana@email.com', '123'),
('Bruno Souza', 'bruno@email.com', '123'),
('Carla Mendes', 'carla@email.com', '123');

/* =========================
   CATEGORIAS
========================= */

INSERT INTO categoria(nome, descricao)
VALUES
('Ficção Científica', 'Livros futuristas'),
('Fantasia', 'Mundos mágicos'),
('Romance', 'Relacionamentos humanos'),
('Clássicos', 'Obras clássicas'),
('Suspense', 'Mistério e tensão'),
('Filosofia', 'Reflexões filosóficas');

/* =========================
   AUTORES
========================= */

INSERT INTO autor(nome, ano_nascimento, ano_morte)
VALUES
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

/* =========================
   EDITORAS
========================= */

INSERT INTO editora(nome, cidade, estado, pais)
VALUES
('Penguin Books', 'Londres', NULL, 'Reino Unido'),
('HarperCollins', 'Nova York', 'NY', 'EUA'),
('Companhia das Letras', 'São Paulo', 'SP', 'Brasil'),
('Editora Record', 'Rio de Janeiro', 'RJ', 'Brasil'),
('Rocco', 'Rio de Janeiro', 'RJ', 'Brasil');

/* =========================
   LIVROS
========================= */

INSERT INTO livro (
	id_usuario,
    id_autor,
    id_editora,
    id_categoria,
    titulo,
    ano_publicacao,
    lido
)
VALUES
(1,1,1,4,'1984',1949,1),
(1,2,1,2,'The Hobbit',1937,1),
(1,4,3,4,'Dom Casmurro',1899,1),
(1,6,2,1,'Foundation',1951,1),

(2,8,5,2,'Harry Potter and the Sorcerer''s Stone',1997,1),
(2,9,2,5,'The Shining',1977,1),
(2,10,1,1,'Brave New World',1932,1),

(3,7,1,6,'Crime and Punishment',1866,1),
(3,5,2,5,'The ABC Murders',1936,1),
(3,3,1,3,'Mansfield Park',1814,1);

/* =========================
   NOVOS AUTORES
========================= */

INSERT INTO autor(nome)
VALUES
('Santo Agostinho'),
('Aristóteles');

/* =========================
   NOVAS EDITORAS
========================= */

INSERT INTO editora(nome)
VALUES
('L&M');

/* =========================
   NOVAS CATEGORIAS
========================= */

INSERT INTO categoria(nome)
VALUES
('Religião');

/* =========================
   NOVOS LIVROS
========================= */

/*
Santo Agostinho = id 11
Aristóteles = id 12

Religião = id 7
Filosofia = id 6
L&M = id 6
*/

INSERT INTO livro (
	id_usuario,
    id_autor,
    id_editora,
    id_categoria,
    titulo,
    sinopse,
    ano_publicacao
)
VALUES
(2,12,6,6,'Ética a Nicômaco',
'Reflexões filosóficas sobre ética e felicidade.',2011),

(2,12,6,6,'Política',
'Estudo sobre organização política.',2007),

(3,11,6,7,'Confissões',
'Obra autobiográfica de Santo Agostinho.',2015),

(3,11,6,7,'Sobre a Vida Feliz',
'Discussão sobre felicidade e espiritualidade.',2001);

/* =========================
   CONSULTAS
========================= */

/* TODOS OS LIVROS */
SELECT * FROM livro;

/* LIVROS + AUTORES */
SELECT
	t1.titulo,
    t2.nome AS nome_autor
FROM livro t1
JOIN autor t2
	ON t1.id_autor = t2.id_autor;

/* LIVROS + CATEGORIA */
SELECT
	t1.titulo,
    t2.nome AS autor,
    t3.nome AS categoria
FROM livro t1
JOIN autor t2
	ON t1.id_autor = t2.id_autor
JOIN categoria t3
	ON t1.id_categoria = t3.id_categoria;

/* RELATÓRIO COMPLETO */
SELECT
	t4.nome AS usuario,
    t1.titulo,
    t2.nome AS autor,
    t3.nome AS categoria,
    t5.nome AS editora
FROM livro t1
JOIN autor t2
	ON t1.id_autor = t2.id_autor
JOIN categoria t3
	ON t1.id_categoria = t3.id_categoria
JOIN usuario t4
	ON t1.id_usuario = t4.id_usuario
JOIN editora t5
	ON t1.id_editora = t5.id_editora;

/* QUANTIDADE TOTAL DE LIVROS */
SELECT COUNT(*) AS total_livros
FROM livro;

/* LIVROS POR USUÁRIO */
SELECT
	t2.nome,
    COUNT(t1.id_livro) AS qtd_livros
FROM livro t1
JOIN usuario t2
	ON t1.id_usuario = t2.id_usuario
GROUP BY
	t2.nome;

/* LIVROS POR CATEGORIA */
SELECT
	t2.nome AS categoria,
    COUNT(t1.id_livro) AS qtd_livros
FROM livro t1
JOIN categoria t2
	ON t1.id_categoria = t2.id_categoria
GROUP BY
	t2.nome;

/* PERCENTUAL POR CATEGORIA */
SELECT
	t2.nome AS categoria,
    COUNT(t1.id_livro) AS qtd_livros,
    ROUND(
		(COUNT(t1.id_livro) /
        (SELECT COUNT(*) FROM livro)) * 100,
        2
    ) AS percentual
FROM livro t1
JOIN categoria t2
	ON t1.id_categoria = t2.id_categoria
GROUP BY
	t2.nome
ORDER BY percentual DESC;

/* ESTATÍSTICAS DOS USUÁRIOS */
SELECT
	t2.nome,
    COUNT(t1.id_livro) AS qtd_livros,
    SUM(t1.lido) AS qtd_lidos,
    
    ROUND(
		(SUM(t1.lido) / COUNT(t1.id_livro)) * 100,
        2
    ) AS pct_lido,
    
    MAX(t1.ano_publicacao) AS ano_mais_recente,
    MIN(t1.ano_publicacao) AS ano_mais_antigo

FROM livro t1
JOIN usuario t2
	ON t1.id_usuario = t2.id_usuario

GROUP BY
	t2.nome;

/* IDADE MÉDIA DOS AUTORES */
SELECT
AVG(
	IF(
		ano_morte IS NOT NULL,
        ano_morte,
        YEAR(CURRENT_DATE())
    ) - ano_nascimento
) AS idade_media_autor
FROM autor
WHERE ano_nascimento IS NOT NULL;
