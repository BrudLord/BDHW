-- Запрос 2: Топ-5 самых популярных песен по количеству добалений в плейлисты
-- Запрос вычисляет топ-5 песен, которые добавлялись в плейлисты чаще всего.

SET search_path = music_service;

SELECT
    s.id AS song_id,
    s.title AS song_title,
    COUNT(ps.song_id) AS playlist_count,
    RANK() OVER (
        ORDER BY
            COUNT(ps.song_id) DESC
    ) AS rank
FROM
    song s
    JOIN playlist_song ps ON s.id = ps.song_id
GROUP BY
    s.id,
    s.title
ORDER BY
    playlist_count DESC
LIMIT
    5;