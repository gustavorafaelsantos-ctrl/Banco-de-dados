-- 1. Criação do Banco de Dados
CREATE DATABASE biblioteca_pessoal;
USE biblioteca_pessoal;

-- 2. Criação da Tabela Usuario
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Criação da Tabela Autor
CREATE TABLE autor (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- 4. Criação da Tabela Editora
CREATE TABLE editora (
    id_editora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- 5. Criação da Tabela Categoria
CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- 6. Criação da Tabela Livro com Relacionamentos e Restrições
CREATE TABLE livro (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    isbn VARCHAR(20),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    id_usuario INT NOT NULL,
    id_autor INT NOT NULL,
    id_editora INT NOT NULL,
    id_categoria INT NOT NULL,
    
    -- Se o usuário for deletado, os livros dele também serão (Cascade)
    CONSTRAINT fk_livro_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    
    -- Impede a exclusão se houver livros vinculados (Restrict/No Action)
    CONSTRAINT fk_livro_autor FOREIGN KEY (id_autor) 
        REFERENCES autor(id_autor) ON DELETE RESTRICT,
    
    CONSTRAINT fk_livro_editora FOREIGN KEY (id_editora) 
        REFERENCES editora(id_editora) ON DELETE RESTRICT,
        
    CONSTRAINT fk_livro_categoria FOREIGN KEY (id_categoria) 
        REFERENCES categoria(id_categoria) ON DELETE RESTRICT
);

