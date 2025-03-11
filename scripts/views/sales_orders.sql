CREATE VIEW sales_orders AS
SELECT 
    o.id AS order_id,
    o.user_id,
    u.email AS user_email,
    o.amount,
    o.currency,
    o.status,
    o.created_at,
    t.name AS track_name,
    l.name AS license_name,
    l.price_rub,
    l.price_usd
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN order_tracks ot ON o.id = ot.order_id
JOIN licenses l ON ot.license_id = l.id
JOIN tracks t ON l.track_id = t.id;

REVOKE ALL ON sales_orders FROM PUBLIC;
GRANT SELECT ON sales_orders TO sales_role, admin_role;
