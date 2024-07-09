USE library;

CREATE PROCEDURE sp_BorrowedBooksReport(
    IN StartDate DATE,
    IN EndDate DATE
)
BEGIN
    SELECT
        L.loanID,
        B.title AS BookTitle,
        CONCAT(BR.firstName, ' ', BR.lastName) AS BorrowerName,
        L.dateBorrowed AS BorrowedDate
    FROM Loans L
    JOIN Books B ON L.bookID = B.bookID
    JOIN Borrowers BR ON L.borrowerID = BR.borrowerID
    WHERE L.dateBorrowed BETWEEN StartDate AND EndDate
    ORDER BY L.dateBorrowed;
END;

CALL sp_BorrowedBooksReport('2024-01-01', '2024-06-30');