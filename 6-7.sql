-- Запрос 7: Актуальная цена песен с учётом версионности
-- Запрос выводит список песен с их актуальной ценой. Цена берется из последней версии стоимости

SET search_path = music_service;

SELECT
    s.id AS song_id,
    s.title AS song_title,
    sc.cost AS current_cost,
    sc.version AS current_version
FROM
    song s
    JOIN song_cost sc ON s.actual_song_cost_id = sc.id
WHERE
    sc.version = (
        SELECT
            MAX(version)
        FROM
            song_cost sc2
        WHERE
            sc2.id = sc.id
    );