CREATE MATERIALIZED VIEW avg_bpm_per_license_type AS
SELECT 
    l.name AS license_type,
    AVG(t.bpm) AS avg_bpm,
    COUNT(DISTINCT ot.id) AS total_sales
FROM licenses l
JOIN order_tracks ot ON l.id = ot.license_id
JOIN orders o ON ot.order_id = o.id
JOIN tracks t ON l.track_id = t.id
WHERE o.created_at >= NOW() - INTERVAL '12 months'
GROUP BY l.name;
