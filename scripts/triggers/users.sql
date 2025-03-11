CREATE TRIGGER encrypt_password
BEFORE INSERT OR UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION encrypt_password_trigger();
