/*
Find out about the tags, how many different are there, how many of each
is repeated, and so on
*/

-- Getting the number of each tag1
SELECT tag, COUNT(*) AS tag_num
FROM tags
GROUP BY tag
ORDER BY tag_num DESC
LIMIT 10;

-- Getting how many uinque tag are there and also how many tims all of them are mentioned
-- Finding the sum of the col first and second of the previous query
with all_tags AS (
    SELECT tag, COUNT(*) AS tag_num
    FROM tags
    GROUP BY tag
)
SELECT
    COUNT(*) AS num_of_tags,
    SUM(tag_num) AS total_usage
FROM all_tags;
