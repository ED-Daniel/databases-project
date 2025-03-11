CREATE TRIGGER trigger_log_role_update
BEFORE UPDATE ON roles
FOR EACH ROW
EXECUTE FUNCTION log_role_changes();

CREATE TRIGGER trigger_log_role_delete
BEFORE DELETE ON roles
FOR EACH ROW
EXECUTE FUNCTION log_role_changes();
