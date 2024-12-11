-- Запрос 5: Список альбомов с количеством песен и средней стоимостью песен
-- Запрос выводит список альбомов с указанием количества песен в каждом альбоме и средней стоимости этих песен, отсортированный по средней стоимости песни.

SET search_path = music_service;

SELECT
    a.id AS album_id,
    a.title AS album_title,
    COUNT(s.id) AS song_count,
    AVG(sc.cost) AS avg_song_cost
FROM
    album a
    JOIN song s ON a.id = s.album_id
    JOIN song_cost sc ON s.actual_song_cost_id = sc.id
GROUP BY
    a.id,
    a.title
ORDER BY
    avg_song_cost DESC;