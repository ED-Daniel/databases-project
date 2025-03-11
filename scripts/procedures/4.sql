CREATE OR REPLACE PROCEDURE get_top_referrers(
    IN p_limit INT,
    OUT referrer_id INT,
    OUT referrer_email VARCHAR,
    OUT total_referrals INT,
    OUT total_revenue NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        u.id AS referrer_id,
        u.email AS referrer_email,
        COUNT(r.referred_id) AS total_referrals,
        COALESCE(SUM(o.amount), 0) AS total_revenue
    FROM users u
    JOIN referrals r ON u.id = r.referrer_id
    LEFT JOIN orders o ON r.referred_id = o.user_id
    GROUP BY u.id
    ORDER BY total_referrals DESC, total_revenue DESC
    LIMIT p_limit;
END;
$$;
