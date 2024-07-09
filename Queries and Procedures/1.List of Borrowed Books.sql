SELECT b.title
FROM books b
         JOIN loans l ON b.bookId = l.bookID
         JOIN borrowers o ON o.borrowerID = l.borrowerID
WHERE o.firstName = 'FirstName3'