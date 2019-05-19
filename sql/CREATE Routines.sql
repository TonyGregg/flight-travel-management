IF OBJECT_ID('CalculateSegmentTime', 'IF') IS NOT NULL
    DROP FUNCTION CalculateSegmentTime;
GO

CREATE FUNCTION CalculateSegmentTime
    (@Origin            VARCHAR(3)
    ,@Destination       VARCHAR(3)
    ,@DepartureTime     TIME
    ,@ArrivalTime       TIME
    ,@Day               CHAR(2))
RETURNS TABLE
RETURN
SELECT SegmentTimeMinutes=DATEDIFF(minute, 
       CAST(CONVERT(VARCHAR(16), @DepartureTime + DepDate, 121) + c.UTC AS DATETIMEOFFSET), 
       CAST(CONVERT(VARCHAR(16), @ArrivalTime + ArrDate, 121) + d.UTC AS DATETIMEOFFSET))
FROM (
    SELECT CAST('1900-01-01' AS DATETIME) + CAST(LEFT(@Day, 1) AS INT)
        ,CAST('1900-01-01' AS DATETIME) + CAST(RIGHT(@Day, 1) AS INT)
    ) b (DepDate, ArrDate)
CROSS APPLY (
    SELECT IATA_Code, UTC
    FROM Airports 
    WHERE IATA_Code = @Origin) c
CROSS APPLY (
    SELECT IATA_Code, UTC
    FROM Airports 
    WHERE IATA_Code = @Destination) d
GO


IF OBJECT_ID('HaversineDistance', 'IF') IS NOT NULL
    DROP FUNCTION HaversineDistance;
GO

CREATE FUNCTION HaversineDistance
    (@OriginLat     FLOAT
    ,@OriginLong    FLOAT
    ,@DestLat       FLOAT
    ,@DestLong      FLOAT)
RETURNS TABLE WITH SCHEMABINDING
RETURN
SELECT Miles=CASE
    -- Fudge the case when Lat/Long for Origin/Destination is the same to avoid
    -- possibly getting a floating point error. 
    WHEN @OriginLat = @DestLat AND @OriginLong = @DestLong THEN CAST(0. AS FLOAT)
    ELSE -- Replace 3960 with 6371 for KM instead of miles (radius of the Earth)
        ( 3960. * ACOS( COS( RADIANS( @OriginLat ) ) *  COS( RADIANS( @DestLat ) ) * 
        COS( RADIANS(  @DestLong  ) - RADIANS( @OriginLong ) ) +  SIN( RADIANS( @OriginLat ) ) * 
        SIN( RADIANS(  @DestLat  ) ) ) ) END
GO

IF OBJECT_ID('FlightSchedule', 'IF') IS NOT NULL
    DROP FUNCTION FlightSchedule;
GO

CREATE FUNCTION FlightSchedule
    (@Airline           CHAR(2) = NULL
    ,@Origin            VARCHAR(3) = NULL
    ,@Destination       VARCHAR(3) = NULL
    ,@DepartureDate     DATETIME = NULL)
RETURNS TABLE 
RETURN
-- Select all flight segments with corresponding departure and arrival times
WITH Flights AS (
    SELECT SegmentID, FlightNo, Origin, Destination
        ,DepartureTime
        ,ArrivalTime
        ,[Day]
        -- Format for display
        ,[DaysOfWeek]=CASE [DayOfWeek] % 2 WHEN 1 THEN 'SU' ELSE '^^' END +
            CASE ([DayOfWeek]/2) % 2 WHEN 1 THEN 'MO' ELSE '^^' END +
            CASE ([DayOfWeek]/4) % 2 WHEN 1 THEN 'TU' ELSE '^^' END +
            CASE ([DayOfWeek]/8) % 2 WHEN 1 THEN 'WE' ELSE '^^' END +
            CASE ([DayOfWeek]/16) % 2 WHEN 1 THEN 'TH' ELSE '^^' END +
            CASE ([DayOfWeek]/32) % 2 WHEN 1 THEN 'FR' ELSE '^^' END +
            CASE ([DayOfWeek]/64) % 2 WHEN 1 THEN 'SA' ELSE '^^' END
        ,[DayOfWeek]
        ,DepartureDay, ArrivalDay
        -- The PARTITION below identifies cases where the same flight number
        -- operates on a different schedule on different days of the week
        ,SegmentNo=ROW_NUMBER() OVER (
            PARTITION BY FlightNo, [DayOfWeek] ORDER BY SegmentID)
        ,SegmentTime
        ,SegmentDistanceMiles
        ,SegmentDistanceKM
        ,OperatingDate
        ,Airline
    FROM DailyFlightSchedules
    -- Empty string as @DepartureDate is handled as a NULL (no) value
    -- Drop the time portion of any actual date supplied.
    OUTER APPLY (
        SELECT ISNULL(DATEADD(day, 0, DATEDIFF(day, 0, @DepartureDate)), '')
        ) b(OperatingDate)
    WHERE (OperatingDate = '' OR EffectiveStart IS NULL OR 
        OperatingDate >= EffectiveStart) AND 
        (OperatingDate = '' OR EffectiveEnd IS NULL OR 
        OperatingDate <= EffectiveEnd))
SELECT a.FlightNo, SegmentNo, a.Origin, a.Destination
    ,DepartureTime=CASE 
        WHEN OperatingDate = ''
            THEN CONVERT(VARCHAR(5), a.DepartureTime, 108)
        WHEN OperatingDate <> '' AND InitialDeparture > 1 AND
                a.SegmentNo > 1 AND [Day] = '11'
            THEN CONVERT(VARCHAR(10), OperatingDate, 121) + ' ' + 
                CAST(a.ArrivalTime AS VARCHAR(5))
        ELSE CONVERT(VARCHAR(16)
            ,DATEADD(day, CAST(LEFT([Day], 1) AS INT), OperatingDate) + ' ' + 
                CAST(a.DepartureTime AS VARCHAR(5)),121) END
    ,ArrivalTime=CASE 
        WHEN OperatingDate = ''
            THEN CONVERT(VARCHAR(5), a.ArrivalTime, 108)
        WHEN OperatingDate <> '' AND InitialDeparture > 1 AND
                a.SegmentNo > 1 AND [Day] = '11'
            THEN CONVERT(VARCHAR(10), OperatingDate, 121) + ' ' + 
                CAST(a.ArrivalTime AS VARCHAR(5))
        ELSE CONVERT(VARCHAR(16)
            ,DATEADD(day, CAST(RIGHT([Day], 1) AS INT), OperatingDate) + ' ' + 
                CAST(a.ArrivalTime AS VARCHAR(5)),121) END
    ,DepartureDay=CASE WHEN OperatingDate IS NULL THEN DepartureDay ELSE '  ' END
    ,ArrivalDay=CASE WHEN OperatingDate IS NULL THEN ArrivalDay ELSE '  ' END
    -- Decode the DayOfWeek INT to a string of operating days
    ,DaysOfWeek
    ,SegmentTime
    ,SegmentDistanceMiles
    ,SegmentDistanceKM
FROM Flights a
INNER JOIN (
    SELECT FlightNo, [DayOfWeek]
        ,InitialDeparture=CASE
            -- No (NULL) or empty string as origin supplied so include 
            -- the earliest segment 
            WHEN ISNULL(@Origin, '') = '' THEN MIN(SegmentNo)
            -- If % not in @Origin, we find the first segment that's an exact match
            -- to @Origin
            WHEN CHARINDEX('%', @Origin) = 0 
                THEN MIN(CASE WHEN Origin = @Origin THEN SegmentNo END)
            -- If % in @Origin, do a LIKE search to identify the first matching segment
            ELSE MIN(CASE WHEN Origin LIKE @Origin THEN SegmentNo END) END
        ,FinalArrival=CASE 
            -- No (NULL) or empty string as destination supplied so include 
            -- the earliest segment 
            WHEN ISNULL(@Destination, '') = '' THEN MAX(SegmentNo)
            -- If % not in @Destination, we find the last segment that's an exact match 
            -- to @Destination
            WHEN CHARINDEX('%', @Destination) = 0 
                THEN MAX(CASE WHEN Destination = @Destination THEN SegmentNo END)
            -- If % in @Destination, do a LIKE search to identify the last matching segment
            ELSE MAX(CASE WHEN Destination LIKE @Destination THEN SegmentNo END) END
    FROM Flights
    GROUP BY FlightNo, [DayOfWeek]) b
    ON a.FlightNo = b.FlightNo AND a.[DayOfWeek] = b.[DayOfWeek]
WHERE -- Select only segments between the search criteria 
    a.SegmentNo BETWEEN InitialDeparture AND FinalArrival AND
    -- Empty string as @Airline is handled as a NULL (no) value
    (ISNULL(@Airline, '') = '' OR Airline = @Airline) AND
    -- OperatingDate IS NULL if no @DepartureDate was supplied
    (OperatingDate = '' OR
    -- Decode the days of the week on which the flight operates
    -- Note: Sensitive to @@DATEFIRST 
    (b.[DayOfWeek]/POWER(2, DATEPART(dw, OperatingDate) -1)) % 2 = 1)
GO

IF OBJECT_ID('FlightItinerary', 'IF') IS NOT NULL
    DROP FUNCTION FlightItinerary;
GO

CREATE FUNCTION FlightItinerary
    (@Airline           CHAR(2) = NULL
    ,@Origin            VARCHAR(3) = NULL
    ,@Destination       VARCHAR(3) = NULL
    ,@DepartureDate     DATETIME = NULL)
RETURNS TABLE 
RETURN
-- Select all flights from the FlightSchedule TVF using the
-- same parameters passed to the FlightItinerary TVF
WITH FlightSched AS ( 
    SELECT FlightNo, SegmentNo
        ,Origin, Destination, DepartureTime, ArrivalTime, DepartureDay, ArrivalDay
        ,DaysOfWeek, SegmentTime, Miles=SegmentDistanceMiles, KM=SegmentDistanceKM
    FROM FlightSchedule(@Airline, @Origin, @Destination, @DepartureDate))
SELECT FlightNo
    ,Itinerary, DepartureTime, ArrivalTime, DepartureDay, ArrivalDay
    ,DaysOfWeek, TotalFlightTime, TotalMiles, TotalKM
    ,ElapsedTime=SegmentTimeMinutes
FROM (
    SELECT FlightNo
        -- Itinerary is the flattened list of 1st origin + all destinations
        ,Itinerary=(
            SELECT TOP 1 Origin + '-'
            FROM FlightSched b
            WHERE a.FlightNo = b.FlightNo AND a.DaysOfWeek = b.DaysOfWeek
            ORDER BY SegmentNo) + STUFF((
            SELECT '-' + Destination
            FROM FlightSched b
            WHERE a.FlightNo = b.FlightNo AND a.DaysOfWeek = b.DaysOfWeek
            ORDER BY SegmentNo
            FOR XML PATH('')), 1, 1, '')
        -- Initial departure time is departure time for the first segment 
        ,DepartureTime=(
            SELECT TOP 1 DepartureTime
            FROM FlightSched b
            WHERE a.FlightNo = b.FlightNo AND a.DaysOfWeek = b.DaysOfWeek
            ORDER BY SegmentNo)
        -- Final arrival time is arrival time for the last segment 
        ,ArrivalTime=(
            SELECT TOP 1 ArrivalTime
            FROM FlightSched b
            WHERE a.FlightNo = b.FlightNo AND a.DaysOfWeek = b.DaysOfWeek
            ORDER BY SegmentNo DESC)
        -- Initial departure's departure day is from the first segment
        ,DepartureDay=(
            SELECT TOP 1 DepartureDay
            FROM FlightSched b
            WHERE a.FlightNo = b.FlightNo AND a.DaysOfWeek = b.DaysOfWeek
            ORDER BY SegmentNo)
        -- Final arrival's arrival day is from the last segment
        ,ArrivalDay=(
            SELECT TOP 1 ArrivalDay
            FROM FlightSched b
            WHERE a.FlightNo = b.FlightNo AND a.DaysOfWeek = b.DaysOfWeek
            ORDER BY SegmentNo DESC)
        ,DaysOfWeek
        ,TotalFlightTime=SUM(SegmentTime)
        ,TotalMiles=SUM(Miles)
        ,TotalKM=SUM(KM)
    FROM FlightSched a
    GROUP BY FlightNo, DaysOfWeek) a
-- Create the encoded [Day] to pass to the next CROSS APPLY
CROSS APPLY (
    SELECT LEFT(Itinerary, 3), RIGHT(Itinerary, 3) 
        ,CASE RIGHT(DepartureDay, 1) WHEN '1' THEN '1' ELSE '0' END +
        CASE RIGHT(ArrivalDay, 1) WHEN '1' THEN '1' ELSE '0' END
    ) b(Origin, Destination, [Day])
-- This CROSS APPLY calculates the total "segment" time or really the total time from
-- the initial origin to the final destination
CROSS APPLY CalculateSegmentTime(Origin, Destination, DepartureTime, ArrivalTime, [Day]) c
GO

IF OBJECT_ID('DisplayMileageChart', 'P') IS NOT NULL
    DROP PROCEDURE DisplayMileageChart;
GO

CREATE PROCEDURE DisplayMileageChart
    (@Airports VARCHAR(8000)
    ,@MilesOrKM CHAR(1) = 'M') AS
BEGIN
DECLARE @SQL    NVARCHAR(MAX)

    SELECT @SQL = 'SELECT [Origin/Destination]=Origin ' + (
        SELECT ',[' + Item + ']=MAX(CASE Destination WHEN ''' + Item + 
            ''' THEN Miles END) ' 
        FROM DelimitedSplit8K(@Airports, ';')
        ORDER BY Item
        FOR XML PATH('')) +
            'FROM (
                SELECT Origin=a.Item, Destination=b.Item
                    ,Miles=ROUND(Miles*CASE @MilesOrKM WHEN ''K'' THEN 1.60934 ELSE 1. END, 0)
                FROM DelimitedSplit8K(@Airports, '';'') a
                CROSS JOIN DelimitedSplit8K(@Airports, '';'') b
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
            ORDER BY Origin'

    EXEC sp_executesql @SQL
        ,N'@Airports VARCHAR(8000), @MilesOrKM CHAR(1)'
        ,@Airports=@Airports
        ,@MilesOrKM=@MilesOrKM
END
GO

IF OBJECT_ID('DisplaySegmentTimes', 'P') IS NOT NULL
    DROP PROCEDURE DisplaySegmentTimes;
GO

CREATE PROCEDURE DisplaySegmentTimes
    (@Airports VARCHAR(8000)) AS
BEGIN
DECLARE @SQL    NVARCHAR(MAX)

    SELECT @SQL = 'SELECT [Origin/Destination] ' + (
        SELECT ',[' + Item + ']=CASE WHEN [' + Item + '] IS NULL THEN ''N/A'' ELSE CAST([' +
            Item + '] AS VARCHAR(5)) END '
        FROM DelimitedSplit8K(@Airports, ';')
        ORDER BY Item
        FOR XML PATH('')) + 'FROM (SELECT [Origin/Destination]=Origin ' + (
        SELECT ',[' + Item + ']=MAX(CASE Destination WHEN ''' + Item + 
            ''' THEN SegmentTime END) '
        FROM DelimitedSplit8K(@Airports, ';')
        ORDER BY Item
        FOR XML PATH('')) +
            '    FROM (
                    SELECT Origin=a.Item, Destination=b.Item, SegmentTime
                    FROM DelimitedSplit8K(@Airports, '';'') a
                    CROSS JOIN DelimitedSplit8K(@Airports, '';'') b
                    OUTER APPLY (
                        SELECT SegmentTime
                        FROM DailyFlightSchedules
                        WHERE Origin = a.Item and Destination = b.Item) c) a
                GROUP BY Origin) a
            ORDER BY [Origin/Destination]'

    EXEC sp_executesql @SQL
        ,N'@Airports VARCHAR(8000)', @Airports=@Airports
END

GO