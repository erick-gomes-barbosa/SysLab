DROP SCHEMA IF EXISTS system CASCADE;
CREATE SCHEMA system;

-- Tabela de armazenamento dos dados dos usuários do sistema
CREATE TABLE system.user (
    -- Chaves Primárias
    id              INTEGER                     GENERATED ALWAYS AS IDENTITY,

    -- Informações sobre o Usuário
    registery       INTEGER                     NOT NULL,
    type            VARCHAR(20)                 NOT NULL,
    name            VARCHAR(60)                 NOT NULL,
    
    --Informações de Entrada
    email           VARCHAR(50)                 NOT NULL,
    password        VARCHAR(64)                 NOT NULL,

    --Período de tempo de atuação do usuário
    entry_time      utils.domain_time_period   NOT NULL,
    departure_time  utils.domain_time_period   NOT NULL,

    --Definição das Chaves Primárias
    CONSTRAINT pk_system_user           PRIMARY KEY (id),

    --Definição dos Campos Únicos
    CONSTRAINT uq_system_user_registery UNIQUE (registery),
    CONSTRAINT uq_system_user_email     UNIQUE (email),
);

CREATE TABLE system.laboratory (
    --Chaves Primárias
    id              INTEGER                     GENERATED ALWAYS AS IDENTITY,

    --Infomrações sobre o laboratório
    enviroment_id   VARCHAR(5)                  NOT NULL,
    qty_computers   INTEGER                     NOT NULL,
    qty_chais       INTEGER                     NOT NULL,

    --Período de tempo de utilização do laboratório
    opening_time    utils.domain_time_period    NOT NULL,
    closing_time    utils.domain_time_period    NOT NULL,

    --Definição das Chaves Primárias
    CONSTRAINT pk_system_laboratory                 PRIMARY KEY(id),

    --Definição dos Campos Únicos
    CONSTRAINT uq_system_laboratory_enviroment_id   UNIQUE(enviroment_id),
)

CREATE TABLE system.user_laboratory(
    --Chave Primária
    id              INTEGER GENERATED ALWAYS AS IDENTITY,

    --Chaves Estrangeiras
    user_id         INTEGER NOT NULL,
    laboratory_id   INTEGER NOT NULL,

    --Definição da Chave Primária
    CONSTRAINT pk_system_user_laboratory        PRIMARY KEY(id),

    --Definição das Chaves Estrangeiras
    CONSTRAINT fk_system_user_id
        FOREIGN KEY (user_id)
        REFERENCES system.user(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_system_laboratory_id
        FOREIGN KEY (laboratory_id)
        REFERENCES system.laboratory(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    --Definição dos Campos Únicos
    CONSTRAINT uq_system_user_laboratory_pair   UNIQUE(user_id, laboratory_id)
)