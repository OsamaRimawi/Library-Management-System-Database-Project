WITH BorrowedBooks AS (SELECT b.author,
                              COUNT(*) AS borrowedCount
                       FROM Loans l
                                JOIN books b on b.bookId = l.bookID
                       GROUP BY b.author)
SELECT bb.author,
       bb.borrowedCount,
       DENSE_RANK() OVER (ORDER BY bb.borrowedCount DESC) As ranking
FROM BorrowedBooks bb