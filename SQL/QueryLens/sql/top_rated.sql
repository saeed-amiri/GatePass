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
