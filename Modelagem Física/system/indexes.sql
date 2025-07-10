CREATE UNIQUE INDEX idx_unique_administrator
ON system.user (type)
WHERE type = 'Administrador';