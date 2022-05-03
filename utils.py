import sqlite3


def get_connection_sql(sqlite_query):
    with sqlite3.connect("animal.db") as con:
        cur = con.cursor()
        result = cur.execute(sqlite_query)
        return result.fetchall()


def show_item(item):
    sqlite_query = f"""
        select * from new_animals
        where {item} = new_animals.id
    """
    result = get_connection_sql(sqlite_query)
    return result
