-- Отключение внешних ключей
ALTER TABLE public.user_roles DROP CONSTRAINT IF EXISTS user_roles_role_id_fkey;
ALTER TABLE public.user_roles DROP CONSTRAINT IF EXISTS user_roles_user_id_fkey;
ALTER TABLE public.user_info DROP CONSTRAINT IF EXISTS user_info_user_id_fkey;
ALTER TABLE public.referrals DROP CONSTRAINT IF EXISTS referrals_referred_id_fkey;
ALTER TABLE public.referrals DROP CONSTRAINT IF EXISTS referrals_referrer_id_fkey;
ALTER TABLE public.tracks DROP CONSTRAINT IF EXISTS tracks_owner_id_fkey;
ALTER TABLE public.licenses DROP CONSTRAINT IF EXISTS licenses_track_id_fkey;
ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_user_id_fkey;
ALTER TABLE public.order_tracks DROP CONSTRAINT IF EXISTS order_tracks_license_id_fkey;
ALTER TABLE public.order_tracks DROP CONSTRAINT IF EXISTS order_tracks_order_id_fkey;
ALTER TABLE public.tracks DROP CONSTRAINT IF EXISTS tracks_img_files_id_fkey;
ALTER TABLE public.audio_files DROP CONSTRAINT IF EXISTS audio_files_track_id_fkey;

-- Удаление таблиц в правильном порядке
DROP TABLE IF EXISTS public.roles_audit;
DROP TABLE IF EXISTS public.audio_files;
DROP TABLE IF EXISTS public.img_files;
DROP TABLE IF EXISTS public.order_tracks;
DROP TABLE IF EXISTS public.orders;
DROP TABLE IF EXISTS public.licenses;
DROP TABLE IF EXISTS public.tracks;
DROP TABLE IF EXISTS public.referrals;
DROP TABLE IF EXISTS public.user_info;
DROP TABLE IF EXISTS public.user_roles;
DROP TABLE IF EXISTS public.roles;
DROP TABLE IF EXISTS public.users;

-- Включение внешних ключей (если потребуется пересоздание таблиц)
