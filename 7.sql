CREATE SCHEMA music_service_views;
SET search_path=music_service_view;

CREATE VIEW view_user AS
SELECT
    first_name,
    COALESCE(last_name, 'N/A') AS last_name,
    CONCAT(SUBSTRING(email, 1, POSITION('@' IN email) - 1), '@****') AS email
FROM music_service.user;

CREATE VIEW view_playlist AS
SELECT
    name
FROM music_service.playlist;

CREATE VIEW view_user_playlist AS
SELECT
    u.first_name AS user_first_name,
    u.last_name AS user_last_name
    p.name AS playlist_name
FROM music_service.user_playlist AS up
INNER JOIN music_service.user AS u 
ON up.user_id = u.id
INNER JOIN music_service.playlist AS p 
ON up.playlist_id = p.id;
