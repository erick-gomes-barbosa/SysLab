-- ================================
--Permissões das ROLEs de usuário
-- ================================
GRANT CONNECT ON DATABASE gvuedsnndhovbkeuylll TO usr_user;

-- Schema system
GRANT USAGE ON SCHEMA system TO usr_user;

GRANT UPDATE ON system.vw_update_t_user_r_sys_user TO usr_user


-- ================================
-- Permissões das ROLEs do sistema
-- ================================

-- Schema system
GRANT USAGE ON SCHEMA system TO sys_user;

GRANT SELECT(registery, type, name, email, password, entry_time, departure_time) 
ON system.user TO sys_user;

GRANT INSERT(type, name, email, password, entry_time, departure_time)
ON system.user TO sys_user;

GRANT UPDATE(name, email, password, entry_time, departure_time, is_activated)
ON system.user TO sys_user;

GRANT SELECT(enviroment_id, qty_computers, qty_chairs, opening_time, closing_time, is_activated)
ON system.laboratory TO sys_user;