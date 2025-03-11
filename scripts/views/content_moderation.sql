CREATE VIEW content_moderation AS
SELECT 
    t.id AS track_id,
    t.name AS track_name,
    t.owner_id,
    u.email AS owner_email,
    t.description,
    t.created_at,
    img.url AS image_url,
    audio.url AS audio_url
FROM tracks t
JOIN users u ON t.owner_id = u.id
LEFT JOIN img_files img ON t.img_files_id = img.id
LEFT JOIN audio_files audio ON t.id = audio.track_id;

REVOKE ALL ON content_moderation FROM PUBLIC;
GRANT SELECT ON content_moderation TO content_moderator_role, admin_role;
