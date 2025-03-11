SELECT 
    u.id, 
    u.email, 
    ui.full_name, 
    ui.nickname, 
    COUNT(ot.id) AS total_licenses_purchased
FROM users u
JOIN user_info ui ON u.id = ui.user_id
JOIN orders o ON u.id = o.user_id
JOIN order_tracks ot ON o.id = ot.order_id
GROUP BY u.id, ui.full_name, ui.nickname
HAVING COUNT(ot.id) > 3
ORDER BY total_licenses_purchased DESC;