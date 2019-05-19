DELETE FROM DailyFlightSchedules
WHERE FlightNo IN ('XX001', 'XX002', 'XX003', 'XX004', 'XX005')

INSERT INTO DailyFlightSchedules
    (Airline, Flight, Origin, Destination, DepartureTime, ArrivalTime, EffectiveStart, EffectiveEnd, [Day])
VALUES('XX','001', 'BKK', 'POM', '08:00', '19:25', NULL, '2013-01-06', '00')
INSERT INTO DailyFlightSchedules
    (Airline, Flight, Origin, Destination, DepartureTime, ArrivalTime, EffectiveStart, EffectiveEnd, [Day])
VALUES('XX','002', 'BKK', 'POM', '09:00', '20:25', '2013-01-07', NULL, '00')
INSERT INTO DailyFlightSchedules
    (Airline, Flight, Origin, Destination, DepartureTime, ArrivalTime, EffectiveStart, EffectiveEnd, [Day])
VALUES('XX','003', 'BKK', 'POM', '09:00', '20:25', '2013-01-01', '2013-01-12', '00')
INSERT INTO DailyFlightSchedules
    (Airline, Flight, Origin, Destination, DepartureTime, ArrivalTime, EffectiveStart, EffectiveEnd, [Day])
VALUES('XX','004', 'HKG', 'LAX', '23:45', '20:15', NULL,NULL, '00')
INSERT INTO DailyFlightSchedules
    (Airline, Flight, Origin, Destination, DepartureTime, ArrivalTime, EffectiveStart, EffectiveEnd, [Day])
VALUES('XX','004', 'LAX', 'JFK', '23:35', '08:00', NULL,NULL, '01')
INSERT INTO DailyFlightSchedules
    (Airline, Flight, Origin, Destination, DepartureTime, ArrivalTime, EffectiveStart, EffectiveEnd, [Day])
VALUES('XX','005', 'HKG', 'LAX', '23:45', '23:15', NULL,NULL, '00')
INSERT INTO DailyFlightSchedules
    (Airline, Flight, Origin, Destination, DepartureTime, ArrivalTime, EffectiveStart, EffectiveEnd, [Day])
VALUES('XX','005', 'LAX', 'JFK', '01:35', '08:00', NULL,NULL, '11')
GO

-- Correct the encoding for {Day] and calculate segment times, segment distances
UPDATE a
SET [Day]=CASE  WHEN [Day] = '+1' THEN '01' 
                WHEN [Day] IS NULL THEN '00' 
                WHEN [Day] = '  ' THEN '00' ELSE [Day] END
    ,SegmentTime=b.SegmentTimeMinutes
    ,SegmentDistanceMiles=ROUND(e.Miles, 0)
FROM DailyFlightSchedules a
CROSS APPLY CalculateSegmentTime(a.Origin, a.Destination, a.DepartureTime, a.ArrivalTime
    ,CASE       WHEN [Day] = '+1' THEN '01' 
                WHEN [Day] IS NULL THEN '00' 
                WHEN [Day] = '  ' THEN '00' ELSE [Day] END) b
CROSS APPLY (
    SELECT IATA_Code, LatDec, LongDec
    FROM Airports 
    WHERE IATA_Code = a.Origin) c
CROSS APPLY (
    SELECT IATA_Code, LatDec, LongDec
    FROM Airports 
    WHERE IATA_Code = a.Destination) d
OUTER APPLY HaversineDistance(c.LatDec, c.LongDec, d.LatDec, d.LongDec) e

SELECT * 
FROM DailyFlightSchedules

--***********************************************************
--***********************************************************
-- Some more FUNCTIONs to solve the application problems    *
--***********************************************************
--***********************************************************
