/*
Movie Genre Frequency
    - Count how often each genre appears (requires parsing `genres` text)
    - Columns: `genre`, `count`
*/

-- The number of the genres
SELECT genres, COUNT(*) AS num_genres
FROM movies
GROUP by genres
ORDER BY num_genres  DESC
LIMIT 10;

-- Total of the previous query
WITH genres_query AS (
    SELECT genres,
        COUNT(*) AS num_genres
    FROM movies
    GROUP BY genres
)
SELECT
    COUNT(*) AS n_genres,
    SUM(num_genres) AS suming
FROM genres_query;

/*Get the number of each unique genres
The previous queries gave these:
       genres        | num_genres 
----------------------+------------
 Drama                |       1053
 Comedy               |        946
 Comedy|Drama         |        435
 Comedy|Romance       |        363
 Drama|Romance        |        349
 Documentary          |        339
 Comedy|Drama|Romance |        276
 Drama|Thriller       |        168
 Horror               |        167
 Horror|Thriller      |        135
(10 rows)

 n_genres | suming 
----------+--------
      951 |   9742
(1 row)

here I want to find out how many times, for example "Drama" or "Comedy" are appeared.
*/
WITH genres_split AS (
    SELECT UNNEST(STRING_TO_ARRAY(genres, '|')) AS genre
    FROM movies
    WHERE genres IS NOT NULL AND genres != '(no genres listed)'
)
SELECT genre, COUNT(*) AS genre_count
FROM genres_split
GROUP BY genre
ORDER BY genre_count DESC
LIMIT 15;

-- Count them all
WITH genres_split AS (
    SELECT UNNEST(STRING_TO_ARRAY(genres, '|')) AS genre
    FROM movies
    WHERE genres is NOT NULL AND genres != '(no genres listed)'
),
split_table AS(
    SELECT genre, COUNT(*) AS genre_count
    FROM genres_split
    GROUP BY genre
)
SELECT
    COUNT(*) AS unique_genres,
    SUM(genre_count) AS all_occurrence
FROM split_table;