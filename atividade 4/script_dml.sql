-- =============================================
-- SCRIPT DML - ATIVIDADE 4
-- Carga inicial e operações DML
-- =============================================

-- =============================================
-- 1. CARGA INICIAL DE DADOS
-- =============================================

-- Inserindo Autores
INSERT INTO autores (nome) VALUES 
('J.K. Rowling'),
('George Orwell'),
('Friedrich Nietzsche'),
('Platão'),
('Machado de Assis');

-- Inserindo Categorias
INSERT INTO categorias (nome) VALUES 
('Fantasia'),
('Ficção Científica'),
('Filosofia'),
('Literatura Brasileira'),
('Distopia');

-- Inserindo Livros
INSERT INTO livros (titulo, id_autor, id_categoria, ano_publicacao) VALUES 
('Harry Potter e a Pedra Filosofal', 1, 1, 1997),
('Harry Potter e o Prisioneiro de Azkaban', 1, 1, 1999),
('1984', 2, 5, 1949),
('Assim Falou Zaratustra', 3, 3, 1883),
('A República', 4, 3, -380),
('Memórias Póstumas de Brás Cubas', 5, 4, 1881),
('O Alienista', 5, 4, 1882),
('Harry Potter e o Cálice de Fogo', 1, 1, 2000);

-- =============================================
-- 2. CONSULTAS SOLICITADAS
-- =============================================

-- Query que retorna todos os livros da autora 'J.K. Rowling'
SELECT 
    l.titulo AS Livro,
    a.nome AS Autor,
    c.nome AS Categoria,
    l.ano_publicacao AS Ano
FROM livros l
JOIN autores a ON l.id_autor = a.id_autor
JOIN categorias c ON l.id_categoria = c.id_categoria
WHERE a.nome = 'J.K. Rowling'
ORDER BY l.ano_publicacao;

-- Query que retorna todos os livros da categoria 'Filosofia'
SELECT 
    l.titulo AS Livro,
    a.nome AS Autor,
    c.nome AS Categoria
FROM livros l
JOIN autores a ON l.id_autor = a.id_autor
JOIN categorias c ON l.id_categoria = c.id_categoria
WHERE c.nome = 'Filosofia'
ORDER BY l.titulo;

-- =============================================
-- 3. ALTERAÇÃO
-- =============================================

-- Altera o nome da categoria 'Filosofia' para 'Censurado'
UPDATE categorias 
SET nome = 'Censurado' 
WHERE nome = 'Filosofia';

-- =============================================
-- 4. DELEÇÃO
-- =============================================

-- Deleta todos os livros da categoria 'Censurado'
DELETE FROM livros 
WHERE id_categoria = (SELECT id_categoria FROM categorias WHERE nome = 'Censurado');

-- =============================================
-- Verificação final 
-- =============================================
SELECT * FROM categorias;
SELECT * FROM livros;
