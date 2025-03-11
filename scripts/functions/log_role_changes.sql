CREATE OR REPLACE FUNCTION log_role_changes()
RETURNS TRIGGER AS $$
BEGIN
    -- Сохраняем старую версию данных
    INSERT INTO roles_audit (role_id, old_name, old_description, action_type, modified_by)
    VALUES (OLD.id, OLD.name, OLD.description, TG_OP, current_user);

    RETURN OLD;  -- Возвращаем старую запись
END;
$$ LANGUAGE plpgsql;
