WITH BorrowedBooks AS (SELECT b.genre,
                              COUNT(*) AS borrowedCount
                       FROM Loans l
                                JOIN books b on b.bookId = l.bookID
                       WHERE l.dateBorrowed >= '2024-02-01'
                         AND l.dateBorrowed < '2024-03-01'
                       GROUP BY b.genre)
SELECT bb.genre,
       bb.borrowedCount,
       DENSE_RANK() OVER (ORDER BY bb.borrowedCount DESC) As ranking
FROM BorrowedBooks bb