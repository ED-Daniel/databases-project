CREATE VIEW users_with_pending_orders AS
SELECT 
    u.id, 
    u.email, 
    o.id AS order_id, 
    o.amount, 
    o.currency, 
    o.status, 
    o.created_at
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status ILIKE 'pending' OR o.amount = 0;
