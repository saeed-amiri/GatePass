## Dataset

This project uses the [MovieLens 100K Dataset](https://grouplens.org/datasets/movielens/) from GroupLens Research at the University of Minnesota.

> **License:** Non-commercial use only. Redistribution allowed under the same license conditions.  
> **Citation:**  
> Harper, F. M., & Konstan, J. A. (2015). The MovieLens Datasets: History and Context. *ACM Transactions on Interactive Intelligent Systems (TiiS)*, 5(4), 1–19. [https://doi.org/10.1145/2827872](https://doi.org/10.1145/2827872)



## Directory Structure

```plaintext
QueryLens
│   ├── data
│   │   ├── links.csv
│   │   ├── movies.csv
│   │   ├── ratings.csv
│   │   ├── README.txt
│   │   └── tags.csv
│   ├── outputs
│   ├── README.md
│   ├── sql
│   │   └── schema.sql
│   └── src
└── README.md
```
---

**schema.sql**: Manually inspect the CSV headers  

- Create a new database called `movielens`
    ```bash
    sudo -u postgres createdb -O postgres movielens
    ```
    > -O postgres → make postgres the owner of the DB  
    > movielens → name of the new database  
- Create a new table called `movies` in the `movielens` database
    ```bash
    psql -U postgres -d movielens -f schema.sql
    ```
    > -U postgres → connect as the postgres user
    > -d movielens → connect to the movielens database
    > -f schema.sql → execute the SQL commands in the schema.sql file
- To see the tables in the database
    ```bash
    sudo -u postgres psql -d movielens -c "\dt"
    ```
    > -c "\dt" → execute the command to list the tables in the database
    The output should look like this:
    ```bash
             List of relations
     Schema |  Name  | Type  |  Owner   
    --------+--------+-------+----------
     public | movies | table | postgres
    (1 row)
    ```
- To see the columns in the 'movies' table
    ```bash
    sudo -u postgres psql -d movielens -c "\d movies"
    ```
    > -c "\d movies" → execute the command to describe the movies table
    The output should look like this:
    ```bash
               Table "public.movies"
     Column |  Type   | Collation | Nullable | Default 
    --------+---------+-----------+----------+---------
     movieid | integer |           | not null | 
     title  | text    |           | not null | 
     genres | text    |           |          | 
    Indexes:
        "movies_pkey" PRIMARY KEY, btree (movieid)
    ```
we did it for all the csv files:
```bash
          List of relations
 Schema |  Name   | Type  |  Owner   
--------+---------+-------+----------
 public | links   | table | postgres
 public | movies  | table | postgres
 public | ratings | table | postgres
 public | tags    | table | postgres
(4 rows)
```
