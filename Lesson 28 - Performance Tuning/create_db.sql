DROP DATABASE IF EXISTS imdb;
CREATE DATABASE imdb;
USE imdb;

-- place the input files into C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\
-- SHOW VARIABLES LIKE "secure_file_priv";
-- you need to configure mysqld to not timeout and mysql workbench to also not timeout

CREATE TABLE title_basics (
    tconst VARCHAR(10) PRIMARY KEY,
    titleType VARCHAR(20),
    primaryTitle VARCHAR(511),
    originalTitle VARCHAR(511),
    isAdult BOOLEAN,
    startYear SMALLINT,
    endYear SMALLINT,
    runtimeMinutes INT,
    genres VARCHAR(255)
);

CREATE TABLE title_ratings (
    tconst VARCHAR(10) PRIMARY KEY,
    averageRating DECIMAL(3, 1),
    numVotes INT
);

CREATE TABLE name_basics (
    nconst VARCHAR(10) PRIMARY KEY,
    primaryName VARCHAR(255),
    birthYear SMALLINT,
    deathYear SMALLINT,
    primaryProfession VARCHAR(255),
    knownForTitles VARCHAR(255)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.basics.tsv'
INTO TABLE title_basics
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes, genres);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.ratings.tsv'
INTO TABLE title_ratings
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(tconst, averageRating, numVotes);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/name.basics.tsv'
INTO TABLE name_basics
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(nconst, primaryName, birthYear, deathYear, primaryProfession, knownForTitles);

SET @old_innodb_stats_on_metadata = @@global.innodb_stats_on_metadata;
SET GLOBAL innodb_stats_on_metadata='ON';

SELECT * FROM title_basics LIMIT 10;
SELECT COUNT(*) FROM title_basics;
SELECT COUNT(tconst) FROM title_basics;
SELECT COUNT(*) FROM name_basics;
SELECT COUNT(*) FROM title_ratings;

DROP INDEX idx_startYear ON title_basics;

SELECT primaryTitle, startYear, genres
FROM title_basics
WHERE startYear = 2020 AND titleType = 'movie'
LIMIT 10;

SELECT primaryTitle, startYear, genres
FROM title_basics
WHERE startYear = 2020 AND titleType = 'movie';

CREATE INDEX idx_startYear ON title_basics(startYear);

SELECT primaryTitle, startYear, genres
FROM title_basics
WHERE startYear = 2020 AND titleType = 'movie'
LIMIT 10;

SHOW INDEXES FROM title_basics;
SHOW TABLE STATUS FROM imdb;
SELECT 
    table_name AS `Table`, 
    round(((data_length) / 1024 / 1024), 2) `Table Size in MB` ,
    round(((index_length) / 1024 / 1024), 2) `Index Size in MB`
FROM information_schema.TABLES 
WHERE table_schema = "imdb"
    AND table_name = "title_basics";

DROP INDEX idx_best ON title_ratings;

SELECT tb.primaryTitle, tr.averageRating, tr.numVotes
FROM title_basics tb
JOIN title_ratings tr ON tb.tconst = tr.tconst
WHERE tb.titleType = 'movie'
ORDER BY tr.averageRating DESC, tr.numVotes DESC
LIMIT 10;

EXPLAIN SELECT tb.primaryTitle, tr.averageRating, tr.numVotes
FROM title_basics tb
JOIN title_ratings tr ON tb.tconst = tr.tconst
WHERE tb.titleType = 'movie'
ORDER BY tr.averageRating DESC, tr.numVotes DESC
LIMIT 10;

SELECT tb.primaryTitle, tr.averageRating, tr.numVotes
FROM title_basics tb
JOIN title_ratings tr ON tb.tconst = tr.tconst
WHERE tb.titleType = 'movie'
ORDER BY tr.averageRating DESC, tr.numVotes DESC
LIMIT 10;

CREATE INDEX idx_best ON title_ratings(averageRating, numVotes);

EXPLAIN SELECT tb.primaryTitle, tr.averageRating, tr.numVotes
FROM title_basics tb
JOIN title_ratings tr ON tb.tconst = tr.tconst
WHERE tb.titleType = 'movie'
ORDER BY tr.averageRating DESC, tr.numVotes DESC
LIMIT 10;

SELECT startYear, COUNT(*) AS movie_count
FROM title_basics tb
WHERE tb.titleType = 'movie'
  AND tb.startYear BETWEEN 2000 AND 2020
GROUP BY startYear
ORDER BY startYear DESC
LIMIT 5;

SELECT startYear, COUNT(*) AS movie_count
FROM (
    SELECT startYear
    FROM title_basics
    WHERE titleType = 'movie' 
      AND startYear BETWEEN 2000 AND 2020
) filtered
GROUP BY startYear
ORDER BY movie_count DESC
LIMIT 5;

CREATE TABLE movies_per_year AS
SELECT startYear, COUNT(*) AS movie_count
FROM title_basics tb
WHERE tb.titleType = 'movie'
  AND tb.startYear IS NOT NULL
GROUP BY startYear;

SELECT * 
FROM movies_per_year
ORDER BY startYear DESC;

SELECT COUNT(*)
FROM title_basics
WHERE genres LIKE '%action%';

CREATE TABLE genres (
	genreName VARCHAR(50) PRIMARY KEY
);

CREATE TABLE movie_genres (
	tconst VARCHAR(10),
    genreName VARCHAR(50),
    PRIMARY KEY (tconst, genreName)
);

-- run python script normalize_genres.py

SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE movie_genres
ADD FOREIGN KEY (genreName) REFERENCES genres(genreName),
ADD FOREIGN KEY (tconst) REFERENCES title_basics(tconst);
SET FOREIGN_KEY_CHECKS=1;

SELECT *
FROM movie_genres
LIMIT 10;

SELECT *
FROM genres;

SELECT COUNT(*)
FROM title_basics tb
JOIN movie_genres mg ON tb.tconst = mg.tconst
WHERE tb.titleType = 'movie' AND mg.genreName = 'action';

SELECT * FROM genres LIMIT 10;

SET GLOBAL innodb_stats_on_metadata = @old_innodb_stats_on_metadata;
