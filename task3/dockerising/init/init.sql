CREATE TABLE files (
        id SERIAL PRIMARY KEY,
        user_name VARCHAR(100) NOT NULL,
        file_name VARCHAR(255) NOT NULL,
        file_data BYTEA NOT NULL
    );

CREATE TABLE auth (
      id SERIAL PRIMARY KEY,
      username VARCHAR(150) NOT NULL,
      password VARCHAR(150) NOT NULL
    );

INSERT INTO auth(username, password) VALUES('me','myself');
INSERT INTO auth(username, password) VALUES('myself','me');
