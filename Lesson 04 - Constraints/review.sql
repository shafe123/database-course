CREATE DATABASE inventory;
USE inventory;

CREATE TABLE Item (
    itemId CHAR(50) PRIMARY KEY,
    commonName TEXT NOT NULL,
    vendorId INT UNSIGNED
);

CREATE TABLE Stock (
    stockId INT UNSIGNED PRIMARY KEY,
    itemId CHAR(50),
    bayLocation CHAR(50),
    quantity INT UNSIGNED,
    lastUpdated DATETIME,
    FOREIGN KEY itemId REFERENCES Item(itemId),
    FOREIGN KEY bayLocation REFERENCES Bay(bayId)
);

CREATE TABLE Bay (
    bayId CHAR(50) UNSIGNED PRIMARY KEY,
    warehouseId INT UNSIGNED,
    location VARCHAR(255)
);

CREATE TABLE Warehouse (
    warehouseId INT UNSIGNED PRIMARY KEY,
    name VARCHAR(255),
    streetAddress VARCHAR(255),
    city VARCHAR(255),
    state CHAR(2),
    zip SMALLINT UNSIGNED
);