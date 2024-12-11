SET search_path=music_service;

INSERT INTO "user" (first_name, last_name, email) VALUES
    ('Kate', 'KateSurname', 'kate@ya.ru'),
    ('Leo', 'LeoSurname', 'leo@ya.ru');

INSERT INTO playlist (name) VALUES
    ('Kate Hits'),
    ('Leo Favorites');

INSERT INTO user_playlist (user_id, playlist_id) VALUES
    (11, 7),
    (12, 8);

INSERT INTO musician (user_id, nick_name) VALUES
    (11, 'DJ Kate');

INSERT INTO album (title, date) VALUES
    ('New Era', '2023-12-12');

INSERT INTO musician_album (musician_id, album_id) VALUES
    (7, 7);
   
INSERT INTO song_cost (cost, version) VALUES
    (1.50, 1);

INSERT INTO song (album_id, title, file_url, actual_song_cost_id) VALUES
    (7, 'Song 1, New Era', 'http://example.com/newera_song1.mp3', 10);

INSERT INTO playlist_song (playlist_id, song_id) VALUES
    (7, 8),
    (8, 8);
    
INSERT INTO purchase (user_id, date) VALUES
    (11, '2023-09-06');

INSERT INTO purchase_song (purchase_id, song_id, song_cost_id) VALUES
    (6, 8, 10);
