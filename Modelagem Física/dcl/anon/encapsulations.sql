-- Permissão temporária de Criação no Schema system
GRANT CREATE ON SCHEMA system TO sys_anon;

-- Seleção na Tabela de Usuário
SET ROLE sys_anon;

DROP FUNCTION system.fn_select_t_user_r_sys_anon;
CREATE OR REPLACE FUNCTION system.fn_select_t_user_r_sys_anon(email_user VARCHAR(50))
RETURNS TABLE(email VARCHAR(50), password VARCHAR(64), is_activated BOOLEAN) AS $$
BEGIN
    RETURN QUERY
    SELECT usr.email, usr.password, usr.is_activated
    FROM system.user usr
    WHERE usr.email = email_user
    LIMIT 1;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = system, pg_temp;
RESET ROLE;

-- Buscar o ID para a variável de sessão

SET ROLE sys_anon;

DROP FUNCTION system.fn_select_id_t_user_r_sys_anon;
CREATE OR REPLACE FUNCTION system.fn_select_id_t_user_r_sys_anon(email_user VARCHAR(50))
RETURNS TABLE(id INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT usr.id
    FROM system.user usr
    WHERE usr.email = email_user
    LIMIT 1;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = system, pg_temp;

RESET ROLE;

--Inseção na Tabela de Usuários
CREATE OR REPLACE VIEW system.vw_insert_t_user_r_sys_anon AS
SELECT email, password FROM system.user;

SET ROLE sys_anon;

DROP FUNCTION system.fn_insert_t_user_r_sys_anon
CREATE OR REPLACE FUNCTION
system.fn_insert_t_user_r_sys_anon()
RETURNS trigger AS $$
BEGIN
    INSERT INTO system.user(email, password) VALUES (NEW.email, NEW.password);
    RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = system, pg_temp;
RESET ROLE;

DROP TRIGGER vw_insert_t_user_r_sys_anon_trg ON system.vw_insert_t_user_r_sys_anon;
CREATE OR REPLACE TRIGGER vw_insert_t_user_r_sys_anon_trg
INSTEAD OF INSERT ON system.vw_insert_t_user_r_sys_anon
FOR EACH ROW
EXECUTE FUNCTION system.fn_insert_t_user_r_sys_anon();

-- Revogando a permissão temporária de criação no esquema System
REVOKE CREATE ON SCHEMA system FROM sys_anon;