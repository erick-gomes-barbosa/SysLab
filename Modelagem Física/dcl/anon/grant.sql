-- ================================
--Permissões das ROLEs de usuário
-- ================================
GRANT CONNECT ON DATABASE gvuedsnndhovbkeuylll TO usr_anon;

--Schema system
GRANT USAGE ON SCHEMA system TO usr_anon;

GRANT INSERT ON system.vw_insert_t_user_r_sys_anon TO usr_anon;

GRANT EXECUTE 
ON FUNCTION system.fn_insert_function_t_user_r_sys_anon() TO usr_anon

GRANT EXECUTE 
ON FUNCTION system.fn_select_t_user_r_sys_anon(email_user VARCHAR(50)) TO usr_anon;


-- ================================
-- Permissões das ROLEs do sistema
-- ================================
GRANT USAGE ON SCHEMA system TO sys_anon;

-- Schema system
GRANT SELECT(email, password, is_activated) ON system.user TO sys_anon;

GRANT INSERT(registery, type, name, email, password, entry_time, departure_time) ON system.user TO sys_anon;
