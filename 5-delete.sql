DELETE FROM song
WHERE album_id = (SELECT id FROM album WHERE title = 'Super Hit 3');

DELETE FROM playlist
WHERE id NOT IN (SELECT DISTINCT playlist_id FROM playlist_song);

DELETE FROM musician WHERE user_id = 10;
DELETE FROM purchase WHERE user_id = 10;
DELETE FROM "user" WHERE id = 10;

DELETE FROM purchase
WHERE date < '2023-01-01';

DELETE FROM song
WHERE file_url NOT LIKE '%.mp3';

DELETE FROM musician
WHERE id NOT IN (SELECT DISTINCT musician_id FROM musician_album);