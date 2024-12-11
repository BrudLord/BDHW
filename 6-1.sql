-- Запрос 1: Дни, в которые пользователи купили песен хотя бы на 1 доллар
-- Запрос подсчитывает общую стоимость песен, купленных пользователями, группируя данные по дням. Также фильтруются только те месяцы, где общая стоимость покупок превышает 1.

SET search_path = music_service;

SELECT
    DATE_TRUNC('day', p.date) AS purchase_month,
    SUM(sc.cost) AS total_cost
FROM
    purchase p
    JOIN purchase_song ps ON p.id = ps.purchase_id
    JOIN song_cost sc ON ps.song_cost_id = sc.id
GROUP BY
    DATE_TRUNC('day', p.date)
HAVING
    SUM(sc.cost) > 1
ORDER BY
    total_cost DESC;