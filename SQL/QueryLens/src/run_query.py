from pathlib import Path
import psycopg2

SQL_PATH = Path(__file__).resolve().parent.parent / 'sql' / 'best_movies.sql'

with open(SQL_PATH, 'r', encoding='utf-8') as f:
    query = f.read()

conn = psycopg2.connect(
    dbname='movielens',
    user='postgres',
    password='password',
    host='localhost',
    port='5432'
)

with conn.cursor() as cur:
    cur.execute(query)
    results = cur.fetchall()

# Print results
for row in results:
    print(row)

conn.close()
