DROP ROLE IF EXISTS usr_backup

CREATE ROLE usr_backup WITH
    LOGIN
    PASSWORD 'SysL4bDat@B4s3'
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOINHERIT;

CREATE ROLE sys_backup WITH
    NOLOGIN
    SUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOINHERIT;

GRANT CONNECT ON DATABASE gvuedsnndhovbkeuylll TO usr_backup;

DO $$
DECLARE
    schema_name text;
BEGIN
    FOREACH schema_name IN ARRAY ARRAY['public', 'log', 'system', 'utils', 'auth', 'storage']
    LOOP
        EXECUTE format('REVOKE ALL ON ALL TABLES IN SCHEMA %I FROM usr_backup;', v_schema_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I REVOKE ALL ON TABLES FROM usr_backup;', v_schema_name);
        EXECUTE format('GRANT USAGE ON SCHEMA %I TO usr_backup;', v_schema_name);
    END LOOP;
END $$;

DO $$
DECLARE
    v_schema_name TEXT;
BEGIN
    FOREACH v_schema_name IN ARRAY ARRAY['public', 'log', 'system', 'utils', 'auth', 'storage']
    LOOP
        EXECUTE format('GRANT USAGE ON SCHEMA %I TO sys_backup;', v_schema_name);
        EXECUTE format('GRANT SELECT ON ALL TABLES IN SCHEMA %I TO sys_backup;', v_schema_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT SELECT ON TABLES TO sys_backup;', v_schema_name);

    END LOOP; -- Fim do loop de schemas
END $$;