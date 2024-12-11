-- Запрос 6: Топ-3 самых активных пользователя по количеству покупок

SET search_path = music_service;

SELECT
    u.id as user_id,
    u.email as user_email,
    COUNT(p.id) as purchase_count,
    RANK() over (
        ORDER BY
            COUNT(p.id) DESC
    ) as rank
FROM
    "user" u
    JOIN purchase p ON u.id = p.user_id
GROUP BY
    u.id,
    u.email
ORDER BY
    rank
LIMIT
    3;