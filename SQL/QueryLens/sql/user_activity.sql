/*
Checking the activity of the users
*/

SELECT userId, COUNT(*) AS rated_count
FROM ratings r
GROUP BY userId
ORDER BY rated_count DESC
LIMIT 10;

/*
Finding the favorite movie of the person who rated the most number of movies
*/

WITH movie_worm_list AS (
    SELECT
        userId,
        COUNT(*) AS rated_count
    FROM ratings
    GROUP BY userId
),
worm AS (
    SELECT userId
    FROM movie_worm_list
    ORDER BY rated_count DESC
    LIMIT 1
),
ranked_rating AS (
    SELECT
        r.userId,
        r.movieId,
        r.rating,
        ROW_NUMBER() OVER (PARTITION BY r.userId ORDER BY r.rating DESC) AS rank
    FROM ratings r
    WHERE r.userId = (SELECT userId FROM worm)
    ORDER BY rank
),
worm_tree AS (
    SELECT *
    FROM ranked_rating
    WHERE rank = 5
    LIMIT 5
)
SELECT
    m.movieId,
    m.title,
    wt.rating,
    wt.userId
FROM
    movies m
JOIN worm_tree wt ON m.movieId = wt.movieId
ORDER BY wt.rating
;

