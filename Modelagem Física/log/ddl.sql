DROP SCHEMA IF EXISTS log CASCADE;
CREATE SCHEMA log;

DROP TABLE IF EXISTS log.generic;
CREATE TABLE log.generic(
    --Chave Primária
    id                  INTEGER                     GENERATED ALWAYS AS IDENTITY,

    --Informações genéricas sobre os Logs
    type                utils.log_enum_generic_type NOT NULL,
    create_time         TIMESTAMP WITH TIME ZONE    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descri              TEXT                            NULL,

    --Informações sobre os Logs Filhos
    children_logs       JSONB                           NULL,

    --Chave Estrangeira
    responsible_user    INTEGER                     NOT NULL DEFAULT 1,

    --Definição da Chave Primária
    CONSTRAINT pk_log_generic       PRIMARY KEY(id),

    --Definição das Chaves Estrangeiras
    CONSTRAINT fk_system_user_id
        FOREIGN KEY (responsible_user)
        REFERENCES system.user(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS log.user;
CREATE TABLE log.user(
    --Chave Primária
    id          INTEGER GENERATED ALWAYS AS IDENTITY,

    --Chaves Estrangeiras
    generic_id  INTEGER NOT NULL,
    user_id     INTEGER NOT NULL,

    --Definição da Chave Primária
    CONSTRAINT pk_log_users     PRIMARY KEY(id),

    --Definição das Chaves Estrangeiras
    CONSTRAINT fk_log_generic_id
        FOREIGN KEY (generic_id)
        REFERENCES log.generic(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_system_user_id
        FOREIGN KEY (user_id)
        REFERENCES system.user(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    -- Definição dos Campos Únicos
    CONSTRAINT uq_log_user_generic_id   UNIQUE(generic_id)
);

DROP TABLE IF EXISTS log.laboratory;
CREATE TABLE log.laboratory(
    --Chave Primária
    id              INTEGER GENERATED ALWAYS AS IDENTITY,

    --Chaves Estrangeiras
    generic_id      INTEGER NOT NULL,
    laboratory_id   INTEGER NOT NULL,

    --Definição da Chave Primária
    CONSTRAINT pk_log_laboratory     PRIMARY KEY(id),

    --Definição das Chaves Estrangeiras
    CONSTRAINT fk_log_generic_id
        FOREIGN KEY (generic_id)
        REFERENCES log.generic(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_system_laboratory_id
        FOREIGN KEY (laboratory_id)
        REFERENCES system.laboratory(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    -- Definição dos Campos Únicos
    CONSTRAINT uq_log_laboratory_generic_id       UNIQUE(generic_id)
);

DROP TABLE IF EXISTS log.laboratory_per_user;
CREATE TABLE log.laboratory_per_user(
    --Chave Primária
    id              INTEGER GENERATED ALWAYS AS IDENTITY,
    
    --Lista de laboratórios por usuário
    laboratory_list JSONB       NULL,

    --Chaves Estrangeiras
    generic_id      INTEGER NOT NULL,
    laboratory_id   INTEGER NOT NULL,
    user_id         INTEGER NOT NULL,

    --Definição da Chave Primária
    CONSTRAINT pk_log_laboratory_per_user     PRIMARY KEY(id),

    --Definição das Chaves Estrangeiras
    CONSTRAINT fk_log_generic_id
        FOREIGN KEY (generic_id)
        REFERENCES log.generic(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_system_laboratory_id
        FOREIGN KEY (laboratory_id)
        REFERENCES system.laboratory(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_system_user_id
        FOREIGN KEY (user_id)
        REFERENCES system.user(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    -- Definição dos Campos Únicos
    CONSTRAINT uq_log_laboratory_per_user_generic_id       UNIQUE(generic_id)
);

DROP TABLE IF EXISTS log.assosiation_user_laboratory;
CREATE TABLE log.assosiation_user_laboratory(
    --Chave Primária
    id              INTEGER GENERATED ALWAYS AS IDENTITY,

    --Chaves Estrangeiras
    generic_id      INTEGER NOT NULL,
    laboratory_id   INTEGER NOT NULL,
    user_id         INTEGER NOT NULL,

    --Definição da Chave Primária
    CONSTRAINT pk_log_assosiation_user_laboratory     PRIMARY KEY(id),

    --Definição das Chaves Estrangeiras
    CONSTRAINT fk_log_generic_id
        FOREIGN KEY (generic_id)
        REFERENCES log.generic(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_system_laboratory_id
        FOREIGN KEY (laboratory_id)
        REFERENCES system.laboratory(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_system_user_id
        FOREIGN KEY (user_id)
        REFERENCES system.user(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    -- Definição dos Campos Únicos
    CONSTRAINT uq_log_assosiation_user_laboratory_generic_id       UNIQUE(generic_id)
);

DROP TABLE IF EXISTS log.user_login_logout;
CREATE TABLE log.user_login_logout(
    --Chave Primária
    id              INTEGER GENERATED ALWAYS AS IDENTITY,

    --Informações sobre a operação
    operation_type  utils.log_enum_user_login_logout_type   NOT NULL,
    session_key     VARCHAR(64) NOT NULL,

    --Chaves Estrangeiras
    generic_id      INTEGER NOT NULL,
    user_id         INTEGER NOT NULL,

    --Definição da Chave Primária
    CONSTRAINT pk_log_user_login_logout     PRIMARY KEY(id),

    --Definição das Chaves Estrangeiras
    CONSTRAINT fk_log_generic_id
        FOREIGN KEY (generic_id)
        REFERENCES log.generic(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_system_user_id
        FOREIGN KEY (user_id)
        REFERENCES system.user(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    -- Definição dos Campos Únicos
    CONSTRAINT uq_log_user_login_logout_generic_id   UNIQUE(generic_id)
);