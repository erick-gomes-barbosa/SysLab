--Schema SYSTEM
CREATE DOMAIN utils.domain_time_period AS TIME(0) WITH TIME ZONE;
ALTER DOMAIN utils.domain_time_period
ADD CONSTRAINT check_time_period
CHECK(
    (VALUE AT TIME ZONE 'America/Sao_Paulo')::TIME WITHOUT TIME ZONE > '04:00:00' AND
    (VALUE AT TIME ZONE 'America/Sao_Paulo')::TIME WITHOUT TIME ZONE < '22:00:00'
);