SELECT grantee, privilege_type, table_name FROM information_schema.role_table_grants WHERE grantee = 'sys_maintence';
-- ================================
-- Permissões da ROLE do sistema
-- ================================
GRANT USAGE ON SCHEMA auth TO sys_maintence;
GRANT USAGE ON SCHEMA storage TO sys_maintence;
GRANT USAGE ON SCHEMA public TO sys_maintence;
GRANT USAGE ON SCHEMA system TO sys_maintence;
GRANT USAGE ON SCHEMA log TO sys_maintence;

-- Schema auth
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA auth TO sys_maintence;
REVOKE UPDATE ON ALL TABLES IN SCHEMA auth FROM sys_maintence;
REVOKE INSERT ON ALL TABLES IN SCHEMA auth FROM sys_maintence;

-- Schema storage
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA storage TO sys_maintence;
REVOKE UPDATE ON ALL TABLES IN SCHEMA storage FROM sys_maintence;
REVOKE INSERT ON ALL TABLES IN SCHEMA storage FROM sys_maintence;

--Schema public
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM sys_maintence;

--Schema system
GRANT SELECT, DELETE ON ALL TABLES IN SCHEMA system TO sys_maintence;

GRANT INSERT(type, name, email, password, entry_time, departure_time) ON system."user" TO sys_maintence;
GRANT UPDATE(type, name, email, password, entry_time, departure_time, is_activated) ON system."user" TO sys_maintence;

GRANT INSERT(enviroment_id, qty_computers, qty_chairs, opening_time, closing_time) ON system.laboratory TO sys_maintence;
GRANT UPDATE(enviroment_id, qty_computers, qty_chairs, opening_time, closing_time, is_activated) ON system.laboratory TO sys_maintence;

GRANT INSERT(laboratory_id, user_id) ON system.user_laboratory TO sys_maintence;
GRANT UPDATE(allowed, laboratory_id, user_id) ON system.user_laboratory TO sys_maintence;

--Schema log
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA log FROM sys_maintence;
GRANT DELETE ON ALL TABLES IN SCHEMA log TO sys_maintence;

--Schema utils
GRANT CREATE ON SCHEMA utils TO sys_maintence;