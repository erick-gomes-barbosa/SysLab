-- Criação do índice único de administrador
DROP INDEX idx_unique_administrador;
CREATE UNIQUE INDEX idx_unique_administrator
ON auth.users (type)
WHERE type = 'Administrador';