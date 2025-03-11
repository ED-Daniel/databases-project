SELECT 
    SUM(o.amount) AS total_revenue,
    COUNT(DISTINCT ot.id) AS total_sales,
    DATE_TRUNC('month', o.created_at) AS month
FROM orders o
JOIN order_tracks ot ON o.id = ot.order_id
JOIN licenses l ON ot.license_id = l.id
WHERE l.track_id = 1 
    AND l.name ILIKE '%Exclusive%'
    AND DATE_TRUNC('month', o.created_at) = DATE_TRUNC('month', NOW())
GROUP BY month;