-- Создаем роли
CREATE ROLE admin_role;
CREATE ROLE sales_role;
CREATE ROLE client_support_role;
CREATE ROLE content_moderator_role;

-- Создаем пользователей
CREATE USER admin_user WITH PASSWORD 'admin_pass';
CREATE USER sales_user WITH PASSWORD 'sales_pass';
CREATE USER client_support_user WITH PASSWORD 'client_support_pass';
CREATE USER content_moderator_user WITH PASSWORD 'content_moderator_pass';

-- Назначаем роли пользователям
GRANT admin_role TO admin_user;
GRANT sales_role TO sales_user;
GRANT client_support_role TO client_support_user;
GRANT content_moderator_role TO content_moderator_user;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON orders TO sales_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON order_tracks TO sales_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON licenses TO sales_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON tracks TO sales_role;

REVOKE ALL ON users FROM sales_role;
REVOKE ALL ON user_info FROM sales_role;
REVOKE ALL ON referrals FROM sales_role;

GRANT SELECT, INSERT, UPDATE ON users TO client_support_role;
GRANT SELECT, INSERT, UPDATE ON user_info TO client_support_role;
GRANT SELECT, INSERT, UPDATE ON referrals TO client_support_role;

REVOKE ALL ON orders FROM client_support_role;
REVOKE ALL ON tracks FROM client_support_role;
REVOKE ALL ON licenses FROM client_support_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON tracks TO content_moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON user_info TO content_moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON img_files TO content_moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON audio_files TO content_moderator_role;

REVOKE ALL ON users FROM content_moderator_role;
REVOKE ALL ON orders FROM content_moderator_role;
REVOKE ALL ON referrals FROM content_moderator_role;
