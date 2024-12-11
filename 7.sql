CREATE SCHEMA music_service_views;
SET search_path=music_service_views;

CREATE VIEW view_user AS
SELECT
    first_name,
    COALESCE(last_name, 'N/A') last_name,
    CONCAT(SUBSTRING(email, 1, POSITION('@' IN email) - 1), '@****') AS email
FROM music_service."user";

CREATE VIEW view_playlist AS
SELECT
    name
FROM music_service.playlist;

CREATE VIEW view_user_playlist AS
SELECT
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    p.name AS playlist_name
FROM music_service.user_playlist up
INNER JOIN music_service."user" u 
ON up.user_id = u.id
INNER JOIN music_service.playlist p 
ON up.playlist_id = p.id;

CREATE VIEW music_service_views.view_musician AS
SELECT
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    LEFT(nick_name, 3) || REPEAT('*', LENGTH(nick_name) - 3) AS nick_name
FROM music_service.musician m
INNER JOIN music_service."user" u 
ON m.user_id = u.id;

CREATE VIEW view_album AS
SELECT
    title,
    date
FROM music_service.album;

CREATE VIEW view_musician_album AS
SELECT
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    a.title AS album_title
FROM music_service.musician_album ma
INNER JOIN music_service.musician m 
ON ma.musician_id = m.id
INNER JOIN music_service."user" u 
ON m.user_id = u.id
INNER JOIN music_service.album a 
ON ma.album_id = a.id;

CREATE VIEW music_service_views.view_user_album AS
SELECT
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    a.title AS album_title
FROM music_service.user_album ua
INNER JOIN music_service."user" u 
ON ua.user_id = u.id
INNER JOIN music_service.album a 
ON ua.album_id = a.id;

CREATE VIEW music_service_views.view_song_cost AS
SELECT
    CONCAT(LEFT(cost::TEXT, POSITION('.' IN cost::TEXT) - 1), '.**') AS masked_cost
FROM music_service.song_cost;

CREATE VIEW music_service_views.view_song AS
SELECT
    a.title AS album_title,
    s.title AS song_title,
    s.file_url,
    CONCAT(LEFT(sc.cost::TEXT, POSITION('.' IN sc.cost::TEXT) - 1), '.**') AS masked_cost
FROM music_service.song s
INNER JOIN music_service.album a 
ON s.album_id = a.id
INNER JOIN music_service.song_cost sc 
ON s.actual_song_cost_id = sc.id;

CREATE VIEW music_service_views.view_playlist_song AS
SELECT
    p.name AS playlist_name,
    s.title AS song_title
FROM music_service.playlist_song ps
INNER JOIN music_service.playlist p 
ON ps.playlist_id = p.id
INNER JOIN music_service.song s 
ON ps.song_id = s.id;

CREATE VIEW music_service_views.view_purchase AS
SELECT
    p.date AS purchase_date,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name
FROM music_service.purchase p
INNER JOIN music_service."user" u 
ON p.user_id = u.id;

CREATE VIEW music_service_views.view_purchase_song AS
SELECT
    pu.date AS purchase_date,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    s.title AS song_title,
    CONCAT(LEFT(sc.cost::TEXT, POSITION('.' IN sc.cost::TEXT) - 1), '.**') AS masked_cost
FROM music_service.purchase_song ps
INNER JOIN music_service.purchase pu 
ON ps.purchase_id = pu.id
INNER JOIN music_service."user" u 
ON pu.user_id = u.id
INNER JOIN music_service.song s 
ON ps.song_id = s.id
INNER JOIN music_service.song_cost sc 
ON ps.song_cost_id = sc.id;
