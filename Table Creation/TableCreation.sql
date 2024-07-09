CREATE DATABASE library;

USE library;

CREATE TABLE Books (
    bookId INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    publishedDate DATE,
    genre VARCHAR(100),
    shelfLocation VARCHAR(100),
    currentStatus VARCHAR(10) CHECK (currentStatus IN ('Available', 'Borrowed')) NOT NULL
);

CREATE TABLE Borrowers (
    borrowerID INT PRIMARY KEY,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    dateOfBirth DATE,
    membershipDate DATE NOT NULL
);

CREATE TABLE Loans (
    loanID INT PRIMARY KEY,
    bookID INT ,
    borrowerID INT,
    dateBorrowed DATE NOT NULL,
    dueDate DATE NOT NULL,
    dateReturned DATE NULL,
    FOREIGN KEY (bookID) REFERENCES Books(bookID),
    FOREIGN KEY (borrowerID) REFERENCES Borrowers(borrowerID)
);

-- Insert 1000 dummy books
INSERT INTO Books (bookId, title, author, isbn, publishedDate, genre, shelfLocation, currentStatus)
SELECT
    seq AS bookId,
    CONCAT('Title ', seq) AS title,
    CONCAT('Author ', seq) AS author,
    LPAD(seq, 13, '0') AS isbn,
    DATE_SUB(CURDATE(), INTERVAL seq DAY) AS publishedDate,
    CONCAT('Genre ', FLOOR(seq/100)) AS genre,
    CONCAT('Shelf ', FLOOR(seq/10)) AS shelfLocation,
    CASE WHEN seq % 2 = 0 THEN 'Available' ELSE 'Borrowed' END AS currentStatus
FROM
    (SELECT @seq := @seq + 1 AS seq FROM
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t3,
        (SELECT @seq := 0) vars) seqs;

-- Insert 1000 dummy borrowers
INSERT INTO Borrowers (borrowerID, firstName, lastName, email, dateOfBirth, membershipDate)
SELECT
    seq AS borrowerID,
    CONCAT('FirstName', seq) AS firstName,
    CONCAT('LastName', seq) AS lastName,
    CONCAT('user', seq, '@example.com') AS email,
    DATE_SUB(CURDATE(), INTERVAL seq YEAR) AS dateOfBirth,
    DATE_SUB(CURDATE(), INTERVAL FLOOR(seq/10) DAY) AS membershipDate
FROM
    (SELECT @seq := @seq + 1 AS seq FROM
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t3,
        (SELECT @seq := 0) vars) seqs;

-- Insert 1000 dummy loans
INSERT INTO Loans (loanID, bookID, borrowerID, dateBorrowed, dueDate, dateReturned)
SELECT
    seq AS loanID,
    seq AS bookID,
    seq AS borrowerID,
    DATE_SUB(CURDATE(), INTERVAL seq DAY) AS dateBorrowed,
    DATE_ADD(DATE_SUB(CURDATE(), INTERVAL seq DAY), INTERVAL 14 DAY) AS dueDate,
    CASE WHEN seq % 2 = 0 THEN DATE_ADD(DATE_SUB(CURDATE(), INTERVAL seq DAY), INTERVAL 14 DAY) ELSE NULL END AS dateReturned
FROM
    (SELECT @seq := @seq + 1 AS seq FROM
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t3,
        (SELECT @seq := 0) vars) seqs;