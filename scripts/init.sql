CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- public.users definition

-- Drop table

-- DROP TABLE public.users;

CREATE TABLE public.users (
	email varchar NOT NULL,
	"password" BYTEA NOT NULL,
	is_verified bool NOT NULL DEFAULT false,
	verification_code varchar NULL,
	referral_code varchar NOT NULL DEFAULT gen_random_uuid(),
	is_ban bool NOT NULL DEFAULT false,
	is_deleted bool NOT NULL DEFAULT false,
	id serial4 NOT NULL,
	created_at timestamptz NULL DEFAULT now(),
	updated_at timestamptz NULL,
	CONSTRAINT users_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);
CREATE INDEX ix_users_id ON public.users USING btree (id);

-- Permissions

ALTER TABLE public.users OWNER TO test;
GRANT ALL ON TABLE public.users TO test;

---------------------------------------------------------------------------

-- public.roles definition

-- Drop table

-- DROP TABLE public.roles;

CREATE TABLE public.roles (
	"name" varchar NOT NULL,
	description text NULL,
	id serial4 NOT NULL,
	CONSTRAINT roles_pkey PRIMARY KEY (id)
);
CREATE INDEX ix_roles_id ON public.roles USING btree (id);
CREATE UNIQUE INDEX ix_roles_name ON public.roles USING btree (name);

-- Permissions

ALTER TABLE public.roles OWNER TO test;
GRANT ALL ON TABLE public.roles TO test;

---------------------------------------------------------------------------

-- public.user_roles definition

-- Drop table

-- DROP TABLE public.user_roles;

CREATE TABLE public.user_roles (
	user_id int8 NOT NULL,
	role_id int8 NOT NULL,
	CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id)
);

-- Permissions

ALTER TABLE public.user_roles OWNER TO test;
GRANT ALL ON TABLE public.user_roles TO test;

-- public.user_roles foreign keys

ALTER TABLE public.user_roles ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);
ALTER TABLE public.user_roles ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);

---------------------------------------------------------------------------

-- public.user_info definition

-- Drop table

-- DROP TABLE public.user_info;

CREATE TABLE public.user_info (
	user_id int8 NOT NULL,
	full_name varchar NULL,
	show_full_name bool NULL,
	nickname varchar NULL,
	show_nickname bool NULL,
	about text NULL,
	show_about bool NULL,
	instagram_url varchar NULL,
	show_instagram bool NULL,
	youtube_url varchar NULL,
	show_youtube bool NULL,
	telegram_url varchar NULL,
	show_telegram bool NULL,
	contact_phone varchar NULL,
	show_contact_phone bool NULL,
	id serial4 NOT NULL,
	avatar_img_id int8 NULL,
	CONSTRAINT user_info_pkey PRIMARY KEY (id)
);
CREATE INDEX ix_user_info_id ON public.user_info USING btree (id);

-- Permissions

ALTER TABLE public.user_info OWNER TO test;
GRANT ALL ON TABLE public.user_info TO test;


-- public.user_info foreign keys

ALTER TABLE public.user_info ADD CONSTRAINT user_info_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);

---------------------------------------------------------------------------

-- public.referrals definition

-- Drop table

-- DROP TABLE public.referrals;

CREATE TABLE public.referrals (
	referrer_id int8 NOT NULL,
	referred_id int8 NOT NULL,
	id serial4 NOT NULL,
	created_at timestamptz NULL DEFAULT now(),
	CONSTRAINT referrals_pkey PRIMARY KEY (id)
);
CREATE INDEX ix_referrals_id ON public.referrals USING btree (id);

-- Permissions

ALTER TABLE public.referrals OWNER TO test;
GRANT ALL ON TABLE public.referrals TO test;


-- public.referrals foreign keys

ALTER TABLE public.referrals ADD CONSTRAINT referrals_referred_id_fkey FOREIGN KEY (referred_id) REFERENCES public.users(id);
ALTER TABLE public.referrals ADD CONSTRAINT referrals_referrer_id_fkey FOREIGN KEY (referrer_id) REFERENCES public.users(id);

---------------------------------------------------------------------------

-- public.tracks definition

-- Drop table

-- DROP TABLE public.tracks;

CREATE TABLE public.tracks (
	id bigserial NOT NULL,
	"name" varchar NOT NULL,
	img_files_id int8 NULL,
	description text NULL,
	"type" varchar NULL,
	key_sign varchar NULL,
	bpm int4 NULL,
	free_download bool NULL,
	owner_id int8 NULL,
	created_at timestamptz NULL DEFAULT now(),
	updated_at timestamptz NULL,
	is_deleted bool NULL,
	is_draft bool NULL,
	duration int4 NULL,
	CONSTRAINT tracks_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.tracks OWNER TO test;
GRANT ALL ON TABLE public.tracks TO test;


-- public.tracks foreign keys

ALTER TABLE public.tracks ADD CONSTRAINT tracks_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id);

---------------------------------------------------------------------------

-- public.licenses definition

-- Drop table

-- DROP TABLE public.licenses;

CREATE TABLE public.licenses (
	id bigserial NOT NULL,
	"name" varchar NOT NULL,
	track_id int8 NULL,
	price_rub numeric(10, 2) NULL,
	price_usd numeric(10, 2) NULL,
	term_years int4 NULL,
	distribution_copies int4 NULL,
	audio_streams int4 NULL,
	free_downloads int4 NULL,
	monetized_video_streams int4 NULL,
	non_monetized_video_streams int4 NULL,
	monetized_videos int4 NULL,
	non_monetized_videos int4 NULL,
	radio_broadcasting_rights bool NULL,
	radio_stations_allowed int4 NULL,
	performance_for_profit bool NULL,
	not_for_profit_performances int4 NULL,
	is_deleted bool NULL,
	is_show bool NULL,
	CONSTRAINT licenses_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.licenses OWNER TO test;
GRANT ALL ON TABLE public.licenses TO test;


-- public.licenses foreign keys

ALTER TABLE public.licenses ADD CONSTRAINT licenses_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.tracks(id);

---------------------------------------------------------------------------

-- public.orders definition

-- Drop table

-- DROP TABLE public.orders;

CREATE TABLE public.orders (
	id bigserial NOT NULL,
	user_id int8 NULL,
	amount int4 NOT NULL,
	currency varchar NULL,
	status varchar NULL,
	created_at timestamptz NULL DEFAULT now(),
	updated_at timestamptz NULL,
	CONSTRAINT orders_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.orders OWNER TO test;
GRANT ALL ON TABLE public.orders TO test;


-- public.orders foreign keys

ALTER TABLE public.orders ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);

---------------------------------------------------------------------------

-- public.order_tracks definition

-- Drop table

-- DROP TABLE public.order_tracks;

CREATE TABLE public.order_tracks (
	id bigserial NOT NULL,
	order_id int8 NULL,
	license_id int8 NULL,
	CONSTRAINT order_tracks_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.order_tracks OWNER TO test;
GRANT ALL ON TABLE public.order_tracks TO test;

---------------------------------------------------------------------------

-- public.order_tracks foreign keys

ALTER TABLE public.order_tracks ADD CONSTRAINT order_tracks_license_id_fkey FOREIGN KEY (license_id) REFERENCES public.licenses(id);
ALTER TABLE public.order_tracks ADD CONSTRAINT order_tracks_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);
ALTER TABLE order_tracks ADD CONSTRAINT unique_order_license UNIQUE (order_id, license_id);


-- public.img_files definition

-- Drop table

-- DROP TABLE public.img_files;

CREATE TABLE public.img_files (
	id bigserial NOT NULL,
	"name" varchar NOT NULL,
	"type" varchar NULL,
	url varchar NOT NULL,
	"size" int4 NULL,
	owner_id int8 NULL,
	created_at timestamptz NULL DEFAULT now(),
	CONSTRAINT img_files_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.img_files OWNER TO test;
GRANT ALL ON TABLE public.img_files TO test;

-- public.tracks foreign keys

ALTER TABLE public.tracks ADD constraint tracks_img_files_id_fkey FOREIGN KEY (img_files_id) REFERENCES public.img_files(id);

---------------------------------------------------------------------------

-- public.audio_files definition

-- Drop table

-- DROP TABLE public.audio_files;

CREATE TABLE public.audio_files (
	id bigserial NOT NULL,
	track_id int8 NULL,
	"name" varchar NOT NULL,
	url varchar NOT NULL,
	owner_id int8 NULL,
	"size" int4 NULL,
	"type" varchar NULL,
	created_at timestamptz NULL DEFAULT now(),
	CONSTRAINT audio_files_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.audio_files OWNER TO test;
GRANT ALL ON TABLE public.audio_files TO test;


-- public.audio_files foreign keys

ALTER TABLE public.audio_files ADD CONSTRAINT audio_files_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.tracks(id);

---------------------------------------------------------------------------

-- DROP TABLE public.roles_audit;

CREATE TABLE roles_audit (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL,
    old_name VARCHAR NOT NULL,
    old_description TEXT,
    action_type VARCHAR(10) NOT NULL,  -- UPDATE или DELETE
    modified_at TIMESTAMPTZ DEFAULT now(),
    modified_by VARCHAR NOT NULL  -- Кто сделал изменение
);