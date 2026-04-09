/** DELETA O SCHEMA DO BD SE EXISTIR */
DROP DATABASE IF EXISTS biblioteca_pessoal_at4;

/** CRIA E SELECIONA O BANCO */
CREATE DATABASE biblioteca_pessoal_at4;
USE biblioteca_pessoal_at4;

/** ====================== CRIAÇÃO DAS TABELAS ====================== */

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) UNIQUE,
    descricao TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE autor (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL UNIQUE,
    ano_nascimento INT,
    ano_morte INT,
    apresentacao TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE editora (
    id_editora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL UNIQUE,
    cidade VARCHAR(255),
    estado VARCHAR(255),
    pais VARCHAR(255),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE livro (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_autor INT,
    id_editora INT,
    id_categoria INT, 
    titulo VARCHAR(255) NOT NULL,
    sinopse TEXT,
    ano_publicacao INT,
    lido BOOLEAN DEFAULT FALSE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_usuario_livro FOREIGN KEY (id_usuario) 
        REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    
    CONSTRAINT fk_autor_livro FOREIGN KEY (id_autor) 
        REFERENCES autor(id_autor) ON DELETE RESTRICT,
    
    CONSTRAINT fk_editora_livro FOREIGN KEY (id_editora) 
        REFERENCES editora(id_editora) ON DELETE RESTRICT,
    
    CONSTRAINT fk_categoria_livro FOREIGN KEY (id_categoria) 
        REFERENCES categoria(id_categoria) ON DELETE RESTRICT
);
-- Usuários
INSERT INTO usuario (nome, email, senha) VALUES
('Ana Silva', 'ana@email.com', '123'),
('Bruno Souza', 'bruno@email.com', '123'),
('Carla Mendes', 'carla@email.com', '123');

-- Categorias
INSERT INTO categoria (nome, descricao) VALUES
('Ficção Científica', 'Livros com temas futuristas e científicos'),
('Fantasia', 'Mundos imaginários e mágicos'),
('Romance', 'Histórias centradas em relações humanas'),
('Clássicos', 'Obras consagradas da literatura'),
('Suspense', 'Narrativas de tensão e mistério'),
('Filosofia', 'Reflexões filosóficas');
-- Autores
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
-- Editoras
INSERT INTO editora (nome, cidade, estado, pais) VALUES
('Penguin Books', 'Londres', NULL, 'Reino Unido'),
('HarperCollins', 'Nova York', 'NY', 'EUA'),
('Companhia das Letras', 'São Paulo', 'SP', 'Brasil'),
('Editora Record', 'Rio de Janeiro', 'RJ', 'Brasil'),
('Rocco', 'Rio de Janeiro', 'RJ', 'Brasil');

-- Livros (42 registros)
INSERT INTO livro (id_usuario, id_autor, id_editora, id_categoria, titulo, ano_publicacao, lido) VALUES
(1,1,1,4,'1984',1949,TRUE),
(1,1,1,1,'Animal Farm',1945,TRUE);

SELECT * FROM categoria;
SELECT * FROM livro;
-- =============================================
-- CONSULTAS SOLICITADAS
-- =============================================

-- 1. Todos os livros da autora 'J.K. Rowling'
SELECT 
    l.titulo AS Livro,
    a.nome AS Autor,
    c.nome AS Categoria,
    l.ano_publicacao AS Ano
FROM livro l
JOIN autor a ON l.id_autor = a.id_autor
JOIN categoria c ON l.id_categoria = c.id_categoria
WHERE a.nome = 'J.K. Rowling'
ORDER BY l.ano_publicacao;
-- 2. Todos os livros da categoria 'Filosofia'
SELECT 
    l.titulo AS Livro,
    a.nome AS Autor,
    c.nome AS Categoria
FROM livro l
JOIN autor a ON l.id_autor = a.id_autor
JOIN categoria c ON l.id_categoria = c.id_categoria
WHERE c.nome = 'Filosofia'
ORDER BY l.titulo;
-- =============================================
-- 3. ALTERAÇÃO
-- =============================================

UPDATE categoria 
SET nome = 'Censurado' 
WHERE nome = 'Filosofia';

-- =============================================
-- 4. DELEÇÃO
-- =============================================

DELETE FROM livro 
WHERE id_categoria = (SELECT id_categoria FROM categoria WHERE nome = 'Censurado');

-- =============================================
-- Verificação final
-- =============================================
SELECT * FROM categoria;
SELECT * FROM livro ORDER BY id_livro;
