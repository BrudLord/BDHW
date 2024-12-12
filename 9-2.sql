CREATE OR REPLACE FUNCTION insert_new_song_cost_version()
RETURNS TRIGGER AS $$
DECLARE
    v_new_cost_id INTEGER;
    v_old_cost_id INTEGER;
    v_old_cost DECIMAL(10, 2);
    v_new_cost DECIMAL(10, 2);
BEGIN
 FOR v_old_cost_id IN 
        SELECT DISTINCT actual_song_cost_id FROM song 
  LEFT JOIN musician_album ON musician_album.album_id = song.album_id 
  WHERE musician_album.musician_id = OLD.id
    LOOP
        SELECT cost INTO v_old_cost
        FROM song_cost
        WHERE id = v_old_cost_id;

        v_new_cost := 0;

        INSERT INTO song_cost (cost, version)
        VALUES (v_new_cost, (SELECT version + 1 FROM song_cost WHERE id = v_old_cost_id))
        RETURNING id INTO v_new_cost_id;

        UPDATE song
        SET actual_song_cost_id = v_new_cost_id
        WHERE actual_song_cost_id = v_old_cost_id;
    END LOOP;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_new_song_cost_version_trigger
BEFORE DELETE ON music_service.musician
FOR EACH ROW
EXECUTE FUNCTION insert_new_song_cost_version();
