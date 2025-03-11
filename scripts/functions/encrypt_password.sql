CREATE OR REPLACE FUNCTION encrypt_password_trigger()
RETURNS TRIGGER AS $$
BEGIN
    NEW.password := pgp_sym_encrypt(NEW.password::TEXT, 'MySecretKey');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;