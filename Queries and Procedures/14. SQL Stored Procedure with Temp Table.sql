USE library;
CREATE PROCEDURE sp_OverdueBooksReport()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS TempOverdueBorrowers
    (
        borrowerID INT,
        firstName  VARCHAR(100),
        lastName   VARCHAR(100),
        email      VARCHAR(255),
        PRIMARY KEY (borrowerID)
    );

    INSERT INTO TempOverdueBorrowers (borrowerID, firstName, lastName, email)
    SELECT DISTINCT BR.borrowerID,
                    BR.firstName,
                    BR.lastName,
                    BR.email
    FROM Loans L
             JOIN Borrowers BR ON L.borrowerID = BR.borrowerID
    WHERE L.dateReturned IS NULL
      AND L.dueDate < CURDATE();

    SELECT TOB.borrowerID,
           TOB.firstName,
           TOB.lastName,
           TOB.email,
           L.bookID,
           L.loanID,
           L.dateBorrowed AS BorrowedDate,
           L.dueDate      AS DueDate
    FROM TempOverdueBorrowers TOB
             JOIN Loans L ON TOB.borrowerID = L.borrowerID
             JOIN Books B ON L.bookID = B.bookID
    WHERE L.dateReturned IS NULL
      AND L.dueDate < CURDATE();

    DROP TEMPORARY TABLE IF EXISTS TempOverdueBorrowers;
END;

CALL sp_OverdueBooksReport();