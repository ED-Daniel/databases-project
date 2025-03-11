-- Заполнение таблицы roles
INSERT INTO public.roles (name, description) VALUES
('Customer', 'Пользователь, который может покупать треки'),
('Seller', 'Пользователь, который может продавать треки');

-- Заполнение таблицы users
INSERT INTO public.users (email, password, is_verified, verification_code, referral_code, is_ban, is_deleted) VALUES
('user1@example.com', 'password1', true, 'code1', 'ref1', false, false),
('user2@example.com', 'password2', true, 'code2', 'ref2', false, false),
('user3@example.com', 'password3', true, 'code3', 'ref3', false, false),
('seller1@example.com', 'password4', true, 'code4', 'ref4', false, false),
('seller2@example.com', 'password5', true, 'code5', 'ref5', false, false);

-- Заполнение таблицы user_roles
INSERT INTO public.user_roles (user_id, role_id) VALUES
(1, 1), -- user1 - Customer
(2, 1), -- user2 - Customer
(3, 1), -- user3 - Customer
(4, 2), -- seller1 - Seller
(5, 2); -- seller2 - Seller

-- Заполнение таблицы user_info
INSERT INTO public.user_info (user_id, full_name, show_full_name, nickname, show_nickname, about, show_about, instagram_url, show_instagram, youtube_url, show_youtube, telegram_url, show_telegram, contact_phone, show_contact_phone) VALUES
(1, 'Иван Иванов', true, 'ivan123', true, 'Люблю музыку', true, 'https://instagram.com/ivan123', true, 'https://youtube.com/ivan123', true, 'https://t.me/ivan123', true, '+79123456789', true),
(2, 'Петр Петров', true, 'petr456', true, 'Музыкальный энтузиаст', true, 'https://instagram.com/petr456', true, 'https://youtube.com/petr456', true, 'https://t.me/petr456', true, '+79123456780', true),
(3, 'Сидор Сидоров', true, 'sidor789', true, 'Музыкальный продюсер', true, 'https://instagram.com/sidor789', true, 'https://youtube.com/sidor789', true, 'https://t.me/sidor789', true, '+79123456781', true),
(4, 'Алексей Алексеев', true, 'alex999', true, 'Продаю биты', true, 'https://instagram.com/alex999', true, 'https://youtube.com/alex999', true, 'https://t.me/alex999', true, '+79123456782', true),
(5, 'Дмитрий Дмитриев', true, 'dima777', true, 'Продаю эксклюзивные биты', true, 'https://instagram.com/dima777', true, 'https://youtube.com/dima777', true, 'https://t.me/dima777', true, '+79123456783', true);

-- Заполнение таблицы tracks
INSERT INTO public.tracks (name, description, type, key_sign, bpm, free_download, owner_id, is_deleted, is_draft, duration) VALUES
('Трек 1', 'Описание трека 1', 'Hip-Hop', 'C#m', 120, false, 4, false, false, 180),
('Трек 2', 'Описание трека 2', 'Trap', 'Am', 140, false, 4, false, false, 200),
('Трек 3', 'Описание трека 3', 'R&B', 'Fm', 100, false, 5, false, false, 220),
('Трек 4', 'Описание трека 4', 'Pop', 'Gm', 130, false, 5, false, false, 190),
('Трек 5', 'Описание трека 5', 'Electronic', 'Dm', 150, false, 4, false, false, 210);

-- Заполнение таблицы licenses
INSERT INTO public.licenses (name, track_id, price_rub, price_usd, term_years, distribution_copies, audio_streams, free_downloads, monetized_video_streams, non_monetized_video_streams, monetized_videos, non_monetized_videos, radio_broadcasting_rights, radio_stations_allowed, performance_for_profit, not_for_profit_performances, is_deleted, is_show) VALUES
('Free Lease', 1, 1000.00, 15.00, 1, 1000, 5000, 100, 100, 200, 50, 100, true, 10, true, 5, false, true),
('Exclusive', 1, 5000.00, 75.00, 5, 10000, 100000, 1000, 1000, 2000, 500, 1000, true, 50, true, 10, false, true),
('Free Lease', 2, 1200.00, 18.00, 1, 1000, 5000, 100, 100, 200, 50, 100, true, 10, true, 5, false, true),
('Exclusive', 2, 6000.00, 90.00, 5, 10000, 100000, 1000, 1000, 2000, 500, 1000, true, 50, true, 10, false, true),
('Free Lease', 3, 1500.00, 22.00, 1, 1000, 5000, 100, 100, 200, 50, 100, true, 10, true, 5, false, true),
('Exclusive', 3, 7000.00, 105.00, 5, 10000, 100000, 1000, 1000, 2000, 500, 1000, true, 50, true, 10, false, true);

-- Заполнение таблицы orders
INSERT INTO public.orders (user_id, amount, currency, status) VALUES
(1, 1000.00, 'RUB', 'completed'),
(2, 1200.00, 'RUB', 'completed'),
(3, 1500.00, 'RUB', 'pending');

-- Заполнение таблицы order_tracks
INSERT INTO public.order_tracks (order_id, license_id) VALUES
(1, 1), -- Заказ 1 с лицензией Free Lease на трек 1
(2, 3), -- Заказ 2 с лицензией Free Lease на трек 2
(3, 5); -- Заказ 3 с лицензией Free Lease на трек 3

-- Заполнение таблицы img_files
INSERT INTO public.img_files (name, type, url, size, owner_id) VALUES
('image1.jpg', 'jpg', 'https://example.com/image1.jpg', 1024, 4),
('image2.jpg', 'jpg', 'https://example.com/image2.jpg', 2048, 5);

-- Заполнение таблицы audio_files
INSERT INTO public.audio_files (track_id, name, url, owner_id, size, type) VALUES
(1, 'audio1.mp3', 'https://example.com/audio1.mp3', 4, 5000, 'mp3'),
(2, 'audio2.mp3', 'https://example.com/audio2.mp3', 4, 6000, 'mp3'),
(3, 'audio3.mp3', 'https://example.com/audio3.mp3', 5, 7000, 'mp3'),
(4, 'audio4.mp3', 'https://example.com/audio4.mp3', 5, 8000, 'mp3'),
(5, 'audio5.mp3', 'https://example.com/audio5.mp3', 4, 9000, 'mp3');