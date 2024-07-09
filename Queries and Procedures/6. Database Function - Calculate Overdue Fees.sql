#DROP FUNCTION fn_CalculateOverdueFees;

CREATE FUNCTION fn_CalculateOverdueFees(
    loan_id INT
)
    RETURNS DECIMAL(10, 2)
    READS SQL DATA

BEGIN
    DECLARE overdueDays INT;
    DECLARE overdueFee DECIMAL(10, 2);

    SELECT DATEDIFF(NOW(), dueDate)
    INTO overdueDays
    FROM Loans
    WHERE loanID = loan_id;
    SET overdueDays = overdueDays * -1;
    IF overdueDays > 0 THEN
        IF overdueDays <= 30 THEN
            SET overdueFee = overdueDays * 1.00;
        ELSE
            SET overdueFee = (30 * 1.00) + ((overdueDays - 30) * 2.00);
        END IF;
    ELSE
        SET overdueFee = 0.00;
    END IF;

    RETURN overdueFee;
END;

SELECT fn_CalculateOverdueFees(1) AS OverdueFee;
