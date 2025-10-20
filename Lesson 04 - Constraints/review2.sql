CREATE DATABASE inventory;
USE inventory;

CREATE TABLE Item (
    itemId CHAR(50) PRIMARY KEY,
    commonName TEXT NOT NULL,
    vendorId INT UNSIGNED
);

CREATE TABLE "Stock Location" (
    stockId INT UNSIGNED PRIMARY KEY,
    itemId INT UNSIGNED,
    quantity INT UNSIGNED,
    lastUpdated DATETIME,
    FOREIGN KEY itemId REFERENCES Item(itemId)
);
