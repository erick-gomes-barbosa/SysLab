ALTER TABLE system.user
ADD CONSTRAINT check_system_type_user
CHECK(
    VALUE IN('Administrador', 'Aluno', 'Profesor', 'Técnico')
);

ALTER TABLE system.user
ADD CONSTRAINT check_system_user_email
CHECK(
    VALUE ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
);

ALTER TABLE system.user
ADD CONSTRAINT check_password_lenght
CHECK(
    char_length(VALUE) = 64
);

ALTER TABLE system.user
ADD CONSTRAINT ck_system_user_entry_before_departure
CHECK(
    entry_time<departure_time
);

ALTER TABLE system.laboratory
ADD CONSTRAINT ck_enviroment_id
CHECK(
    char_length(VALUE) = 5 AND
    VALUE ~ '^\d{3}[a-z]{2}$'
);

ALTER TABLE system.laboratory
ADD CONSTRAINT ck_system_laboratory_opening_before_closing
CHECK(
    opening_time<closing_time
);