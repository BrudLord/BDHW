-- Информация о музыкантах и их альбомах
-- Представление показывает данные о музыкантах, их псевдонимах, количестве выпущенных альбомов и общем количестве песен в этих альбомах.

SET search_path = music_service;

CREATE VIEW music_service_views.view_musician_albums_and_songs AS
SELECT
    m.id AS musician_id,
    m.nick_name AS musician_nick_name,
    COUNT(DISTINCT ma.album_id) AS total_albums,
    COUNT(s.id) AS total_songs
FROM
    musician m
    LEFT JOIN musician_album ma ON m.id = ma.musician_id
    LEFT JOIN album a ON ma.album_id = a.id
    LEFT JOIN song s ON a.id = s.album_id
GROUP BY
    m.id,
    m.nick_name
ORDER BY
    musician_nick_name;