WITH BorrowedBooks AS (SELECT borrowerID,
                              COUNT(*) AS borrowedCount
                       FROM Loans
                       WHERE dateReturned IS NULL
                       GROUP BY borrowerID),
     ActiveBorrowers AS (SELECT borrowerID
                         FROM BorrowedBooks
                         WHERE borrowedCount >= 2)
SELECT CONCAT(b.FirstName, ' ', b.LastName) AS FullName
FROM Borrowers b
         JOIN
     ActiveBorrowers ab ON b.borrowerID = ab.borrowerID;
