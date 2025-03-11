-- Импорт данных в таблицу roles
COPY public.roles (name, description)
FROM '/data/roles.csv'
DELIMITER ','
CSV HEADER;

-- Импорт данных в таблицу users
COPY public.users (email, password, is_verified, verification_code, referral_code, is_ban, is_deleted)
FROM '/data/users.csv'
DELIMITER ','
CSV HEADER;

-- Импорт данных в таблицу user_roles
COPY public.user_roles (user_id, role_id)
FROM '/data/user_roles.csv'
DELIMITER ','
CSV HEADER;

-- Импорт данных в таблицу user_info
COPY public.user_info (user_id, full_name, show_full_name, nickname, show_nickname, about, show_about, instagram_url, show_instagram, youtube_url, show_youtube, telegram_url, show_telegram, contact_phone, show_contact_phone)
FROM '/data/user_info.csv'
DELIMITER ','
CSV HEADER;

-- Импорт данных в таблицу tracks
COPY public.tracks (name, description, type, key_sign, bpm, free_download, owner_id, is_deleted, is_draft, duration)
FROM '/data/tracks.csv'
DELIMITER ','
CSV HEADER;

-- Импорт данных в таблицу licenses
COPY public.licenses (name, track_id, price_rub, price_usd, term_years, distribution_copies, audio_streams, free_downloads, monetized_video_streams, non_monetized_video_streams, monetized_videos, non_monetized_videos, radio_broadcasting_rights, radio_stations_allowed, performance_for_profit, not_for_profit_performances, is_deleted, is_show)
FROM '/data/licenses.csv'
DELIMITER ','
CSV HEADER;

-- Импорт данных в таблицу orders
COPY public.orders (user_id, amount, currency, status)
FROM '/data/orders.csv'
DELIMITER ','
CSV HEADER;

-- Импорт данных в таблицу order_tracks
COPY public.order_tracks (order_id, license_id)
FROM '/data/order_tracks.csv'
DELIMITER ','
CSV HEADER;

-- Импорт данных в таблицу img_files
COPY public.img_files (name, type, url, size, owner_id)
FROM '/data/img_files.csv'
DELIMITER ','
CSV HEADER;

-- Импорт данных в таблицу audio_files
COPY public.audio_files (track_id, name, url, owner_id, size, type)
FROM '/data/audio_files.csv'
DELIMITER ','
CSV HEADER;