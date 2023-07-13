import psycopg2

commands = (
  """
  CREATE TABLE auth (
    id SERIAL PRIMARY KEY,
    username VARCHAR(150) NOT NULL,
    password VARCHAR(150) NOT NULL
  );
  """,
  
  """
  INSERT INTO auth(username, password) VALUES('me','myself');
  INSERT INTO auth(username, password) VALUES('myself','me');
  """
)

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