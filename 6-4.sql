-- Запрос 4: Последние альбомы каждого музыканта
-- Запрос определяет последний (по дате выхода) альбом каждого музыканта.

SET search_path = music_service;

SELECT
    m.id AS musician_id,
    m.nick_name AS musician_name,
    a.id AS album_id,
    a.title AS album_title,
    a.date AS release_date
FROM
    musician m
    JOIN musician_album ma ON m.id = ma.musician_id
    JOIN album a ON ma.album_id = a.id
WHERE
    a.date = (
        SELECT
            MAX(a2.date)
        FROM
            musician_album ma2
            JOIN album a2 ON ma2.album_id = a2.id
        WHERE
            ma2.musician_id = m.id
    );