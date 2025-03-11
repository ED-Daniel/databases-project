CREATE OR REPLACE PROCEDURE add_user_with_info(
    IN p_email VARCHAR,
    IN p_password TEXT,
    IN p_full_name VARCHAR DEFAULT NULL,
    IN p_nickname VARCHAR DEFAULT NULL,
    IN p_about TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_user_id INT;
    v_exists INT;
BEGIN
    -- Проверяем, существует ли пользователь с таким email
    SELECT id INTO v_user_id FROM users WHERE email = p_email;

    IF v_user_id IS NULL THEN
        -- Пользователь не найден - создаем нового
        INSERT INTO users (email, password)
        VALUES (p_email, pgp_sym_encrypt(p_password, 'MySecretKey'))
        RETURNING id INTO v_user_id;

        RAISE NOTICE 'Создан новый пользователь ID: %', v_user_id;
    ELSE
        RAISE NOTICE 'Пользователь уже существует с ID: %', v_user_id;
    END IF;

    -- Проверяем, есть ли у пользователя запись в user_info
    SELECT COUNT(*) INTO v_exists FROM user_info WHERE user_id = v_user_id;

    IF v_exists = 0 THEN
        -- Если информации нет, создаем новую запись
        INSERT INTO user_info (user_id, full_name, nickname, about)
        VALUES (v_user_id, p_full_name, p_nickname, p_about);

        RAISE NOTICE 'Добавлена информация о пользователе ID: %', v_user_id;
    ELSE
        RAISE NOTICE 'Информация о пользователе уже существует для ID: %', v_user_id;
    END IF;
END;
$$;
