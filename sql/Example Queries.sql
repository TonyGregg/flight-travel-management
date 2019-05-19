WITH Flights AS (
    SELECT SegmentID, FlightNo, Origin, Destination
        ,DepartureTime
        ,ArrivalTime
        ,[Day]
        -- Decode the [DayOfWeek] saved in the table
        ,[DaysOfWeek]=CASE [DayOfWeek] % 2 WHEN 1 THEN 'SU' ELSE '^^' END +
            CASE ([DayOfWeek]/2) % 2 WHEN 1 THEN 'MO' ELSE '^^' END +
            CASE ([DayOfWeek]/4) % 2 WHEN 1 THEN 'TU' ELSE '^^' END +
            CASE ([DayOfWeek]/8) % 2 WHEN 1 THEN 'WE' ELSE '^^' END +
            CASE ([DayOfWeek]/16) % 2 WHEN 1 THEN 'TH' ELSE '^^' END +
            CASE ([DayOfWeek]/32) % 2 WHEN 1 THEN 'FR' ELSE '^^' END +
            CASE ([DayOfWeek]/64) % 2 WHEN 1 THEN 'SA' ELSE '^^' END
        ,DepartureDay, ArrivalDay
        -- The PARTITION below identifies cases where the same flight number
        -- operates on a different schedule on different days of the week
        ,SegmentNo=ROW_NUMBER() OVER (
            PARTITION BY FlightNo, [DayOfWeek] ORDER BY SegmentID)
    FROM DailyFlightSchedules)
SELECT FlightNo, SegmentNo
    ,Origin, Destination
    ,DepartureTime=CAST(DepartureTime AS VARCHAR(5))
    ,ArrivalTime=CAST(ArrivalTime AS VARCHAR(5))
    ,ArrivalDay
    ,[DaysOfWeek]
FROM Flights
WHERE FlightNo IN ('PX009','PX011','PX054','PX055','CG100', 'CG1403', 'CG4352')

DECLARE @DepartureDate DATETIME = NULL -- '2013-01-06'

;WITH Flights AS (
    SELECT SegmentID, FlightNo, Origin, Destination
        ,DepartureTime
        ,ArrivalTime
        ,[Day]
        ,[DaysOfWeek]=CASE [DayOfWeek] % 2 WHEN 1 THEN 'SU' ELSE '^^' END +
            CASE ([DayOfWeek]/2) % 2 WHEN 1 THEN 'MO' ELSE '^^' END +
            CASE ([DayOfWeek]/4) % 2 WHEN 1 THEN 'TU' ELSE '^^' END +
            CASE ([DayOfWeek]/8) % 2 WHEN 1 THEN 'WE' ELSE '^^' END +
            CASE ([DayOfWeek]/16) % 2 WHEN 1 THEN 'TH' ELSE '^^' END +
            CASE ([DayOfWeek]/32) % 2 WHEN 1 THEN 'FR' ELSE '^^' END +
            CASE ([DayOfWeek]/64) % 2 WHEN 1 THEN 'SA' ELSE '^^' END
        ,DepartureDay, ArrivalDay
        -- The PARTITION below identifies cases where the same flight number
        -- operates on a different schedule on different days of the week
        ,SegmentNo=ROW_NUMBER() OVER (
            PARTITION BY FlightNo, [DayOfWeek] ORDER BY SegmentID)
    FROM DailyFlightSchedules
    OUTER APPLY (SELECT @DepartureDate) b(OperatingDate)
    WHERE (OperatingDate IS NULL OR EffectiveStart IS NULL OR 
        OperatingDate >= EffectiveStart) AND 
        (OperatingDate IS NULL OR EffectiveEnd IS NULL OR 
        OperatingDate <= EffectiveEnd))
SELECT FlightNo, SegmentNo
    ,Origin, Destination
    ,DepartureTime=CAST(DepartureTime AS VARCHAR(5))
    ,ArrivalTime=CAST(ArrivalTime AS VARCHAR(5))
    ,ArrivalDay
FROM Flights
WHERE FlightNo IN ('XX001','XX002','XX003')


SELECT FlightNo, Origin, Destination
    ,DepartureTime, ArrivalTime, ArrivalDay, DaysOfWeek
FROM FlightSchedule(NULL, NULL, NULL, NULL)
WHERE FlightNo IN ('CG100', 'PX009', 'PX011', 'PX055')

SELECT FlightNo, Origin, Destination
    ,DepartureTime, ArrivalTime, ArrivalDay, DaysOfWeek
FROM FlightSchedule('CG', NULL, NULL, NULL)
WHERE FlightNo IN ('CG100', 'PX009', 'PX011', 'PX055')

SELECT FlightNo, Origin, Destination
    ,DepartureTime, ArrivalTime, DaysOfWeek
FROM FlightSchedule(NULL, NULL, NULL, '2012-11-14')
WHERE FlightNo IN ('CG100', 'PX009', 'PX011', 'PX055')

SELECT FlightNo, SegmentNo, Origin, Destination
    ,DepartureTime, ArrivalTime, DaysOfWeek
FROM FlightSchedule(NULL, NULL, NULL, NULL)
WHERE FlightNo IN ('CG1411', 'CG1616')

SELECT FlightNo, SegmentNo, Origin, Destination
    ,DepartureTime, ArrivalTime, DaysOfWeek
FROM FlightSchedule(NULL, 'GKA', NULL, NULL)

SELECT FlightNo, SegmentNo, Origin, Destination
    ,DepartureTime, ArrivalTime, DaysOfWeek
FROM FlightSchedule(NULL, NULL, 'GKA', NULL)

SELECT FlightNo, Origin, Destination
    ,DepartureTime, ArrivalTime, DaysOfWeek
    ,SegmentTime, Miles=SegmentDistanceMiles
FROM FlightSchedule(NULL, 'POM', 'BNE', NULL)

SELECT SegmentID, FlightNo, Origin, Destination
    ,DepartureTime=CAST(DepartureTime AS VARCHAR(5))
    ,ArrivalTime=CAST(ArrivalTime AS VARCHAR(5))
    ,[Day]
FROM DailyFlightSchedules
WHERE FlightNo IN ('XX004', 'XX005')

-- Raw data for flights XX004 and XX005
SELECT FlightNo, SegmentNo, Origin, Destination
    ,DepartureTime, DepartureDay
    ,ArrivalTime, ArrivalDay, SegmentTime
FROM FlightSchedule(NULL, NULL, NULL, NULL)
WHERE FlightNo IN ('XX004', 'XX005')

-- Show departures for both flights regardless of origin
-- for the departure date
SELECT FlightNo, SegmentNo, Origin, Destination
    ,DepartureTime, ArrivalTime, SegmentTime
FROM FlightSchedule(NULL, NULL, NULL, '2012-11-15')
WHERE FlightNo IN ('XX004', 'XX005')

-- Show departures from LAX as the origin for departure date
SELECT FlightNo, SegmentNo, Origin, Destination
    ,DepartureTime, ArrivalTime, SegmentTime
FROM FlightSchedule(NULL, 'LAX', NULL, '2012-11-15')

SELECT FlightNo, Itinerary, DepartureTime, ArrivalTime
    ,ArrivalDay, DaysOfWeek
FROM FlightItinerary(NULL, NULL, NULL, NULL)
WHERE FlightNo IN ('CG1411', 'CG1616')

SELECT FlightNo, SegmentNo, Origin, Destination
    ,DepartureTime, ArrivalTime, DaysOfWeek
FROM FlightSchedule(NULL, NULL, NULL, NULL)
WHERE FlightNo IN ('CG1411', 'CG1616')

SELECT FlightNo, Itinerary, DepartureTime, ArrivalTime
    ,ArrivalDay, DaysOfWeek
FROM FlightItinerary(NULL, NULL, NULL, NULL)
WHERE FlightNo IN ('CG1411', 'CG1616')

SELECT FlightNo, SegmentNo, Origin, Destination
    ,DepartureTime, ArrivalTime, DaysOfWeek
FROM FlightSchedule(NULL, NULL, NULL, NULL)
WHERE FlightNo IN ('CG1411', 'CG1616')

DECLARE @Days       INT = 7
    ,@StartingDay   DATETIME = GETDATE()  -- Today is: 2012-11-15 08:00
    ,@Origin        CHAR(3) = 'POM'
    ,@Destination   CHAR(3) = 'WTP'

;WITH Calendar (OperatingDate) AS (
    SELECT TOP (@Days) DATEADD(day
        ,ROW_NUMBER() OVER (ORDER BY (SELECT NULL))-1
        ,@StartingDay)
    FROM (VALUES ($),($),($),($),($),($),($),($),($),($)) a (n1)
    CROSS JOIN (VALUES ($),($),($),($),($),($),($),($),($),($)) b(n2))
SELECT FlightNo, Itinerary, DepartureTime, ArrivalTime
    ,WD=UPPER(LEFT(DATENAME(dw, OperatingDate), 2))
    ,DaysOfWeek
FROM Calendar
CROSS APPLY FlightItinerary(NULL, @Origin, @Destination, OperatingDate)


DECLARE @Airports VARCHAR(8000) = 'BKK;HKG;CNS;POM;LAX'

SELECT [Origin/Destination]=Origin
    ,BKK=MAX(CASE Destination WHEN 'BKK' THEN Miles END)
    ,CNS=MAX(CASE Destination WHEN 'CNS' THEN Miles END)
    ,HKG=MAX(CASE Destination WHEN 'HKG' THEN Miles END)
    ,LAX=MAX(CASE Destination WHEN 'LAX' THEN Miles END)
    ,POM=MAX(CASE Destination WHEN 'POM' THEN Miles END)
FROM (
    SELECT Origin=a.Item, Destination=b.Item, Miles=ROUND(Miles, 0)
    FROM DelimitedSplit8K(@Airports, ';') a
    CROSS JOIN DelimitedSplit8K(@Airports, ';') b
    CROSS APPLY (
        SELECT IATA_Code, LatDec, LongDec
        FROM Airports 
        WHERE IATA_Code = a.Item) c
    CROSS APPLY (
        SELECT IATA_Code, LatDec, LongDec
        FROM Airports 
        WHERE IATA_Code = b.Item) d
    OUTER APPLY HaversineDistance(c.LatDec, c.LongDec, d.LatDec, d.LongDec) f) a
GROUP BY Origin
ORDER BY Origin


--DECLARE @Airports VARCHAR(8000) = STUFF((
SET @Airports = STUFF((
    SELECT ';' + IATA_Code
    FROM Airports
    WHERE Country = 'PAPUA NEW GUINEA'
    ORDER BY IATA_Code
    FOR XML PATH('')), 1, 1, '')

EXEC DisplayMileageChart @Airports

--DECLARE @Airports VARCHAR(8000) = 'BKK;HKG;CNS;POM;LAX'

SELECT [Origin/Destination]=Origin
    ,BKK=MAX(CASE Destination WHEN 'BKK' THEN SegmentTime END)
    ,CNS=MAX(CASE Destination WHEN 'CNS' THEN SegmentTime END)
    ,HKG=MAX(CASE Destination WHEN 'HKG' THEN SegmentTime END)
    ,LAX=MAX(CASE Destination WHEN 'LAX' THEN SegmentTime END)
    ,POM=MAX(CASE Destination WHEN 'POM' THEN SegmentTime END)
FROM (
    SELECT Origin=a.Item, Destination=b.Item, SegmentTime
    FROM DelimitedSplit8K(@Airports, ';') a
    CROSS JOIN DelimitedSplit8K(@Airports, ';') b
    OUTER APPLY (
        SELECT SegmentTime
        FROM DailyFlightSchedules
        WHERE Origin = a.Item and Destination = b.Item) c) a
GROUP BY Origin
ORDER BY Origin


--DECLARE @Airports VARCHAR(8000) = STUFF((
SET @Airports = STUFF((
    SELECT ';' + IATA_Code
    FROM Airports
    WHERE Country = 'PAPUA NEW GUINEA'
    ORDER BY IATA_Code
    FOR XML PATH('')), 1, 1, '')

EXEC DisplaySegmentTimes @Airports
