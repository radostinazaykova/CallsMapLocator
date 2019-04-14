
--DROP TABLE dbo.Customer
CREATE TABLE [dbo].[Customer](
    [number] [varchar](20) NULL,
    [gender] [varchar](1) NULL,
    [age] [int] NULL
)
--Sample data:
--number               gender age
---------------------- ------ -----------
--+421910000115        M      49
--+421910000124        M      51
--+421910000190        M      53
--+421910000469        ?      15
--+421910000664        F      58
--+421910000834        M      49
--+421910000885        F      64
--+421910000931        M      15
--+421910000984        F      56
--+421910001031        F      72

--DROP TABLE dbo.Traffic
CREATE TABLE dbo.[Traffic](
    [aNumber] [varchar](20) NULL,
    [direction] [varchar](3) NULL,
    [bNumber] [varchar](20) NULL,
    [startDateTime] [datetime] NULL,
    [cellLong] [numeric](19, 16) NULL,
    [cellLat] [numeric](19, 16) NULL
)
--aNumber              direction bNumber              startDateTime           cellLong                                cellLat
---------------------- --------- -------------------- ----------------------- --------------------------------------- ---------------------------------------
--+421955719040        ->        tbaslacte            2016-04-18 04:11:26.000 17.1793888889000000                     48.1861111111000000
--+421913328590        ->        tbaslacte            2016-04-18 04:12:01.000 17.4081944444000000                     48.2247222222000000
--+421975257528        ->        tbaslacte            2016-04-18 04:24:43.000 17.2890555556000000                     48.2008333333000000
--+421975896322        ->        ebanab               2016-04-18 04:04:03.000 17.1236666667000000                     48.1613888889000000
--+421994190657        ->        ebanab               2016-04-18

--Randomly generate 2000000 cуstomers into Customer table having age between 1 and 100 and gender having value one of the 'M','F','?'
--Randomly generate 10000000 traffic rows into Traffic table with realtion to Customer (aNumber) generated in 2. step using cell generated in 1. step.

DECLARE @CustomerCounter INT = 2000000

WHILE @CustomerCounter > 0
BEGIN

	INSERT INTO [dbo].[Customer]
		(number, gender, age)
	VALUES
		('+' + CAST(@CustomerCounter AS VARCHAR(50)), IIF(RAND() > 0.5, 'M', 'F'), CAST(RAND() * 100 AS INT) + 1)

	SET @CustomerCounter = @CustomerCounter - 1
END

DECLARE @TrafficCounter INT = 10000000

WHILE @TrafficCounter > 0
BEGIN

	INSERT INTO [dbo].[Traffic]
		(aNumber
		,direction
		,bNumber
		,startDateTime
		,cellLong
		,cellLat)
	SELECT TOP (4000)
			number,
			'->',
			IIF(RAND() > 0.5, 'tbaslacte', 'ebanab'),
			'2016-04-18 04:11:26.000',
			17 + RAND(),
			48 + RAND()
	FROM 
		dbo.Customer c WITH(NOLOCK)
	WHERE 
		NOT EXISTS
		(
			SELECT TOP 1 1 
			FROM dbo.Traffic t WITH(NOLOCK)
			WHERE t.aNumber = c.number
		)

	IF @@ROWCOUNT = 0
	BEGIN

		INSERT INTO [dbo].[Traffic]
			(aNumber
			,direction
			,bNumber
			,startDateTime
			,cellLong
			,cellLat)
		SELECT TOP (4000)
			number,
			'->',
			IIF(RAND() > 0.5, 'tbaslacte', 'ebanab'),
			'2016-04-18 04:11:26.000',
			17 + RAND(),
			48 + RAND()
		FROM 
			dbo.Customer c WITH(NOLOCK)

	END

	SET @TrafficCounter = @TrafficCounter - 4000

END


SELECT *
FROM dbo.Customer

SELECT *
FROM dbo.Traffic

DROP TABLE dbo.Customer
DROP TABLE dbo.Traffic
