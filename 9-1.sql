CREATE TABLE IF NOT EXISTS music_service.change_logs (
    id serial PRIMARY KEY,
    table_name TEXT,
    change_type TEXT,
    changed_by TEXT,
    change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION music_service.log_table_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO music_service.change_logs(table_name, change_type, changed_by)
    VALUES (TG_TABLE_SCHEMA || '.' || TG_TABLE_NAME, TG_OP, current_user);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    tbl_name TEXT;
    trgr_name TEXT;
BEGIN
    FOR tbl_name IN
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'music_service'
          AND table_type = 'BASE TABLE' AND table_name != 'change_logs'
    LOOP
        trgr_name := format('%I_changes', tbl_name);

        IF NOT EXISTS (
            SELECT 1 FROM information_schema.triggers
            WHERE trigger_name = trgr_name
              AND event_object_table = tbl_name
              AND event_object_schema = 'music_service'
        ) THEN
            EXECUTE format('
                CREATE TRIGGER %I
                AFTER INSERT OR UPDATE OR DELETE ON %I.%I
                FOR EACH ROW EXECUTE FUNCTION music_service.log_table_changes();',
                trgr_name, 'music_service', tbl_name);
        END IF;
    END LOOP;
END $$;
