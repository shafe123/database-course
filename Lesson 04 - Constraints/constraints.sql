CREATE DATABASE IF NOT EXISTS lesson04;
USE lesson04;

DROP IF EXISTS film;

CREATE TABLE language (
    language_id TINYINT UNSIGNED PRIMARY KEY
)

CREATE TABLE film (
  film_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(128) NOT NULL UNIQUE,
  description TEXT,
  release_year YEAR,
  language_id TINYINT UNSIGNED NOT NULL,
  original_language_id TINYINT UNSIGNED,
  rental_duration TINYINT UNSIGNED NOT NULL DEFAULT 3,
  rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
  length SMALLINT UNSIGNED,
  replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
  rating ENUM('G','PG','PG-13','R','NC-17') DEFAULT 'G',
  special_features SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes'),
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY  (film_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  FOREIGN KEY (original_language_id) REFERENCES language (language_id),
  CHECK (length > 0),
  CHECK (rental_rate > PI()),
  -- CHECK (release_year <= YEAR(CURRENT_TIMESTAMP)), -- cannot use non-deterministic functions in CHECK
  CHECK (replacement_cost > rental_rate * rental_duration)
);

DESCRIBE film;
SHOW TABLE CREATE film;