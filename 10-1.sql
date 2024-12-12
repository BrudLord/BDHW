-- Процедура, которая навешивает заданную скидку на все песни

SET search_path = music_service;

CREATE OR REPLACE PROCEDURE make_discount(p_discount_percentage DECIMAL(5, 2))
LANGUAGE plpgsql AS
$$
DECLARE
    v_new_cost_id INTEGER;
    v_old_cost_id INTEGER;
    v_old_cost DECIMAL(10, 2);
    v_new_cost DECIMAL(10, 2);
BEGIN
    FOR v_old_cost_id IN 
        SELECT DISTINCT actual_song_cost_id FROM song
    LOOP
        SELECT cost INTO v_old_cost
        FROM song_cost
        WHERE id = v_old_cost_id;

        v_new_cost := v_old_cost * (1 - p_discount_percentage / 100);

        INSERT INTO song_cost (cost, version)
        VALUES (v_new_cost, (SELECT version + 1 FROM song_cost WHERE id = v_old_cost_id))
        RETURNING id INTO v_new_cost_id;

        UPDATE song
        SET actual_song_cost_id = v_new_cost_id
        WHERE actual_song_cost_id = v_old_cost_id;
    END LOOP;
END;
$$;
