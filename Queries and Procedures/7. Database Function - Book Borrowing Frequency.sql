#DROP FUNCTION fn_BookBorrowingFrequency;

CREATE FUNCTION fn_BookBorrowingFrequency(
    book_id INT
)
    RETURNS INT
    READS SQL DATA
BEGIN
    DECLARE borrowCount INT;

    SELECT COUNT(*)
    INTO borrowCount
    FROM Loans
    WHERE bookID = book_id;

    RETURN borrowCount;
END;

SELECT fn_BookBorrowingFrequency(2) AS BorrowCount;
