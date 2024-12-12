-- Активность пользователей по плейлистам и покупкам
-- Представление предоставляет данные о том, сколько плейлистов создал каждый пользователь и сколько песен они купили.

SET search_path = music_service;

CREATE VIEW music_service_views.view_user_activity AS
SELECT
    u.id AS user_id,
    u.first_name || ' ' || u.last_name AS user_name,
    COALESCE(COUNT(DISTINCT up.playlist_id), 0) AS total_playlists,
    COALESCE(COUNT(DISTINCT ps.song_id), 0) AS total_purchased_songs
FROM
    "user" u
    LEFT JOIN user_playlist up ON u.id = up.user_id
    LEFT JOIN purchase p ON u.id = p.user_id
    LEFT JOIN purchase_song ps ON p.id = ps.purchase_id
GROUP BY
    u.id,
    u.first_name,
    u.last_name
ORDER BY
    user_name;