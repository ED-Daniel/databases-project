CREATE OR REPLACE PROCEDURE get_monthly_revenue(
    IN p_track_id INT,
    IN p_license_type VARCHAR,
    OUT total_revenue NUMERIC,
    OUT total_sales INT,
    OUT month DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT 
        COALESCE(SUM(o.amount), 0),
        COUNT(DISTINCT ot.id),
        DATE_TRUNC('month', NOW())::DATE
    INTO total_revenue, total_sales, month
    FROM orders o
    JOIN order_tracks ot ON o.id = ot.order_id
    JOIN licenses l ON ot.license_id = l.id
    WHERE l.track_id = p_track_id 
        AND l.name ILIKE '%' || p_license_type || '%'
        AND DATE_TRUNC('month', o.created_at) = DATE_TRUNC('month', NOW());
END;
$$;
