SELECT b.bookId,
       b.title,
       l.dateBorrowed,
       br.borrowerID,
       br.firstName
FROM Books b
         JOIN Loans l ON b.bookId = l.bookId
         JOIN Borrowers br ON l.borrowerID = br.borrowerID
WHERE l.dateReturned IS NULL
  AND DATEDIFF(NOW(), l.dueDate) > 30;
