CREATE VIEW client_support_users AS
SELECT 
    u.id AS user_id,
    u.email,
    ui.full_name,
    ui.nickname,
    u.is_verified,
    u.is_ban,
    u.created_at,
    r.referrer_id AS referred_by
FROM users u
LEFT JOIN user_info ui ON u.id = ui.user_id
LEFT JOIN referrals r ON u.id = r.referred_id;

REVOKE ALL ON client_support_users FROM PUBLIC;
GRANT SELECT ON client_support_users TO client_support_role, admin_role;
