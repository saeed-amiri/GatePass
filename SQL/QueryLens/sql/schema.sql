DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS links;

CREATE TABLE movies (
    movieId INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    genres TEXT
);

CREATE TABLE ratings (
    userId INTEGER,
    movieId INTEGER,
    rating NUMERIC,
    timestamp BIGINT
);

CREATE TABLE tags (
    userId INTEGER,
    movieId INTEGER,
    tag TEXT,
    timestamp BIGINT
);

CREATE TABLE links (
    movieId INTEGER,
    imdbId INTEGER,
    tmdbId INTEGER
);