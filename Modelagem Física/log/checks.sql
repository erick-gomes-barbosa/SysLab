ALTER TABLE log.user_login_logout
ADD CONSTRAINT ck_session_key_length
CHECK(
    char_length(VALUE)
)