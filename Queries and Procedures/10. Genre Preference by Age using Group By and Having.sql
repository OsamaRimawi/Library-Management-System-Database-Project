WITH AgeGroups AS (
    SELECT
        borrowerID,
        FLOOR(DATEDIFF(CURDATE(), dateOfBirth) / 365) AS age,
        CASE
            WHEN FLOOR(DATEDIFF(CURDATE(), dateOfBirth) / 365) BETWEEN 0 AND 10 THEN '0-10'
            WHEN FLOOR(DATEDIFF(CURDATE(), dateOfBirth) / 365) BETWEEN 11 AND 20 THEN '11-20'
            WHEN FLOOR(DATEDIFF(CURDATE(), dateOfBirth) / 365) BETWEEN 21 AND 30 THEN '21-30'
            WHEN FLOOR(DATEDIFF(CURDATE(), dateOfBirth) / 365) BETWEEN 31 AND 40 THEN '31-40'
            ELSE '40+'
        END AS ageGroup
    FROM Borrowers
),

LoansWithDetails AS (
    SELECT
        B.genre,
        AG.ageGroup
    FROM Loans L
    JOIN Books B ON L.bookID = B.bookID
    JOIN AgeGroups AG ON L.borrowerID = AG.borrowerID
),

GenrePreference AS (
    SELECT
        ageGroup,
        genre,
        COUNT(*) AS loanCount
    FROM LoansWithDetails
    GROUP BY ageGroup, genre
),

PreferredGenres AS (
    SELECT
        ageGroup,
        genre,
        loanCount,
        RANK() OVER (PARTITION BY ageGroup ORDER BY loanCount DESC) AS genreRank
    FROM GenrePreference
)

SELECT
    ageGroup,
    genre AS preferredGenre,
    loanCount AS numberOfLoans
FROM PreferredGenres
WHERE genreRank = 1
ORDER BY ageGroup;
