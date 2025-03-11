SELECT u.id, u.email, COUNT(r.referred_id) AS total_referrals
FROM users u
JOIN referrals r ON u.id = r.referrer_id
GROUP BY u.id
ORDER BY total_referrals DESC
LIMIT 10;

---
CREATE INDEX idx_referrals_referrer_id ON referrals(referrer_id);

CREATE MATERIALIZED VIEW top_referrers AS
SELECT referrer_id, COUNT(referred_id) AS total_referrals
FROM referrals
GROUP BY referrer_id
ORDER BY total_referrals DESC;
---

SELECT u.email, tr.total_referrals
FROM users u
JOIN top_referrers tr ON u.id = tr.referrer_id
LIMIT 10;
