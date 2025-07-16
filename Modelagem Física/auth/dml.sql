-- Atualizando valores anteriormente nullos do registro de administrador.
-- obs: a inserção do administrador foi realizado na plataforma do Nhost, aqui apenas estou adicionando valores que não
-- pertencem nativamente à tabela de 'auth.users'.
SELECT * FROM auth.users;

UPDATE auth.users SET registery = 1002025001, usertype = 'Administrador', username = 'Administrador', entry_time = '04:00:00-03:00', departure_time = '22:00:00-03:00'
WHERE email = 'syslab@baymetrics.com';

ALTER TABLE auth.users ALTER COLUMN registery DROP NOT NULL;
ALTER TABLE auth.users ALTER COLUMN usertype DROP NOT NULL;
ALTER TABLE auth.users ALTER COLUMN username DROP NOT NULL;
ALTER TABLE auth.users ALTER COLUMN entry_time DROP NOT NULL;
ALTER TABLE auth.users ALTER COLUMN departure_time DROP NOT NULL;

ALTER TABLE auth.users RENAME COLUMN name TO username;
ALTER TABLE auth.users RENAME COLUMN type TO usertype;