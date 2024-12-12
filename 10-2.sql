CREATE OR REPLACE PROCEDURE delete_user_albums_and_playlist_by_musician(p_user_id INTEGER, p_musician_id INTEGER)
LANGUAGE plpgsql AS
$$
BEGIN
    DELETE FROM user_album
    WHERE user_id = p_user_id
    AND album_id IN (
        SELECT a.id
        FROM album a
        INNER JOIN musician_album ma ON a.id = ma.album_id
        WHERE ma.musician_id = p_musician_id
    );

    DELETE FROM user_playlist
    WHERE user_id = p_user_id
    AND playlist_id IN (
        SELECT ps.playlist_id
        FROM playlist_song ps
        INNER JOIN song s ON ps.song_id = s.id
        INNER JOIN album a ON s.album_id = a.id
        INNER JOIN musician_album ma ON a.id = ma.album_id
        WHERE ma.musician_id = p_musician_id
    );
END;
$$;
