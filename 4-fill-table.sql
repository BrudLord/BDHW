SET search_path=music_service;
INSERT INTO "user" (first_name, last_name, email) values
    ('Ant', 'AntSurname', 'ant@ya.ru'),
    ('Bob', 'BobSurname', 'bob@ya.ru'),
    ('Cora', 'CoraSurname', 'cora@ya.ru'),
    ('Dobby', 'DobbySurname', 'dobby@ya.ru'),
    ('Eva', 'EvaSurname', 'eva@ya.ru'),
    ('Foma', 'FomaaSurname', 'foma@ya.ru'),
    ('Gorge', 'GorgeSurname', 'gorge@ya.ru'),
    ('Holms', 'HolmsSurname', 'holms@ya.ru'),
    ('Ivan', 'IvanSurname', 'ivan@ya.ru'),
    ('John', 'JohnSurname', 'john@ya.ru');
  
INSERT INTO playlist (name) VALUES
    ('Abby Songs'),
    ('Bobr dobr'),
    ('Cars and co'),
    ('Dobby the best'),
    ('Easter songs'),
    ('Franch music');
  
INSERT INTO user_playlist (user_id, playlist_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 6),
    (2, 2),
    (3, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 6);
  
INSERT INTO musician (user_id, nick_name) VALUES
    (1, 'DJ Ant'),
    (2, 'Bob Beats'),
    (3, 'Cora-Cora'),
    (5, 'Eva Online'),
    (6, 'Foma not believe'),
    (10, 'Super John 3000');
  
INSERT INTO album (title, date) VALUES
    ('Super Hit 1', '2021-01-01'),
    ('Super Hit 2', '2022-02-02'),
    ('Super Hit 3', '2023-03-03'),
    ('Super Hit 4', '2024-04-04'),
    ('Super Hit 5', '2025-05-05'),
    ('Super Hit 6', '2026-06-06');
  
INSERT INTO musician_album (musician_id, album_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 5),
    (6, 6);
  
INSERT INTO song_cost (cost, version) VALUES
    (0.99, 1),
    (5.29, 2),
    (10.99, 3),
    (1.29, 1),
    (0.99, 1),
    (1.00, 1),
    (5.99, 1),
    (6.29, 1),
    (126.29, 1);
  
INSERT INTO song (album_id, title, file_url, actual_song_cost_id) VALUES
    (1, 'Song 1, Hit 1', 'http://example.com/song1.mp3', 3),
    (1, 'Song 2, Hit 1', 'http://example.com/song2.mp3', 4),
    (2, 'Song 1, Hit 2', 'http://example.com/song3.mp3', 5),
    (3, 'Song 1, Hit 3', 'http://example.com/song4.mp3', 6),
    (4, 'Song 1, Hit 4', 'http://example.com/song5.mp3', 7),
    (5, 'Song 1, Hit 5', 'http://example.com/song6.mp3', 8),
    (6, 'Song 1, Hit 6', 'http://example.com/song7.mp3', 9);
  
INSERT INTO playlist_song (playlist_id, song_id) VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 3),
    (3, 1),
    (4, 3),
    (5, 6),
    (6, 5);
  
INSERT INTO purchase (user_id, date) VALUES
    (1, '2023-09-01'),
    (2, '2023-09-02'),
    (3, '2023-09-03'),
    (4, '2023-09-04'),
    (5, '2023-09-05');
  
INSERT INTO purchase_song (purchase_id, song_id, song_cost_id) VALUES
    (1, 1, 2),
    (2, 2, 4),
    (3, 3, 5),
    (4, 4, 6),
    (5, 5, 7);
