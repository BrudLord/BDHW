CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE playlist (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE user_playlist (
    user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    playlist_id INTEGER NOT NULL REFERENCES playlist(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, playlist_id)
);

CREATE TABLE musician (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    nick_name TEXT NOT NULL
);

CREATE TABLE album (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    date DATE NOT NULL
);

CREATE TABLE musician_album (
    id SERIAL PRIMARY KEY,
    musician_id INTEGER NOT NULL REFERENCES musician(id) ON DELETE CASCADE,
    album_id INTEGER NOT NULL REFERENCES album(id) ON DELETE CASCADE
);

CREATE TABLE user_album (
    user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    album_id INTEGER NOT NULL REFERENCES album(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, album_id)
);

CREATE TABLE song_cost (
    id SERIAL PRIMARY KEY,
    cost DECIMAL(10, 2) NOT NULL,
    version INTEGER NOT NULL
);

CREATE TABLE song (
    id SERIAL PRIMARY KEY,
    album_id INTEGER NOT NULL REFERENCES album(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    file_url TEXT NOT NULL,
    actual_song_cost_id INTEGER NOT NULL REFERENCES song_cost(id) ON DELETE CASCADE
);

CREATE TABLE playlist_song (
    playlist_id INTEGER NOT NULL REFERENCES playlist(id) ON DELETE CASCADE,
    song_id INTEGER NOT NULL REFERENCES song(id) ON DELETE CASCADE,
    PRIMARY KEY (playlist_id, song_id)
);

CREATE TABLE purchase (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    date DATE NOT NULL
);

CREATE TABLE purchase_song (
    purchase_id INTEGER NOT NULL REFERENCES purchase(id) ON DELETE CASCADE,
    song_id INTEGER NOT NULL REFERENCES song(id) ON DELETE CASCADE,
    song_cost_id INTEGER NOT NULL REFERENCES song_cost(id) ON DELETE CASCADE,
    PRIMARY KEY (purchase_id, song_id, song_cost_id)
);