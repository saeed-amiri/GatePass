/*
Get the list of the best movie of each genre
Steps:
    - Find the best movies:
        1. find best movies based on the rates with considering number of rating
        2. Find the list of the geners of movies (split)
        3. For each item in the step 2 find the best movie from list 1
*/

WITH movie_stats AS (
    SELECT
        movieId,
        AVG(rating) AS avg_rating,
        COUNT(*) AS num_ratings
    FROM ratings
    GROUP BY movieId
    HAVING COUNT(*) >= 50
    ORDER BY avg_rating DESC
),
movie_genres AS (
    SELECT
        m.movieId,
        m.title,
        UNNEST(STRING_TO_ARRAY(m.genres, '|')) AS genre
    FROM movies m
    WHERE m.genres IS NOT NULL AND m.genres != '(no genres listed)'
),
rated_movies_with_genres AS (
    SELECT
        mg.genre,
        mg.movieId,
        mg.title,
        ms.avg_rating,
        ms.num_ratings
    FROM movie_genres mg
    JOIN movie_stats ms ON mg.movieId = ms.movieId
),
ranked_by_genre AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY genre
            ORDER BY avg_rating DESC, num_ratings DESC
        ) AS rank
    FROM rated_movies_with_genres
)
SELECT genre, title, avg_rating, num_ratings
FROM ranked_by_genre
WHERE rank = 1
ORDER BY avg_rating DESC, genre;
