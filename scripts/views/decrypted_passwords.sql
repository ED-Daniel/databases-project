CREATE OR REPLACE VIEW admin_decrypted_passwords AS
SELECT 
    id, 
    email, 
    convert_from(pgp_sym_decrypt(password::BYTEA, 'MySecretKey')::BYTEA, 'UTF8') AS decrypted_password
FROM users;


REVOKE ALL ON admin_decrypted_passwords FROM PUBLIC;
GRANT SELECT ON admin_decrypted_passwords TO admin_role;