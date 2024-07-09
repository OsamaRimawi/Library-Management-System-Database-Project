SELECT
    DAYNAME(dateBorrowed) AS DayOfWeek,
    COUNT(*) AS NumberOfLoans,
    CONCAT(FORMAT(COUNT(*) * 100 / (SELECT COUNT(*) FROM Loans), 2), '%') AS PercentageOfTotalLoans
FROM Loans
GROUP BY DayOfWeek
ORDER BY NumberOfLoans DESC
LIMIT 3;
