UPDATE "user"
SET email = 'bob.new@ya.ru'
WHERE first_name = 'Bob';

UPDATE playlist
SET name = 'Vehicles and more'
WHERE name = 'Cars and co';

UPDATE song_cost
SET cost = 4.99
WHERE id = (SELECT actual_song_cost_id FROM song WHERE title = 'Song 1, Hit 5');

UPDATE musician
SET nick_name = 'Ultimate John'
WHERE nick_name = 'Super John 3000';

UPDATE album
SET date = '2023-02-15'
WHERE title = 'Super Hit 2';

UPDATE song_cost
SET cost = 1.49
WHERE cost < 1.00;