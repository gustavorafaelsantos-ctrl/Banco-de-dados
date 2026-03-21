DROP DATABASE biblioteca_pessoal;
CREATE DATABASE biblioteca_pessoal;
USE biblioteca_pessoal_1s2026;

CREATE TABLE usuario(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(128) NOT NULL UNIQUE,
    data_cadastro DATE DEFAULT(CURRENT_DATE) NOT NULL
);
