-- Поиск всех плейлистов, принадлежащих пользователю 'Ant'
SELECT p.id, p.name 
FROM user_playlist up
JOIN playlist p ON up.playlist_id = p.id
JOIN "user" u ON up.user_id = u.id
WHERE u.first_name = 'Ant';

-- Вывести все песни альбома с заголовком 'Super Hit 1'
SELECT s.id, s.title, s.file_url
FROM song s
JOIN album a ON s.album_id = a.id
WHERE a.title = 'Super Hit 1';

-- Список всех пользователей, которые сделали покупки песен на сумму более 5.00
SELECT DISTINCT u.id, u.first_name, u.last_name, u.email
FROM "user" u
JOIN purchase p ON u.id = p.user_id
JOIN purchase_song ps ON p.id = ps.purchase_id
JOIN song_cost sc ON ps.song_cost_id = sc.id
WHERE sc.cost > 5.00;

-- Найти все никнеймы музыкантов и названия их альбомов
SELECT m.nick_name, a.title
FROM musician m
JOIN musician_album ma ON m.id = ma.musician_id
JOIN album a ON ma.album_id = a.id;

-- Вывести все песни и их стоимость, которые находятся в плейлисте 'Abby Songs'
SELECT s.title, sc.cost
FROM song s
JOIN playlist_song ps ON s.id = ps.song_id
JOIN playlist p ON ps.playlist_id = p.id
JOIN song_cost sc ON s.actual_song_cost_id = sc.id
WHERE p.name = 'Abby Songs';

-- Показать все альбомы, выпущенные в 2022 году
SELECT a.title
FROM album a
WHERE a.date BETWEEN '2022-01-01' AND '2022-12-31';

-- Найти пользователей, у которых больше двух плейлистов
SELECT u.id, u.first_name, u.last_name, COUNT(up.playlist_id) as playlist_count
FROM "user" u
JOIN user_playlist up ON u.id = up.user_id
GROUP BY u.id, u.first_name, u.last_name
HAVING COUNT(up.playlist_id) > 2;