DROP DATABASE IF EXISTS lms;
CREATE DATABASE lms;
USE lms;

CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    isActive BOOL DEFAULT TRUE
);

CREATE TABLE Grades (
    GradeID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    AssignmentName VARCHAR(100) NOT NULL,
    Grade DECIMAL(5, 2) NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE SET NULL
);

CREATE TABLE Notifications (
    NotificationID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    Message TEXT NOT NULL,
    SentAt TIMESTAMP DEFAULT NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE SET NULL
);

INSERT INTO Students (Name, Email)
VALUES 
    ('Alice Johnson', 'alice@example.com'),
    ('Bob Smith', 'bob@example.com');
    
INSERT INTO Grades (StudentID, AssignmentName, Grade)
VALUES 
    (1, 'Math Assignment 1', 85.00),
    (2, 'Science Assignment 1', 90.00);
