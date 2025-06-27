--Schema LOG
CREATE TYPE
utils.log_enum_generic_type
AS ENUM(
    'criação',
    'alteração',
    'deleção',
    'assosciação'
);

CREATE TYPE
utils.log_enum_user_login_logout_type
AS ENUM(
    'login',
    'logout'
);