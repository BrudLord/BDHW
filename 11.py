from sqlalchemy import MetaData, create_engine, delete, desc, func, select, update

# Указать ваши значения
DB_LOGIN = "postgres"
DB_PASSWORD = "postgres"
DB_NAME = "hse"
DB_HOST = "localhost"
DB_PORT = "5432"


engine = create_engine(
    f"postgresql://{DB_LOGIN}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)
connection = engine.connect()
metadata = MetaData()
metadata.reflect(bind=engine, schema="music_service")


user_table = metadata.tables["music_service.user"]
playlist_table = metadata.tables["music_service.playlist"]
user_playlist_table = metadata.tables["music_service.user_playlist"]
musician_table = metadata.tables["music_service.musician"]
album_table = metadata.tables["music_service.album"]
song_table = metadata.tables["music_service.song"]
song_cost_table = metadata.tables["music_service.song_cost"]
playlist_song_table = metadata.tables["music_service.playlist_song"]
purchase_table = metadata.tables["music_service.purchase"]
purchase_song_table = metadata.tables["music_service.purchase_song"]


# Create запросы
def create_queries():
    connection.execute(
        user_table.insert(),
        [
            {"first_name": "Kate", "last_name": "KateSurname", "email": "kate@ya.ru"},
            {"first_name": "Leo", "last_name": "LeoSurname", "email": "leo@ya.ru"},
        ],
    )

    connection.execute(
        playlist_table.insert(), [{"name": "Kate Hits"}, {"name": "Leo Favorites"}]
    )

    connection.execute(
        user_playlist_table.insert(),
        [{"user_id": 11, "playlist_id": 7}, {"user_id": 12, "playlist_id": 8}],
    )


# Read запросы
def read_queries():
    # Все плейлисты пользователя Ant
    query = (
        select(playlist_table.c.id, playlist_table.c.name)
        .join(
            user_playlist_table,
            user_playlist_table.c.playlist_id == playlist_table.c.id,
        )
        .join(user_table, user_table.c.id == user_playlist_table.c.user_id)
        .where(user_table.c.first_name == "Ant")
    )
    result = connection.execute(query)
    print("Все плейлисты пользователя Ant:\n", result.fetchall())

    # Все песни альбома с заголовком 'Super Hit 1'
    query = (
        select(song_table.c.id, song_table.c.title)
        .join(album_table, song_table.c.album_id == album_table.c.id)
        .where(album_table.c.title == "Super Hit 1")
    )
    result = connection.execute(query)
    print("Все песни альбома с заголовком 'Super Hit 1':\n", result.fetchall())


# Update запросы
def update_queries():
    update_query = (
        update(user_table)
        .where(user_table.c.first_name == "Bob")
        .values(email="bob.new@ya.ru")
    )
    connection.execute(update_query)


# Delete запросы
def delete_queries():
    delete_query = delete(song_table).where(
        song_table.c.album_id
        == select(album_table.c.id)
        .where(album_table.c.title == "Super Hit 3")
        .scalar_subquery()
    )
    connection.execute(delete_query)


# Сложные read-запросы
def analytical_queries():
    # Сумма покупок по дням, в которые вышло более 1 бакса
    analytic_query = (
        select(
            func.date_trunc("day", purchase_table.c.date).label("purchase_day"),
            func.sum(song_cost_table.c.cost).label("total_cost"),
        )
        .join(
            purchase_song_table,
            purchase_table.c.id == purchase_song_table.c.purchase_id,
        )
        .join(
            song_cost_table, purchase_song_table.c.song_cost_id == song_cost_table.c.id
        )
        .group_by(func.date_trunc("day", purchase_table.c.date))
        .having(func.sum(song_cost_table.c.cost) > 1)
        .order_by(desc("total_cost"))
    )
    result = connection.execute(analytic_query)
    print(
        "Сумма покупок по дням, в которые вышло более 1 бакса:",
        *result.fetchall(),
        sep="\n",
    )

    # Топ-5 песен, которые добавлялись в плейлисты чаще всего
    top_songs_query = (
        select(
            song_table.c.id.label("song_id"),
            song_table.c.title.label("song_title"),
            func.count(playlist_song_table.c.song_id).label("playlist_count"),
            func.rank()
            .over(order_by=func.count(playlist_song_table.c.song_id).desc())
            .label("rank"),
        )
        .join(playlist_song_table, song_table.c.id == playlist_song_table.c.song_id)
        .group_by(song_table.c.id, song_table.c.title)
        .order_by(desc("playlist_count"))
        .limit(5)
    )
    result = connection.execute(top_songs_query)
    print(
        "Топ-5 песен, которые добавлялись в плейлисты чаще всего:",
        *result.fetchall(),
        sep="\n",
    )

    # Средняя стоимость покупки для каждого пользователя
    average_cost_query = (
        select(
            user_table.c.id.label("user_id"),
            user_table.c.email.label("user_email"),
            func.avg(func.coalesce(song_cost_table.c.cost, 0)).label("average_cost"),
        )
        .join(purchase_table, user_table.c.id == purchase_table.c.user_id, isouter=True)
        .join(
            purchase_song_table,
            purchase_table.c.id == purchase_song_table.c.purchase_id,
            isouter=True,
        )
        .join(
            song_cost_table,
            purchase_song_table.c.song_cost_id == song_cost_table.c.id,
            isouter=True,
        )
        .group_by(user_table.c.id, user_table.c.email)
    )
    result = connection.execute(average_cost_query)
    print(
        "Средняя стоимость покупки для каждого пользователя:",
        *result.fetchall(),
        sep="\n",
    )


create_queries()
read_queries()
update_queries()
delete_queries()
analytical_queries()

# Закрытие соединения
connection.close()
