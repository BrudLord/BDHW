-- Запрос 3: Средняя стоимость покупки для каждого пользователя
-- Запрос вычисляет среднюю стоимость покупки для каждого пользователя, где есть хотя бы одна покупка

SET search_path = music_service;

SELECT
    u.id AS user_id,
    u.email AS user_email,
    AVG(SUM(sc.cost)) OVER (PARTITION BY u.id) AS avg_purchase_cost
FROM
    "user" u
    JOIN purchase p ON u.id = p.user_id
    JOIN purchase_song ps ON p.id = ps.purchase_id
    JOIN song_cost sc ON ps.song_cost_id = sc.id
GROUP BY
    u.id,
    u.email,
    p.id;