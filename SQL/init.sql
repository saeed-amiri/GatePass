-- Create and connect to a database manually later; don't include \c here
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT,
  age INT
);

INSERT INTO users (name, age) VALUES ('Neo', 37), ('Trinity', 35);

SELECT * FROM users;
