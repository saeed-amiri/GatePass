# Commands to Run the SQL Script
## Run the SQL Script Using the `psql` command in `postgres`
```bash
sudo -i -u postgres psql -d testdb -f path/script.sql
```
in which:
- `sudo -i -u postgres` is used to switch to the `postgres` user:
    - `-i` makes the shell act as if it had been invoked as a login shell.
    - `-u postgres` specifies the user to switch to, in this case, `postgres`.

- `psql` is the PostgreSQL command line client.
- `-d testdb` specifies the database to connect to:
    - `-d` is the option to specify the database name.
    - `testdb` is the name of the database to connect to.
- `-f path/to/your/script.sql` specifies the path to the SQL script file to be executed.
    - `-f` is the option to specify a file to execute.
    - `path/to/your/script.sql` is the path to the SQL script file to be executed.


## Creating a Database and a Table
```sql
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT,
  age INT
);

INSERT INTO users (name, age) VALUES ('Neo', 37), ('Trinity', 35);
```
Saving this table in a cvs file:
```sql
COPY users TO 'tmp/file.csv' DELIMITER ',' CSV HEADER;
```
But only `/tmp` dir can be used, because `COPY` runs inside the PostgreSQL server:
- Not your terminal, 
- Not the `psql` client, 
- It’s executed by the PostgreSQL daemon process, running as the Linux user postgres. 

That means: 
- It only has access to paths that the postgres user can write to (like /tmp, /var/lib/postgresql, etc.) 
- It cannot write to your home directory (/home/santiago/...) unless permissions are explicitly given
- It's like calling `fopen()` inside a C program that runs as a different user: it can't touch things you own unless you open access.

