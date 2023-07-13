import psycopg2

commands = [
    """
    CREATE TABLE files (
        id SERIAL PRIMARY KEY,
        user_name VARCHAR(100) NOT NULL,
        file_name VARCHAR(255) NOT NULL,
        file_data BYTEA NOT NULL
    );
    """
]

conn = psycopg2.connect(
    host="localhost",
    database="postgres",
    user="postgres",
    password="1234"
)
cur = conn.cursor()

for command in commands:
        cur.execute(command)
        
conn.commit()

cur.close()
conn.close()

