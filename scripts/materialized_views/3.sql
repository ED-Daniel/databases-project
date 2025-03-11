CREATE MATERIALIZED VIEW popular_tracks_last_6_months AS
SELECT 
    t.id AS track_id,
    t.name AS track_name,
    u.id AS owner_id,
    u.email AS owner_email,
    COUNT(ot.id) AS total_licenses_sold
FROM tracks t
JOIN users u ON t.owner_id = u.id
JOIN licenses l ON t.id = l.track_id
JOIN order_tracks ot ON l.id = ot.license_id
JOIN orders o ON ot.order_id = o.id
WHERE o.created_at >= NOW() - INTERVAL '6 months'
GROUP BY t.id, u.id
HAVING COUNT(ot.id) > 5;
