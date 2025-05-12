/*
Find the users who has rated the most movies in that genre
*/

WITH genre_rating AS (
    SELECT
        r.userId,
        r.movieId,
        UNNEST(STRING_TO_ARRAY(m.genres, '|')) AS genre
    FROM ratings r
    JOIN movies m ON r.movieId = m.movieId

),
user_genre_counts AS (
    SELECT
        userId,
        genre,
        COUNT(*) AS rating_count
    FROM genre_rating
    GROUP BY userId, genre
),
ranked_users AS (
    SELECT *,
        ROW_NUMBER() OVER(
            PARTITION BY genre
            ORDER BY rating_count DESC
        ) AS rank
    FROM user_genre_counts
)
SELECT genre, userId, rating_count
FROM ranked_users
WHERE rank = 1
ORDER BY genre;