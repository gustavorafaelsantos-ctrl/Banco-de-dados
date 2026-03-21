ALTER TABLE livro 
ADD COLUMN id_autor INT,
ADD COLUMN id_editora INT,
ADD CONSTRAINT fk_autor FOREIGN KEY (id_autor) REFERENCES autor(id_autor),
ADD CONSTRAINT fk_editora FOREIGN KEY (id_editora) REFERENCES editora(id_editora);
