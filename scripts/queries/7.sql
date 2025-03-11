SELECT 
    u.id AS owner_id,
    u.email AS owner_email,
    COUNT(DISTINCT ot.id) AS total_sales,
    SUM(o.amount) AS total_revenue,
    AVG(o.amount) AS average_sale_price
FROM users u
JOIN tracks t ON u.id = t.owner_id
JOIN licenses l ON t.id = l.track_id
JOIN order_tracks ot ON l.id = ot.license_id
JOIN orders o ON ot.order_id = o.id
GROUP BY u.id
ORDER BY total_revenue DESC;