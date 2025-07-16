DROP SCHEMA IF EXISTS system CASCADE;
CREATE SCHEMA system;

CREATE TABLE system.laboratory (
    --Chaves Primárias
    id              INTEGER                     GENERATED ALWAYS AS IDENTITY,

    --Infomrações sobre o laboratório
    enviroment_id   VARCHAR(5)                  NOT NULL,
    qty_computers   INTEGER                     NOT NULL,
    qty_chairs      INTEGER                     NOT NULL,

    --Período de tempo de utilização do laboratório
    opening_time    utils.domain_time_period    NOT NULL,
    closing_time    utils.domain_time_period    NOT NULL,

    --Definição das Chaves Primárias
    CONSTRAINT pk_system_laboratory                 PRIMARY KEY(id),

    --Definição dos Campos Únicos
    CONSTRAINT uq_system_laboratory_enviroment_id   UNIQUE(enviroment_id)
);

ALTER TABLE system.laboratory
ALTER COLUMN qty_chairs SET DEFAULT 0;

ALTER TABLE system.laboratory
ALTER COLUMN qty_computers SET DEFAULT 0;

ALTER TABLE system.laboratory
ADD COLUMN is_activated BOOLEAN NOT NULL DEFAULT TRUE;

ALTER TABLE system.laboratory
ADD COLUMN television BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE system.laboratory
ADD COLUMN fan BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE system.laboratory
ADD COLUMN air_conditioner BOOLEAN NOT NULL DEFAULT FALSE;

DROP TABLE IF EXISTS system.user_laboratory;
CREATE TABLE system.user_laboratory(
    --Chave Primária
    id              INTEGER GENERATED ALWAYS AS IDENTITY,

    --Chaves Estrangeiras
    user_id         UUID NOT NULL,
    laboratory_id   INTEGER NOT NULL,

    --Definição da Chave Primária
    CONSTRAINT pk_system_user_laboratory        PRIMARY KEY(id),

    --Definição das Chaves Estrangeiras
    CONSTRAINT fk_system_user_id
        FOREIGN KEY (user_id)
        REFERENCES auth.users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_system_laboratory_id
        FOREIGN KEY (laboratory_id)
        REFERENCES system.laboratory(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    --Definição dos Campos Únicos
    CONSTRAINT uq_system_user_laboratory_pair   UNIQUE(user_id, laboratory_id)
);

ALTER TABLE system.user_laboratory
ADD COLUMN allowed BOOLEAN NOT NULL DEFAULT TRUE;