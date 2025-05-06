-- Create and connect to a database manually later; don't include \c here
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(32),
  age INT
);

INSERT INTO users (name, age) VALUES ('Neo', 37), ('Trinity', 35);

COPY users TO '/tmp/users.csv' WITH (FORMAT csv, HEADER);
SELECT * FROM users;
