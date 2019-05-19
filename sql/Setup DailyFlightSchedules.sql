IF OBJECT_ID('DailyFlightSchedules', 'U') IS NOT NULL
    DROP TABLE DailyFlightSchedules;
GO
CREATE TABLE DailyFlightSchedules
    (SegmentID              INT IDENTITY
    ,Airline                CHAR(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
                            FOREIGN KEY REFERENCES Airlines(AirlineCode)
    ,Flight                 VARCHAR(4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
    ,Origin                 CHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
                            FOREIGN KEY REFERENCES Airports(IATA_Code)
    ,Destination            CHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
                            FOREIGN KEY REFERENCES Airports(IATA_Code)
    ,DepartureTime          TIME NOT NULL
    ,ArrivalTime            TIME NOT NULL
    ,EffectiveStart         DATETIME NULL
    ,EffectiveEnd           DATETIME NULL
    ,[Day]                  CHAR(2) NULL
    ,[DayOfWeek]            INT DEFAULT (127)  -- Default = every day of the week
    ,SegmentTime            INT DEFAULT(0)
    ,SegmentDistanceMiles   INT NULL DEFAULT(0)
    ,SegmentDistanceKM      AS (ROUND(SegmentDistanceMiles * 1.60934, 0))
    ,FlightNo               AS (Airline+Flight) PERSISTED
    ,DepartureDay           AS (CASE LEFT([Day], 1) WHEN '1' THEN '+1' ELSE '' END)
    ,ArrivalDay             AS (CASE RIGHT([Day], 1) WHEN '1' THEN '+1' ELSE '' END))
GO

CREATE INDEX DFS
 ON DailyFlightSchedules (FlightNo, Origin, Destination, DepartureTime, ArrivalTime)
 INCLUDE([DayOfWeek])
GO

INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES('PX','003', 'POM', 'BNE', '06:30:00', '09:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','003', 'POM', 'BNE', '09:30:00', '12:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','003', 'POM', 'BNE', '12:15:00', '15:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','004', 'BNE', 'POM', '10:25:00', '13:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','004', 'BNE', 'POM', '13:25:00', '16:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','004', 'BNE', 'POM', '16:40:00', '19:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','005', 'POM', 'BNE', '14:30:00', '17:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','005', 'POM', 'BNE', '15:10:00', '18:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','005', 'BNE', 'SYD', '18:55:00', '20:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','005', 'POM', 'BEN', '17:00:00', '19:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','006', 'BNE', 'POM', '09:30:00', '12:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','006', 'BNE', 'POM', '10:00:00', '13:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','008', 'POM', 'HKG', '16:35:00', '20:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','009', 'HKG', 'POM', '22:55:00', '07:35:00', '+1')
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','010', 'POM', 'MNL', '17:30:00', '20:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','011', 'MNL', 'POM', '21:45:00', '05:05:00', '+1')
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','054', 'POM', 'NRT', '14:35:00', '20:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','055', 'NRT', 'POM', '21:25:00', '04:30:00', '+1')
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','085', 'NAN', 'HIR', '09:00:00', '11:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','085', 'HIR', 'POM', '11:40:00', '13:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','182', 'POM', 'HGU', '15:15:00', '16:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','183', 'HGU', 'POM', '16:45:00', '17:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','147', 'WWK', 'VAI', '06:00:00', '06:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','147', 'VAI', 'MAG', '07:10:00', '08:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','147', 'MAG', 'POM', '08:45:00', '09:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','090', 'POM', 'CNS', '10:45:00', '12:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','090', 'POM', 'CNS', '09:30:00', '10:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','093', 'CNS', 'POM', '13:00:00', '14:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','093', 'CNS', 'POM', '12:00:00', '13:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','098', 'POM', 'CNS', '18:30:00', '19:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','098', 'POM', 'CNS', '17:00:00', '19:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','205', 'RAB', 'POM', '06:30:00', '07:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','205', 'RAB', 'POM', '09:20:00', '10:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','206', 'POM', 'RAB', '15:15:00', '16:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','279', 'RAB', 'KVG', '06:00:00', '06:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','279', 'KVG', 'POM', '07:05:00', '08:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','220', 'POM', 'MAS', '09:35:00', '11:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','220', 'MAS', 'KVG', '11:30:00', '12:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','271', 'KVG', 'POM', '12:50:00', '14:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','126', 'POM', 'MAG', '15:35:00', '16:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','126', 'MAG', 'WWK', '17:05:00', '17:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','125', 'WWK', 'MAG', '06:00:00', '06:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','125', 'MAG', 'POM', '07:10:00', '08:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','292', 'POM', 'LAE', '09:15:00', '10:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','292', 'LAE', 'MAS', '10:30:00', '11:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','295', 'MAS', 'MAG', '12:00:00', '12:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','295', 'MAG', 'POM', '13:20:00', '14:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','100', 'POM', 'LAE', '06:00:00', '06:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','101', 'LAE', 'POM', '07:15:00', '08:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','084', 'POM', 'HIR', '09:45:00', '13:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','084', 'HIR', 'NAN', '13:45:00', '17:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','180', 'POM', 'HGU', '08:45:00', '09:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','181', 'HGU', 'POM', '10:15:00', '11:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','102', 'POM', 'LAE', '12:00:00', '12:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','103', 'LAE', 'POM', '13:15:00', '14:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','214', 'POM', 'LAE', '15:15:00', '16:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','214', 'LAE', 'RAB', '16:30:00', '17:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','215', 'RAB', 'LAE', '12:25:00', '13:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','215', 'LAE', 'POM', '14:00:00', '14:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','091', 'CNS', 'POM', '07:00:00', '08:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','091', 'CNS', 'POM', '07:00:00', '09:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','091', 'CNS', 'POM', '09:00:00', '10:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','204', 'POM', 'RAB', '10:00:00', '11:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','207', 'RAB', 'POM', '11:55:00', '13:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','146', 'POM', 'MAG', '14:25:00', '15:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','146', 'MAG', 'VAI', '15:55:00', '17:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','146', 'VAI', 'WWK', '17:30:00', '18:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','144', 'POM', 'WWK', '11:30:00', '12:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','144', 'WWK', 'VAI', '13:20:00', '14:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','145', 'VAI', 'WWK', '14:30:00', '15:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','145', 'WWK', 'POM', '15:40:00', '17:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','274', 'POM', 'RAB', '14:55:00', '16:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','274', 'RAB', 'KVG', '16:50:00', '17:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','275', 'KVG', 'RAB', '06:00:00', '06:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','275', 'RAB', 'POM', '07:05:00', '08:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','252', 'POM', 'RAB', '06:00:00', '07:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','252', 'RAB', 'BUA', '07:55:00', '08:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','252', 'POM', 'RAB', '09:35:00', '11:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','252', 'RAB', 'BUA', '11:30:00', '12:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','257', 'BUA', 'RAB', '12:40:00', '13:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','257', 'RAB', 'LAE', '13:50:00', '14:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','257', 'LAE', 'POM', '15:25:00', '16:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','250', 'POM', 'BUA', '09:40:00', '11:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','251', 'BUA', 'POM', '09:05:00', '10:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','253', 'BUA', 'RAB', '11:50:00', '12:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','253', 'RAB', 'POM', '13:00:00', '14:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','253', 'BUA', 'RAB', '14:00:00', '14:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','253', 'RAB', 'POM', '15:10:00', '16:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','106', 'POM', 'LAE', '17:45:00', '18:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','107', 'LAE', 'POM', '19:00:00', '19:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','254', 'POM', 'BUA', '06:00:00', '07:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','254', 'BUA', 'RAB', '08:10:00', '08:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','258', 'POM', 'LAE', '10:00:00', '10:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','258', 'LAE', 'RAB', '11:15:00', '12:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','258', 'RAB', 'BUA', '12:50:00', '13:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','110', 'POM', 'MAG', '10:00:00', '11:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','111', 'MAG', 'POM', '11:30:00', '12:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','228', 'POM', 'KVG', '11:25:00', '12:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','228', 'KVG', 'MAS', '13:25:00', '14:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','291', 'MAS', 'POM', '14:45:00', '15:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','294', 'POM', 'MAG', '09:15:00', '10:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','294', 'MAG', 'MAS', '10:45:00', '11:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','293', 'MAS', 'LAE', '12:05:00', '13:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','293', 'LAE', 'POM', '13:35:00', '14:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','811', 'LNV', 'POM', '06:00:00', '08:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','842', 'POM', 'HKN', '09:35:00', '11:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','842', 'HKN', 'RAB', '11:30:00', '12:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','843', 'RAB', 'HKN', '12:45:00', '13:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','843', 'HKN', 'POM', '14:00:00', '15:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','852', 'POM', 'PNP', '07:00:00', '07:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','853', 'PNP', 'POM', '07:55:00', '08:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','960', 'POM', 'GKA', '09:15:00', '10:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','961', 'GKA', 'POM', '10:45:00', '11:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','810', 'POM', 'LNV', '14:55:00', '17:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','954', 'POM', 'GUR', '07:00:00', '08:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','954', 'POM', 'GUR', '10:30:00', '11:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','955', 'GUR', 'POM', '08:20:00', '09:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','955', 'GUR', 'POM', '11:50:00', '12:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','910', 'POM', 'MAG', '10:00:00', '11:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','910', 'POM', 'MAG', '12:40:00', '13:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','911', 'MAG', 'POM', '11:45:00', '13:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','911', 'MAG', 'POM', '14:20:00', '15:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','864', 'POM', 'TIZ', '10:00:00', '11:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','864', 'POM', 'TIZ', '09:35:00', '11:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','864', 'POM', 'TIZ', '09:15:00', '10:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','865', 'TIZ', 'POM', '11:25:00', '12:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','865', 'TIZ', 'POM', '11:50:00', '13:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','865', 'TIZ', 'POM', '11:05:00', '12:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','840', 'POM', 'HKN', '08:00:00', '09:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','840', 'POM', 'HKN', '09:35:00', '11:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','844', 'POM', 'HKN', '15:35:00', '17:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','844', 'POM', 'HKN', '15:45:00', '17:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','845', 'HKN', 'POM', '17:30:00', '19:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','845', 'HKN', 'POM', '13:05:00', '14:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','845', 'HKN', 'POM', '06:45:00', '08:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','847', 'HKN', 'LAE', '09:55:00', '11:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','847', 'LAE', 'POM', '11:35:00', '12:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','846', 'POM', 'LAE', '10:00:00', '11:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','846', 'LAE', 'HKN', '11:25:00', '12:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','607', 'MXH', 'POM', '06:45:00', '08:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','607', 'MXH', 'POM', '06:30:00', '07:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','700', 'POM', 'MXH', '10:00:00', '11:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','700', 'POM', 'MXH', '10:15:00', '11:14:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','701', 'MXH', 'POM', '12:00:00', '13:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','701', 'MXH', 'POM', '12:10:00', '13:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','606', 'POM', 'MXH', '15:35:00', '17:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','606', 'POM', 'MXH', '15:35:00', '17:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','606', 'POM', 'MXH', '09:30:00', '10:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','841', 'HKN', 'POM', '06:45:00', '08:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','841', 'HKN', 'POM', '11:30:00', '13:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','860', 'POM', 'MDU', '12:00:00', '13:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','861', 'MDU', 'POM', '13:45:00', '15:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','900', 'POM', 'TBG', '09:15:00', '11:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','901', 'TBG', 'POM', '11:30:00', '13:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','962', 'POM', 'GKA', '14:55:00', '16:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','963', 'GKA', 'POM', '16:25:00', '17:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','812', 'POM', 'LNV', '06:30:00', '08:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','817', 'LNV', 'RAB', '09:10:00', '09:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','818', 'RAB', 'LNV', '10:05:00', '10:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','813', 'LNV', 'POM', '11:00:00', '13:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','813', 'LNV', 'POM', '09:10:00', '11:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','862', 'POM', 'CMU', '09:15:00', '10:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','863', 'CMU', 'POM', '10:55:00', '12:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','904', 'POM', 'UNG', '12:45:00', '14:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','903', 'UNG', 'POM', '15:00:00', '16:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','401', 'MXH', 'CNS', '07:00:00', '09:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','400', 'CNS', 'MXH', '13:00:00', '15:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','634', 'MXH', 'HGU', '11:30:00', '12:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','635', 'HGU', 'MXH', '12:30:00', '13:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','906', 'POM', 'TBG', '10:00:00', '11:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','906', 'TBG', 'HGU', '12:15:00', '13:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','905', 'HGU', 'TBG', '13:40:00', '14:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','905', 'TBG', 'POM', '15:05:00', '16:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','958', 'POM', 'GUR', '15:15:00', '16:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','959', 'GUR', 'POM', '16:35:00', '17:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','856', 'POM', 'PNP', '14:00:00', '14:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','857', 'PNP', 'POM', '14:55:00', '15:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2100', 'POM', 'LAE', '06:00:00', '07:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2101', 'LAE', 'POM', '08:00:00', '09:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2904', 'POM', 'RAB', '10:30:00', '12:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2905', 'RAB', 'POM', '13:30:00', '15:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2606', 'POM', 'MXH', '11:00:00', '12:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2606', 'POM', 'MXH', '07:00:00', '08:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2607', 'MXH', 'POM', '13:25:00', '14:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2607', 'MXH', 'POM', '09:25:00', '10:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2840', 'POM', 'HKN', '11:00:00', '12:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2841', 'HKN', 'POM', '13:30:00', '15:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2980', 'POM', 'HGU', '11:00:00', '12:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'PX','2981', 'HGU', 'POM', '13:10:00', '14:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','201', 'BNE', 'POM', '10:00:00', '13:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','200', 'POM', 'BNE', '13:50:00', '16:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','100', 'POM', 'CNS', '17:30:00', '19:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','100', 'POM', 'CNS', '15:40:00', '17:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','101', 'CNS', 'POM', '06:30:00', '08:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1300', 'POM', 'UNG', '09:00:00', '10:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1300', 'UNG', 'TBG', '11:25:00', '11:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1305', 'TBG', 'POM', '12:20:00', '14:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1308', 'POM', 'DAU', '12:55:00', '14:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1309', 'DAU', 'POM', '14:35:00', '15:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1308', 'POM', 'DAU', '12:00:00', '13:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1309', 'DAU', 'POM', '13:40:00', '14:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1310', 'POM', 'DAU', '10:15:00', '11:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1310', 'DAU', 'UNG', '11:55:00', '13:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1310', 'POM', 'DAU', '09:00:00', '10:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1310', 'DAU', 'UNG', '10:40:00', '11:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1311', 'UNG', 'DAU', '13:30:00', '14:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1311', 'DAU', 'POM', '15:05:00', '16:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1311', 'UNG', 'DAU', '12:15:00', '13:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1311', 'DAU', 'POM', '13:50:00', '15:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1401', 'TBG', 'MXH', '06:45:00', '07:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1401', 'MXH', 'POM', '08:00:00', '09:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1402', 'POM', 'HGU', '13:15:00', '14:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1402', 'HGU', 'UNG', '15:10:00', '16:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1402', 'UNG', 'TBG', '16:35:00', '17:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1403', 'TBG', 'UNG', '07:45:00', '08:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1403', 'UNG', 'HGU', '08:40:00', '09:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1403', 'HGU', 'POM', '10:05:00', '11:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1400', 'POM', 'MXH', '14:20:00', '15:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1400', 'MXH', 'TBG', '16:15:00', '17:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1410', 'LAE', 'GKA', '12:30:00', '13:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1410', 'GKA', 'HGU', '13:35:00', '14:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1410', 'HGU', 'UNG', '14:35:00', '15:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1410', 'UNG', 'TBG', '16:00:00', '16:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1411', 'TBG', 'UNG', '08:00:00', '08:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1411', 'UNG', 'HGU', '08:55:00', '09:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1411', 'HGU', 'GKA', '10:20:00', '10:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1411', 'GKA', 'LAE', '11:20:00', '11:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1413', 'TBG', 'UNG', '11:55:00', '12:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1413', 'UNG', 'HGU', '12:50:00', '13:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1414', 'HGU', 'TBG', '10:25:00', '11:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1500', 'POM', 'LAE', '06:00:00', '07:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1501', 'LAE', 'POM', '07:30:00', '08:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1504', 'POM', 'LAE', '09:40:00', '10:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1505', 'LAE', 'POM', '11:10:00', '12:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1508', 'POM', 'LAE', '15:45:00', '16:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1509', 'LAE', 'POM', '17:15:00', '18:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1520', 'POM', 'BUA', '12:45:00', '13:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1520', 'POM', 'BUA', '10:10:00', '10:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1521', 'BUA', 'POM', '11:25:00', '12:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1521', 'BUA', 'POM', '14:00:00', '14:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1540', 'POM', 'HGU', '08:30:00', '09:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1540', 'POM', 'HGU', '10:20:00', '11:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1540', 'POM', 'HGU', '06:50:00', '08:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1541', 'HGU', 'POM', '09:15:00', '10:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1543', 'HGU', 'POM', '16:00:00', '17:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1543', 'HGU', 'POM', '16:55:00', '18:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1543', 'HGU', 'POM', '12:15:00', '13:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1611', 'WWK', 'MAG', '14:30:00', '15:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1611', 'MAG', 'HGU', '15:50:00', '16:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1612', 'HGU', 'WWK', '13:15:00', '14:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1613', 'WWK', 'HGU', '11:50:00', '12:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1616', 'HGU', 'GKA', '08:45:00', '09:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1616', 'GKA', 'MAG', '09:40:00', '10:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1616', 'MAG', 'WWK', '10:35:00', '11:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1670', 'POM', 'PNP', '06:10:00', '06:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1670', 'POM', 'PNP', '09:20:00', '09:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1670', 'POM', 'PNP', '12:50:00', '13:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1671', 'PNP', 'POM', '07:10:00', '07:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1671', 'PNP', 'POM', '10:20:00', '10:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1671', 'PNP', 'POM', '13:50:00', '14:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1642', 'POM', 'GUR', '09:15:00', '10:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1642', 'GUR', 'MIS', '10:45:00', '11:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1640', 'POM', 'GUR', '11:20:00', '12:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1641', 'GUR', 'POM', '12:50:00', '13:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1643', 'MIS', 'GUR', '12:00:00', '12:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1643', 'GUR', 'POM', '13:20:00', '14:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1644', 'POM', 'GUR', '09:15:00', '10:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1644', 'GUR', 'LSA', '10:45:00', '11:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1644', 'POM', 'GUR', '08:00:00', '09:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1644', 'GUR', 'LSA', '09:30:00', '10:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1645', 'LSA', 'GUR', '11:50:00', '12:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1645', 'GUR', 'POM', '13:00:00', '14:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1645', 'LSA', 'GUR', '10:35:00', '11:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1645', 'GUR', 'POM', '11:45:00', '12:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1710', 'POM', 'BUA', '10:10:00', '12:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1710', 'BUA', 'LNV', '13:05:00', '14:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1711', 'LNV', 'BUA', '10:00:00', '10:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1711', 'BUA', 'POM', '11:25:00', '13:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1712', 'LNV', 'RAB', '14:25:00', '14:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1712', 'RAB', 'KVG', '15:20:00', '16:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1713', 'KVG', 'RAB', '08:00:00', '08:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1713', 'RAB', 'LNV', '09:05:00', '09:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1714', 'LNV', 'KVG', '07:00:00', '07:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','1715', 'KVG', 'LNV', '16:25:00', '17:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4372', 'POM', 'KMA', '08:00:00', '08:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4372', 'KMA', 'KRI', '09:15:00', '09:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4372', 'KRI', 'SGK', '10:15:00', '10:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4373', 'SGK', 'AWB', '10:55:00', '11:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4374', 'AWB', 'DAU', '11:05:00', '11:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4373', 'DAU', 'AWB', '12:15:00', '12:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4373', 'AWB', 'SGK', '12:55:00', '13:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4373', 'SGK', 'KRI', '13:25:00', '13:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4373', 'KRI', 'KMA', '14:15:00', '14:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4373', 'KMA', 'POM', '15:15:00', '16:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4350', 'POM', 'KRI', '09:45:00', '11:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4350', 'KRI', 'OPU', '11:40:00', '12:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4350', 'OPU', 'DAU', '12:35:00', '13:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4350', 'DAU', 'SKC', '13:25:00', '14:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4350', 'SKC', 'OBX', '14:25:00', '14:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4350', 'OBX', 'BOT', '15:00:00', '15:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4350', 'BOT', 'LMY', '15:30:00', '15:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4350', 'LMY', 'UNG', '16:00:00', '16:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4351', 'UNG', 'LMY', '08:00:00', '08:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4351', 'LMY', 'BOT', '08:40:00', '09:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'BOT', 'OBX', '09:10:00', '09:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'OBX', 'SKC', '09:40:00', '10:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'SKC', 'DAU', '10:15:00', '11:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'DAU', 'OPU', '11:25:00', '11:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'OPU', 'KRI', '12:05:00', '12:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'KRI', 'POM', '13:10:00', '14:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'POM', 'KRI', '09:00:00', '10:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'KRI', 'OPU', '10:55:00', '11:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'OPU', 'DAU', '11:50:00', '12:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'DAU', 'WPM', '12:40:00', '13:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'WPM', 'SKC', '13:10:00', '13:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'SKC', 'OBX', '14:00:00', '14:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'OBX', 'LMY', '14:35:00', '15:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4352', 'LMY', 'UNG', '15:10:00', '15:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4353', 'UNG', 'LMY', '08:00:00', '08:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4353', 'LMY', 'OBX', '08:40:00', '09:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4353', 'OBX', 'SKC', '09:15:00', '09:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4353', 'SKC', 'WPM', '09:50:00', '10:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4353', 'WPM', 'DAU', '10:40:00', '11:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4353', 'DAU', 'OPU', '11:20:00', '11:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4353', 'OPU', 'KRI', '12:00:00', '12:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4353', 'KRI', 'POM', '13:05:00', '14:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4374', 'POM', 'KRI', '06:30:00', '08:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4374', 'KRI', 'SGK', '18:25:00', '18:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4374', 'SGK', 'AWB', '09:05:00', '09:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4375', 'AWB', 'DAU', '09:35:00', '10:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4375', 'DAU', 'AWB', '10:25:00', '10:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4375', 'AWB', 'SGK', '11:05:00', '11:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4375', 'SGK', 'KRI', '11:35:00', '12:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4375', 'KRI', 'POM', '12:25:00', '14:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4376', 'POM', 'KMA', '09:00:00', '09:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4376', 'KMA', 'KRI', '10:15:00', '10:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4376', 'KRI', 'OPU', '11:05:00', '11:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4376', 'OPU', 'DAU', '12:00:00', '12:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4377', 'DAU', 'OPU', '12:50:00', '13:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4377', 'OPU', 'KRI', '13:30:00', '14:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4377', 'KRI', 'KMA', '14:25:00', '15:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4377', 'KMA', 'POM', '15:25:00', '16:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4440', 'POM', 'KMA', '11:30:00', '12:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4440', 'KMA', 'KRI', '12:45:00', '13:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4440', 'POM', 'KMA', '10:00:00', '10:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4440', 'KMA', 'KRI', '11:15:00', '11:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4441', 'KRI', 'KMA', '13:45:00', '14:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4441', 'KMA', 'POM', '14:45:00', '15:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4441', 'KRI', 'KMA', '12:05:00', '12:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4441', 'KMA', 'POM', '13:05:00', '14:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4472', 'POM', 'KMA', '10:00:00', '10:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4472', 'KMA', 'KRI', '11:15:00', '11:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4472', 'KRI', 'HGU', '12:05:00', '12:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4473', 'KGW', 'KRI', '13:15:00', '14:05:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4473', 'KRI', 'KMA', '14:15:00', '14:55:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4473', 'KMA', 'POM', '15:15:00', '16:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4674', 'POM', 'TFI', '06:15:00', '07:15:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4674', 'POM', 'TFI', '14:30:00', '15:30:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4674', 'POM', 'TFI', '15:00:00', '16:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4677', 'TFI', 'AGL', '07:25:00', '07:35:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4677', 'AGL', 'POM', '07:45:00', '08:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4677', 'TFI', 'AGL', '16:10:00', '16:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4677', 'AGL', 'POM', '16:30:00', '17:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4679', 'TFI', 'ITK', '15:40:00', '16:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4679', 'ITK', 'POM', '16:20:00', '16:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4686', 'POM', 'KKD', '10:10:00', '10:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4687', 'KKD', 'POM', '10:50:00', '11:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4810', 'POM', 'FNE', '08:20:00', '08:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4810', 'FNE', 'TPI', '09:00:00', '09:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4802', 'POM', 'FNE', '06:30:00', '07:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4802', 'FNE', 'WTP', '07:10:00', '07:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4805', 'WTP', 'POM', '07:30:00', '08:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4806', 'POM', 'ONB', '06:30:00', '07:00:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4806', 'ONB', 'WTP', '07:10:00', '07:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4813', 'TPI', 'POM', '09:20:00', '09:50:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4814', 'POM', 'MRM', '08:00:00', '08:20:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4814', 'MRM', 'EFG', '08:30:00', '08:40:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4817', 'EFG', 'POM', '08:50:00', '09:10:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4820', 'POM', 'KGW', '08:00:00', '08:25:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4820', 'KGW', 'MMV', '08:35:00', '08:45:00', NULL)
INSERT INTO DailyFlightSchedules (Airline, Flight,Origin,Destination,DepartureTime,ArrivalTime,[Day]) VALUES( 'CG','4823', 'MMV', 'POM', '08:55:00', '09:20:00', NULL)


;WITH PNGFlights (FlightNo, Origin, Destination, DepartureTime, ArrivalTime
    ,MO, TU, WE, TH, FR, SA, SU)
AS (
SELECT 'PX003','POM','BNE','06:30','09:25','YES','NO','YES','YES','NO','NO','YES'
UNION ALL SELECT 'PX003','POM','BNE','09:30','12:25','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX003','POM','BNE','12:15','15:15','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX004','BNE','POM','10:25','13:25','YES','NO','YES','YES','NO','NO','YES'
UNION ALL SELECT 'PX004','BNE','POM','13:25','16:25','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX004','BNE','POM','16:40','19:40','NO','NO','NO','NO','No','YES','NO'
UNION ALL SELECT 'PX005','POM','BNE','14:30','17:25','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX005','POM','BNE','15:10','18:05','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX005','BNE','SYD','18:55','20:25','NO','No','NO','NO','NO','No','YES'
UNION ALL SELECT 'PX005','POM','BEN','17:00','19:55','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX006','BNE','POM','09:30','12:30','No','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX006','BNE','POM','10:00','13:00','NO','No','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX008','POM','HKG','16:35','20:55','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX009','HKG','POM','22:55','07:35','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX010','POM','MNL','17:30','20:30','NO','NO','YES','NO','NO','YES','NO'
UNION ALL SELECT 'PX011','MNL','POM','21:45','05:05','NO','NO','YES','NO','NO','YES','NO'
UNION ALL SELECT 'PX054','POM','NRT','14:15','19:55','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX054','POM','NRT','14:35','20:15','NO','NO','YES','No','NO','NO','NO'
UNION ALL SELECT 'PX055','NRT','POM','21:25','04:30','NO','NO','YES','NO','NO','YES','NO'
UNION ALL SELECT 'PX085','NAN','HIR','09:00','11:00','YES','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX085','HIR','POM','11:40','13:00','YES','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX182','POM','HGU','15:15','16:15','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX183','HGU','POM','16:45','17:45','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX147','WWK','VAI','06:00','06:40','YES','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX147','VAI','MAG','07:10','08:15','YES','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX147','MAG','POM','08:45','09:45','YES','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX090','POM','CNS','10:45','12:10','YES','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX090','POM','CNS','09:30','10:55','NO','YES','YES','YES','YES','NO','YES'
UNION ALL SELECT 'PX093','CNS','POM','13:00','14:25','YES','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX093','CNS','POM','12:00','13:25','NO','YES','YES','YES','YES','NO','YES'
UNION ALL SELECT 'PX098','POM','CNS','18:30','19:55','NO','NO','NO','NO','YES','NO','YES'
UNION ALL SELECT 'PX098','POM','CNS','17:00','19:15','NO','YES','YES','YES','NO','NO','NO'
UNION ALL SELECT 'PX205','RAB','POM','06:30','07:50','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX205','RAB','POM','09:20','10:40','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX206','POM','RAB','15:15','16:40','NO','NO','YES','NO','NO','NO','YES'
UNION ALL SELECT 'PX279','RAB','KVG','06:00','06:35','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX279','KVG','POM','07:05','08:35','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX220','POM','MAS','09:35','11:00','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX220','MAS','KVG','11:30','12:20','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX271','KVG','POM','12:50','14:30','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX126','POM','MAG','15:35','16:35','YES','YES','YES','YES','NO','YES','NO'
UNION ALL SELECT 'PX126','MAG','WWK','17:05','17:45','YES','YES','YES','YES','NO','YES','NO'
UNION ALL SELECT 'PX125','WWK','MAG','06:00','06:40','NO','YES','YES','YES','YES','NO','YES'
UNION ALL SELECT 'PX125','MAG','POM','07:10','08:10','NO','YES','YES','YES','YES','NO','YES'
UNION ALL SELECT 'PX292','POM','LAE','09:15','10:00','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX292','LAE','MAS','10:30','11:30','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX295','MAS','MAG','12:00','12:50','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX295','MAG','POM','13:20','14:20','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX100','POM','LAE','06:00','06:45','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX101','LAE','POM','07:15','08:00','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX084','POM','HIR','09:45','13:05','NO','NO','NO','NO','YES','NO','YES'
UNION ALL SELECT 'PX084','HIR','NAN','13:45','17:45','NO','NO','NO','NO','YES','NO','YES'
UNION ALL SELECT 'PX180','POM','HGU','08:45','09:45','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX181','HGU','POM','10:15','11:15','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX102','POM','LAE','12:00','12:45','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX103','LAE','POM','13:15','14:00','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX214','POM','LAE','15:15','16:00','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX214','LAE','RAB','16:30','17:35','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX215','RAB','LAE','12:25','13:30','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX215','LAE','POM','14:00','14:45','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX091','CNS','POM','07:00','08:25','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX091','CNS','POM','07:00','09:15','NO','NO','YES','YES','YES','NO','NO'
UNION ALL SELECT 'PX091','CNS','POM','09:00','10:25','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX204','POM','RAB','10:00','11:25','NO','YES','NO','NO','YES','NO','YES'
UNION ALL SELECT 'PX207','RAB','POM','11:55','13:15','NO','NO','NO','NO','YES','NO','YES'
UNION ALL SELECT 'PX146','POM','MAG','14:25','15:25','NO','NO','NO','NO','YES','NO','YES'
UNION ALL SELECT 'PX146','MAG','VAI','15:55','17:00','NO','NO','NO','NO','YES','NO','YES'
UNION ALL SELECT 'PX146','VAI','WWK','17:30','18:10','NO','NO','NO','NO','YES','NO','YES'
UNION ALL SELECT 'PX144','POM','WWK','11:30','12:50','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX144','WWK','VAI','13:20','14:00','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX145','VAI','WWK','14:30','15:10','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX145','WWK','POM','15:40','17:00','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX274','POM','RAB','14:55','16:20','NO','YES','NO','YES','YES','YES','NO'
UNION ALL SELECT 'PX274','RAB','KVG','16:50','17:25','NO','YES','NO','YES','YES','YES','NO'
UNION ALL SELECT 'PX275','KVG','RAB','06:00','06:35','NO','NO','YES','NO','YES','YES','YES'
UNION ALL SELECT 'PX275','RAB','POM','07:05','08:25','NO','NO','YES','NO','YES','YES','YES'
UNION ALL SELECT 'PX252','POM','RAB','06:00','07:25','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX252','RAB','BUA','07:55','08:35','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX252','POM','RAB','09:35','11:00','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX252','RAB','BUA','11:30','12:10','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX257','BUA','RAB','12:40','13:20','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX257','RAB','LAB','13:50','14:55','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX257','LAB','POM','15:25','16:10','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX250','POM','BUA','09:40','11:20','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX251','BUA','POM','09:05','10:35','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX253','BUA','RAB','11:50','12:30','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX253','RAB','POM','13:00','14:20','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX253','BUA','RAB','14:00','14:40','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX253','RAB','POM','15:10','16:30','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX106','POM','LAE','17:45','18:30','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX107','LAE','POM','19:00','19:45','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX254','POM','BUA','06:00','07:40','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX254','BUA','RAB','08:10','08:50','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX258','POM','LAE','10:00','10:45','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX258','LAE','RAB','11:15','12:20','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX258','RAB','BUA','12:50','13:30','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX110','POM','MAG','10:00','11:00','NO','YES','YES','YES','NO','NO','NO'
UNION ALL SELECT 'PX111','MAG','POM','11:30','12:30','NO','YES','YES','YES','NO','NO','NO'
UNION ALL SELECT 'PX228','POM','KVG','11:25','12:55','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX228','KVG','MAS','13:25','14:15','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX291','MAS','POM','14:45','15:05','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX294','POM','MAG','09:15','10:15','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX294','MAG','MAS','10:45','11:35','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX293','MAS','LAE','12:05','13:05','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX293','LAE','POM','13:35','14:20','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX811','LNV','POM','06:00','08:20','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX842','POM','HKN','09:35','11:05','YES','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX842','HKN','RAB','11:30','12:20','YES','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX843','RAB','HKN','12:45','13:35','YES','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX843','HKN','POM','14:00','15:30','YES','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX852','POM','PNP','07:00','07:35','YES','YES','YES','YES','YES','NO','YES'
UNION ALL SELECT 'PX853','PNP','POM','07:55','08:30','YES','YES','YES','YES','YES','NO','YES'
UNION ALL SELECT 'PX960','POM','GKA','09:15','10:25','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX961','GKA','POM','10:45','11:55','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX810','POM','LNV','14:55','17:15','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX954','POM','GUR','07:00','08:00','YES','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX954','POM','GUR','10:30','11:30','NO','YES','NO','YES','YES','YES','YES'
UNION ALL SELECT 'PX955','GUR','POM','08:20','09:20','YES','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX955','GUR','POM','11:50','12:50','NO','YES','NO','YES','YES','YES','YES'
UNION ALL SELECT 'PX910','POM','MAG','10:00','11:15','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX910','POM','MAG','12:40','13:55','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX911','MAG','POM','11:45','13:00','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX911','MAG','POM','14:20','15:35','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX864','POM','TIZ','10:00','11:30','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX864','POM','TIZ','09:35','11:05','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX864','POM','TIZ','09:15','10:45','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX865','TIZ','POM','11:25','12:55','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX865','TIZ','POM','11:50','13:20','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX865','TIZ','POM','11:05','12:35','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX840','POM','HKN','08:00','09:30','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX840','POM','HKN','09:35','11:15','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX844','POM','HKN','15:35','17:05','YES','NO','YES','NO','YES','YES','YES'
UNION ALL SELECT 'PX844','POM','HKN','15:45','17:15','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX845','HKN','POM','17:30','19:00','YES','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX845','HKN','POM','13:05','14:35','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX845','HKN','POM','06:45','08:10','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX847','HKN','LAE','09:55','11:00','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX847','LAE','POM','11:35','12:35','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX846','POM','LAE','10:00','11:00','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX846','LAE','HKN','11:25','12:40','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX607','MXH','POM','06:45','08:10','YES','YES','NO','YES','YES','NO','NO'
UNION ALL SELECT 'PX607','MXH','POM','06:30','07:55','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX700','POM','MXH','10:00','11:25','YES','NO','NO','YES','YES','NO','NO'
UNION ALL SELECT 'PX700','POM','MXH','10:15','11:14','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX701','MXH','POM','12:00','13:25','YES','NO','NO','YES','YES','NO','NO'
UNION ALL SELECT 'PX701','MXH','POM','12:10','13:25','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX606','POM','MXH','15:35','17:05','YES','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX606','POM','MXH','15:35','17:00','NO','NO','NO','YES','YES','NO','NO'
UNION ALL SELECT 'PX606','POM','MXH','09:30','10:35','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX841','HKN','POM','06:45','08:15','YES','NO','NO','NO','YES','YES','NO'
UNION ALL SELECT 'PX841','HKN','POM','11:30','13:00','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX860','POM','MDU','12:00','13:25','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'PX861','MDU','POM','13:45','15:05','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'PX900','POM','TBG','09:15','11:05','YES','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX901','TBG','POM','11:30','13:20','YES','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX962','POM','GKA','14:55','16:05','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX963','GKA','POM','16:25','17:35','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'PX812','POM','LNV','06:30','08:45','YES','YES','YES','YES','YES','NO','NO'
UNION ALL SELECT 'PX817','LNV','RAB','09:10','09:40','YES','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'PX818','RAB','LNV','10:05','10:35','YES','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'PX813','LNV','POM','11:00','13:10','YES','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'PX813','LNV','POM','09:10','11:20','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX862','POM','CMU','09:15','10:35','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'PX863','CMU','ROM','10:55','12:05','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'PX904','POM','UNG','12:45','14:35','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX903','UNG','POM','15:00','16:50','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX401','MXH','CNS','07:00','09:45','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX400','CNS','MXH','13:00','15:45','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX634','MXH','HGU','11:30','12:00','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX635','HGU','MXH','12:30','13:00','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX906','POM','TBG','10:00','11:50','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX906','TBG','HGU','12:15','13:15','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX905','HGU','TBG','13:40','14:40','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX905','TBG','POM','15:05','16:55','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX958','POM','GUR','15:15','16:15','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX959','GUR','POM','16:35','17:35','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX856','POM','PNP','14:00','14:35','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX857','PNP','POM','14:55','15:30','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'PX2100','POM','LAE','06:00','07:00','YES','YES','YES','YES','YES','NO','NO'
UNION ALL SELECT 'PX2101','LAE','POM','08:00','09:00','YES','YES','YES','YES','YES','NO','NO'
UNION ALL SELECT 'PX2904','POM','RAB','10:30','12:30','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX2905','RAB','POM','13:30','15:30','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'PX2606','POM','MXH','11:00','12:25','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX2606','POM','MXH','07:00','08:25','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX2607','MXH','POM','13:25','14:50','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'PX2607','MXH','POM','09:25','10:50','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'PX2840','POM','HKN','11:00','12:30','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX2841','HKN','POM','13:30','15:00','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'PX2980','POM','HGU','11:00','12:10','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'PX2981','HGU','POM','13:10','14:20','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'CG201','BNE ','POM','10:00','13:05','YES','NO','YES','NO','YES','NO','YES'
UNION ALL SELECT 'CG200','POM ','BNE','13:50','16:50','YES','NO','YES','NO','YES','NO','YES'
UNION ALL SELECT 'CG100','POM','CNS','17:30','19:40','YES','YES','YES','YES','YES','NO','NO'
UNION ALL SELECT 'CG100','POM ','CNS','17:30','19:40','YES','YES','YES','YES','YES','NO','NO'
UNION ALL SELECT 'CG100','POM','CNS','15:40','17:50','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG101','CNS ','POM','06:30','08:40','YES','YES','YES','YES','YES','YES','NO'
UNION ALL SELECT 'CG1300','POM','UNG','09:00','10:55','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1300','UNG ','TBG','11:25','11:50','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1305','TBG ','POM','12:20','14:30','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1308','POM','DAU','12:55','14:05','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1309','DAU ','POM','14:35','15:45','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1308','POM','DAU','12:00','13:10','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1309','DAU ','POM','13:40','14:50','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1310','POM ','DAU','10:15','11:25','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1310','DAU ','UNG','11:55','13:00','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1310','POM','DAU','09:00','10:10','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1310','DAU ','UNG','10:40','11:45','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1311','UNG ','DAU','13:30','14:35','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1311','DAU ','POM','15:05','16:15','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1311','UNG ','DAU','12:15','13:20','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1311','DAU ','POM','13:50','15:00','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1401','TBG ','MXH','06:45','07:30','YES','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1401','MXH ','POM','08:00','09:30','YES','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1402','POM','HGU','13:15','14:40','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1402','HGU','UNG','15:10','16:05','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1402','UNG ','TBG','16:35','17:00','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1403','TBG ','UNG','07:45','08:10','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1403','UNG ','HGU','08:40','09:35','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1403','HGU','POM','10:05','11:30','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1400','POM ','MXH','14:20','15:50','YES','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1400','MXH ','TBG','16:15','17:00','YES','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1410','LAE ','GKA','12:30','13:05','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1410','GAK','HGU','13:35','14:05','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1410','HGU','UNG','14:35','15:30','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1410','UNG ','TBG','16:00','16:25','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1411','TBG ','UNG','08:00','08:25','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1411','UNG ','HGU','08:55','09:50','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1411','HGU','GKA','10:20','10:50','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1411','GKA','LAE','11:20','11:55','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1413','TBG ','UNG','11:55','12:20','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1413','UNG ','HGU','12:50','13:45','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1414','HGU ','TBG','10:25','11:25','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1500','POM ','LAE','06:00','07:00','YES','YES','YES','YES','YES','YES','NO'
UNION ALL SELECT 'CG1501','LAE ','POM','07:30','08:30','YES','YES','YES','YES','YES','YES','NO'
UNION ALL SELECT 'CG1504','POM ','LAE','09:40','10:40','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'CG1505','LAE ','POM','11:10','12:10','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'CG1508','POM ','LAE','15:45','16:45','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'CG1509','LAE ','POM','17:15','18:15','YES','YES','YES','YES','YES','YES','YES'
UNION ALL SELECT 'CG1520','POM ','BUL','12:45','13:30','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1520','POM','BUL','10:10','10:55','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1521','BUL ','POM','11:25','12:10','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1521','BUL ','POM','14:00','14:45','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1540','POM ','HGU','08:30','09:55','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1540','POM ','HGU','10:20','11:25','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1540','POM ','HGU','06:50','08:15','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1541','HGU','POM','09:15','10:40','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1543','HGU','POM','16:00','17:25','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG1543','HGU','POM','16:55','18:20','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1543','HGU','POM','12:15','13:40','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG1611','WWK','MAG','14:30','15:20','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1611','MAG','HGU','15:50','16:25','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1612','HGU','WWK','13:15','14:00','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1613','WWK','HGU','11:50','12:35','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG1616','HGU','GKA','08:45','09:15','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG1616','GKA','MAG','09:40','10:10','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG1616','MAG','WWK','10:35','11:25','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG1670','POM ','PNP','06:10','06:40','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1670','POM','PNP','09:20','09:50','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1670','POM','PNP','12:50','13:20','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1671','PNP ','POM','07:10','07:40','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1671','PNP ','POM','10:20','10:50','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1671','PNP ','POM','13:50','14:20','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG1642','POM ','GUR','09:15','10:15','YES','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG1642','GUR ','MIS','10:45','11:35','YES','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG1640','POM','GUR','11:20','12:20','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1641','GUR ','POM','12:50','13:50','NO','YES','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG1643','MIS ','GUR','12:00','12:50','YES','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG1643','GUR ','POM','13:20','14:20','YES','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG1644','POM','GUR','09:15','10:15','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG1644','GUR ','LSA','10:45','11:25','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG1644','POM','GUR','08:00','09:00','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1644','GUR ','LSA','09:30','10:10','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1645','LSA','GUR','11:50','12:30','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG1645','GUR ','POM','13:00','14:00','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG1645','LSA','GUR','10:35','11:15','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1645','GUR ','POM','11:45','12:45','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG1710','POM ','BUA','10:10','12:35','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1710','BUA','LNV','13:05','14:00','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1711','LNV ','BUA','10:00','10:55','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1711','BUA','POM','11:25','13:50','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1712','LNV ','RAB','14:25','14:55','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1712','RAB ','KVG','15:20','16:00','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1713','KVG','RAB','08:00','08:40','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1713','RAB ','LNV','09:05','09:35','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1714','LNV ','KVG','07:00','07:35','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG1715','KVG ','LNV','16:25','17:00','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4372','POM','KMA','08:00','08:55','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4372','KMA','KRI','09:15','09:55','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4372','KRI','SGK','10:15','10:45','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4373','SGK ','AWB','10:55','11:15','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4374','AWB','DAU','11:05','11:55','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4373','DAU ','AWB','12:15','12:45','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4373','AWB','SGK','12:55','13:15','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4373','SGK ','KRI','13:25','13:55','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4373','KRI','KMA','14:15','14:55','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4373','KMA','POM','15:15','16:10','NO','YES','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4350','POM','KRI','09:45','11:20','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4350','KRI','OPU','11:40','12:25','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4350','OPU','DAU','12:35','13:05','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4350','DAU ','SKC','13:25','14:15','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4350','SKC','OBX','14:25','14:50','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4350','OBX','BOT','15:00','15:20','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4350','BOT','LMY','15:30','15:50','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4350','LMY','UNG','16:00','16:30','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4351','UNG ','LMY','08:00','08:30','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4351','LMY','BOT','08:40','09:00','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4352','BOT','OBX','09:10','09:30','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4352','OBX','SKC','09:40','10:05','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4352','SKC','DAU','10:15','11:05','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4352','DAU','OPU','11:25','11:55','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4352','OPU','KRI','12:05','12:50','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4352','KRI','POM','13:10','14:45','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4352','POM','KRI','09:00','10:35','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'CG4352','KRI','OPU','10:55','11:40','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'CG4352','OPU','DAU','11:50','12:20','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'CG4352','DAU','WPM','12:40','13:00','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'CG4352','WPM','SKC','13:10','13:50','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'CG4352','SKC','OBX','14:00','14:25','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'CG4352','OBX','LMY','14:35','15:00','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'CG4352','LMY','UNG','15:10','15:40','NO','NO','NO','NO','NO','YES','NO'
UNION ALL SELECT 'CG4353','UNG ','LMY','08:00','08:30','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4353','LMY','OBX','08:40','09:05','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4353','OBX','SKC','09:15','09:40','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4353','SKC','WPM','09:50','10:30','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4353','WPM','DAU','10:40','11:00','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4353','DAU','OPU','11:20','11:50','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4353','OPU','KRI','12:00','12:45','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4353','KRI','POM','13:05','14:30','NO','NO','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4374','POM','KRI','06:30','08:05','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4374','KRI','SGK','18:25','08:55','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4374','SGK ','AWB','09:05','09:25','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4375','AWB ','DAU','09:35','10:05','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4375','DAU','AWB','10:25','10:55','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4375','AWB','SGK','11:05','11:25','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4375','SGK ','KRI','11:35','12:05','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4375','KRI','POM','12:25','14:00','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4376','POM ','KMA','09:00','09:55','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4376','KMA ','KRI','10:15','10:55','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4376','KRI ','OPU','11:05','11:50','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4376','OPU ','DAU','12:00','12:30','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4377','DAU ','OPU','12:50','13:20','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4377','OPU ','KRI','13:30','14:15','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4377','KRI ','KMA','14:25','15:05','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4377','KMA ','POM','15:25','16:20','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4440','POM','KMA','11:30','12:25','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4440','KMA','KRI','12:45','13:25','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4440','POM','KMA','10:00','10:55','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG4440','KMA','KRI','11:15','11:55','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG4441','KRI','KMA','13:45','14:25','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4441','KMA','POM','14:45','15:40','NO','NO','NO','NO','NO','NO','YES'
UNION ALL SELECT 'CG4441','KRI','KMA','12:05','12:45','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG4441','KMA','POM','13:05','14:00','NO','NO','YES','NO','YES','NO','NO'
UNION ALL SELECT 'CG4472','POM','KMA','10:00','10:55','NO','NO','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG4472','KMA','KRI','11:15','11:55','NO','NO','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG4472','KRI','HGU','12:05','12:55','NO','NO','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG4473','KGU','KRI','13:15','14:05','NO','NO','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG4473','KRI','KMA','14:15','14:55','NO','NO','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG4473','KMA','POM','15:15','16:10','NO','NO','NO','YES','NO','YES','NO'
UNION ALL SELECT 'CG4674','POM ','TFI','06:15','07:15','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4674','POM','TFI','14:30','15:30','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4674','POM','TFI','15:00','16:00','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4677','TFI ','AGL','07:25','07:35','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4677','AGL ','POM','07:45','08:40','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4677','TFI ','AGL','16:10','16:20','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4677','AGL ','POM','16:30','17:25','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4679','TFI ','ITK','15:40','16:10','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4679','ITK','POM','16:20','16:50','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4686','POM','KKD','10:10','10:40','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4687','KKD','POM','10:50','11:20','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4810','POM','FNE','08:20','08:50','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4810','FNE ','TPI','09:00','09:10','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4802','POM ','FNE','06:30','07:00','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4802','FNE ','WTP','07:10','07:20','YES','NO','NO','NO','NO','NO','NO'
UNION ALL SELECT 'CG4805','WTP ','POM','07:30','08:00','YES','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4806','POM','ONB','06:30','07:00','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4806','ONB','WTP','07:10','07:20','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4813','TPI','POM','09:20','09:50','NO','YES','NO','YES','NO','NO','NO'
UNION ALL SELECT 'CG4814','POM','MRM','08:00','08:20','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4814','MRM','EFG','08:30','08:40','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4817','EFG','POM','08:50','09:10','NO','NO','NO','NO','YES','NO','NO'
UNION ALL SELECT 'CG4820','POM','KGW','08:00','08:25','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4820','KGW','MMV','08:35','08:45','NO','NO','YES','NO','NO','NO','NO'
UNION ALL SELECT 'CG4823','MMV','POM','08:55','09:20','NO','NO','YES','NO','NO','NO','NO')
UPDATE b
SET [DayOfWeek]=
    CASE UPPER(SU) WHEN 'YES' THEN 1 ELSE 0 END + 
        CASE UPPER(MO) WHEN 'YES' THEN 2 ELSE 0 END +
        CASE UPPER(TU) WHEN 'YES' THEN 4 ELSE 0 END +
        CASE UPPER(WE) WHEN 'YES' THEN 8 ELSE 0 END +
        CASE UPPER(TH) WHEN 'YES' THEN 16 ELSE 0 END +
        CASE UPPER(FR) WHEN 'YES' THEN 32 ELSE 0 END +
        CASE UPPER(SA) WHEN 'YES' THEN 64 ELSE 0 END
FROM DailyFlightSchedules b
INNER JOIN PNGFlights a
    ON a.FlightNo = b.FlightNo AND a.Origin = b.Origin AND
        a.Destination = b.Destination AND a.DepartureTime = CAST(b.DepartureTime AS VARCHAR(5)) AND
        a.ArrivalTime = CAST(b.ArrivalTime AS VARCHAR(5))
