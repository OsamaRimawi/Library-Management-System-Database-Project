WITH BorrowedBooks AS (SELECT borrowerID,
                              COUNT(*) AS borrowedCount
                       FROM Loans
                       GROUP BY borrowerID)
SELECT b.borrowerID,
       CONCAT(r.FirstName, ' ', r.LastName)        AS FullName,
       b.borrowedCount,
       RANK() OVER (ORDER BY b.borrowedCount DESC) As ranking
FROM BorrowedBooks b,
     borrowers r
WHERE r.borrowerID = b.borrowerID
