#DROP PROCEDURE sp_AddNewBorrower;

CREATE PROCEDURE sp_AddNewBorrower(
    IN FirstName VARCHAR(100),
    IN LastName VARCHAR(100),
    IN Email VARCHAR(255),
    IN DateOfBirth DATE,
    IN MembershipDate DATE
)
BEGIN
    DECLARE email_count INT;
    DECLARE maxBorrowerID INT;

    SELECT COUNT(*)
    INTO email_count
    FROM Borrowers b
    WHERE b.email = Email;

    IF email_count > 0 THEN
        SELECT 'Error: Email already exists';

    ELSE
        SELECT COALESCE(MAX(borrowerID), 0) + 1
        INTO maxBorrowerID
        FROM Borrowers;
        INSERT INTO Borrowers (borrowerID, firstName, lastName, email, dateOfBirth, membershipDate)
        VALUES (maxBorrowerID, FirstName, LastName, Email, DateOfBirth, MembershipDate);
        SELECT maxBorrowerID;


    END IF;
END;

CALL sp_AddNewBorrower(
        'Osama',
        'Rimawi',
        'osama@gmail.com',
        '2020-05-09',
        '2021-02-09');
