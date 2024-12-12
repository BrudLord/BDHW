-- Статистика по количеству покупок и доходу от продаж песен
-- Представление показывает, сколько раз каждая песня была продана, общий доход от её продаж и данные о её альбоме.

SET search_path = music_service;

CREATE VIEW music_service_views.view_sales_statistics AS
SELECT
    s.id AS song_id,
    s.title AS song_title,
    a.title AS album_title,
    COUNT(ps.song_id) AS total_sales,
    COALESCE(SUM(sc.cost), 0) AS total_revenue
FROM
    song s
    LEFT JOIN album a ON s.album_id = a.id
    LEFT JOIN purchase_song ps ON s.id = ps.song_id
    LEFT JOIN song_cost sc ON ps.song_cost_id = sc.id
GROUP BY
    s.id,
    s.title,
    a.title
ORDER BY
    song_title;