-- Permissão temporária de  Criação no Schema system
GRANT CREATE ON SCHEMA system TO sys_user;

-- Seleção na Tabela de Usuário
SET ROLE sys_user;

DROP FUNCTION IF EXISTS system.fn_select_t_user_r_sys_user;
CREATE OR REPLACE FUNCTION system.fn_select_t_user_r_sys_user(id_user INTEGER)
RETURNS TABLE (registery INTEGER, type VARCHAR(20), name VARCHAR(60), email VARCHAR(50), password VARCHAR(64), entry_time TIME(0), departure_time TIME(0)) AS $$
BEGIN
	RETURN QUERY
	SELECT usr.registery, usr.type, usr.name, usr.email, usr.password, usr.entry_time, usr.departure_time
	FROM system.user usr
	WHERE usr.id = id_user
	LIMIT 1;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = system, pg_temp;

RESET ROLE;

-- Seleção na Tabela de Laboratório
SET ROLE sys_user;

DROP FUNCTION IF EXISTS system.fn_select_t_laboratory_r_sys_user;
CREATE OR REPLACE FUNCTION system.fn_select_t_laboratory_r_sys_user(id_laboratory INTEGER)
RETURNS TABLE (enviroment_id VARCHAR(5), qty_computers INTEGER, qty_chairs INTEGER, opening_time TIME(0), closing_time TIME(0), is_activated BOOLEAN) AS $$
BEGIN
	RETURN QUERY
	SELECT lab.enviroment_id, lab.qty_computers, lab.qty_chairs, lab.opening_time, lab.closing_time, lab.is_activated
	FROM system.laboratory lab
	WHERE lab.id = id_laboratory
	LIMIT 1;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = system, pg_temp;

RESET ROLE;

-- Inserção na Tabela de Usuário
CREATE OR REPLACE VIEW system.vw_insert_t_user_r_sys_user AS
SELECT type, name, email, password, entry_time, departure_time FROM system.user;

SET ROLE sys_user;

DROP FUNCTION IF EXISTS system.fn_insert_t_user_r_sys_user;
CREATE OR REPLACE FUNCTION
system.fn_insert_t_user_r_sys_user()
RETURNS trigger AS $$
BEGIN
	INSERT INTO system.user(type, name, email, password, entry_time, departure_time) 
	VALUES(NEW.type, NEW.name, NEW.email, NEW.password, NEW.entry_time, NEW.departure_time);
	RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = system, pg_temp;

RESET ROLE;

DROP TRIGGER vw_insert_t_user_r_sys_user_trg ON system.vw_insert_t_user_r_sys_user;
CREATE OR REPLACE TRIGGER vw_insert_t_user_r_sys_user_trg
INSTEAD OF INSERT ON system.vw_insert_t_user_r_sys_user
FOR EACH ROW
EXECUTE FUNCTION system.fn_insert_t_user_r_sys_user();

-- Atualização na Tabela de Usuário
DROP VIEW IF EXISTS system.vw_update_t_user_r_sys_user;
CREATE OR REPLACE VIEW system.vw_update_t_user_r_sys_user AS
SELECT id, name, email, password, entry_time, departure_time, is_activated FROM system.user;

SET ROLE sys_user;

DROP FUNCTION IF EXISTS system.fn_update_t_user_r_sys_user();
CREATE OR REPLACE FUNCTION
system.fn_update_t_user_r_sys_user()
RETURNS trigger AS $$
BEGIN
	UPDATE system.user
	SET
		name = COALESCE(NEW.name, name),
		email = COALESCE(NEW.email, email),
		password = COALESCE(NEW.password, password),
		entry_time = COALESCE(NEW.entry_time, entry_time),
		departure_time = COALESCE(NEW.departure_time, departure_time),
		is_activated = COALESCE(NEW.is_activated, is_activated)
	WHERE
		id = OLD.id;

	RETURN FOUND;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = system, pg_temp;

RESET ROLE;

DROP TRIGGER vw_updtae_t_user_r_sys_user_trg ON system.vw_update_t_user_r_sys_user;
CREATE OR REPLACE TRIGGER vw_updtae_t_user_r_sys_user_trg
INSTEAD OF UPDATE ON system.vw_update_t_user_r_sys_user
FOR EACH ROW
EXECUTE FUNCTION system.fn_update_t_user_r_sys_user();

-- Revogando a permissão temporária de Criação no Schema system
REVOKE CREATE ON SCHEMA system FROM sys_user;