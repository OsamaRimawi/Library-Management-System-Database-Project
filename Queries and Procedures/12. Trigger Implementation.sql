USE library;
CREATE TABLE AuditLog (
    logID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    StatusChange VARCHAR(200),
    ChangeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
#DROP TABLE AuditLog;
#DROP TRIGGER trg_StatusChangeAudit;

CREATE TRIGGER trg_StatusChangeAudit
AFTER UPDATE ON Books
FOR EACH ROW
BEGIN
    DECLARE previous_status VARCHAR(200);

    IF OLD.currentStatus != NEW.currentStatus THEN
        INSERT INTO AuditLog (BookID, StatusChange)
        VALUES (NEW.bookId, CONCAT('Status changed from ', OLD.currentStatus, ' to ', NEW.currentStatus));
    END IF;
END;

UPDATE Books t SET t.currentStatus = 'Available' WHERE t.bookId = 4;
