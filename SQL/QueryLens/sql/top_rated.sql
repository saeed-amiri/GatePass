-- Count how many rating each movies has
SELECT movieId, COUNT(*) AS rating_count
FROM ratings
GROUP BY movieId
ORDER BY rating_count DESC
LIMIT 10;

-- The same, but this time with getting the names of the movies from movies!
SELECT m.movieId, m.title, COUNT(*) AS rating_count
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY m.movieId, m.title
ORDER BY rating_count DESC
FETCH FIRST 10 ROWS ONLY;  -- Same as LIMIT 10;

/*
Getting the movies which has rating number bigger than the average rating
*/

WITH movie_ratings AS (
    SELECT movieId, COUNT(*) AS rating_count
    FROM ratings
    GROUP BY movieId
),
average_rating AS (
    SELECT AVG(rating_count) AS avg_rating
    FROM movie_ratings
)
SELECT m.movieId, m.title, mr.rating_count
FROM movie_ratings mr
JOIN movies m ON mr.movieId = m.movieId
JOIN average_rating ar ON mr.rating_count > ar.avg_rating
ORDER BY mr.rating_count DESC
LIMIT 10;


/*
 - The same, but this time add tags from tag to it
 - It gives a long rows, which forced into vim!
 - So we add a limitation to it
 - It is called "correlated subqueries" (see README)
 */
SELECT
    m.movieId,
    m.title,
    (
        SELECT string_agg(tag, ', ')
        FROM (
            SELECT DISTINCT tag
            FROM tags t2
            WHERE t2.movieId = m.movieId
            LIMIT 3
        ) AS limited_tags
    ) AS tags,
    COUNT(*) AS rating_count
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY m.movieId, m.title
ORDER BY rating_count DESC
FETCH FIRST 10 ROWS ONLY;
