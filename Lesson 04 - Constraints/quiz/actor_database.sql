CREATE TABLE Film (
  filmId SMALLINT UNSIGNED AUTO_INCREMENT,
  title VARCHAR(128) NOT NULL,
  releaseYear YEAR NOT NULL,
  rentalDuration TINYINT UNSIGNED NOT NULL DEFAULT 3,
  rentalRate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
  replacementCost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
  categoryId SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (filmId),
  FOREIGN KEY (categoryId) REFERENCES Category(categoryId),
  CHECK (replacement_cost >= rental_duration * rental_rate)
);

CREATE TABLE Category (
  categoryId TINYINT UNSIGNED AUTO_INCREMENT,
  categoryName VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (categoryId)
);
