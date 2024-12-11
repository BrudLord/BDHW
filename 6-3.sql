-- Запрос 3: Средняя стоимость покупки для каждого пользователя

SET search_path = music_service;

SELECT
    u.id AS user_id,
    u.email AS user_email,
    AVG(COALESCE(sc.cost, 0))
FROM
    "user" u
    LEFT JOIN purchase p ON u.id = p.user_id
    LEFT JOIN purchase_song ps ON p.id = ps.purchase_id
    LEFT JOIN song_cost sc ON ps.song_cost_id = sc.id
GROUP BY
    u.id,
    u.email;