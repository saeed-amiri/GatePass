## Dataset

This project uses the [MovieLens 100K Dataset](https://grouplens.org/datasets/movielens/) from GroupLens Research at the University of Minnesota.

> **License:** Non-commercial use only. Redistribution allowed under the same license conditions.  
> **Citation:**  
> Harper, F. M., & Konstan, J. A. (2015). The MovieLens Datasets: History and Context. *ACM Transactions on Interactive Intelligent Systems (TiiS)*, 5(4), 1–19. [https://doi.org/10.1145/2827872](https://doi.org/10.1145/2827872)

## Project Goal:

> Use pure SQL (executed via terminal scripts) to explore, analyze, and manipulate MovieLens data stored in a PostgreSQL database.

### This is a learning-focused, engineering-style SQL lab, aimed at:

- Practicing schema design, loading, and querying  
- Performing joins, groupings, filters, and calculations  
- Producing clean outputs (eventually saved/exported) 
Understood. No fluff.

---

##  What we're going to take out of the data:

### 1. **Top Rated Movies**

* Show movies with the highest average rating (with minimum votes)
* Columns: `title`, `avg_rating`, `number_of_ratings`

### 2. **Most Rated Movies**

* Show which movies have been rated the most
* Columns: `title`, `number_of_ratings`

### 3. **User Activity**

* See how many ratings each user gave
* Columns: `userId`, `number_of_ratings`

### 4. **Tag Usage**

* Show the most frequently used tags
* Columns: `tag`, `count`

### 5. **Movie Genre Frequency**

* Count how often each genre appears (requires parsing `genres` text)
* Columns: `genre`, `count`

### 6. **Year-Based Trends**

* Extract year from movie titles (e.g., “(1995)”) and analyze average rating by year
* Columns: `year`, `avg_rating`

---


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
- To drop the database if it already exists
    ```bash
    sudo -u postgres dropdb movielens
    ```
- To get list of databases
    ```bash
    sudo -u postgres psql -l
    ```
    or inside psql
    ```sql
    \l
    ```
- Create a new table called `movies` in the `movielens` database
    ```bash
    sudo -u postgres psql -d movielens -f schema.sql
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

**loads.sql**: Load the CSV files into the database
```bash
COPY movies FROM "\copy movies FROM 'data/movies.csv' DELIMITER ',' CSV HEADER;"
COPY ratings FROM "data/ratings.csv" DELIMITER ',' CSV HEADER;
COPY movies FROM "data/tags.csv" DELIMITER ',' CSV HEADER;
COPY movies FROM "data/links.csv" DELIMITER ',' CSV HEADER;
```
> -c "\copy movies FROM 'data/movies.csv' DELIMITER ',' CSV HEADER;" → execute the command to copy the data from the movies.csv file into the movies table

- To check if the data was loaded correctly
```bash
sudo -u postgres psql -d movielens -c "SELECT * FROM movies LIMIT 5;"
```
> -c "SELECT * FROM movies LIMIT 5;" → execute the command to select the first 5 rows from the movies table
The output should look like this:
```bash
 movieid |               title                |                   genres                    
---------+------------------------------------+---------------------------------------------
       1 | Toy Story (1995)                   | Adventure|Animation|Children|Comedy|Fantasy
       2 | Jumanji (1995)                     | Adventure|Children|Fantasy
       3 | Grumpier Old Men (1995)            | Comedy|Romance
       4 | Waiting to Exhale (1995)           | Comedy|Drama|Romance
       5 | Father of the Bride Part II (1995) | Comedy
(5 rows)
```

## Correlated Subqueries
```sql
SELECT
    title,
    (
        SELECT
            AVG(rating)
            FROM ratings WHERE ratings.movieid = movies.movieid
    ) AS avg_rating
FROM movies
WHERE
    (
        SELECT
            COUNT(*)
            FROM ratings WHERE ratings.movieid = movies.movieid
    ) > 100
ORDER BY avg_rating DESC;
```
> - The subquery `(SELECT AVG(rating) FROM ratings WHERE ratings.movieid = movies.movieid)` calculates the average rating for each movie.
> - The subquery `(SELECT COUNT(*) FROM ratings WHERE ratings.movieid = movies.movieid) > 100` filters the movies to only include those with more than 100 ratings. 
> - The outer query selects the title and average rating of the movies that meet the criteria and orders them by average rating in descending order.

### What is it? (geeks4geeks)[https://www.geeksforgeeks.org/sql-correlated-subqueries/]
A correlated subquery is a subquery in SQL that refers to values from the outer query. The key difference between a correlated subquery and a regular subquery is that a correlated subquery is evaluated for each row processed by the outer query. This makes it dynamic, as it can return different results for each row depending on the values of the outer query.
Key characteristics

> - Row-by-Row Evaluation: The subquery is executed once for each row in the outer query.
> - Dynamic and Dependent: The inner query uses values from the outer query, making it dependent on the outer query.
> - Used for Complex Filtering: Correlated subqueries are commonly used for row-specific filtering, ranking, or calculations based on other related data.

The syntax of a correlated subquery allows you to reference columns from the outer query inside the subquery. Here’s the basic structure:
Syntax:
```sql
    SELECT column1, column2, ….
    FROM table1 outer
    WHERE column1 operator
                        (SELECT column1, column2
                         FROM table2
                         WHERE expr1 = outer.expr2);
```
