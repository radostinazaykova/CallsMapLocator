CREATE PROCEDURE proced
(
	@range VARCHAR(500) ='12-50' 
)
AS
BEGIN

	DECLARE @FromAge INT
	DECLARE @ToAge INT


	SELECT @FromAge = CAST(SUBSTRING(@range, 0, CHARINDEX('-',@range)) AS INT)

	SELECT @ToAge = CAST(SUBSTRING(@range, CHARINDEX('-',@range) + 1, 500) AS INT)


	SELECT *
	FROM dbo.Customer
	WHERE Age BETWEEN @FromAge AND @ToAge

END